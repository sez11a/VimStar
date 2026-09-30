local M = {}

-- Minimum supported Neovim version. Pinned to VimStar's published floor of
-- 0.11+ (see docs/index.md and install-vimstar.{sh,ps1}); the install scripts
-- do their own gating, this is a belt-and-braces fail-fast for a hand-crafted
-- config. Every API this file uses is already stable in 0.11 — in particular
-- vim.ui.input() takes the async `on_confirm` form (identical to 0.12) — so
-- no code path below branches on version. This check only exists to give a
-- clear error if someone on an older, unsupported build tries the dialog.
local function require_min_version()
	if vim.fn.has("nvim-0.11") == 1 then
		return
	end
	-- Parse the "NVIM v0.10.3" line from `:version` (there may be a blank line in front in
	-- headless, so match anywhere rather than at ^; stop at whitespace so we only get x.y.z).
	local running = vim.fn.execute("version"):match("NVIM v(%S+)") or "an unknown version"
	vim.notify(
		"VimStar (and this save dialog) require Neovim 0.11 or later; you are running "
			.. running .. ". Please upgrade and restart.",
		vim.log.levels.ERROR,
		{ title = "Save As", persistent = true }
	)
	error("Neovim 0.11+ required for the Save As dialog", 2)
end

local function win_valid(win)
	return win ~= nil and vim.api.nvim_win_is_valid(win)
end

local function buf_valid(buf)
	return buf ~= nil and vim.api.nvim_buf_is_valid(buf)
end

local function parent_of(path)
	path = path:gsub("/+$", "")
	if path == "" then
		return "/"
	end
	local dir = vim.fs.dirname(vim.fs.normalize(path))
	return (dir or path)
end

function M.new(opts)
	require_min_version()
	opts = opts or {}

	local state = {}
	state.width = math.floor(vim.o.columns * 0.6)
	state.height = math.floor(vim.o.lines * 0.55)
	state.row = math.floor((vim.o.lines - state.height) / 2)
	state.col = math.floor((vim.o.columns - state.width) / 2)

	-- The buffer we ultimately want to save. Captured up front so that the
	-- later `:saveas` targets the user's real buffer, not one of the dialog's
	-- scratch (nofile) buffers.
	state.save_buf = vim.api.nvim_get_current_buf()
	state.start_name = vim.api.nvim_buf_get_name(state.save_buf)

	local cwd = opts.start_path or vim.fn.expand("%:p:h")
	if cwd == "" then
		cwd = state.start_name ~= "" and vim.fs.dirname(vim.fs.normalize(state.start_name)) or vim.uv.cwd()
	end
	state.cwd = vim.fs.normalize(cwd) or cwd

	state.filename = ""
	state.entries = {}
	state.selected_idx = 1
	state.top_line = 1
	state.closed = false

	state.browser_win = nil
	state.browser_buf = nil
	state.input_win = nil
	state.input_buf = nil

	state.on_save = opts.on_save
	state.on_cancel = opts.on_cancel or function() end

	M._create_windows(state)
	M._load_entries(state)
	M._render_browser(state)
	M._render_input(state)
	M._setup_keymaps(state)
end

function M._create_windows(state)
	local browser_height = math.floor(state.height * 0.65)
	local input_height = math.max(3, math.ceil(state.height * 0.35))

	local function make_buf()
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
		vim.api.nvim_buf_set_option(buf, "swapfile", false)
		vim.api.nvim_buf_set_option(buf, "buflisted", false)
		vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
		return buf
	end

	state.browser_buf = make_buf()

	local browser_config = {
		style = "minimal",
		relative = "editor",
		width = state.width - 2,
		height = browser_height,
		row = state.row + 1,
		col = state.col + 1,
		border = "single",
		title = " Directory Browser ",
		title_pos = "left",
	}

	state.browser_win = vim.api.nvim_open_win(state.browser_buf, false, browser_config)
	vim.api.nvim_win_set_option(state.browser_win, "cursorline", true)
	vim.api.nvim_win_set_option(state.browser_win, "number", true)
	vim.api.nvim_win_set_option(state.browser_win, "relativenumber", false)
	vim.api.nvim_win_set_option(state.browser_win, "wrap", false)

	state.input_buf = make_buf()

	local input_config = {
		style = "minimal",
		relative = "editor",
		width = state.width - 2,
		height = input_height - 1,
		row = state.row + 1 + browser_height + 2,
		col = state.col + 1,
		border = "single",
		title = " Save As ",
		title_pos = "left",
	}

	state.input_win = vim.api.nvim_open_win(state.input_buf, false, input_config)

	vim.api.nvim_set_current_win(state.browser_win)
end

function M._load_entries(state)
	local browser = require("saveas.browser")
	local raw = browser.list_directory(state.cwd)

	state.entries = {}

	-- Show a standard ".." entry at the top so the user can step up one level
	-- by selecting it (in addition to <BS> / ".").
	local parent = parent_of(state.cwd)
	if parent ~= state.cwd then
		table.insert(state.entries, { name = "..", path = parent, is_dir = true })
	end

	for _, e in ipairs(raw) do
		if e.is_dir then
			table.insert(state.entries, e)
		end
	end

	state.selected_idx = 1
	state.top_line = 1
end

local function visible_count(state)
	local browser_height = math.floor(state.height * 0.65)
	return math.max(1, browser_height - 2)
end

function M._render_browser(state)
	local n = visible_count(state)
	local lines = {}
	local start = state.top_line
	local finish = math.min(start + n - 1, #state.entries)

	for i = start, finish do
		local entry = state.entries[i]
		if entry then
			local prefix = (i == state.selected_idx) and ">" or " "
			table.insert(lines, prefix .. " " .. entry.name .. "/")
		end
	end

	if #lines == 0 then
		table.insert(lines, "  (no subdirectories)")
	elseif #lines < n then
		for _ = #lines + 1, n do
			table.insert(lines, " ")
		end
	end

	if state.browser_buf and buf_valid(state.browser_buf) then
		vim.api.nvim_buf_set_lines(state.browser_buf, 0, -1, false, lines)
	end
	if state.browser_win and win_valid(state.browser_win) then
		local cur = state.selected_idx - start + 1
		local maxline = #lines
		cur = math.max(1, math.min(cur, maxline))
		local maxcol = #lines[cur]
		vim.api.nvim_win_set_cursor(state.browser_win, { cur, math.min(1, maxcol) })
	end
end

function M._render_input(state)
	if state.input_buf and buf_valid(state.input_buf) then
		local lines = {
			"  In:   " .. state.cwd,
			"  As:   " .. (state.filename ~= "" and state.filename or "(not set yet)"),
			"",
			"  <CR> enter dir   <BS> up   i save   <Esc> cancel",
		}
		vim.api.nvim_buf_set_lines(state.input_buf, 0, -1, false, lines)
	end
end

local function close(state)
	if state.closed then
		return
	end
	state.closed = true
	if win_valid(state.browser_win) then
		vim.api.nvim_win_close(state.browser_win, true)
	end
	if win_valid(state.input_win) then
		vim.api.nvim_win_close(state.input_win, true)
	end
end

function M._setup_keymaps(state)
	local function cancel()
		close(state)
		state.on_cancel()
	end

	-- Ask for the filename. Neovim 0.12+ made vim.ui.input async: the result
	-- arrives in the `on_confirm` callback (input is nil when the user aborts,
	-- or "" when they confirmed with an empty field).
	local function ask_filename(default, done)
		vim.ui.input({
			prompt = "Save to " .. state.cwd .. "/ ",
			default = default or "",
		}, function(name)
			if name == nil then
				done(nil)
				return
			end
			name = name:gsub("^%s+", ""):gsub("%s+$", "")
			state.filename = name
			M._render_input(state)
			done(name ~= "" and name or nil)
		end)
	end

	local function confirm()
		local base = (state.start_name ~= "") and vim.fn.fnamemodify(state.start_name, ":t") or ""

		ask_filename(base, function(name)
			if not name then
				close(state)
				vim.notify("Save cancelled.", vim.log.levels.INFO, { title = "Save As" })
				return
			end

			local full_path = vim.fs.joinpath(state.cwd, name)

			if state.on_save then
				close(state)
				state.on_save(full_path)
				return
			end

			-- `:saveas` operates on the *current* buffer. Point it at the buffer
			-- we captured at open-time so we save the user's file, not a dialog
			-- buffer. Done after the name is accepted so aborting leaves the
			-- buffer we were on.
			local ok, err = pcall(vim.api.nvim_set_current_buf, state.save_buf)
			if not ok then
				close(state)
				vim.notify("Cannot save: " .. tostring(err), vim.log.levels.ERROR, { title = "Save As" })
				return
			end

			close(state)
			vim.cmd("saveas " .. vim.fn.fnameescape(full_path))
			vim.notify("Saved to " .. full_path, vim.log.levels.INFO, { title = "Save As" })
		end)
	end

	local function browse_up()
		if state.selected_idx > 1 then
			state.selected_idx = state.selected_idx - 1
			if state.selected_idx < state.top_line then
				state.top_line = state.top_line - 1
			end
			M._render_browser(state)
		end
	end

	local function browse_down()
		if state.selected_idx < #state.entries then
			state.selected_idx = state.selected_idx + 1
			if state.selected_idx > state.top_line + visible_count(state) - 1 then
				state.top_line = state.top_line + 1
			end
			M._render_browser(state)
		end
	end

	local function enter_dir()
		local entry = state.entries[state.selected_idx]
		if not entry or not entry.is_dir then
			return
		end
		state.cwd = vim.fs.normalize(entry.path) or entry.path
		state.selected_idx = 1
		state.top_line = 1
		M._load_entries(state)
		M._render_browser(state)
		M._render_input(state)
	end

	local function up_dir()
		local parent = parent_of(state.cwd)
		if parent == state.cwd then
			return -- already at filesystem root
		end
		state.cwd = parent
		state.selected_idx = 1
		state.top_line = 1
		M._load_entries(state)
		M._render_browser(state)
		M._render_input(state)
	end

	local function set(key, fn)
		vim.keymap.set("n", key, fn, { buffer = state.browser_buf, silent = true, nowait = true })
	end

	set("j", browse_down)
	set("k", browse_up)
	set("<Down>", browse_down)
	set("<Up>", browse_up)
	set("<CR>", enter_dir)
	set("<Enter>", enter_dir)
	set("<BS>", up_dir)
	set("<C-h>", up_dir)
	set(".", up_dir)
	set("i", confirm)
	set("s", confirm)
	set("<Esc>", cancel)
	set("q", cancel)
	set("Q", cancel)
end

return M

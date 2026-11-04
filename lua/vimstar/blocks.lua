-- lua/vimstar/blocks.lua
-- Persistent WordStar-style blocks for VimStar

local M = {}

local ns = vim.api.nvim_create_namespace("VimStarBlocks")
local highlight_ns = vim.api.nvim_create_namespace("VimStarBlockHighlight")
local state = {}

local function ensure_state(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if not state[buf] then
    state[buf] = {
      current = { begin_id = nil, end_id = nil },
      previous = { begin_id = nil, end_id = nil },
      source_id = nil,
      visible = true,
      column_mode = false,
    }
  end
  return state[buf]
end

local function clear_extmark(buf, id)
  if id then
    pcall(vim.api.nvim_buf_del_extmark, buf, ns, id)
  end
end

local function get_mark_pos(buf, id)
  if not id then return nil end
  local mark = vim.api.nvim_buf_get_extmark_by_id(buf, ns, id, { details = true })
  if mark and #mark > 0 then
    return { row = mark[1], col = mark[2] }
  end
  return nil
end

local function clear_all_highlights(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(buf, highlight_ns, 0, -1)
end

function M.mark_begin()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)

  -- Clear old begin marker if one already exists
  if s.current.begin_id and not s.current.end_id then
    clear_extmark(buf, s.current.begin_id)
    clear_all_highlights(buf)
  end

  -- Current becomes previous
  s.previous = s.current
  s.current = { begin_id = nil, end_id = nil }

  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  s.current.begin_id = vim.api.nvim_buf_set_extmark(buf, ns, row, col, {
    right_gravity = false,
    virt_text = { { " ⟪B⟫", "Comment" } },
    virt_text_pos = "inline",
  })

  M.update_highlight(buf)
end

function M.mark_end()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local cursor = vim.api.nvim_win_get_cursor(0)

  s.current.end_id = vim.api.nvim_buf_set_extmark(buf, ns, cursor[1] - 1, cursor[2], {
    right_gravity = true,
  })

  -- Remove begin marker
  if s.current.begin_id then
    local bpos = get_mark_pos(buf, s.current.begin_id)
    if bpos then
      clear_extmark(buf, s.current.begin_id)
      s.current.begin_id = vim.api.nvim_buf_set_extmark(buf, ns, bpos.row, bpos.col, {
        right_gravity = false,
      })
    end
  end

  M.update_highlight(buf)
end

function M.toggle_previous_block()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  s.current, s.previous = s.previous, s.current

  clear_all_highlights(buf)
  M.update_highlight(buf)

end

-- Normalize a marked region so that the start position comes first.
-- The end column is exclusive, matching nvim_buf_get_text() below.
local function normalize_region(begin_pos, end_pos)
  local start_row, start_col = begin_pos.row, begin_pos.col
  local end_row, end_col = end_pos.row, end_pos.col
  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, start_col, end_row, end_col = end_row, end_col, start_row, start_col
  end
  return start_row, start_col, end_row, end_col
end

function M.update_highlight(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)


  clear_all_highlights(buf)

  local begin_pos = get_mark_pos(buf, s.current.begin_id)
  local end_pos = get_mark_pos(buf, s.current.end_id)


  if not (begin_pos and end_pos and s.visible) then
    return
  end

  -- Normalize so the highlight always spans from the earlier position to the
  -- later one, regardless of which mark was set first.
  local start_row, start_col, end_row, end_col = normalize_region(begin_pos, end_pos)

  if s.column_mode then
    -- Column mode: highlight the same column span on every line of the block,
    -- producing a true rectangular selection.
    for row = start_row, end_row do
      vim.api.nvim_buf_set_extmark(buf, highlight_ns, row, start_col, {
        end_row = row,
        end_col = end_col,
        hl_group = "Visual",
        priority = 150,
        strict = false,
      })
    end
  else
    -- Charwise mode: highlight the continuous region from start to end.
    vim.api.nvim_buf_set_extmark(buf, highlight_ns, start_row, start_col, {
      end_row = end_row,
      end_col = end_col,
      hl_group = "Visual",
      priority = 150,
      strict = false,
    })
  end
end

function M.toggle_visibility()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  s.visible = not s.visible
  M.update_highlight(buf)
end

function M.toggle_column_mode()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  s.column_mode = not s.column_mode
  vim.notify("Column mode " .. (s.column_mode and "ON" or "OFF"), vim.log.levels.INFO)
end

local function get_block_region(buf, begin_pos, end_pos, column_mode)
  if not (begin_pos and end_pos) then
    vim.notify("No valid positions", vim.log.levels.WARN)
    return {}, nil
  end

  local start_row, start_col, end_row, end_col = normalize_region(begin_pos, end_pos)

  local text = {}
  if column_mode then
    -- Rectangular (blockwise) extraction: take the same column span from every
    -- line of the block. The end column is exclusive, matching the charwise
    -- branch below.
    --
    -- Rows shorter than the block keep only the text they actually have, just
    -- like a native visual-block yank. Padding them with spaces here would
    -- make the pasted block wider than the source block.
    for row = start_row, end_row do
      local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
      local from_col = math.min(start_col, #line)
      local to_col = math.min(end_col, #line)
      local chunk = to_col > from_col and line:sub(from_col + 1, to_col) or ""
      table.insert(text, chunk)
    end
  else
    -- Charwise: use nvim_buf_get_text (very reliable)
    text = vim.api.nvim_buf_get_text(buf, start_row, start_col, end_row, end_col, {})
  end

  return text, column_mode and "b" or "c"
end

-- Delete a rectangular region (column mode). The end column is exclusive.
local function delete_rectangle(buf, begin_pos, end_pos)
  local start_row, start_col, end_row, end_col = normalize_region(begin_pos, end_pos)
  for row = end_row, start_row, -1 do
    local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
    local from_col = math.min(start_col, #line)
    local to_col = math.min(end_col, #line)
    if to_col > from_col then
      vim.api.nvim_buf_set_text(buf, row, from_col, row, to_col, {})
    end
  end
end

-- Paste blockwise text after the cursor, like a native visual-block put.
-- `paste_row`/`paste_col` are the 0-based cursor position *before* the put.
-- With after=true, block paste inserts each row's text at paste_col + 1 on
-- consecutive lines starting at paste_row. Returns the pasted region: the
-- first row, the last row, the insert column, and the exclusive end column.
local function paste_block(text, paste_row, paste_col)
  local start_col = paste_col + 1
  vim.api.nvim_put(text, "b", true, true)  -- after=true, follow=true

  local width = 0
  for _, chunk in ipairs(text) do
    if #chunk > width then width = #chunk end
  end
  local last_row = paste_row + #text - 1
  local end_col = start_col + width
  return { row = paste_row, last_row = last_row, col = start_col, end_col = end_col }
end

-- Inserts text at the cursor. Returns the region of the inserted text: the
-- first row, the last row, the insert column, and the exclusive end column
-- (or nil if nothing was inserted). For block mode, pass the pre-put cursor
-- row/col as `paste_row`/`paste_col` so the returned region is computed from a
-- reliable position (the cursor after a block put is content-dependent).
local function insert_text_at_cursor(text, regtype, paste_row, paste_col)
  if #text == 0 then
    vim.notify("No text to insert", vim.log.levels.WARN)
    return nil
  end

  if regtype == "b" then
    paste_row = paste_row or vim.api.nvim_win_get_cursor(0)[1] - 1
    paste_col = paste_col or vim.api.nvim_win_get_cursor(0)[2]
    return paste_block(text, paste_row, paste_col)
  end

  vim.api.nvim_put(text, regtype, true, true)  -- after=true, follow=true

  local after = vim.api.nvim_win_get_cursor(0)
  return { row = after[1], last_row = after[1], col = after[2], end_col = after[2] }
end

-- Set the current block markers at explicit positions. The end column is
-- exclusive and may sit one past the last character of a line, which the
-- cursor cannot represent.
local function set_block_marks(buf, begin_row, begin_col, end_row, end_col)
  local s = ensure_state(buf)

  s.previous = s.current
  s.current = { begin_id = nil, end_id = nil }

  -- The block is already closed, so the begin marker carries no virtual text.
  -- strict = false so the exclusive end column (one past the last character)
  -- is clamped instead of raising E5108.
  s.current.begin_id = vim.api.nvim_buf_set_extmark(buf, ns, begin_row, begin_col, {
    right_gravity = false,
    strict = false,
  })

  s.current.end_id = vim.api.nvim_buf_set_extmark(buf, ns, end_row, end_col, {
    right_gravity = true,
    strict = false,
  })

  M.update_highlight(buf)
end

function M.copy_block()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local begin_pos = get_mark_pos(buf, s.current.begin_id)
  local end_pos = get_mark_pos(buf, s.current.end_id)

  local text, regtype = get_block_region(buf, begin_pos, end_pos, s.column_mode)
  insert_text_at_cursor(text, regtype)

  M.update_highlight(buf)
end

function M.unmark_block()
  local buf = vim.api.nvim_get_current_buf()
  M.clear_block(buf, false)
  clear_all_highlights(buf)
end

function M.move_block()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local c = s.current
  local begin_pos = get_mark_pos(buf, c.begin_id)
  local end_pos = get_mark_pos(buf, c.end_id)

  if not (begin_pos and end_pos) then
    vim.notify("No block marked", vim.log.levels.WARN)
    return
  end

  local text, regtype = get_block_region(buf, begin_pos, end_pos, s.column_mode)
  if #text == 0 then return end

  -- Remember source for Space-qv
  s.source_id = vim.api.nvim_buf_set_extmark(buf, ns, begin_pos.row, begin_pos.col, { id = s.source_id })

  -- Delete the original block
  if s.column_mode then
    delete_rectangle(buf, begin_pos, end_pos)
  else
    vim.api.nvim_buf_set_text(buf, begin_pos.row, begin_pos.col, end_pos.row, end_pos.col, {})
  end

  -- Record paste position *right before paste*
  local paste_start = vim.api.nvim_win_get_cursor(0)

  -- Paste
  local pasted = insert_text_at_cursor(text, regtype, paste_start[1] - 1, paste_start[2])
  if not pasted then return end

  -- Clear old block (the one we moved from)
  M.clear_block(buf, true)   -- preserve source for qv

  -- Re-mark the pasted block as the new current
  if s.column_mode then
    -- The block end column can sit one past the last character of a line, which
    -- the cursor cannot represent, so set the markers explicitly.
    set_block_marks(buf, pasted.row, pasted.col, pasted.last_row, pasted.end_col)
  else
    vim.api.nvim_win_set_cursor(0, {paste_start[1], paste_start[2]})
    M.mark_begin()

    vim.api.nvim_win_set_cursor(0, {pasted.row, pasted.col})
    M.mark_end()
  end

end

function M.delete_block()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local begin_pos = get_mark_pos(buf, s.current.begin_id)
  local end_pos = get_mark_pos(buf, s.current.end_id)

  if begin_pos and end_pos then
    if s.column_mode then
      delete_rectangle(buf, begin_pos, end_pos)
    else
      local lines = vim.api.nvim_buf_get_lines(buf, end_pos.row, end_pos.row + 1, true)
      local max_col = lines[1] and #lines[1] or 0
      vim.api.nvim_buf_set_text(buf, begin_pos.row, begin_pos.col, end_pos.row, math.min(end_pos.col, max_col), {})
    end
  end
  M.clear_block(buf)
end

function M.clear_block(buf, preserve_source)
  buf = buf or vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  clear_extmark(buf, s.current.begin_id)
  clear_extmark(buf, s.current.end_id)
  if not preserve_source then
    clear_extmark(buf, s.source_id)
    s.source_id = nil
  end
  s.current.begin_id, s.current.end_id = nil, nil
  clear_all_highlights(buf)
end

function M.jump_to_begin()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local pos = get_mark_pos(buf, s.current.begin_id)
  if pos then
    vim.api.nvim_win_set_cursor(0, {pos.row + 1, pos.col})
  end
end

function M.jump_to_end()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local pos = get_mark_pos(buf, s.current.end_id)
  if pos then
    vim.api.nvim_win_set_cursor(0, {pos.row + 1, pos.col})
  end
end

function M.jump_to_source()
  local buf = vim.api.nvim_get_current_buf()
  local s = ensure_state(buf)
  local pos = get_mark_pos(buf, s.source_id)
  if pos then
    vim.api.nvim_win_set_cursor(0, {pos.row + 1, pos.col})
  end
end

-- Auto-update highlight on certain events (optional)
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if state[buf] then
      M.update_highlight(buf)
    end
  end,
})

-- Status for lualine / statusline
function M.get_status()
  local buf = vim.api.nvim_get_current_buf()
  local s = state[buf]
  if not s then return "" end

  local has_block = s.current.begin_id and s.current.end_id
  if not has_block then return "" end

  local begin_pos = get_mark_pos(buf, s.current.begin_id)
  local end_pos = get_mark_pos(buf, s.current.end_id)

  if begin_pos and end_pos then
    local lines = end_pos.row - begin_pos.row + 1
    return string.format("Block:%d", lines)  -- e.g. "Block:5"
  end
  return "Block"
end

return M

local ts_branch = vim.g.tree_sitter_branch or "master"
local depcheck = require("vimstar.depcheck")
local vts = require("vimstar.treesitter")

-- Parsers are kept outside the plugin directory so that updating
-- nvim-treesitter never invalidates them.
local parser_dir = vts.parser_dir

--- Point the plugin at the branch this Neovim needs.
---
--- A stale lazy-lock.json entry (written before the Neovim upgrade) keeps
--- restoring the old commit every time the plugin is installed, so the
--- checkout has to be repaired here and the lockfile has to be rewritten.
--- Otherwise the same breakage comes back on the next install.
---
---@param plugin table
local function repair_checkout(plugin)
  local want = ts_branch
  local have = vts.detect_api(plugin.dir)
  if not have or have == want then
    return
  end

  local dir = plugin.dir

  -- The wanted branch may not be fetched yet; the network is optional here
  -- because the clone usually has every branch already.
  pcall(vim.fn.system, { "git", "-C", dir, "fetch", "origin", want, "--quiet" })

  local sha = vim.trim(vim.fn.system({ "git", "-C", dir, "rev-parse", "--verify", "--quiet", "refs/remotes/origin/" .. want }))
  if sha == "" then
    sha = vim.trim(vim.fn.system({ "git", "-C", dir, "rev-parse", "--verify", "--quiet", want }))
  end

  if sha == "" then
    depcheck.report(
      "nvim-treesitter is checked out from the '" .. have .. "' branch, but this Neovim needs the '"
        .. want .. "' branch. Run :Lazy update to fix it."
    )
    return
  end

  local out = vim.fn.system({ "git", "-C", dir, "checkout", "--force", sha })
  if vim.v.shell_error ~= 0 then
    depcheck.report("Could not switch nvim-treesitter to the '" .. want .. "' branch: " .. out)
    return
  end

  -- Rewrite lazy-lock.json, otherwise the stale commit is restored again the
  -- next time the plugin is installed.
  pcall(function()
    require("lazy.manage.lock").update()
  end)

  depcheck.report("nvim-treesitter was on the '" .. have .. "' branch, switched it to '" .. want .. "'.")
end

--- Install the parsers VimStar cannot work without.
---
--- On the 0.12 branch `:TSUpdate` only refreshes parsers that are already
--- installed, so a fresh install has to ask for them explicitly.
---
---@param langs string[]
local function install_parsers(langs)
  local missing = {}
  for _, lang in ipairs(langs) do
    if not vts.has_parser(lang) then
      missing[#missing + 1] = lang
    end
  end
  if #missing > 0 then
    vts.install(missing)
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Only load when a C compiler is available; every other option relies on
    -- at least the markdown_inline grammar, which must be compiled from source.
    -- Without a compiler, native Markdown block highlighting still works (Neovim
    -- ships it in the binary). Skipping avoids compile errors on Windows users.
    cond = function()
      return depcheck.has_cc()
    end,
    branch = ts_branch,
    lazy = false,
    init = repair_checkout,
    build = function(plugin)
      if vts.detect_api(plugin.dir) == "main" then
        require("nvim-treesitter").setup({ install_dir = parser_dir })
        -- Markdown is the heart of VimStar, so its parsers are always there.
        install_parsers({ "markdown", "markdown_inline" })
        return
      end
      -- The legacy branch installs every supported grammar with :TSUpdate.
      -- Load the plugin first, otherwise the command does not exist yet.
      require("lazy.core.loader").load(plugin, { task = "build" })
      vim.cmd("TSUpdate")
    end,
    config = function()
      local nts = require("nvim-treesitter")
      local modern = type(nts.get_available) == "function"

      if modern then
        -- Neovim 0.12+ rewrite of nvim-treesitter.
        nts.setup({ install_dir = parser_dir })
        vim.opt.runtimepath:prepend(parser_dir)

        -- Grammars are compiled on demand: the first time a filetype is
        -- opened, the matching parser is installed in the background.
        local pending = {}

        --- Attach the parser of a language to the buffers that need it.
        ---
        ---@param lang string
        local function attach(lang)
          if vim.fn.filereadable(parser_dir .. "/parser/" .. lang .. ".so") == 0 then
            return
          end
          pending[lang] = nil

          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) then
              local ft = vim.bo[buf].filetype
              if ft ~= "" and vts.lang_for(ft) == lang then
                local ok = pcall(vim.treesitter.start, buf, lang)
                if ok then
                  -- The window showing the buffer, or the current one.
                  local win = vim.fn.bufwinid(buf)
                  pcall(function()
                    vim.wo[win > 0 and win or 0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo[win > 0 and win or 0].foldmethod = "expr"
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                  end)
                end
              end
            end
          end
        end

        vim.api.nvim_create_autocmd("FileType", {
          callback = function(ev)
            local ft = vim.bo[ev.buf].filetype
            if ft == "" then
              return
            end

            -- Filetype and tree-sitter language are not always the same
            -- ("sh" is "bash", "typescriptreact" is "tsx", ...).
            local lang = vts.lang_for(ft)

            -- Only real tree-sitter languages belong here. Filetypes that are
            -- not in the parser registry (e.g. plugin buffers like "alpha" or
            -- "notify") have no grammar to install; skip them instead of
            -- trying to install a parser and spamming errors.
            if not vts.has_grammar(lang) then
              return
            end

            local ok = pcall(vim.treesitter.start, ev.buf, lang)
            if ok then
              -- The window showing the buffer, or the current one.
              local win = vim.fn.bufwinid(ev.buf)
              pcall(function()
                vim.wo[win > 0 and win or 0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo[win > 0 and win or 0].foldmethod = "expr"
                vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
              end)
              return
            end

            -- The parser is missing. Install it, unless a tool it needs is
            -- not available.
            local missing = depcheck.check_parser_requirements(lang)
            if #missing > 0 then
              depcheck.report("Cannot install " .. lang .. " tree-sitter parser: "
                .. table.concat(missing, ", "))
              return
            end

            pending[lang] = true
            -- The grammar is compiled in the background, the user keeps
            -- working while that happens.
            vts.install({ lang }, {
              wait = false,
              on_done = function()
                attach(lang)
              end,
            })
          end,
        })

        -- nvim-treesitter fires User TSUpdate once a parser has been
        -- installed; attach it to the buffers that are already open.
        vim.api.nvim_create_autocmd("User", {
          pattern = "TSUpdate",
          callback = function()
            for lang in pairs(pending) do
              attach(lang)
            end
          end,
        })
      else
        -- Legacy API, used by Neovim 0.11 and earlier.
        require("nvim-treesitter.configs").setup({
          parser_install_dir = parser_dir,
          highlight = { enable = true },
          indent = { enable = true },
          auto_install = true,
        })
        vim.opt.runtimepath:append(parser_dir)
      end

      -- Tree-Sitter enables folding via foldmethod=expr; expand everything.
      vim.opt.foldlevel = 99
    end,
  },
}

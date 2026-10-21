local M = {}

local depcheck = require("vimstar.depcheck")

-- Parsers are kept outside the plugin directory so that updating
-- nvim-treesitter never invalidates them.
M.parser_dir = vim.fn.stdpath("data") .. "/treesitter"

--- Where is nvim-treesitter installed?
---
--- Lazy knows the exact location, but the module must also work when the
--- plugin is not installed (yet), so there is a fallback.
---
---@return string
function M.plugin_dir()
  local ok, config = pcall(require, "lazy.core.config")
  if ok and type(config) == "table" and config.plugins then
    local plugin = config.plugins["nvim-treesitter"]
    if plugin and plugin.dir then
      return plugin.dir
    end
  end
  return vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
end

--- Which API does the checked-out nvim-treesitter expose?
---
--- The API depends on the branch that is actually checked out, not on the
--- Neovim version. init.lua picks the branch, but what ends up on disk is
--- decided by git: a stale entry in lazy-lock.json can pin a commit from the
--- other branch, which is what happens when Neovim is upgraded across 0.12.
--- Always detect the API instead of trusting the version.
---
---@param dir? string plugin directory
---@return "main"|"master"|nil
function M.detect_api(dir)
  dir = dir or M.plugin_dir()
  if not dir or dir == "" then
    return nil
  end
  if vim.uv.fs_stat(dir .. "/lua/nvim-treesitter/init.lua") then
    return "main" -- Neovim 0.12+ rewrite
  end
  if vim.uv.fs_stat(dir .. "/lua/nvim-treesitter.lua") then
    return "master" -- legacy API
  end
  return nil
end

--- The tree-sitter language of a filetype ("sh" is "bash", ...).
---
---@param ft string
---@return string
function M.lang_for(ft)
  if ft == "" then
    return ""
  end
  local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
  if ok and lang and lang ~= "" then
    return lang
  end
  return ft
end

--- Is the parser of this language installed?
---
---@param lang string
---@return boolean
function M.has_parser(lang)
  return vim.fn.filereadable(M.parser_dir .. "/parser/" .. lang .. ".so") == 1
end

--- Does nvim-treesitter know a grammar for this language?
---
--- Filetypes without a grammar (plugin buffers, for example) must not be
--- turned into an installation request.
---
---@param lang string
---@return boolean
function M.has_grammar(lang)
  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  return ok and type(parsers) == "table" and parsers[lang] ~= nil
end

--- Languages of the buffers that are open right now and have no parser yet.
---
---@return string[]
function M.missing_langs()
  local missing = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local ft = vim.bo[buf].filetype
      if ft ~= "" then
        local lang = M.lang_for(ft)
        if lang ~= "" and M.has_grammar(lang) and not M.has_parser(lang) then
          missing[lang] = true
        end
      end
    end
  end
  return vim.tbl_keys(missing)
end

--- Install parsers.
---
--- By default the call waits until the grammars are compiled. That is what
--- the build step and the update command want. Opening a file wants the
--- opposite: the parser is compiled in the background while the user keeps
--- working.
---
---@param langs string[]
---@param opts? { wait?: boolean, on_done?: fun(lang: string) }
---@return boolean success
function M.install(langs, opts)
  if #langs == 0 then
    return true
  end

  local api = M.detect_api()
  if not api then
    depcheck.report("nvim-treesitter is not installed yet. Run :Lazy install nvim-treesitter first.")
    return false
  end

  -- Grammars are compiled from source, so they need a toolchain.
  for _, lang in ipairs(langs) do
    local missing = depcheck.check_parser_requirements(lang)
    if #missing > 0 then
      depcheck.report("Cannot install the " .. lang .. " parser: " .. table.concat(missing, ", "))
      return false
    end
  end

  if api == "main" then
    local ts = require("nvim-treesitter")
    -- Make sure the parsers land in VimStar's parser directory, not in the
    -- default one of the plugin.
    ts.setup({ install_dir = M.parser_dir })
    -- `force` is needed because the plugin also counts the query files as
    -- installed parsers: a parser whose library is gone but whose queries
    -- are still there would be skipped otherwise.
    local ok, err = pcall(function()
      local task = ts.install(langs, { force = true })
      if opts and opts.on_done then
        task:await(function(install_err)
          if install_err then
            depcheck.report("Could not install the parsers: " .. tostring(install_err))
            return
          end
          -- The callback touches the Neovim API, so it must not run in the
          -- middle of the installation.
          vim.schedule(function()
            for _, lang in ipairs(langs) do
              opts.on_done(lang)
            end
          end)
        end)
      end
      if not opts or opts.wait ~= false then
        task:wait()
      end
    end)
    if not ok then
      depcheck.report("Could not install the parsers: " .. tostring(err))
      return false
    end
    return true
  end

  -- Legacy branch: every parser is installed by its own command. The bang
  -- skips the question about reinstalling a parser that is already there.
  for _, lang in ipairs(langs) do
    pcall(vim.cmd, "TSInstall! " .. lang)
  end
  if opts and opts.on_done then
    for _, lang in ipairs(langs) do
      opts.on_done(lang)
    end
  end
  return true
end

--- Update the installed parsers and install the ones that are missing.
---
--- `:TSUpdate` only refreshes the parsers that are already there, so on its
--- own it cannot fix a buffer whose grammar was never installed.
---
function M.update()
  if not depcheck.has_cc() then
    depcheck.report("Tree-Sitter highlighting is unavailable without a C compiler (cc, gcc, or clang).")
    return
  end

  local api = M.detect_api()
  if not api then
    depcheck.report("nvim-treesitter is not installed yet. Run :Lazy install nvim-treesitter first.")
    return
  end

  -- The buffers that are open right now may need a grammar that is missing.
  local missing = M.missing_langs()
  if #missing > 0 then
    vim.notify("Installing missing parsers: " .. table.concat(missing, ", "), vim.log.levels.INFO, { title = "VimStar" })
    M.install(missing)
  end

  -- Refresh the parsers that are already installed.
  if api == "main" then
    local ts = require("nvim-treesitter")
    ts.setup({ install_dir = M.parser_dir })
    ts.update({}, { summary = true }):await(function(err)
      if err then
        depcheck.report("Could not update the parsers: " .. tostring(err))
      end
    end)
  else
    vim.cmd("TSUpdate")
  end
end

return M

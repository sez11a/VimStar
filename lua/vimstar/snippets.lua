-- Snippet loader for VimStar.
-- Loads snipmate snippets from the built-in ~/.VimStar/snippets directory,
-- and optionally from a user-configured directory outside of VimStar.
--
-- Set in vimstar-user.lua:
--   vim.g.vimstar_user_snippets = "~/my-snippets"
--
-- The user directory is searched first, so snippets defined there take
-- precedence over the built-in ones when triggers collide.

local M = {}

---Built-in snippets directory (inside VimStar).
local builtin_snippets = vim.fn.expand("~/.VimStar/snippets")

---Load snippets from the built-in dir and, if configured, the user dir.
---The user dir must contain snipmate-style `*.snippets` files, one per
---filetype (e.g. `python.snippets`, `lua.snippets`).
function M.load()
  local paths = { builtin_snippets }

  local user_snippets = vim.g.vimstar_user_snippets
  if user_snippets and user_snippets ~= "" then
    local expanded = vim.fn.expand(user_snippets)
    if vim.uv.fs_stat(expanded) then
      -- User dir first: its snippets take precedence over built-ins.
      table.insert(paths, 1, expanded)
    else
      vim.notify(
        "VimStar: user snippets directory not found: " .. expanded,
        vim.log.levels.WARN
      )
    end
  end

  require("luasnip.loaders.from_snipmate").lazy_load({ paths = paths })
end

return M

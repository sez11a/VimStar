-- Template resolver for VimStar
-- Allows users to override default templates by setting vim.g.vimstar_user_templates
-- to a directory containing customized templates mirroring the default structure.

local M = {}

-- Default template base (the repo location)
local default_base = vim.fn.expand("~/.VimStar/templates")

---Resolve a template path, checking user templates first then falling back to defaults.
---@param rel_path string Relative path from templates root (e.g., "typst/book.typ", "odt/shunn-modern-reference.odt")
---@return string Absolute path to the template file
function M.resolve(rel_path)
  -- User can override in vimstar-user.lua:
  -- vim.g.vimstar_user_templates = "~/.VimStar/user-templates"
  -- vim.g.vimstar_user_templates = "~/my-templates"
  local user_base = vim.g.vimstar_user_templates and vim.fn.expand(vim.g.vimstar_user_templates) or nil

  if user_base then
    local custom = user_base .. "/" .. rel_path
    if vim.uv.fs_stat(custom) then
      return custom
    end
  end
  return default_base .. "/" .. rel_path
end

---Get a Pandoc --template flag value for the given template.
---@param rel_path string Relative path from templates root
---@return string Formatted as "--template /absolute/path/to/template"
function M.pandoc_template(rel_path)
  return "--template " .. vim.fn.shellescape(M.resolve(rel_path))
end

---Get a Pandoc --reference-doc flag value for ODT templates.
---@param rel_path string Relative path from templates root
---@return string Formatted as "--reference-doc /absolute/path/to/template"
function M.reference_doc(rel_path)
  return "--reference-doc " .. vim.fn.shellescape(M.resolve(rel_path))
end

---Get a Pandoc --lua-filter flag value for filter scripts.
---@param rel_path string Relative path from templates root
---@return string Formatted as "--lua-filter /absolute/path/to/filter"
function M.lua_filter(rel_path)
  return "--lua-filter " .. vim.fn.shellescape(M.resolve(rel_path))
end

return M
-- lua/vimstar/shunn_odt.lua
local M = {}

local function xml_escape(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end

local function read_yaml_fields(path)
  local lines = vim.fn.readfile(path)
  if not lines[1] or not lines[1]:match("^---%s*$") then
    error("No YAML front matter in " .. path)
  end

  local fields = {}
  for i = 2, #lines do
    if lines[i]:match("^---%s*$") then
      break
    end
    local key, value = lines[i]:match("^([%w_-]+)%s*:%s*(.*)$")
    if key then
      value = value:gsub("^%s+", ""):gsub("%s+$", "")
      value = value:gsub("^['\"]", ""):gsub("['\"]$", "")
      fields[key] = value
    end
  end
  return fields
end

local function patch_odt_header(odt, surname, shorttitle)
  local styles = vim.fn.system({ "unzip", "-p", odt, "styles.xml" })
  if vim.v.shell_error ~= 0 then
    error("Could not read styles.xml from " .. odt)
  end

  local updated = styles
    :gsub("___SURNAME___", xml_escape(surname))
    :gsub("___SHORTTITLE___", xml_escape(shorttitle))

  if updated:find("___SURNAME___", 1, true) or updated:find("___SHORTTITLE___", 1, true) then
    error("Header placeholders not found. Check the reference.odt header text.")
  end

  local tmp = vim.fn.tempname() .. "-styles.xml"
  vim.fn.writefile(vim.split(updated, "\n", { plain = true }), tmp)

  -- zip expects the member name to be styles.xml, so copy into a temp dir
  local dir = vim.fn.tempname()
  vim.fn.mkdir(dir)
  local styles_path = dir .. "/styles.xml"
  vim.fn.rename(tmp, styles_path)

  vim.fn.system({ "zip", "-j", odt, styles_path })
  if vim.v.shell_error ~= 0 then
    error("Could not update styles.xml in " .. odt)
  end
end

function M.export(opts)
  opts = opts or {}
  local md = opts.markdown or vim.fn.expand("%:p")
  local odt = opts.output or (vim.fn.expand("%:p:r") .. ".odt")
  local reference = opts.reference or vim.fn.expand("<sfile>:p:h") -- replace with real path
  local filter = opts.filter or "shunn-frontmatter.lua"
  local reference_doc = opts.reference_doc or "shunn-modern-reference.odt"

  local fields = read_yaml_fields(md)
  if not fields.surname or not fields.shorttitle then
    error("YAML must contain surname and shorttitle")
  end

  vim.fn.system({
    "pandoc", md,
    "--from", "markdown+yaml_metadata_block",
    "--to", "odt",
    "--reference-doc", reference_doc,
    "--lua-filter", filter,
    "-o", odt,
  })
  if vim.v.shell_error ~= 0 then
    error("Pandoc failed")
  end

  patch_odt_header(odt, fields.surname, fields.shorttitle)
  vim.notify("Wrote " .. odt)
end

return M

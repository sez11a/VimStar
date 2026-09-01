-- shunn-frontmatter.lua
-- Modern Shunn first-page layout for ODT using VimStar YAML keys

local function stringify(v)
  if v == nil then return "" end
  return pandoc.utils.stringify(v)
end

function Pandoc(doc)
  local meta = doc.meta

  local name        = stringify(meta.name)
  local address     = stringify(meta.address)
  local city        = stringify(meta.city)
  local phone       = stringify(meta.phone)
  local email       = stringify(meta.email)
  local affiliation = stringify(meta.affiliation)
  local wordcount   = stringify(meta.wordcount)
  local title       = stringify(meta.title)
  local author      = stringify(meta.author)
  local surname     = stringify(meta.surname)
  local shorttitle  = stringify(meta.shorttitle)

  -- Prevent Pandoc from emitting its own title/author block
  meta.title  = nil
  meta.author = nil

  -- First line: name (left) + tab + word count (right)
  local first_inlines = {}
  if name ~= "" then
    table.insert(first_inlines, pandoc.Str(name))
  end
  if wordcount ~= "" then
    table.insert(first_inlines, pandoc.RawInline("opendocument", "<text:tab/>"))
    table.insert(first_inlines, pandoc.Str(wordcount))
  end

  local first_para = pandoc.Div(
    {pandoc.Para(first_inlines)},
    {["custom-style"] = "ContactFirstLine"}
  )

  -- Remaining contact lines
  local rest_paras = {}
  if address     ~= "" then table.insert(rest_paras, pandoc.Para{pandoc.Str(address)}) end
  if city        ~= "" then table.insert(rest_paras, pandoc.Para{pandoc.Str(city)}) end
  if phone       ~= "" then table.insert(rest_paras, pandoc.Para{pandoc.Str(phone)}) end
  if email       ~= "" then table.insert(rest_paras, pandoc.Para{pandoc.Str(email)}) end
  if affiliation ~= "" then table.insert(rest_paras, pandoc.Para{pandoc.Str(affiliation)}) end

  local contact_div = pandoc.Div(rest_paras, {["custom-style"] = "Contact"})

  local title_div  = pandoc.Div({pandoc.Para{pandoc.Str(title)}},  {["custom-style"] = "Title"})
  local author_div = pandoc.Div({pandoc.Para{pandoc.Str(author)}}, {["custom-style"] = "Author"})

  local spacer = pandoc.Para{pandoc.Str("\u{00A0}")}

  -- Build front matter once
  local front = {first_para, contact_div}

  for i = 1, 4 do
    table.insert(front, spacer)
  end

  table.insert(front, title_div)
  table.insert(front, spacer)
  table.insert(front, author_div)
  table.insert(front, spacer)
  table.insert(front, spacer)

  for i = #front, 1, -1 do
    table.insert(doc.blocks, 1, front[i])
  end

  if surname    ~= "" then meta.surname    = surname end
  if shorttitle ~= "" then meta.shorttitle = shorttitle end

  doc.meta = meta
  return doc
end

function Para(el)
  local text = pandoc.utils.stringify(el):gsub("^%s+", ""):gsub("%s+$", "")
  if text == "#" then
    return pandoc.Div(
      {pandoc.Para{pandoc.Str("#")}},
      {["custom-style"] = "SceneBreak"}
    )
  end
end

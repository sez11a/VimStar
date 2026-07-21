local depcheck = require("vimstar.depcheck")

return {
  {
    "chomosuke/typst-preview.nvim",
    cond = function() return depcheck.has_typst() end,
    ft = 'typst',
    version = "1.*",
    opts = {},
  },
}
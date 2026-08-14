return {
{
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>ou", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    symbol_folding = {
        autofold_depth = false,
      },
  },
},
}

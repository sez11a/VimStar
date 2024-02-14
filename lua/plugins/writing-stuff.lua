return {
  -- required by vim-markdown
  {
    "godlygeek/tabular",
    lazy = false,
  },
  {
    "preservim/vim-markdown",
    lazy = false,
    ft = "markdown",
  },
  {
    "preservim/vim-wordy",
    ft = "markdown",
  },
  {
    "preservim/vim-pencil",
    ft = "markdown",
  },
  {
    "preservim/vim-wordchipper",
    ft = "markdown",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "vim-voom/VOoM",
    lazy = false,
  },
}

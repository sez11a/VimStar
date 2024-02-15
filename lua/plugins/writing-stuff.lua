return {
  -- required by vim-markdown
  {
    "tpope/vim-surround",
    lazy = false,
  },
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
    config = function ()
      vim.cmd("let g:pencil#wrapModeDefault = 'soft'")
      vim.cmd("let g:pencil#autoformat = 0")
      vim.cmd("let g:pencil#conceallevel = 0")
      vim.cmd("call pencil#init()")
    end,
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

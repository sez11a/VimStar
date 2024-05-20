return {
  {
    "tpope/vim-surround",
    lazy = false,
  },
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
    "chentoast/marks.nvim",
    config = function()
      require'marks'.setup {
        default_mappings = true,
        cyclic = true,
        refresh_interval = 250,
      }
    end
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
  {
    "FotiadisM/tabset.nvim",
      config = function()
        require("tabset").setup({
          defaults = {
            tabwidth = 2,
            expandtab = true
          },
          languages = {
            java = {
              tabwidth = 4,
              expandtab = false,
          },
          {
            filetypes = { "markdown", "mkd", "yaml"},
              config = {
                tabwidth = 2,
                expandtab = true,
                softtabstop = 2
            }
          }
        }
      })
      end
  },
}

return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
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
  --[[ The below plugin promised much, but was buggy the last time I tried it. 
  {
    'SCJangra/table-nvim',
    ft = 'markdown',
    opts = {},
  },
]]
    --  Vim Outliner conflicted with other plugins
--  {
--    "vimoutliner/vimoutliner",
--    lazy = false,
--  },
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
  { "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {} },
  {
    'brianhuster/live-preview.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
  },
  {
    "FotiadisM/tabset.nvim",
      config = function()
        require("tabset").setup({
          defaults = {
            tabwidth = 4,
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
  {
    "mpas/marp-nvim",
      config = function()
        require("marp").setup({
          port = 8084,
          wait_for_response_timeout = 30,
          wait_for_response_delay = 1,
        })
      end,
  },
}

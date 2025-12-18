return {
--  {
--    "tpope/vim-surround",
--    lazy = false,
--  },
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
  {
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup{

      }
    end,
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
  {
    "preservim/vim-wordchipper",
    ft = "markdown",
  },
  {
    'brianhuster/live-preview.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
  },
--  {
--    "iamcco/markdown-preview.nvim",
--    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--    ft = { "markdown" },
--    build = function() vim.fn["mkdp#util#install"]() end,
--  },
--  {
--    "3rd/image.nvim",
--    config = function()
--        require('image').setup({
--        integrations = {
--          markdown = {
--            resolve_image_path = function(document_path, image_path, fallback)
--              -- document_path is the path to the file that contains the image
--              -- image_path is the potentially relative path to the image. for
--              -- markdown it's `![](this text)`
--
--              -- you can call the fallback function to get the default behavior
--              return fallback(document_path, image_path)
--            end,
--          }
--        }
--      })
--    end
-- },
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

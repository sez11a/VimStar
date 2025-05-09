return {
   {
    "kyoz/purify",
    lazy = false,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/vim")
    end,
  },
  {
    "EdenEast/nightfox.nvim"
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
      "scottmckendry/cyberdream.nvim",
      lazy = false,
      priority = 1000,
  },
  {
    "vim-scripts/xoria256.vim",
    lazy = false,
  },
  {
      'sainnhe/edge',
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.edge_enable_italic = true
        vim.g.edge_style = 'aura'
        -- vim.cmd.colorscheme('edge')
      end
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
  },
  {
    "miikanissi/modus-themes.nvim",
    priority = 1000
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('nordic').load()
    end
  },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup {
        style = "darker"
      }
      require("onedark").load()
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-macchiato"
      require("catppuccin").setup({
        integrations = {
          cmp = true,
          gitsigns = true,
          neotree = true,
          treesitter = true,
          alpha = true,
          dap = true,
          dap_ui = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
          },
          telescope = {
            enabled = true,
          },
          gitgutter = true,
          which_key = true,
        }
      })
    end
  },
  {
    'maxmx03/fluoromachine.nvim',
       lazy = false,
       priority = 1000,
      config = function ()
       local fm = require 'fluoromachine'

       fm.setup {
          glow = true,
          theme = 'retrowave',
          transparent = true,
       }

      end
  }
}

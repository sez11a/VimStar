return {
   {
    "kyoz/purify",
    lazy = false,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/vim")
    end,
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
  }
}

return {
   {
     "folke/which-key.nvim",
     event = "VeryLazy",
     init = function()
       vim.o.timeout = true
       vim.o.timeoutlen = 300
     end,
     opts = {
       -- your configuration comes here
       -- or leave it empty to use the default settings
       -- refer to the configuration section below
       window = {
         border = "single", -- double, rounded, single, shadow
         position = "top", -- bottom, top
         margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
         padding = {2, 2, 2, 2}, -- extra window padding [top, right, bottom, left]
         winblend = 0,
       },
     }
   }
}

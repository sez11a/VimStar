return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup({
      stages = "fade_in_slide_out",
      timeout = 5000,
      -- background_colour = "#000000", -- Example: set a background color (hex code)
      max_height = 10,
      max_width = 100,
      merge_duplicates = true,
    })

    -- If you want to replace the default vim.notify with nvim-notify
    vim.notify = require("notify")
  end,
}

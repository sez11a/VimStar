return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup({
      -- You can customize your notification settings here
      stages = "fade_in_slide_out", -- Animation style
      timeout = 5000, -- Default timeout for notifications (in ms)
      -- background_colour = "#000000", -- Example: set a background color (hex code)
      max_height = 10, -- Max height of the notification window
      max_width = 80, -- Max width of the notification window
      -- To override vim.notify with nvim-notify
      -- This is often recommended so other plugins use nvim-notify's style
      -- vim.notify = require("notify"),
    })

    -- If you want to replace the default vim.notify with nvim-notify
    vim.notify = require("notify")
  end,
}

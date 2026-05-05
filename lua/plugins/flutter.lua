return {

  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = function()
      require("flutter-tools").setup({
        dev_log = { enabled = true },
        widget_guides = { enabled = true },
      })
    end,
  }

}

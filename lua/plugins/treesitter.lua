return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    main = "nvim-treesitter.config",
    opts = {
          },
    config = function()
      ---@diagnostic disable: missing-fields
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          'bash',
          'vim',
          'vimdoc',
          'regex',
          'lua',
          'markdown',
          'markdown-inline',
          'html',
          'c',
          'python'
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'ruby', 'markdown' },
          disable = { "latex", },
        },
        indent = { enable = true },
        parser_install_dir = vim.fn.stdpath("data") .."/treesitter",
      })
      ---@diagnostic enable:missing-fields
    end
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
}

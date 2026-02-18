return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
          },
    config = function()
      --[[ deprecating old config in favor of new
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
          'javascript',
          'typescript',
          'tsx',
          'jsx',
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
      ]]
      require'nvim-treesitter'.setup {
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { 'ruby', 'markdown' },
            disable = { "latex", },
          },
          indent = { enable = true },
          parser_install_dir = vim.fn.stdpath("data") .."/treesitter",
      }
      require'nvim-treesitter'.install {
          'bash',
          'vim',
          'vimdoc',
          'regex',
          'lua',
          'markdown',
          'markdown-inline',
          'html',
          'javascript',
          'typescript',
          'tsx',
          'jsx',
          'c',
          'python'
      }
    end
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
}

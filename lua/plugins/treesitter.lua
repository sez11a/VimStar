return {
  -- Modern version for Neovim 0.12+
  {
    "neovim-treesitter/nvim-treesitter",
    name = "nvim-treesitter-modern",
    cond = function()
      local v = vim.version()
      return (v.major == 0 and v.minor >= 12) or v.major > 0
    end,
    dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
    config = function()
      require("nvim-treesitter").setup({
        highlight = { enable = true },
        indent = { enable = true },
        parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
      })
      vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/treesitter")
    end,
  },

  -- Legacy version for Neovim 0.11 (uses pre-rewrite legacy setup)
  {
    "nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter-legacy",
    cond = function()
      local v = vim.version()
      return v.major == 0 and v.minor < 12
    end,
    branch = "master",
    config = function()
      require("nvim-treesitter.configs").setup({
        parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
        highlight = { enable = true },
        indent = { enable = true },
      })
      vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/treesitter")
    end,
  },
}
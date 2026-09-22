return {
  -- Neovim 0.12+ (rewrite on the main branch)
  {
    "nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter-modern",
    cond = function()
      local v = vim.version()
      return (v.major == 0 and v.minor >= 12) or v.major > 0
    end,
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/treesitter",
      })
      vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/treesitter")

      -- Features are no longer toggled via highlight/indent.enable
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- Neovim 0.11 and earlier (legacy API on the master branch)
  {
    "nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter-legacy",
    cond = function()
      local v = vim.version()
      return v.major == 0 and v.minor < 12
    end,
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      })
      vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/treesitter")
    end,
  },
}
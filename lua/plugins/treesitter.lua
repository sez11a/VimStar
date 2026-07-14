return {
  -- Modern version for Neovim 0.12+
  {
    "neovim-treesitter/nvim-treesitter",
    cond = function()
      local v = vim.version()
      return (v.major == 0 and v.minor >= 12) or v.major > 0
    end,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "ruby", "markdown" },
          disable = { "latex" },
        },
        indent = { enable = true },
        parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
      }
      vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/treesitter")

      pcall(function()
        require("nvim-treesitter").install({
          "bash", "vim", "vimdoc", "regex", "lua",
          "markdown", "markdown_inline",
          "html", "javascript", "typescript", "tsx", "jsx",
          "c", "python",
        })
      end)
    end,
  },

  -- Older repo for Neovim 0.11 (uses modern-style setup)
  {
    "nvim-treesitter/nvim-treesitter",
    cond = function()
      local v = vim.version()
      return v.major == 0 and v.minor < 12
    end,
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "ruby", "markdown" },
          disable = { "latex" },
        },
        indent = { enable = true },
        parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
      }
      vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/treesitter")

      pcall(function()
        require("nvim-treesitter").install({
          "bash", "vim", "vimdoc", "regex", "lua",
          "markdown", "markdown_inline",
          "html", "javascript", "typescript", "tsx", "jsx",
          "c", "python",
        })
      end)
    end,
  },
}

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

      local has_c_compiler = vim.fn.executable("gcc") == 1 or vim.fn.executable("clang") == 1 or vim.fn.executable("cc") == 1

      pcall(function()
        require("nvim-treesitter").install({
          "bash", "vim", "vimdoc", "regex", "lua",
          "markdown", "markdown_inline",
        })
        
        if has_c_compiler then
          require("nvim-treesitter").install({
            "html", "javascript", "typescript", "tsx",
            "c", "python",
          })
        end
      end)
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
      -- Configure parser directory path (Legacy style)
      local parser_dir = vim.fn.stdpath("data") .. "/treesitter"
      vim.opt.runtimepath:append(parser_dir)
      
      require("nvim-treesitter.install").prefer_git = true
      
      local has_c_compiler = vim.fn.executable("gcc") == 1 or vim.fn.executable("clang") == 1 or vim.fn.executable("cc") == 1

      if has_c_compiler then
        require("nvim-treesitter.install").compilers = { "cc", "gcc", "clang" }
        
        require("nvim-treesitter.configs").setup {
          parser_install_dir = parser_dir,
          ensure_installed = {
            "bash", "vim", "vimdoc", "regex", "lua",
            "markdown", "markdown_inline",
            "html", "javascript", "typescript", "tsx",
            "c", "python",
          },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "ruby", "markdown" },
            disable = { "latex" },
          },
          indent = { enable = true },
        }
      else
        require("nvim-treesitter.configs").setup {
          parser_install_dir = parser_dir,
          ensure_installed = {
            "bash", "vim", "vimdoc", "regex", "lua",
            "markdown", "markdown_inline",
          },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "ruby", "markdown" },
            disable = { "latex" },
          },
          indent = { enable = true },
        }
      end
    end,
  },
}

local ts_branch = vim.g.tree_sitter_branch or "master"
local is_modern = vim.version().major == 0 and vim.version().minor >= 12

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = ts_branch,
    lazy = false,
    build = ":TSUpdate",
    config = function()
      if is_modern then
        require("nvim-treesitter").setup({
          install_dir = vim.fn.stdpath("data") .. "/treesitter",
        })
        vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/treesitter")

        pcall(function()
          require("nvim-treesitter").install({
            "bash",
            "vim",
            "vimdoc",
            "regex",
            "lua",
            "markdown",
            "markdown_inline",
            "html",
            "javascript",
            "typescript",
            "tsx",
            "jsx",
            "c",
            "python",
          })
        end)

        -- Features are no longer toggled via highlight/indent.enable
        vim.api.nvim_create_autocmd("FileType", {
          callback = function()
            pcall(vim.treesitter.start)
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldmethod = "expr"
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end,
        })
      else
        require("nvim-treesitter.configs").setup({
          parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
          highlight = { enable = true },
          indent = { enable = true },
          auto_install = true,
        })
        vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/treesitter")
      end

      -- Tree-Sitter enables folding via foldmethod=expr; expand everything.
      vim.opt.foldlevel = 99
    end,
  },
}

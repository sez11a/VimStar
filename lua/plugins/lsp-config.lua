return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require("mason")

      local mason_tool_installer = require("mason-tool-installer")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "tree-sitter-cli",
          "texlab",
          "jdtls",
          "markmap-cli",
          "lua-language-server",
          "python-lsp-server"
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
--      require('java').setup()
      --local lspconfig = require("lspconfig")
      vim.lsp.config("ts_ls", {
        capabilities = capabilities
      })
      vim.lsp.config("html", {
        capabilities = capabilities
      })
      vim.lsp.config("lua_ls", {
        capabilities = capabilities
      })
      vim.lsp.config("texlab",  {})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    end,
  },
}

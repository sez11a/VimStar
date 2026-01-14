return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool_installer = require('mason-tool-installer')

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      pip = {
        upgrade_pip = true,
      }
    })

    mason_lspconfig.setup({
      ensure_installed = {
        'lua_ls',
        'html',
        'cssls',
        'pylsp',
        'clangd',
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
}

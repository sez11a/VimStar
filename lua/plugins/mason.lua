return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local mason = require('mason')
    local depcheck = require("vimstar.depcheck")
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

    local ensure_lsps = {'lua_ls'}

    if depcheck.has_node() then
      table.insert(ensure_lsps, 'html')
      table.insert(ensure_lsps, 'cssls')
      table.insert(ensure_lsps, 'ts_ls')
    end

    mason_lspconfig.setup({
      ensure_installed = ensure_lsps,
    })

    local ensure_tools = {}

    if depcheck.has_executable("git") then
      table.insert(ensure_tools, "tree-sitter-cli")
    end

    if depcheck.has_node() and depcheck.has_yarn() then
      table.insert(ensure_tools, "markmap-cli")
    end

    mason_tool_installer.setup({
      ensure_installed = ensure_tools
    })
  end,
}
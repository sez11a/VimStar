return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' }, --Lazy loading
  dependencies = {
    'williamboman/mason.nvim',
    'hrsh7th/cmp-nvim-lsp',
    { 'folke/lazydev.nvim', lazy = false, opts = {} },
    },
  config = function()
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local keymap = vim.keymap
    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local function opts(desc)
          return { desc = desc, buffer = ev.buf, silent = true }
        end

        keymap.set('n', 'K', vim.lsp.buf.hover, opts('Show documentation'))
				keymap.set('n', 'gR', '<cmd>Telescope lsp_references<cr>', opts('Show LSP references'))
				keymap.set('n', 'gD', vim.lsp.buf.declaration, opts('Go to declaration'))
				keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts('Show LSP definitions'))
				keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opts('Show LSP implementations'))
				--keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', opts('Show LSP type definitions'))
				keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, opts('Show available code actions'))
      end,
    })

    -- TypeScript
    vim.lsp.config("ts_ls", {
      capabilities = capabilities
    })
    vim.lsp.enable("ts_ls")

    --HTML
    vim.lsp.config("html", {
      capabilities = capabilities
    })

    --Lua
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          completion = { callSnippet = 'Replace' },
        },
      },
    })
    vim.lsp.enable("lua_ls")

    --Texlab
    vim.lsp.config("texlab", {})
    vim.lsp.enable("texlab")

    --[[Java
    vim.lsp.config("jdtls", {
        capabilities = capabilities
      })
    --vim.lsp.enable("jdtls")
    ]]

    -- Python LSP
	  vim.lsp.config("pylsp", {
      capabilities = capabilities,
      settings = {
        pylsp = {
          -- Disable Python linters
          plugins = {
            pycodestyle = { enabled = true },
            pyflakes    = { enabled = true },
            pylint      = { enabled = true },
            mccabe      = { enabled = true },
            rope_completion = { enabled = true },
          },
        },
      },
    })
    vim.lsp.enable("pylsp")

		-- C LSP
    vim.lsp.config("clangd", {
      capabilities = capabilities,
      -- handlers = no_diagnostics,
      settings = {
        clangd = {
          fallbackFlags = { "-std=c11" },  -- Example: Set C standard
        },
      },
    })
    vim.lsp.enable("clangd")
  end
}

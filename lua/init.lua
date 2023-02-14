require('nvim-treesitter.configs').setup {
	 -- one of "all", "maintained" (parsers with maintainers),
	 -- or a list of languages
	 ensure_installed = { "c", "cpp", "java", "lua", "python", "rust", "typescript", "help", "vim", "javascript", "ruby", "elixir", "comment" },

	 highlight = { enable = true },
	 indent = { enable = true, disable = { 'python' } },
	 incremental_selection = {
		  enable = true,
		  keymaps = {
			   init_selection = '<c-space>',
			   node_incremental = '<c-space>',
			   scope_incremental = '<c-s>',
			   node_decremental = '<c-backspace>',
		  },
	 },
	 textobjects = {
		  select = {
			   enable = true,
			   lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			   keymaps = {
				    -- You can use the capture groups defined in textobjects.scm
				    ['aa'] = '@parameter.outer',
				    ['ia'] = '@parameter.inner',
				    ['af'] = '@function.outer',
				    ['if'] = '@function.inner',
				    ['ac'] = '@class.outer',
				    ['ic'] = '@class.inner',
			   },
		  },
		  move = {
			   enable = true,
			   set_jumps = true, -- whether to set jumps in the jumplist
			   goto_next_start = {
				    [']m'] = '@function.outer',
				    [']]'] = '@class.outer',
			   },
			   goto_next_end = {
				    [']M'] = '@function.outer',
				    [']['] = '@class.outer',
			   },
			   goto_previous_start = {
				    ['[m'] = '@function.outer',
				    ['[['] = '@class.outer',
			   },
			   goto_previous_end = {
				    ['[M'] = '@function.outer',
				    ['[]'] = '@class.outer',
			   },
		  },
		  swap = {
			   enable = true,
			   swap_next = {
				    ['<leader>a'] = '@parameter.inner',
			   },
			   swap_previous = {
				    ['<leader>A'] = '@parameter.inner',
			   },
		  },
	 },
}

local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
	-- formatting
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			 group = vim.api.nvim_create_augroup("Format", { clear = true }),
			 buffer = bufnr,
			 callback = function() vim.lsp.buf.formatting_seq_sync() end
		})
	end
end

nvim_lsp.solargraph.setup {}
nvim_lsp.tsserver.setup {}

local servers = {
	 -- clangd = {},
	 gopls = {},
	 pyright = {},
	 -- rust_analyzer = {},
	 tsserver = {},
	 sumneko_lua = {
		  Lua = {
			   workspace = { checkThirdParty = false },
			   telemetry = { enable = false },
		  },
	 },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
	 ensure_installed = (servers),
	 automatic_installation = true,
}

mason_lspconfig.setup_handlers {
	 function(server_name)
		 require('lspconfig')[server_name].setup {
			  capabilities = capabilities,
			  on_attach = on_attach,
			  settings = servers[server_name],
		 }
	 end,
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Make sure to use this new on_attach function when you setup
-- your language servers
require('lspconfig')['solargraph'].setup {
	 on_attach = on_attach
}

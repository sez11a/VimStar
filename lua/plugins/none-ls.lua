return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.erb_lint,
				null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.diagnostics.vale.with{
          -- Use Vale only with .vale.ini present
          condition = function()
            return require"null-ls.utils".root_pattern(
              ".vale.ini"
            )(vim.api.nvim_buf_get_name(0)) ~= nil
          end,
        },
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}

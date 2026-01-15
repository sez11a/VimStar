return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
    require("dapui").setup()
		require("dap-go").setup()

		local dap, dapui = require("dap"), require("dapui")

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<Leader>db", function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint'})
    vim.keymap.set("n", "<Leader>dB", function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = 'Debug: Set Conditional Breakpoint' })
		vim.keymap.set("n", "<Leader>dc", function() dap.continue() end, { desc = 'Debug: Start/Continue' })
		vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>", { desc = "Debug: Terminate" })
		vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>", { desc = "Debug: Step Over"} )
    vim.keymap.set("n", "<Leader>di", function() dap.step_into() end, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<Leader>dt", function () dap.step_out() end, { desc = "Debug: Step Out" })

	end,
}

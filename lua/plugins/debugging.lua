return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
    {
      "mfussenegger/nvim-dap-python",
      ft = {
        "python"
      }
    },
	},
	config = function()
    require("dapui").setup()
		require("dap-go").setup()

    local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(mason_debugpy)

    local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        require("dap-python").setup(venv .. "/bin/python")
      else
        require("dap-python").setup(mason_debugpy)
      end

		local dap, dapui = require("dap"), require("dapui")

    table.insert(dap.configurations.python or {}, {
      type = "python",
      request = "launch",
      name = "Launch current file",
      program = "${file}",
      console = "integratedTerminal",
      justMyCode = true,
    })

    table.insert(dap.configurations.python or {}, {
      type = "python",
      request = "launch",
      name = "Pytest - current file (verbose)",
      module = "pytest",
      args = { "${file}", "-s", "-vv" },
      justMyCode = false,
    })

    dap.configurations.java = {
      {
        type = 'java';
        request = 'attach';
        name = "Debug (Attach) - Remote";
        hostName = "127.0.0.1";
        port = 5005;
      },
    }

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

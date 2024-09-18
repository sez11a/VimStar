local map = vim.keymap.set
local expr_options = { expr = true, silent = true }
--Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

local builtin = require("telescope.builtin")

local wk = require("which-key")

wk.add(
  {
    -- Debug Menu
    { "<leader>d", group = "Debug" },
    { "<leader>dt", "<cmd> DapToggleBreakpoint <CR>", desc = "Toggle Breakpoint" },
    { "<leader>dc", "<cmd> DapContinue <CR>", desc = "Continue" },
    { "<leader>dx", "<cmd> DapTerminate <CR>", desc = "Terminate Debugging" },
    { "<leader>do", "<cmd> DapStepOver <CR>", desc = "Step Over" },
    -- Git Menu
    { "<leader>g", group = "Git" },
    { "<leader>gb", "<cmd> Gedit HEAD <CR>", desc = "Git Browse Head" },
    { "<leader>gc", "<cmd> Git commit <CR>", desc = "Git Commit" },
    { "<leader>gm", "<cmd> Git difftool -y master <CR>", desc = "Git Diff Master" },
    { "<leader>gp", "<cmd> Gitsigns preview_hunk <CR>", desc = "Preview Hunk" },
    { "<leader>gs", "<cmd> Git <CR>", desc = "Git Status" },
    { "<leader>gt", "<cmd> Gitsigns toggle_current_line_blame <CR>", desc = "Toggle Current Line Blame" },
    -- Block and Save Menu
    { "<leader>k", group = "Block and Save" },
    { "<leader>kb", "<cmd> Neotree buffers reveal float <CR>", desc = "Switch Buffer" },
    { "<leader>ke", "<cmd> enew <CR>", desc = "New Buffer" },
    { "<leader>kf", "<cmd> terminal <CR>", desc = "Open Terminal" },
    { "<leader>kj", "<cmd> bd <CR>", desc = "Close Buffer" },
    { "<leader>kl", "<cmd> cd %:p:help |<CR>|", desc = "Change Working Dir" },
    { "<leader>ko", "<cmd> Explore <CR>", desc = "Open File" },
    { "<leader>kq", "<cmd> q! <CR>", desc = "Abandon Changes and Quit" },
    { "<leader>ks", "<cmd> w <CR>", desc = "Save" },
    { "<leader>kt", function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd "p"
          else
            vim.cmd.Neotree "toggle"
          end
        end, desc = "Toggle Neotree" },
    { "<leader>kx", "<cmd> wq <CR>", desc = "Save and Exit" },
    -- Onscreen Format menu
    { "<leader>o", group = "Onscreen Format" },
    { "<leader>oa", vim.lsp.buf.code_action, desc = "Code Actions" },
    { "<leader>od", vim.lsp.buf.definition, desc = "Show Definition" },
    { "<leader>of", vim.lsp.buf.format, desc = "Format Buffer" },
    { "<leader>ok", "<cmd> bnext <CR>", desc = "Next Buffer" },
    { "<leader>ol", "<cmd> ToggleDiag <CR>", desc = "Toggle Diagnostics" },
    { "<leader>om", "<cmd> MarkdownPreviewStop <CR>", desc = "Stop Markdown Preview" },
    { "<leader>oo", "<cmd> set nospell <CR>", desc = "Spell Check Off" },
    { "<leader>op", "<cmd> MarkdownPreview <CR>", desc = "Markdown Preview" },
    { "<leader>or", vim.lsp.buf.references, desc = "Show References" },
    { "<leader>os", "<cmd> set spell <CR>", desc = "Spell Check" },
    { "<leader>ou", "<cmd> call voom#Init('markdown', 1, 1) <CR>", desc = "Toggle Outline" },
    -- Quick Menu
    { "<leader>q", group = "Quick Menu" },
    { "<leader>qf", builtin.live_grep, desc = "Find in Files"},
  })

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

local map = vim.keymap.set
local expr_options = { expr = true, silent = true }
--Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    k = {
      name = "Block and Save",
      s = { "<cmd> w <CR>", "Save" },
      e = { "<cmd> enew <CR>", "New Buffer" },
      j = { "<cmd> bd <CR>", "Close Buffer" },
      x = { "<cmd> wq <CR>", "Save and Exit" },
      o = { "<cmd> Explore <CR>", "Open File" },
      q = { "<cmd> q! <CR>", "Abandon Changes and Quit" },
      f = { "<cmd> terminal <CR>", "Open Terminal" },
      l = { "<cmd> cd %:p:h <CR>", "Change Working Dir" },
      t = {
        function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd "p"
          else
            vim.cmd.Neotree "toggle"
          end
        end,
        "Toggle Neotree",
      },
    },
    o = {
      name = "Onscreen Format",
      p = { "<cmd> MarkdownPreview <CR>", "Markdown Preview" },
      m = { "<cmd> MarkdownPreviewStop <CR>", "Stop Markdown Preview" },
      k = { "<cmd> bnext <CR>", "Next Buffer" },
      l = { "<cmd> ToggleDiag <CR>", "Toggle Diagnostics" },
      s = { "<cmd> set spell <CR>", "Spell Check" },
      o = { "<cmd> set nospell <CR>", "Spell Check Off" },
      u = { "<cmd> call voom#Init('markdown', 1, 1) <CR>", "Toggle Outline" },
      f = { vim.lsp.buf.format, "Format Buffer" },
      d = { vim.lsp.buf.definition, "Show Definition" },
      r = { vim.lsp.buf.references, "Show References" },
      a = { vim.lsp.buf.code_action, "Code Actions" }
    },
    g = {
      name = "Git",
      c = { "<cmd> Git commit <CR>", "Git Commit" },
      m = { "<cmd> Git difftool -y master <CR>", "Git Diff Master" },
      s = { "<cmd> Git <CR>", "Git Status" },
      b = { "<cmd> Gedit HEAD <CR>", "Git Browse Head" },
      p = { "<cmd> Gitsigns preview_hunk <CR>", "Preview Hunk" },
      t = { "<cmd> Gitsigns toggle_current_line_blame <CR>", "Toggle Current Line Blame" }
    }
  }
})

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

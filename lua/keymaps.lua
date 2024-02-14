local wk = require("which-key")

wk.register ({
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
               vim.cmd.Neotree "focus"
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
   },
   g = {
      name = "Git",
      c = { "<cmd> Git commit <CR>", "Git Commit" }, 
      m = { "<cmd> Git difftool -y master <CR>", "Git Diff Master" },
      s = { "<cmd> Git <CR>", "Git Status" },
      b = { "<cmd> Gedit HEAD <CR>", "Git Browse Head" },
   }
})

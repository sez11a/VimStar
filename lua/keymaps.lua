local map = vim.keymap.set
local expr_options = { expr = true, silent = true }
--Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

local blocks = require("vimstar.blocks")
local builtin = require("telescope.builtin")
local wk = require("which-key")
local depcheck = require("vimstar.depcheck")

wk.add(
  {
    -- Block and Save Menu
    { "<leader>k", group = "Block and Save" },
    { "<leader>k-", "", desc = "────────── SAVE ──────────" },
    { "<leader>ke", "<cmd> enew <CR>", desc = "New Buffer" },
    { "<leader>ko", "<cmd> Explore <CR>", desc = "Open File" },
    { "<leader>kl", "<cmd> cd %:p:h |<CR>|", desc = "Change Working Dir" },
    { "<leader>ks", function()
        if vim.fn.bufname() == "" then
          vim.ui.input({ prompt = "Save buffer as: ", default = vim.fn.getcwd() .. "/" }, function(input)
            if input then
              vim.cmd("silent write " .. input)
            end
          end)
        else
          vim.cmd.w()
        end
      end, desc = "Save" },
    { "<leader>kt", function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd "p"
          else
            vim.cmd.Neotree "toggle"
          end
        end, desc = "Toggle Neotree" },
    { "<leader>kx", function()
        if vim.fn.bufname() == "" then
          vim.ui.input({ prompt = "Save and exit as: ", default = vim.fn.getcwd() .. "/" }, function(input)
            if input then
              vim.cmd("silent write " .. input)
              vim.cmd.quit()
            end
          end)
        else
          vim.cmd.wq()
        end
      end, desc = "Save and Exit" },
    { "<leader>km", function()
    if not depcheck.has_executable("markmap") and vim.fn.executable("yarn") == 0 then
      vim.notify("Please install markmap-cli (yarn global add markmap-cli) to enable this feature", vim.log.levels.WARN, { title = "VimStar" })
      return
    end
    vim.cmd("MarkmapSave")
  end, desc = "Save Markmap" },
    { "<leader>kq", "<cmd> q! <CR>", desc = "Abandon Changes and Quit" },
    { "<leader>kf", "<cmd> terminal <CR>", desc = "Open Terminal" },
    { "<leader>k_", "", desc = "────────── BLOCK ──────────" },
    { "<leader>kb", blocks.mark_begin, desc = "Begin Block" },
    { "<leader>kk", blocks.mark_end, desc = "End Block" },
    { "<leader>kc", blocks.copy_block, desc = "Copy Block" },
    { "<leader>kv", blocks.move_block, desc = "Move Block" },
    { "<leader>ky", blocks.delete_block, desc = "Delete Block" },
    { "<leader>kh", blocks.toggle_visibility, desc = "Hide/Show Block" },
    { "<leader>ku", require("vimstar.blocks").toggle_previous_block, desc = "Toggle Previous Block" },
    { "<leader>k<", require("vimstar.blocks").unmark_block, desc = "Unmark Block" },
    { "<leader>kn", blocks.toggle_column_mode, desc = "Toggle Column Mode" },
    { "<leader>k~", "", desc = "────────── BUFFER ──────────" },
    { "<leader>kj", "<cmd> bd <CR>", desc = "Close Buffer" },
    { "<leader>kr", "<cmd> Neotree buffers reveal float <CR>", desc = "Switch Buffer" },

    -- Onscreen Format menu
    { "<leader>o", group = "Onscreen Format" },
    { "<leader>oa", vim.lsp.buf.code_action, desc = "Code Actions" },
    { "<leader>ob", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Rendering" },
    { "<leader>oc", function ()
          vim.b.x = not vim.b.x
          require('cmp').setup.buffer { enabled = not vim.b.x }
          end,
          desc = "Toggle Autocompletion"
    },
    { "<leader>od", vim.lsp.buf.definition, desc = "Show Definition" },
    { "<leader>of", vim.lsp.buf.format, desc = "Format Buffer" },
    { "<leader>oj", "<cmd> %!jq .<CR>", desc = "Use jq to format JSON" },
    { "<leader>ok", "<cmd> bnext <CR>", desc = "Next Buffer" },
    { "<leader>ol", "<cmd> ToggleDiag <CR>", desc = "Toggle Diagnostics" },
    { "<leader>om", function()
    if not depcheck.has_executable("markmap") and vim.fn.executable("yarn") == 0 then
      vim.notify("Please install markmap-cli (yarn global add markmap-cli) to enable this feature", vim.log.levels.WARN, { title = "VimStar" })
      return
    end
    vim.cmd("MarkmapOpen")
  end, desc = "Open Markmap" },
    { "<leader>on", "<cmd> ZenmodeToggle <CR>", desc = "Toggle Distraction-free Mode" },
    { "<leader>oo", "<cmd> set nospell <CR>", desc = "Spell Check Off" },
    { "<leader>oi", "<Plug>CycleListType", desc = "Cycle List Type" },
    { "<leader>op", function()
      if not depcheck.has_executable("node") and vim.fn.executable("npm") == 0 then
        vim.notify("Please install node/npm for LivePreview (visit github.com/brianhuster/live-preview.nvim)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("LivePreview start") 
    end, desc = "Markdown Live Preview" },
    { "<leader>oq", "<cmd> LivePreview close <CR>", desc = "Stop Live Preview" },
    { "<leader>or", vim.lsp.buf.references, desc = "Show References" },
    { "<leader>os", "<cmd> set spell <CR>", desc = "Spell Check" },
    { "<leader>ot", function()
      if not depcheck.has_typst() then
        vim.notify("Please install Typst for preview (run :Mason or install typst)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("TypstPreview toggle") 
    end, desc = "Typst Preview Toggle" },
    { "<leader>ow", function()
      if not depcheck.has_executable("markmap") and not depcheck.has_yarn() then
        vim.notify("Please install markmap-cli or yarn for this feature", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("MarkmapWatch") 
    end, desc = "Markmap Watch" },

    -- Print Controls Menu 
    { "<leader>p", group = "Print Controls" },
    { "<leader>pb", function()
      if not depcheck.has_pandoc() then
        vim.notify("Please install Pandoc to enable PDF export (visit pandoc.org)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("Pandoc pdf --pdf-engine=lualatex --standalone --top-level-division=chapter --template ~/.VimStar/templates/latex/book.tex")
    end, desc="Convert Markdown to PDF: book template (LaTeX)" },
    { "<leader>pp", function()
      if not depcheck.has_pandoc() then
        vim.notify("Please install Pandoc to enable PDF export (visit pandoc.org)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("Pandoc pdf --pdf-engine lualatex --standalone --template ~/.VimStar/templates/latex/article-handout.tex")
    end, desc = "Convert Markdown to PDF: article/handout template (LaTeX)" },
    { "<leader>pe", function()
      if not depcheck.has_pandoc() then
        vim.notify("Please install Pandoc to enable PDF export (visit pandoc.org)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("Pandoc pdf --pdf-engine lualatex --template ~/.VimStar/templates/latex/planner-page.tex")
    end, desc = "Convert Markdown to PDF: planner page template (LaTeX)" },
    { "<leader>pB", function()
      if not depcheck.has_pandoc() then
        vim.notify("Please install Pandoc and Typst for this feature", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("Pandoc pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/book.typ")
    end, desc="Convert Markdown to PDF: book template (Typst)" },
    { "<leader>pP", function()
      if not depcheck.has_pandoc() then
        vim.notify("Please install Pandoc and Typst for this feature", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("Pandoc pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/article-handout.typ")
    end, desc="Convert Markdown to PDF: article/handout template (Typst)" },
    { "<leader>pE", function()
      if not depcheck.has_pandoc() then
        vim.notify("Please install Pandoc and Typst for this feature", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("Pandoc pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/planner-page.typ")
    end, desc="Convert Markdown to PDF: planner page template (Typst, n-up)" },
    { "<leader>pk", function()
      if not depcheck.has_pandoc() then
        vim.notify("Please install Pandoc and Typst for this feature", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("Pandoc pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/book-bookly.typ")
    end, desc="Convert Markdown to PDF: bookly book template (Typst)" },
    { "<leader>pm", function()
      if not depcheck.has_executable("markmap") and not depcheck.has_yarn() then
        vim.notify("Please install markmap-cli or yarn for this feature", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("MarkmapOpen")
    end, desc = "View Mindmap in Browser" },
    { "<leader>ps", function()
      if not depcheck.has_executable("markmap") and not depcheck.has_yarn() then
        vim.notify("Please install markmap-cli or yarn for this feature", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("MarkmapSave")
    end, desc = "Save Mindmap; don't open it" },
    { "<leader>po", function()
      if not depcheck.has_pandoc() then
        vim.notify("Please install Pandoc to enable ODT export (visit pandoc.org)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      vim.cmd("Pandoc odt")
    end, desc = "Convert Markdown to ODT"},

    -- Quick Menu
    { "<leader>q", group = "Quick Menu" },
    { "<leader>q_", "", desc = "────────── CURSOR ─────────" },
    { "<leader>qb", blocks.jump_to_begin, desc = "Jump to Block Begin" },
    { "<leader>qk", blocks.jump_to_end, desc = "Jump to Block End" },
    { "<leader>qv", blocks.jump_to_source, desc = "Jump to Move Source" },
    { "<leader>qe", function() MoveMotion("gg") end, { noremap = true, silent = true }, desc = "Jump to Top" },
    { "<leader>qs", function() MoveMotion("0") end, { noremap = true, silent = true }, desc = "Jump to Left" },
    { "<leader>qd", function() MoveMotion("$") end, { noremap = true, silent = true }, desc = "Jump to Right" },
    { "<leader>qx", function() MoveMotion("G") end, { noremap = true, silent = true }, desc = "Jump to Bottom" },
    { "<leader>qp", function() MoveMotion("<C-o>") end, { noremap = true, silent = true }, desc = "Jump to Previous Position"},
    { "<leader>q-", "", desc = "────────── FIND ──────────" },
    { "<leader>qf", builtin.live_grep, desc = "Find in Files"},
    { "<leader>q~", "", desc = "────────── MANAGE ─────────" },
    { "<leader>qu", function()
        local vimstar_dir = vim.fn.stdpath("config")
        local cmd = string.format("cd %s && git pull origin master", vim.fn.shellescape(vimstar_dir))
        vim.cmd("!" .. cmd)
      end, desc = "Update VimStar" },
    { "<leader>ql", "<cmd> Lazy <CR>", desc = "Manage plugins with Lazy" },
    { "<leader>qm", "<cmd> Mason <CR>", desc = "Manage LSP and linters with Mason" },
    { "<leader>qt", "<cmd> TSUpdate <CR>", desc = "Update Treesitter highlighting" },

    -- Debug menu
    { "<leader>d", group = "Debug" },
    { "<leader>db", function()
      if not pcall(require, "dap") then
        vim.notify("Please install debugpy (Python) or jdtls (Java) for debugging support", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require("dap").toggle_breakpoint() 
    end, desc = "Toggle Breakpoint" },
    { "<leader>dB", function()
      if not pcall(require, "dap") then
        vim.notify("Please install debugpy (Python) or jdtls (Java) for debugging support", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) 
    end, desc = "Conditional Breakpoint" },
    { "<leader>dc", function()
      if not pcall(require, "dap") then
        vim.notify("Please install debugpy (Python) or jdtls (Java) for debugging support", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require("dap").continue() 
    end, desc = "Continue" },
    { "<leader>dx", function()
      if not pcall(require, "dap") then
        vim.notify("Please install debugpy (Python) or jdtls (Java) for debugging support", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require("dap").terminate() 
    end, desc = "Terminate" },
    { "<leader>do", function()
      if not pcall(require, "dap") then
        vim.notify("Please install debugpy (Python) or jdtls (Java) for debugging support", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require("dap").step_over() 
    end, desc = "Step Over" },
    { "<leader>di", function()
      if not pcall(require, "dap") then
        vim.notify("Please install debugpy (Python) or jdtls (Java) for debugging support", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require("dap").step_into() 
    end, desc = "Step Into" },
    { "<leader>dt", function()
      if not pcall(require, "dap") then
        vim.notify("Please install debugpy (Python) or jdtls (Java) for debugging support", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require("dap").step_out() 
    end, desc = "Step Out" },
    -- Code Menu
    { "<leader>c", group = "Code" },
    { "<leader>ca", function()
      if not pcall(require, "codecompanion") then
        vim.notify("Please install Ollama to enable AI features (visit ollama.com)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require("CodeCompanionActions").run() 
    end, mode = "v", desc = "AI Actions on Selection" },
    { "<leader>cc", function()
      if not pcall(require, "codecompanion") then
        vim.notify("Please install Ollama to enable AI features (visit ollama.com)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require("codecompanion").chat() 
    end, desc = "AI Chat" },
    { "<leader>ci", function()
      if not pcall(require, "codecompanion") then
        vim.notify("Please install Ollama to enable AI features (visit ollama.com)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require("CodeCompanionInline").run() 
    end, mode = {"n", "v"}, desc = "Inline AI Edit" },
    { "<leader>cw", function()
          require("neocodeium").toggle()
          -- Optional: notify for feedback
          if require("neocodeium").visible() or vim.fn.exists(":NeoCodeium") == 2 then
            vim.notify("NeoCodeium: " .. (require("neocodeium").get_status() and "Enabled" or "Disabled"),
              vim.log.levels.INFO)
          end
      end, desc = "Toggle Neocodeium (Windsurf)" },
    -- Java Menu
    { "<leader>j", group = "Java" },
    { "<leader>jd", function()
      if not pcall(require, "jdtls") then
        vim.notify("Please install jdtls for Java support (run :Mason)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require('jdtls').test_class() 
    end, desc = "Java Test Class" },
    { "<leader>jn", function()
      if not pcall(require, "jdtls") then
        vim.notify("Please install jdtls for Java support (run :Mason)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require('jdtls').test_nearest_method() 
    end, desc = "Java Test Nearest" },
    { "<leader>ji", function()
      if not pcall(require, "jdtls") then
        vim.notify("Please install jdtls for Java support (run :Mason)", vim.log.levels.WARN, { title = "VimStar" })
        return
      end
      require('jdtls').organize_imports() 
    end, desc = "Java Organize Imports" },
    
    -- Wiki Menu
    { "<leader>w", group = "Wiki" },
    { "<leader>wi", "<cmd>lua vim.cmd('WikiJournalIndex')<CR>", desc = "Wiki Journal Index" },

    -- Find Menu
    { "<leader>f", group = "Find Menu" },
    { "<leader>fs", "<cmd> Telescope find_files <CR>", desc = "Telescope Find Files" },
    { "<leader>fp", "<cmd> Telescope git_files <CR>", desc = "Telescope Git Files" },
    { "<leader>fz", "<cmd> Telescope live_grep <CR>", desc = "Telescope Live Grep" },
    { "<leader>fg", builtin.live_grep, desc = "Live Grep" },
    { "<leader>fj", function()
      local journal_path = vim.g.wiki_root .. '/journal'
      builtin.live_grep({
        cwd = vim.fn.expand(journal_path)
      })
    end, desc = "Find Journal Entries" },
    { "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "Telescope Old Files" },

    -- Git Menu
    { "<leader>g", group = "Git" },
    { "<leader>gb", "<cmd> Gedit HEAD <CR>", desc = "Git Browse Head" },
    { "<leader>gc", "<cmd> Git commit <CR>", desc = "Git Commit" },
    { "<leader>gm", "<cmd> Git difftool -y master <CR>", desc = "Git Diff Master" },
    { "<leader>ga", "<cmd> Git difftool -y main <CR>", desc = "Git Diff Main" },
    { "<leader>gp", "<cmd> Gitsigns preview_hunk <CR>", desc = "Preview Hunk" },
    { "<leader>gs", "<cmd> Git <CR>", desc = "Git Status" },
    { "<leader>gt", "<cmd> Gitsigns toggle_current_line_blame <CR>", desc = "Toggle Current Line Blame" },

  })

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

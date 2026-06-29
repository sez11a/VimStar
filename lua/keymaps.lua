local map = vim.keymap.set
local expr_options = { expr = true, silent = true }
--Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

local blocks = require("vimstar.blocks")
local builtin = require("telescope.builtin")
local wk = require("which-key")

wk.add(
  {
    -- Debug Menu
    { "<leader>d", group = "Debug" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Conditional Breakpoint" },
    { "<leader>dc", "<cmd> DapContinue <CR>", desc = "Continue" },
    { "<leader>dx", "<cmd> DapTerminate <CR>", desc = "Terminate" },
    { "<leader>do", "<cmd> DapStepOver <CR>", desc = "Step Over" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dt", function() require("dap").step_out() end, desc = "Step Out" },
    -- Code Menu
    { "<leader>c", group = "Code" },
    { "<leader>ca", "<cmd> CodeCompanionActions<CR>", mode = "v", desc = "AI Actions on Selection" },
    { "<leader>cc", "<cmd> CodeCompanionChat Toggle <CR>", desc = "AI Chat" },
    { "<leader>ci", "<cmd> CodeCompanionInline<CR>", mode = {"n", "v"}, desc = "Inline AI Edit" },
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
    { "<leader>jd", function() require('jdtls').test_class() end, desc = "Java Test Class" },
    { "<leader>jn", function() require('jdtls').test_nearest_method() end, desc = "Java Test Nearest" },
    { "<leader>ji", function() require('jdtls').organize_imports() end, desc = "Java Organize Imports" },
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
    { "<leader>gp", "<cmd> Gitsigns preview_hunk <CR>", desc = "Preview Hunk" },
    { "<leader>gs", "<cmd> Git <CR>", desc = "Git Status" },
    { "<leader>gt", "<cmd> Gitsigns toggle_current_line_blame <CR>", desc = "Toggle Current Line Blame" },
    -- Block and Save Menu
    { "<leader>k", group = "Block and Save" },
    { "<leader>kb", blocks.mark_begin, desc = "Mark Block Begin" },
    { "<leader>kc", blocks.copy_block, desc = "Copy Block" },
    { "<leader>ke", "<cmd> enew <CR>", desc = "New Buffer" },
    { "<leader>kf", "<cmd> terminal <CR>", desc = "Open Terminal" },
    { "<leader>kh", blocks.toggle_visibility, desc = "Hide/Show Block" },
    { "<leader>kj", "<cmd> bd <CR>", desc = "Close Buffer" },
    { "<leader>kk", blocks.mark_end, desc = "Mark Block End" },
    { "<leader>kl", "<cmd> cd %:p:h |<CR>|", desc = "Change Working Dir" },
    { "<leader>km", "<cmd> MarkmapSave <CR>", desc = "Save Markmap" },
    { "<leader>kn", blocks.toggle_column_mode, desc = "Toggle Column Mode" },
    { "<leader>ko", "<cmd> Explore <CR>", desc = "Open File" },
    { "<leader>kq", "<cmd> q! <CR>", desc = "Abandon Changes and Quit" },
    { "<leader>kr", "<cmd> Neotree buffers reveal float <CR>", desc = "Switch Buffer" },
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
    { "<leader>ku", require("vimstar.blocks").toggle_previous_block, desc = "Toggle Previous Block" },
    { "<leader>kv", blocks.move_block, desc = "Move Block" },
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
    { "<leader>ky", blocks.delete_block, desc = "Delete Block" },
    { "<leader>k<", require("vimstar.blocks").unmark_block, desc = "Unmark Block" },

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
    { "<leader>om", "<cmd> MarkmapOpen <CR>", desc = "Open Markmap" },
    { "<leader>on", "<cmd> ZenmodeToggle <CR>", desc = "Toggle Distraction-free Mode" },
    { "<leader>oo", "<cmd> set nospell <CR>", desc = "Spell Check Off" },
    { "<leader>oi", "<Plug>CycleListType", desc = "Cycle List Type" },
    { "<leader>op", "<cmd> LivePreview start <CR>", desc = "Markdown Live Preview" },
    { "<leader>oq", "<cmd> LivePreview close <CR>", desc = "Stop Live Preview" },
    { "<leader>or", vim.lsp.buf.references, desc = "Show References" },
    { "<leader>os", "<cmd> set spell <CR>", desc = "Spell Check" },
    { "<leader>ot", "<cmd>TypstPreview toggle <CR>", desc = "Typst Preview Toggle" },
    { "<leader>ow", "<cmd> MarkmapWatch <CR>", desc = "Markmap Watch" },
    -- Print Controls Menu 
    { "<leader>p", group = "Print Controls" },
    { "<leader>pb", "<cmd> Pandoc pdf --pdf-engine=lualatex --standalone --top-level-division=chapter --template ~/.VimStar/templates/latex/book.tex <CR>", desc="Convert Markdown to PDF: book template (LaTeX)" },
    { "<leader>pp", "<cmd> Pandoc pdf --pdf-engine lualatex --standalone --template ~/.VimStar/templates/latex/article-handout.tex <CR>", desc = "Convert Markdown to PDF: article/handout template (LaTeX)" },
    { "<leader>pe", "<cmd> Pandoc pdf --pdf-engine lualatex --template ~/.VimStar/templates/latex/planner-page.tex <CR>", desc = "Convert Markdown to PDF: planner page template (LaTeX)" },
    { "<leader>pB", "<cmd> Pandoc pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/book.typ <CR>", desc="Convert Markdown to PDF: book template (Typst)" },
    { "<leader>pP", "<cmd> Pandoc pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/article-handout.typ <CR>", desc="Convert Markdown to PDF: article/handout template (Typst)" },
    { "<leader>pE", "<cmd> Pandoc pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/planner-page.typ <CR>", desc="Convert Markdown to PDF: planner page template (Typst, n-up)" },
    { "<leader>pk", "<cmd> Pandoc pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/book-bookly.typ <CR>", desc="Convert Markdown to PDF: bookly book template (Typst)" },
    { "<leader>pm", "<cmd> MarkmapOpen <CR>", desc = "View Mindmap in Browser" },
    { "<leader>ps", "<cmd> MarkmapSave <CR>", desc = "Save Mindmap; don't open it" },
    { "<leader>po", "<cmd> Pandoc odt <CR>", desc = "Convert Markdown to ODT"},

    -- Quick Menu
    { "<leader>q", group = "Quick Menu" },
    { "<leader>qb", blocks.jump_to_begin, desc = "Jump to Block Begin" },
    { "<leader>qf", builtin.live_grep, desc = "Find in Files"},
    { "<leader>qk", blocks.jump_to_end, desc = "Jump to Block End" },
    { "<leader>ql", "<cmd> Lazy <CR>", desc = "Manage plugins with Lazy" },
    { "<leader>qm", "<cmd> Mason <CR>", desc = "Manage completions and linters with Mason" },
    { "<leader>qt", "<cmd> TSUpdate <CR>", desc = "Update Treesitter highlighting" },
    { "<leader>qv", blocks.jump_to_source, desc = "Jump to Move Source" },
  })

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

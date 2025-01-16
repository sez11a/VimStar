return {
  {
  'lervag/wiki.vim',
    init = function()
      vim.g.wiki_journal = {
--        name = 'journal',
--        root = '',
--        frequency = 'daily',
        date_format = {
          daily = '%Y/%m/%d',
          weekly = '%Y/week_%V',
          monthly = '%Y/%m/summary',
        },
      }
      vim.g.wiki_templates = {
        {
          match_func = function(context)
            return context.path_wiki:find "%d%d%d%d/%d%d/plan"
          end,
          source_filename = "~/.VimStar/wiki/templates/monthly.md"
        },
        {
          match_func = function(context)
            return context.path_wiki:find "agendas/."
          end,
          source_filename = "~/.VimStar/wiki/templates/agenda.md"
        },
        {
          match_func = function(context)
            return context.path_wiki:find "actions/."
          end,
          source_filename = "~/.VimStar/wiki/templates/actions.md"
        },
        {
          match_func = function(context)
            return context.path_wiki:find "notes/."
          end,
          source_filename = "~/.VimStar/wiki/templates/notes.md"
        },
        {
          match_func = function(context)
            return context.path_wiki:find "projects/."
          end,
          source_filename = "~/.VimStar/wiki/templates/project.md"
        },
        {
          -- The daily plan is a catch-all matched last as a function
          --match_re = ".*",
          -- source_func = function(ctx)
          match_func = function(context)
            if context.path_wiki:find "%d%d%d%d/%d%d/%d%d" then
              vim.api.nvim_put({
                  "---",
                  "title: " .. os.date("%A, %B %d, %Y"),
                  "---",
                  "",
                  os.date("[%B %Y](/journal/%Y/%m/plan.md)"),
                  "",
                  "# Schedule",
                  "",
                  "# Actions",
                  "",
                  "# Roles",
                  "",
                  "# Notes",
                }, "l", false, false)
            end
        end
        },
      }
      vim.cmd[[noremap [w <plug>(wiki-journal-prev)]]
      vim.cmd[[noremap ]w <plug>(wiki-journal-next)]]
      vim.cmd[[noremap <leader>wi <plug>(wiki-journal-index)]]
    end
  },
  {
  'lervag/lists.vim',
    init = function()
      vim.g.lists_filetypes = {
          'md',
          'mkd'
      }
    end
  },
  --  Markdown Markmap, not related to wiki but used within it
  {
    "Zeioth/markmap.nvim",
    build = "yarn global add markmap-cli",
    cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
    opts = {
      html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
      hide_toolbar = false, -- (default)
      grace_period = 3600000 -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
    },
    config = function(_, opts) require("markmap").setup(opts) end
  },
}

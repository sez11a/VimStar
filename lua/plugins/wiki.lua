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
            return context.path_wiki:find "%d%d%d%d/%d%d/%d%d"
          end,
          source_filename = "~/.VimStar/wiki/templates/daily.md"
        },
      }
    end
  },
  {
  'lervag/lists.vim',
  }
}

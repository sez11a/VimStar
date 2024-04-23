return {
  {
  'lervag/wiki.vim',
    config = function()
      vim.g.wiki_journal = {
        name = 'journal',
        root = '',
        frequency = 'daily',
        date_format = {
          daily = '%Y/%m/%d',
          weekly = '%Y/week_%V',
          monthly = '%Y/%m/summary',
        },
      }
    end
  },
  {
  'lervag/lists.vim',
  }
}

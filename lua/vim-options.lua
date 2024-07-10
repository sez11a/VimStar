vim.g.mapleader = " "

vim.wo.number = true
vim.cmd("filetype plugin indent on")
vim.cmd("set guicursor+=i:blinkon100")
vim.cmd("set nofixeol")
vim.opt.encoding = "utf-8"
vim.opt.signcolumn = "yes"
vim.opt.syntax = "on"
vim.opt.laststatus = 2
vim.opt.background = "dark"
vim.opt.backspace = "indent,eol,start"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.diffopt:append { "followwrap" }
vim.opt.linebreak = true
vim.opt.spell = true
vim.netrw_liststyle = 2
vim.g.vim_markdown_folding_disabled = 1
vim.g.voom_tree_placement = "right"
vim.g.voom_tree_width = 55
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 2
vim.o.guifont = "IosevkaTermSlab Nerd Font Mono:h12"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.vim_markdown_frontmatter = 1
vim.opt.thesaurus:append { "~/.config/nvim/thesaurus/mthesaur.txt" }
vim.cmd("autocmd BufEnter * if &filetype == '' | setlocal ft=markdown | endif")
vim.cmd("set complete+=s")
vim.o.hidden = true
vim.g.airline_theme = "minimalist"
vim.cmd("let g:airline#extensions#tabline#enabled=1")
vim.g.airline_powerline_fonts = 1

function WikiMonthLink()
  return print(os.date("[%B %Y](/journal/%Y/%m/plan.md)"))
end

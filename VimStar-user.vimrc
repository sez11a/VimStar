" VimStar User Config 
"
" VimStar defaults to a word processor configuration, with 
" leader mappings inspired by WordStar. This file is sourced 
" last, so it's an ideal place to put default settings that 
" users might want to change. 
"
" If you mess something up, A copy of this file sits in the 
" .VimStar folder, ready to be copied to your root, so you 
" can reset everything to the defaults. 
"

" Enable Syntax highlighting
syntax on

" Enable indenting
filetype plugin indent on

" Word Processor color scheme
set background=dark
colorscheme xoria256-blue

" No vi compatibility
set nocompatible
set encoding=utf-8

"Airline Configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='raven'
let g:airline_detect_spell = 0
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#tabline#buffer_nr_show = 1

" Always display status line
set laststatus=2

" Config for word processing
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Ignore case when searching
set ignorecase

" If a pattern has an uppercase letter, it's case sensitive
set smartcase
set number

" Wrap automatically
set wrap
set linebreak
set nolist

" Wrap at 80 columns
set textwidth=80

filetype plugin on
set ofu=syntaxcomplete#Complete

" Never fold Markdown files
let g:vim_markdown_folding_disabled=1

" Never auto-insert bullets; conflicts with Pencil
let g:vim_markdown_auto_insert_bullets=0

" Don't automatically show Markdown preview
let g:markdown_composer_autostart=0

" Whitespace detection off for word processing
let g:better_whitespace_enabled=0

" Preserve whitespace for word processing
let g:strip_whitespace_on_save=0

" Put the menus at the top of the screen
let g:leaderGuide_position = "topleft"

" Default edit mode is word processing
let g:editmode=1

" No tabs; just spaces
set expandtab

" Set spelling config and language
set spell spelllang=en_us
set thesaurus+=~/.vim/thesaurus/mthesaur.txt

" Default file type is Markdown
autocmd BufEnter * if &filetype == "" | setlocal ft=markdown | endif

" Enable Pencil word processing plugin
let g:pencil#wrapModeDefault = 'hard'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init({'wrap': 'hard'})
augroup END

" Quit NERDTree on open
let NERDTreeQuitOnOpen = 1

" Javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete


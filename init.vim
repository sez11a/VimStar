" Configuration Directory
if empty($vimstar_options) 
    let $vimstar_options = "~/.VimStar/options"
endif

let mapleader=" "

" Main configuration
source $vimstar_options/start.vim

let g:leaderGuide_position = "topleft"
syntax on
filetype plugin indent on

" Set the font and window size
if has ('gui_running')
"    set guifont=Anonymous\ Pro\ for\ Powerline\ 12
"    The VGA font below doesn't have bold/italic variants and so had display
"    problems.
"    Guifont! Nouveau_IBM Nerd Font:h18
    Guifont! TerminessTTF Nerd Font Mono:h12
	set lines=50
	set columns=100
endif

set background=dark
colorscheme xoria256

" No vi compatibility
set nocompatible
set encoding=utf-8
"let g:airline_detect_whitespace=0
"let g:airline#extensions#whitespace#enabled
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='murmur'
set laststatus=2

set backspace=indent,eol,start
set tabstop=4
set expandtab 
set softtabstop=4
set shiftwidth=4
set ignorecase
set smartcase
set number
set wrap
set linebreak
set nolist
set textwidth=0
"set ttyscroll=0
"set clipboard=unnamedplus

" nnoremap j gj
" nnoremap k gk

" Save when focus is lost
" au FocusLost * :wa

" Turn on omnicompletion
filetype plugin on
set ofu=syntaxcomplete#Complete

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_auto_insert_bullets=0
let g:markdown_composer_autostart=0
let g:airline#extensions#whitespace#enabled=0
let g:editmode=0

" Javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" This starts WP mode on markdown files, but it wreaks havoc with airline
"autocmd FileType markdown call WordProcessorMode()
"
"Here's another way I tried that also didn't work:
"
"augroup ws
"    autocmd!
"    autocmd FileType markdown,mkd call WordProcessorMode()
"    autocmd FileType text         call WordProcessorMode()
"augroup END

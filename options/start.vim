" Plugins

source $vimstar_options/plugins.vim

" Editing Modes
source $vimstar_options/modes.vim

" Leader Guide
source $vimstar_options/leader-guide.vim

" Key Maps
source $vimstar_options/keymaps.vim

" Startify
source $vimstar_options/startify.vim

" The options below are VimStar defaults. They can be 
" overridden in .VimStar-user.vimrc, which is sourced 
" last and should be in your user folder. 

" Enable Syntax highlighting
syntax on

" Enable indenting
filetype plugin indent on

" Word Processor color scheme
set background=dark
colorscheme xoria256-blue
hi SignColumn guibg=black ctermbg=black
set signcolumn=yes

" No vi compatibility
set nocompatible
set encoding=utf-8

"Airline Configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='minimalist'
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
call deoplete#custom#option('auto_complete', v:false)

" Ignore case when searching
set ignorecase

" If a pattern has an uppercase letter, it's case sensitive
set smartcase
set nonumber

" Wrap automatically
set wrap
set linebreak
set nolist

" Wrap at 80 columns
set textwidth=80

filetype plugin on
set ofu=syntaxcomplete#Complete

" Blinking cursor in insert mode
set guicursor+=i:blinkon1

" Remove Buffergator default keymaps
let g:buffergator_suppress_keymaps=1
" Never fold Markdown files
let g:vim_markdown_folding_disabled=1

" Never auto-insert bullets; conflicts with Pencil
let g:vim_markdown_auto_insert_bullets=0

" Enable fenced code blocks for software documentation
let g:vim_markdown_fenced_languages = ['properties=jproperties', 'bash=sh', 'markup=jsp']

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
let g:wrapmode=1

" No tabs; just spaces
set expandtab

" Set spelling config and language
set spell spelllang=en_us
set thesaurus+=~/.vim/thesaurus/mthesaur.txt

" Default file type is Markdown
autocmd BufEnter * if &filetype == "" | setlocal ft=markdown | endif

" Have complete include the thesaurus
set complete+=s

" Don't require saving buffers to switch buffers
set hidden

" Enable Pencil word processing plugin
let g:pencil#wrapModeDefault = 'hard'
let g:pencil#autoformat = 0
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init({'wrap': 'hard', 'autoformat': 0})
  autocmd FileType text         call pencil#init({'wrap': 'hard', 'autoformat': 0})
augroup END

let g:pencil#map#suspend_af = 'K'   " default is no mapping

" Quit NERDTree on open
"let NERDTreeQuitOnOpen = 1

" Javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete


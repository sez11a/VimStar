" Plugins

source $vimstar_options/plugins.vim

" Editing Modes
source $vimstar_options/modes.vim

" Quick UI
source $vimstar_options/quickui.vim

" Key Maps
source $vimstar_options/keymaps.vim

" Startify
source $vimstar_options/startify.vim

" The options below are VimStar defaults. They can be
" overridden in .VimStar-user.vimrc, which is sourced
" last and should be in your user folder.

" Blinking cursor in insert mode
set guicursor+=i:blinkon100

" Browse files the WordStar way
let g:netrw_liststyle = 2

" Enable Syntax highlighting
syntax on

" Enable indenting
filetype plugin indent on

" Word Processor color scheme
let $wpcolors='xoria256-blue'
let $codecolors='xoria256'
set background=dark
colorscheme $wpcolors
hi SignColumn guibg=black ctermbg=black
set signcolumn=yes

" No vi compatibility
set nocompatible
set encoding=utf-8
" set clipboard+=unnamedplus

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
set tabstop=3
set softtabstop=3
set shiftwidth=3

" Ignore case when searching
set ignorecase

" If a pattern has an uppercase letter, it's case sensitive
set smartcase
set number
set relativenumber

" Wrap automatically
set wrap
set linebreak
set nolist

" Wrap at 80 columns
set textwidth=80

filetype plugin on
set ofu=syntaxcomplete#Complete

" Remove netrw banner
let g:netrw_banner = 0

" Start deoplete, but disable it in default WP mode
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete', v:false)

" Remove Buffergator default keymaps
let g:buffergator_suppress_keymaps=1
" Never fold Markdown files
let g:vim_markdown_folding_disabled=1

" Never auto-insert bullets; conflicts with Pencil
" let g:vim_markdown_auto_insert_bullets=0

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
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#autoformat = 0
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init({'wrap': 'hard', 'autoformat': 0})
augroup END

let g:pencil#map#suspend_af = 'K'   " default is no mapping

" Voom outline tree
let g:voom_tree_placement = "right"
let g:voom_tree_width = 55

" ALE Linter
let g:ale_enabled = 0
let g:ale_linters_explicit = 1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_save = 1
" let g:ale_fix_on_save = 1
let g:ale_linters = {
\	'markdown':		['markdownlint'],
\}
" let g:ale_fixers = {
" \	'markdown': [''],
" \}

" Quit NERDTree on open
"let NERDTreeQuitOnOpen = 1

" Javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" FZF
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" Vimwiki should not take over Markdown syntax
let g:vimwiki_ext2syntax = {}

" Vimwiki Diary
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

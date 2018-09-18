" Configuration Directory
if empty($vimstar_options) 
    let $vimstar_options = "~/.VimStar/options"
endif

let mapleader=" "

" Main configuration
source $vimstar_options/start.vim

" User configuration
source ~/.VimStar-user.vimrc

"set ttyscroll=0
"set clipboard=unnamedplus

" nnoremap j gj
" nnoremap k gk

" Save when focus is lost
" au FocusLost * :wa

" Turn on omnicompletion
"
"Here's another way I tried that also didn't work:
"
"augroup ws
"    autocmd!
"    autocmd FileType markdown,mkd call WordProcessorMode()
"    autocmd FileType text         call WordProcessorMode()
"augroup END

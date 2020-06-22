" Configuration Directory
if empty($vimstar_options)
    let $vimstar_options = "~/.VimStar/options"
endif

" Main configuration
source $vimstar_options/start.vim

" User configuration
source ~/.VimStar-user.vimrc

" Save when focus is lost
" au FocusLost * :wa


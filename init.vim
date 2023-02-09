" Configuration Directory
if empty($vimstar_options)
    let $vimstar_options = "~/.VimStar/options"
endif

" Main configuration
source $vimstar_options/start.vim
:luafile $vimstar_options/../lua/init.lua

" User configuration
source ~/.VimStar-user.vimrc

" Save when focus is lost
" au FocusLost * :wa


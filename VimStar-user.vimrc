" VimStar User Config
"
" VimStar defaults to a word processor configuration, with
" keyboard mappings inspired by WordStar. This file is sourced
" last, so it's an ideal place to put default settings that
" users might want to change.
"
" If you mess something up, A copy of this file sits in the
" .VimStar folder, ready to be copied to your root, so you
" can reset everything to the defaults.
" 
" Below are some things you might want to do. 
"
" Change the default color schemes. This redefines the default 
" scheme to Dracula (which also ships with VimStar) and then 
" sets it to override the default xoria256-blue color scheme. 
"
" let $wpcolors='dracula'
" let $codecolors='xoria256'
"
" Other color schemes are palenight, purify, and nightfox.

" colorscheme $wpcolors

" Add new plugins. For example, VimStar by default uses the 
" built-in netrw file manager, configured to look similar 
" to WordStar 7.0's file manager. You might instead prefer 
" NERDTree or even better, vifm if you already have it 
" installed: 
" Plug 'vifm/vifm.vim'

" Once you have vifm configured, you might want to change the 
" menu entries to call it instead of netrw: 

" let blocksave = [
" 			  \ [ "Save &d", 'w' ],
" 			  \ [ "New &e", 'enew' ],
" 			  \ [ "Close &j", 'bd' ],
" 			  \ [ "Save and Exit &x", 'wq'],
" 			  \ [ "Open/Switch &o", 'EditVifm'],
" 			  \ [ "Abandon Changes &q", 'q!'],
" 			  \ [ "Update Plugins &u", 'PlugUpdate'],
" 			  \ [ "Terminal &f", 'terminal'],
" 			  \ [ "Change Working Dir &l", 'cd %:p:h']
" 			  \]
" let bopts = {'Block & Save': 'select one'}
" noremap <C-k> :call quickui#listbox#open(blocksave,bopts)<cr>

" Anything you could do to configure Vim/Neovim to your liking, 
" you can do here. Enjoy!

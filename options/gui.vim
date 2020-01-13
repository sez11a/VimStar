" GUI Settings

" Default mode is normal
let g:focusmode=0

" If you wish for nostalgia, this font is in the 
" .VimStar/fonts folder. 
" Guifont! PxPlus_IBM_VGA9 Nerd Font:h14

" Use a modern mono font good for code and writing. 
Guifont! Iosevka Slab:h14

set guioptions=mr

""" FocusMode
function! ToggleFocusMode()
"if (&foldcolumn != 12)
if g:focusmode == 0
"    set laststatus=0
"    set numberwidth=10
    set foldcolumn=12
"    set noruler
    set nonumber
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0

    " Guifont! PxPlus_IBM_VGA9 Nerd Font:h18
	Guifont! Iosevka Slab:h18
	let g:focusmode=1
else
   " set laststatus=2
   " set numberwidth=4
   set foldcolumn=0
   " set ruler
    set number
    execute 'colorscheme ' . g:colors_name

	" Guifont! Anonymous Pro for Powerline:h12
	" Guifont! Space Mono:h12
	" Guifont! PxPlus_IBM_VGA9 Nerd Font:h14
	Guifont! Iosevka Slab:h14
	" set guioptions+=T
	let g:focusmode=0

endif

endfunc

" GUI Settings

" Enable Mouse
set mouse=a

" If you wish for nostalgia, this font is in the
" .VimStar/fonts folder.
" set guifont=PxPlus_IBM_VGA9\ Nerd\ Font:h14

" Use a modern mono font good for code and writing.
" set guifont=Iosevka\ Term\ Slab:h14
:execute "GuiFont! Iosevka Term Slab:h12"

set guioptions=mr
GuiTabline 0

" Enable GUI Scrollbar
if exists (':GuiScrollBar')
	GuiScrollBar 1
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv

" Blinking cursor in insert mode
set guicursor+=n-v-c:block-Cursor
set guicursor+=i:blinkwait700-blinkon400-blinkoff250
highlight Cursor guifg=black guibg=yellow
highlight iCursor guifg=red guibg=yellow

" Default mode is normal
let g:focusmode=0

""" FocusMode
function! ToggleFocusMode()
"if (&foldcolumn != 12)
if g:focusmode == 0
"    set laststatus=0
"    set numberwidth=10
"    set foldcolumn=12
"    set noruler
"    set nonumber
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0

    " Guifont! PxPlus_IBM_VGA9 Nerd Font:h18
	Guifont! Iosevka Slab:h24
	let g:focusmode=1
else
   " set laststatus=2
   " set numberwidth=4
"   set foldcolumn=0
   " set ruler
"    set number
    execute 'colorscheme ' . g:colors_name

	" Guifont! PxPlus_IBM_VGA9 Nerd Font:h14
	" set guioptions+=T
	Guifont! Iosevka Slab:h14
	let g:focusmode=0

endif

endfunc

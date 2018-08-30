"Guifont! Nouveau_IBM Nerd Font:h12
" The above font had some display problems.
" Guifont! TerminessTTF Nerd Font Mono:h12
" Guifont! Edlo:h12
" Guifont! Anonymous Pro for Powerline:h12
" Guifont! Space Mono:h12
" Guifont! ProFontUnified Nerd Font:h13
Guifont! Luxi Mono:h12
""" FocusMode
function! ToggleFocusMode()
if (&foldcolumn != 12)
"    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
"    set noruler
    set nonumber
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0

    " Guifont! Anonymous Pro for Powerline:h18 
    Guifont! Nouveau_IBM Nerd Font:h18 
    " Guifont! TerminessTTF Nerd Font Mono:h18
    " Guifont! Edlo:h12
    " Guifont! Space Mono:h18
else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    set number
    execute 'colorscheme ' . g:colors_name

            " Guifont! Anonymous Pro for Powerline:h12
           " Guifont! Space Mono:h12
            Guifont! Luxi Mono:h12
            set guioptions+=T

endif

endfunc

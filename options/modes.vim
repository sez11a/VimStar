" Editing Modes
func! WordProcessorMode() 
  " setlocal formatoptions=1 
  set spell spelllang=en_us 
  set thesaurus+=~/.vim/thesaurus/mthesaur.txt
  set complete+=s
  " setlocal linebreak 
  set wrap
  set textwidth=80
  " Look like WordStar
"  colorscheme adaryn
  colorscheme xoria256-blue
"  colorscheme transparent
  filetype detect
  nnoremap <Leader>w :NextWordy<CR>
  nnoremap <Leader>q :NoWordy<CR>
  call pencil#init()
  let g:editmode=1

endfu 
com! WP call WordProcessorMode()

func! CodeMode()
        map j gj 
        map k gk
        setlocal expandtab
        set textwidth=0
        colorscheme xoria256
        filetype detect
        :NoPencil
        let g:editmode=0
endfu
com! CODE call CodeMode()

function! ToggleWP()
    if g:editmode == 0
        call WordProcessorMode()
    else
        call CodeMode()
    endif
endfu

nnoremap <F9> :call ToggleWP()<cr>

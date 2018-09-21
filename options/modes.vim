" Editing Modes
func! WordProcessorMode()
  " setlocal formatoptions=1
  set spell spelllang=en_us
  set thesaurus+=~/.vim/thesaurus/mthesaur.txt
  set complete+=s
  " setlocal linebreak
  set expandtab
  set wrap
  set textwidth=80
  set nonumber
  " Look like WordStar
"  colorscheme adaryn
  colorscheme xoria256-blue
"  colorscheme transparent
  filetype detect
  let g:better_whitespace_enabled=0
  let g:strip_whitespace_on_save=0
  nnoremap <Leader>w :NextWordy<CR>
  nnoremap <Leader>q :NoWordy<CR>
  call pencil#init()
  let g:editmode=1

endfu
com! WP call WordProcessorMode()

func! CodeMode()
        map j gj
        map k gk
        set noexpandtab
        set textwidth=0
        set nospell
		set number
        colorscheme xoria256
        filetype detect
        :NoPencil
        let g:better_whitespace_enabled=1
        let g:strip_whitespace_on_save=1
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

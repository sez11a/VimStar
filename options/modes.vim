" Editing Modes
func! WordProcessorMode()
  " setlocal formatoptions=1
  set spell spelllang=en_us
  set thesaurus+=~/.vim/thesaurus/mthesaur.txt
  set complete+=s
  " setlocal linebreak
  set expandtab
  set wrap
  " set textwidth=80
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
  let g:wrapmode=1
  syntax sync fromstart
  call deoplete#custom#option('auto_complete', v:false)

endfu
com! WP call WordProcessorMode()

func! CodeMode()
"        map j gj
"        map k gk
        set noexpandtab
        set textwidth=0
        set nospell
		set number
		set nofixendofline "this is for Liferay
        colorscheme xoria256
        filetype detect
        :NoPencil
        let g:better_whitespace_enabled=1
        let g:strip_whitespace_on_save=1
        let g:editmode=0
		let g:wrapmode=0
        syntax sync fromstart
		let g:deoplete#omni_patterns = {}
		let g:deoplete#omni_patterns.java = '[^. *\t]\. \w*'
		let g:deoplete#auto_completion_start_length = 2
		let g:deoplete#sources = {}
		let g:deoplete#sources._ = []
		let g:deoplete#file#enable_buffer_path = 1
		call deoplete#custom#option('auto_complete', v:true)
endfu
com! CODE call CodeMode()

function! ToggleWP()
    if g:editmode == 0
        call WordProcessorMode()
    else
        call CodeMode()
    endif
endfu

function! ToggleWrap()
	if g:wrapmode == 0
		set textwidth=80
		let g:wrapmode=1
		:HardPencil
	else
		set textwidth=0
		let g:wrapmode=0
		:SoftPencil
	endif
endfu

nnoremap <F9> :call ToggleWP()<cr>

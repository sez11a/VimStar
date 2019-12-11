" Custom key combos

nmap <silent> <F3> :Explore<CR>

nnoremap <F4> :call ToggleFocusMode()<cr>
nnoremap <F5> :Latexmk<cr>
nnoremap <F8> :MarkdownPreview<cr>
nnoremap <F9> :call ToggleWP()<cr>
nnoremap <F10> :PFormatToggle<cr>

" WordStar keys using Wordchipper

inoremap <expr> <C-e> wordchipper#chipWith('k')
inoremap <expr> <C-s> wordchipper#chipWith('h')
inoremap <expr> <C-d> wordchipper#chipWith('l')
inoremap <expr> <C-x> wordchipper#chipWith('j')
inoremap <expr> <C-a> wordchipper#chipWith('b')
inoremap <expr> <C-f> wordchipper#chipWith('w')
inoremap <expr> <C-q>r wordchipper#chipWith('gg')
inoremap <expr> <C-q>c wordchipper#chipWith('G')
inoremap <expr> <C-q>s wordchipper#chipWith('0')
inoremap <expr> <C-q>d wordchipper#chipWith('$')
" inoremap <expr> <C-q>p wordchipper#chipWith('<C-o>')
inoremap <expr> <C-q>y wordchipper#chipWith('d$')
inoremap <expr> <C-q>t wordchipper#chipWith('dt')

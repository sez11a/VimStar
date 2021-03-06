" VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" VimPlug plugins
call plug#begin('~/.vim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
"
" Start deoplete in start.vim
" let g:deoplete#enable_at_startup = 1

Plug 'skywind3000/vim-quickui'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-surround'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'plasticboy/vim-markdown'
Plug 'vim-voom/VOoM'
Plug 'vim-airline/vim-airline'
Plug 'garbas/vim-snipmate'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'flazz/vim-colorschemes'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'dracula/vim'
Plug 'dahu/vimple'
Plug 'dahu/Asif'
Plug 'Raimondi/VimRegStyle'
Plug 'dahu/vim-asciidoc'
Plug 'vimoutliner/vimoutliner'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-fugitive'
Plug 'tfnico/vim-gradle'
Plug 'dbeniamine/todo.txt-vim'
Plug 'tpope/vim-speeddating'
Plug 'vim-airline/vim-airline-themes'
Plug 'reedes/vim-wordy'
Plug 'kshenoy/vim-signature'
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-wordchipper'
Plug 'iamcco/markdown-preview.nvim', {  'do': { ->mkdp#util#install() } }
Plug 'godlygeek/tabular'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
Plug 'neomake/neomake'
Plug 'andreshazard/vim-freemarker'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'ryanoasis/vim-devicons'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'airblade/vim-rooter'
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'
call plug#end()

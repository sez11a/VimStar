" VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" VimPlug plugins
call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'folke/neodev.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jay-babu/mason-null-ls.nvim'
Plug 'ms-jpq/coq_nvim', { 'branch': 'coq' }
Plug 'ms-jpq/coq.artifacts', { 'branch': 'artifacts' }
Plug 'ms-jpq/coq.thirdparty', { 'branch': '3p' }

Plug 'skywind3000/vim-quickui'
Plug 'tpope/vim-surround'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'preservim/vim-markdown'
Plug 'vim-voom/VOoM'
Plug 'vim-airline/vim-airline'
Plug 'garbas/vim-snipmate'
" Required by snipmate
Plug 'tomtom/tlib_vim'
" Required by snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
" Various Color Schemes
" Plug 'flazz/vim-colorschemes'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'dracula/vim'
Plug 'EdenEast/nightfox.nvim', { 'branch': 'main' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'joshdick/onedark.vim'
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
Plug 'iamcco/markdown-preview.nvim', {  'do': { ->mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
Plug 'godlygeek/tabular'
" Plug 'artur-shaik/vim-javacomplete2'
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
Plug 'kalafut/vim-taskjuggler'
call plug#end()

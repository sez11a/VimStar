" VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" VimPlug plugins
call plug#begin('~/.vim/plugged')

" Completion 
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

" Core functionality
Plug 'skywind3000/vim-quickui'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/vim-wordy'
Plug 'preservim/vim-pencil'
Plug 'preservim/vim-wordchipper'

" Syntax
Plug 'godlygeek/tabular' "Required by vim-markdown
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', {  'do': { ->mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
Plug 'vimoutliner/vimoutliner'
Plug 'andreshazard/vim-freemarker'
Plug 'kalafut/vim-taskjuggler'
Plug 'dbeniamine/todo.txt-vim'

" Extra Functionality
Plug 'vim-voom/VOoM' "requires Python
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'kshenoy/vim-signature'
Plug 'tomtom/tlib_vim' "required by snipmate
Plug 'MarcWeber/vim-addon-mw-utils' "required by snipmate
Plug 'garbas/vim-snipmate'
Plug 'tfnico/vim-gradle'
Plug 'ntpeters/vim-better-whitespace'
Plug 'dense-analysis/ale'
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'mhinz/vim-startify'
Plug 'neomake/neomake'
Plug 'airblade/vim-rooter'

" Various Color Schemes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'dracula/vim'
Plug 'EdenEast/nightfox.nvim', { 'branch': 'main' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'joshdick/onedark.vim'

" Testing removal
" All the below are required by vim-asciidoc
" Plug 'dahu/vimple'
" Plug 'dahu/Asif'
" Plug 'Raimondi/VimRegStyle'
" Plug 'dahu/vim-asciidoc'
"
" Plug 'jceb/vim-orgmode'
" Plug 'tpope/vim-speeddating'
" Plug 'jeetsukumaran/vim-buffergator'
call plug#end()
" VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" For Markdown Composer plugin below
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

" VimPlug plugins
call plug#begin('~/.vim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'tpope/vim-surround'
" Plug 'scrooloose/nerdtree'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'garbas/vim-snipmate'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'flazz/vim-colorschemes'
Plug 'dahu/vim-asciidoc'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-fugitive'
Plug 'tfnico/vim-gradle'
Plug 'dbeniamine/todo.txt-vim'
Plug 'tpope/vim-speeddating'
Plug 'vim-airline/vim-airline-themes'
Plug 'reedes/vim-wordy'
Plug 'kshenoy/vim-signature'
Plug 'reedes/vim-pencil'
Plug 'euclio/vim-markdown-composer'
Plug 'godlygeek/tabular'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'hecal3/vim-leader-guide'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
Plug 'neomake/neomake'
Plug 'andreshazard/vim-freemarker'
call plug#end()

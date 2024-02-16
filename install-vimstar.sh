#!/usr/bin/env bash

echo "This script installs VimStar, a Neovim distribution with a writing and programming focus."
echo "Beginning install..."

cd ~

if [ ! -d ".VimStar" ]; then
    echo "Cloning VimStar from GitHub into ~/.VimStar..."
    git clone https://github.com/sez11a/VimStar ~/.VimStar
else
    echo "Updating VimStar from GitHub..."
    git -C ~/.VimStar pull
fi

# Ensure .config exists
mkdir -p ~/.config/

# Ensure spell exists
mkdir -p ~/.VimStar/spell

echo "Symbolic linking Neovim config..."
#ln -sfnv ~/.VimStar ~/.vim
ln -sfnv ~/.VimStar ~/.config/nvim
#ln -sfnv ~/.VimStar/init.vim ~/.VimStar/vimrc
#ln -sfnv ~/.VimStar/options/gui.vim ~/.VimStar/ginit.vim

if [ ! -f ".VimStar.vimrc" ]; then
    echo "Copying default config to ~/.VimStar.vimrc"
    cp ~/.VimStar/vimstar-user-template ~/.VimStar/vimstar-user.lua
fi

# echo "Installing Vim-Plug"
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Install finished! Run Neovim to finish setup!"


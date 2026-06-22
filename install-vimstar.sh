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

if [[ "$OSTYPE" == "darwin"* ]]; then
    NVIM_CONFIG_DIR="$HOME/Library/Application Support/nvim"
else
    NVIM_CONFIG_DIR="$HOME/.config/nvim"
fi

mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"

mkdir -p ~/.VimStar/spell

echo "Symbolic linking Neovim config..."
if ! ln -sfnv ~/.VimStar "$NVIM_CONFIG_DIR" 2>&1; then
    echo "Error: Failed to create symlink at $NVIM_CONFIG_DIR"
    exit 1
fi

if [ ! -f ".VimStar.vimrc" ]; then
    echo "Copying default config to ~/.VimStar.vimrc"
    cp ~/.VimStar/vimstar-user-template ~/.VimStar/lua/vimstar-user.lua
fi

if ! command -v nvim &> /dev/null; then
    echo "Warning: Neovim not found. VimStar installed but requires Neovim to work."
fi

echo "Install finished! Run Neovim to finish setup!"


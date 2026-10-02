# Project: VimStar

This is a Neovim distribution implemented in Lua, using the Lazy plugin manager. 

## Quick Start

- Before doing anything with VimStar, read this skill: `./agents/skills/vimstar-purpose`
- Run Neovim to load the distribution; plugins install automatically via Lazy.nvim
- If prompted to create or edit a template, read this skill: `./agents/skills/vimstar-templates`

## Installation

- **Linux**: `curl -sLf https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.sh | bash`
- **macOS**: `curl -sLf https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.sh | bash`
- **Windows**: `Set-ExecutionPolicy Bypass -Scope Process -Force; irm https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.ps1 | iex`
- Installs to `~/.VimStar` (symlinked to Neovim config dir: `~/.config/nvim` on Linux, `~/Library/Application Support/nvim` on macOS, `$env:LOCALAPPDATA/nvim` on Windows)

## Important Constraints

- **Map leader**: Both `<leader>` and `<localleader>` are Space (`vim.g.mapleader = " "`)
- **Wiki root**: Defaults to `~/.VimStar/wiki`; override in `vimstar-user.lua`
- **Spell check**: Enabled for markdown, typst, tex, plaintex, latex filetypes only
- **Indent**: 2 spaces, expandtab by default; 4 spaces for everything else via tabset.nvim.

# Project: VimStar

This is a Neovim distribution implemented in Lua, using the Lazy plugin manager. 

## Quick Start

- Before doing anything with VimStar, read this skill: `./agents/skills/vimstar-purpose`
- Users run Neovim to load the distribution; plugins install automatically via Lazy.nvim
- If prompted to create or edit a template, read this skill: `./agents/skills/vimstar-templates`

## Installation

- **Linux**: `curl -sLf https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.sh | bash`
- **macOS**: `curl -sLf https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.sh | bash`
- **Windows**: `Set-ExecutionPolicy Bypass -Scope Process -Force; irm https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.ps1 | iex`
- Installs to `~/.VimStar` (symlinked to Neovim config dir: `~/.config/nvim` on Linux, `~/Library/Application Support/nvim` on macOS, `$env:LOCALAPPDATA/nvim` on Windows)

## Important Constraints

- **Map leader**: Both `<leader>` and `<localleader>` are Space (`vim.g.mapleader = " "`)
- **Wiki root**: Defaults to `~/.VimStar/wiki`; override in `vimstar-user.lua`
- **Install paths**: This repo (`~/.VimStar`) **is** the user install directory and is symlinked onto Neovim's config dir (`~/.config/nvim` on Linux). Neovim **data/state lives outside** the repo: `~/.local/share/nvim` (Lazy installs plugins under its `lazy/` subdir; Mason stores packages there) and `~/.local/state/nvim`. When inspecting installed plugins (e.g. `nvim-treesitter`), look in `~/.local/share/nvim/lazy/` — NOT under `~/.VimStar`.
- **Spell check**: Enabled for markdown, typst, tex, plaintex, latex filetypes only
- **Indent**: 2 spaces, expandtab by default; 4 spaces for everything else via tabset.nvim.

## Documentation Overrides

- Do not create Related Topics sections in this site.
- When asked to write a post, the language can be more casual. Other sections should follow the technical writing skills.
- Do not write documentation (instructions) in posts. Summarize the feature functionality only, and elaborate on how users might use the feature. 
- If asked to do a post about a feature and you don't find documentation about the feature, offer to write it in the appropriate place.

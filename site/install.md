---
layout: page
title: "Install"
description: "Install VimStar on Linux, macOS, or Windows"
permalink: /install/
---

VimStar installs to `~/.VimStar` and automatically downloads plugins via Lazy.nvim.

The installation script creates a symlink to Neovim's config directory:
- Linux: `~/.config/nvim`
- macOS: `~/Library/Application Support/nvim`
- Windows: `$env:LOCALAPPDATA\nvim`

## Requirements

- Git (available in PATH)
- Neovim 0.9+ (required for Lazy.nvim)
- pandoc (optional, for PDF publishing)

## Linux/macOS

```bash
curl -sLf https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.sh | bash
```

**What happens:**
1. Clones/updates VimStar to `~/.VimStar`
2. Creates Neovim config symlink (platform-specific)
3. Creates spell directory `~/.VimStar/spell/`
4. Copies user template if not present

After installation, run `nvim` to finish setup (plugins download automatically).

**Note:** The script detects your OS and uses the correct Neovim config directory.

## Windows

Open PowerShell and run:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
irm https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.ps1 | iex
```

**Note:** The Windows script creates a symbolic link. Report any issues in the GitHub repository.

## Manual Installation (Advanced)

```bash
# Clone the repository
git clone https://github.com/sez11a/VimStar ~/.VimStar

# Create symlink (Linux)
ln -sfn ~/.VimStar ~/.config/nvim

# Create symlink (macOS)
ln -sfn ~/.VimStar ~/Library/Application\ Support/nvim

# Create symlink (Windows PowerShell)
New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\nvim -Target ~/.VimStar -Force
``

## First Launch

1. Run `nvim`
2. Wait for Lazy.nvim to install plugins (see status bar)
3. Press `Space` to see available keymaps
4. Press `Space-?` for buffer-local keymaps (via which-key)

## Troubleshooting

- **Plugins not installing**: Run `Space-ql` to open Lazy.nvim and check for errors
- **Treesitter highlighting broken**: Run `Space-qt` to update parsers
- **Spell check not working**: Ensure `~/.VimStar/spell/` directory exists
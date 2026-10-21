---
layout: single
title: "Troubleshooting"
description: "Common issues and solutions"
permalink: /troubleshooting/
sidebar: 
  nav: "main"
toc: true
---

## Installation

### Plugins not installing on first launch

**Symptom**: No plugins appear, or Neovim opens with no syntax highlighting.

**Solution**: 
1. Press `Space-ql` to open Lazy.nvim.
2. Check if it's still installing (shows progress bar).
3. Wait 30-60 seconds for initial install.

If still stuck:
```bash
# Clear plugin cache
rm -rf ~/.local/state/nvim/lazy
rm -rf ~/.local/share/nvim/lazy

# Reinstall
nvim -c "Lazy sync"
```

## Tree-sitter

### Incorrect syntax highlighting

**Symptom**: Colors wrong or no syntax highlighting.

**Solution**: Update parsers `Space-qt`

`Space-qt` refreshes the parsers that are already installed and installs the ones that are missing for the files you have open.

### Errors after the Neovim 0.12 upgrade

**Symptom**: Neovim starts with a wall of Tree-Sitter errors, for example `attempt to call field 'get_available' (a nil value)` or `No parser for 'markdown' available`.

**Cause**: Neovim 0.12 needs the `main` branch of `nvim-treesitter`, older versions need `master`. The two branches have completely different APIs. `lazy-lock.json` remembers the exact commit of every plugin, so a stale entry keeps restoring the commit of the `master` branch on every install, no matter which branch VimStar asks for.

**Solution**: VimStar compares the branch that is checked out with the one this Neovim needs and repairs both the checkout and the lockfile on startup. If that does not happen, remove the plugin and let Lazy install it again:

```bash
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter
nvim -c "Lazy install nvim-treesitter"
```

The parsers live in `~/.local/share/nvim/treesitter`, so they survive a reinstall.

### Parser installation fails

**Symptom**: Error about missing parser or compilation.

**Solution**: Install build tools (Linux)

Use your package manager to install build tools. For example, 

**OpenMandriva:** 

```bash
sudo dnf -y install task-devel task-c-devel task-c++-devel clang llvm yarn
```

**Arch:**
```bash
sudo pacman -S base-devel yarn
```

**Debian:** 
```bash
sudo apt install build-essential yarn
```

# Reinstall Tree-sitter

```bash
rm -rf ~/.local/share/nvim/treesitter/parser/*
nvim -c "TSInstall! all"
````

## LSP

### LSP not starting

**Symptom**: No LSP client attached (check with `:LspAttach`).

**Solution**:
1. Open Mason: `Space-qm`
2. Check if LSP is installed (green checkmark)
3. If not, install via Mason UI or: `Mason install <lsp-name>`

### LSP shows errors but code runs fine

This is expected; LSP checks for code quality/issues, not runtime errors.

Common fixes:
- Python: Ensure virtual environment is activated or Mason's Python path is correct
- Java: Add `module-info.java` if using modules
- TypeScript: Check `tsconfig.json` exists

## Debugging

### Breakpoints don't work

**Python**:
1. Ensure `debugpy` is installed via Mason
2. Check Python path: `:echo $VIRTUAL_ENV` (if using venv)

**Java**:
1. Run with debug agent: `java -agentlib:jdwp=...`
2. Port 5005 must be available

### DAP UI not showing

Press `Space-dc` to start debugging. The UI should auto-open on debug attach.

## Buffers

### Buffers not switching properly

Use `Space-kb` to see buffer list and select.

To close a buffer, use `Space-kj`. 

## File Explorer

### Neo-tree not showing

Press `C-n` or `Space-kt` (toggle Neotree).

If still not visible:
```vim
:Neotree toggle
```

## Performance

### Neovim feels slow

**Check startup time**:
```bash
nvim --startuptime profile.log
````

**Common fixes**:
1. Update plugins: `Space-ql` → `Lazy update`
2. Enable lazy loading: Some plugins already load on demand
3. Reduce Tree-sitter parsers: Only install needed ones
4. Disable plugins temporarily to isolate issue

### High memory usage

Memory-heavy plugins:
- Tree-sitter (caches parsers in memory)
- LSP clients (each uses RAM)
- Neo-tree (keeps file list)

**Reduce memory**:
```vim
:TSUninstall unused-parsers
:Lazy clean
```

## Spell Check

### Spell check doesn't enable

Ensure filetype is recognized:
```vim
:set filetype?
```

Manually enable:
```vim
:set spell
```

## Markdown

### Live preview not working

1. Check port 8084 is available:
```bash
netstat -tlnp | grep 8084
````

2. Restart preview: `Space-oq` then `Space-op`.

### Pandoc not found

Install Pandoc:
- Linux: Check your package manager or see https://pandoc.org. 
- macOS: `brew install pandoc`
- Windows: Download from https://pandoc.org. 

## Keybindings

### Space key doesn't trigger

Check leader settings:
```vim
:echo vim.g.mapleader
:echo vim.g.maplocalleader
````

Both should show ` ` (space).

If not, restart Neovim to reload config.

## General Commands

| Command | Purpose |
|--------|---------|
| `:messages` | Show recent messages/errors |
| `:checkhealth` | Run Neovim health check |
| `:scriptnames` | List loaded scripts |
| `Space-ql` | Manage plugins |
| `Space-qm` | Manage LSPs/tools |
| `Space-qt` | Update Tree-sitter |
---
layout: page
title: "Troubleshooting"
description: "Common issues and solutions"
permalink: /troubleshooting/
---

## Installation

### Plugins not installing on first launch

**Symptom**: No plugins appear, or Neovim opens with no syntax highlighting.

**Solution**: 
1. Press `Space-ql` to open Lazy.nvim
2. Check if it's still installing (shows progress bar)
3. Wait 30-60 seconds for initial install

If still stuck:
```bash
# Clear plugin cache
rm -rf ~/.local/state/nvim/lazy
rm -rf ~/.local/share/nvim/lazy

# Reinstall
nvim -c "Lazy sync"
```

## Treesitter

### Incorrect syntax highlighting

**Symptom**: Colors wrong, or no syntax highlighting.

**Solution**:
```bash
# Update parsers
Space-qt  # Via keymap
# or
:TSUpdate
````

### Parser installation fails

**Symptom**: Error about missing parser or compilation.

**Solution**:
```bash
# Install build tools (Linux)
sudo apt install build-essential

# Reinstall Treesitter
rm -rf ~/.local/share/nvim/mason/share/nvim-treesitter/parser/*
nvim -c "TSInstallAll"
````

## LSP

### LSP not starting

**Symptom**: No LSP client attached (check with `:LspAttach`).

**Solution**:
1. Open Mason: `Space-qm`
2. Check if LSP is installed (green checkmark)
3. If not, install via Mason UI or: `Mason install <lsp-name>`

### LSP shows errors but code runs fine

This is expected - LSP checks for code quality/issues, not runtime errors.

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

Press `Space-dc` to start debugging - the UI should auto-open on debug attach.

## Buffers

### Buffers not switching properly

Use `Space-kb` to see buffer list and select.

To see all buffers:
```vim
:buffers
```

To close all but current:
```vim
:bufdo bd
```

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
3. Reduce treesitter parsers: Only install needed ones
4. Disable plugins temporarily to isolate issue

### High memory usage

Memory-heavy plugins:
- Treesitter (caches parsers in memory)
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

Add new filetypes in `vim-options.lua`:
```lua
pattern = { "markdown", "typst", "tex", "plaintex", "latex", "newtype" }
```

## Markdown

### Live preview not working

1. Check port 8084 is available:
```bash
netstat -tlnp | grep 8084
````

2. Restart preview: `Space-oq` then `Space-op`

### pandoc not found

Install pandoc:
- Linux: `sudo apt install pandoc`
- macOS: `brew install pandoc`
- Windows: Download from https://pandoc.org

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
| `:Lazy` | Manage plugins |
| `:Mason` | Manage LSPs/tools |
| `:TSUpdate` | Update Treesitter |
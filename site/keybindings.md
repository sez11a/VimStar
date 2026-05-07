---
layout: page
title: "Keybindings"
description: "Complete list of VimStar keybindings, organized by menu"
permalink: /keybindings/
---

All keybindings use Space as the leader key (`<leader>` and `<localleader>` are both Space).

## WordStar Menus

| Menu | Key | Function |
|------|-----|----------|
| **Block and Save** | `Space-k` | Buffer management, saving, quitting |
| **Onscreen Format** | `Space-o` | Code actions, formatting, preview |
| **Print Controls** | `Space-p` | Pandoc publishing, markmap |
| **Quick Menu** | `Space-q` | Plugin management, updates, debugging |

### Block and Save (`Space-k`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-ke` | `enew` | New buffer |
| `Space-kb` | `Neotree buffers` | Switch buffer (shows list) |
| `Space-kj` | `bd` | Close buffer |
| `Space-ks` | `w` | Save file |
| `Space-kx` | `wq` | Save and exit |
| `Space-kq` | `q!` | Abandon changes and quit |
| `Space-kl` | `cd %:p:h` | Change working directory |
| `Space-km` | `MarkmapSave` | Save markmap diagram |
| `Space-kt` | Toggle Neotree | File explorer |

### Onscreen Format (`Space-o`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-oa` | `vim.lsp.buf.code_action` | Show code actions |
| `Space-of` | `vim.lsp.buf.format` | Format buffer |
| `Space-od` | `vim.lsp.buf.definition` | Show definition |
| `Space-or` | `vim.lsp.buf.references` | Show references |
| `Space-om` | `MarkmapOpen` | Open markmap diagram |
| `Space-ow` | `MarkmapWatch` | Watch markmap (auto-update) |
| `Space-oc` | Toggle nvim-cmp | Disable/enable completion |
| `Space-oj` | `:%!jq .` | Format JSON |
| `Space-ox` | `ZenmodeToggle` | Distraction-free mode |
| `Space-ob` | `RenderMarkdown toggle` | Toggle markdown preview |
| `Space-op` | `LivePreview start` | Start markdown live preview |
| `Space-oq` | `LivePreview close` | Stop live preview |
| `Space-ok` | `bnext` | Next buffer |
| `Space-ol` | `ToggleDiag` | Toggle diagnostics |

### Print Controls (`Space-p`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-pb` | pandoc pdf | Book template |
| `Space-pp` | pandoc pdf | Article/handout template |
| `Space-pm` | MarkmapOpen | View mindmap in browser |
| `Space-po` | pandoc odt | OpenDocument format |
| `Space-ps` | MarkmapSave | Save markmap (don't open) |

**Note:** All `Space-p` commands use the `:Pandoc` user command defined in `vim-options.lua`.

### Quick Menu (`Space-q`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-ql` | `Lazy` | Manage plugins |
| `Space-qm` | `Mason` | Manage LSPs and tools |
| `Space-qt` | `TSUpdate` | Update Treesitter parsers |
| `Space-qf` | `Telescope live_grep` | Find in files |

## Modern Menus

### Find (`Space-f`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-fs` | `Telescope find_files` | Find files |
| `Space-fp` | `Telescope git_files` | Git-tracked files |
| `Space-fz` | `Telescope live_grep` | Live grep |
| `Space-fo` | `Telescope oldfiles` | Open recent files |

### Git (`Space-g`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-gs` | `Git` | Git status |
| `Space-gb` | `Gedit HEAD` | Browse HEAD commit |
| `Space-gm` | `Git difftool -y master` | Diff with master |
| `Space-gp` | `Gitsigns preview_hunk` | Preview change hunk |
| `Space-gt` | `Gitsigns toggle_blame` | Show/hide blame |

### Code (`Space-c`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-ca` | `CodeCompanionActions` | AI actions on selection (visual mode) |
| `Space-cc` | `CodeCompanionChat Toggle` | Open AI chat |
| `Space-ci` | `CodeCompanionInline` | Inline AI edit |
| `Space-co` | Organize imports | LSP organize imports |
| `Space-cw` | Toggle Neocodeium | Toggle AI completion |

### Debug (`Space-d`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-dt` | `DapToggleBreakpoint` | Toggle breakpoint |
| `Space-dc` | `DapContinue` | Continue execution |
| `Space-dx` | `DapTerminate` | Stop debugging |
| `Space-do` | `DapStepOver` | Step over |
| `Space-di` | `DapStepInto` | Step into |
| `Space-dd` | `DapStepOut` | Step out |

**Debugging support:**
- **Python**: Launch current file, Pytest (verbose)
- **Go**: DAP via nvim-dap-go
- **Java**: Attach to port 5005

## Utility Keybindings

| Key | Action | Description |
|-----|--------|-------------|
| `C-p` | `Telescope find_files` | Quick find files |
| `C-n` | `Neotree toggle` | Toggle file explorer |
| `Space-?` | `which-key` | Show buffer keymaps |
| `C-k/j/h/l` | `wincmd` | Navigate vertically/horizontally |
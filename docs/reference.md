---
layout: single
title: "Reference"
description: "Complete list of VimStar keybindings, organized by menu"
permalink: /reference/
sidebar: 
  nav: "main"
toc: true
---

All keybindings use Space as the leader key (`<leader>` and `<localleader>` are both Space).

## WordStar Menus

| Menu | Key | Function |
|------|-----|----------|
| **Block and Save** | `Space-k` | Buffer management, saving, quitting, blocks |
| **Onscreen Format** | `Space-o` | Code actions, formatting, preview |
| **Print Controls** | `Space-p` | Pandoc publishing, markmap |
| **Quick Menu** | `Space-q` | Cursor movement, block navigation, manage |

### Block and Save (`Space-k`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-ke` | `enew` | New buffer |
| `Space-ko` | `Explore` | Open file explorer |
| `Space-kl` | `cd %:p:h` | Change working directory |
| `Space-ks` | `w` | Save file |
| `Space-kt` | Toggle Neotree | File explorer |
| `Space-kx` | `wq` | Save and exit |
| `Space-kf` | `terminal` | Open terminal |
| `Space-kq` | `q!` | Abandon changes and quit |
| `Space-km` | `MarkmapSave` | Save markmap diagram |
| `Space-kn` | Toggle column mode | Block mode toggle |
| `Space-kb` | `blocks.mark_begin` | Begin block |
| `Space-kk` | `blocks.mark_end` | End block |
| `Space-kh` | `blocks.toggle_visibility` | Hide/show block |
| `Space-ku` | `toggle_previous_block` | Toggle previous block |
| `Space-kc` | `copy_block` | Copy block |
| `Space-kv` | `move_block` | Move block |
| `Space-ky` | `delete_block` | Delete block |
| `Space-k<` | `unmark_block` | Unmark block |
| `Space-kj` | `bd` | Close buffer |
| `Space-kr` | `Neotree buffers reveal float` | Switch buffer (reveal) |

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
| `Space-on` | `ZenmodeToggle` | Distraction-free mode |
| `Space-ob` | `RenderMarkdown toggle` | Toggle markdown preview |
| `Space-op` | `LivePreview start` | Start markdown live preview |
| `Space-oq` | `LivePreview close` | Stop live preview |
| `Space-ot` | `TypstPreview toggle` | Typst preview toggle |
| `Space-ok` | `bnext` | Next buffer |
| `Space-ol` | `ToggleDiag` | Toggle diagnostics |

### Print Controls (`Space-p`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-pb` | pandoc pdf | Book template (LaTeX) |
| `Space-pp` | pandoc pdf | Article/handout template (LaTeX) |
| `Space-pe` | pandoc pdf | Planner page template (LaTeX) |
| `Space-pB` | pandoc pdf | Book template (Typst) |
| `Space-pP` | pandoc pdf | Article/handout template (Typst) |
| `Space-pE` | pandoc pdf | Planner page template (Typst, n-up) |
| `Space-pk` | pandoc pdf | Bookly book template (Typst) |
| `Space-pm` | MarkmapOpen | View mindmap in browser |
| `Space-ps` | MarkmapSave | Save markmap (don't open) |
| `Space-po` | pandoc odt | OpenDocument format |

**Note:** All `Space-p` commands use the `:Pandoc` user command defined in `vim-options.lua`.

### Quick Menu (`Space-q`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-qb` | `jump_to_begin` | Jump to block begin |
| `Space-qk` | `jump_to_end` | Jump to block end |
| `Space-qv` | `jump_to_source` | Jump to move source |
| `Space-qe` | `MoveMotion("gg")` | Jump to top |
| `Space-qs` | `MoveMotion("0")` | Jump to left |
| `Space-qd` | `MoveMotion("$")` | Jump to right |
| `Space-qx` | `MoveMotion("G")` | Jump to bottom |
| `Space-qp` | `MoveMotion("<C-o>")` | Jump to previous position |
| `Space-qf` | `Telescope live_grep` | Find in files |
| `Space-qu` | `git pull origin master` | Update VimStar |
| `Space-ql` | `Lazy` | Manage plugins |
| `Space-qm` | `Mason` | Manage LSPs and tools |
| `Space-qt` | `TSUpdate` | Update Treesitter parsers |

## Modern Menus

### Find (`Space-f`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-fs` | `Telescope find_files` | Find files |
| `Space-fp` | `Telescope git_files` | Git-tracked files |
| `Space-fz` | `Telescope live_grep` | Live grep |
| `Space-fg` | `live_grep` | Live grep (alias) |
| `Space-fj` | `live_grep (journal)` | Find journal entries |
| `Space-fo` | `Telescope oldfiles` | Open recent files |

### Git (`Space-g`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-gs` | `Git` | Git status |
| `Space-gb` | `Gedit HEAD` | Browse HEAD commit |
| `Space-gm` | `Git difftool -y master` | Diff with master |
| `Space-ga` | `Git difftool -y main` | Diff with main |
| `Space-gc` | `Git commit` | Git commit |
| `Space-gp` | `Gitsigns preview_hunk` | Preview change hunk |
| `Space-gt` | `Gitsigns toggle_blame` | Show/hide blame |

### Code (`Space-c`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-ca` | `CodeCompanionActions` | AI actions on selection (visual mode) |
| `Space-cc` | `CodeCompanionChat Toggle` | Open AI chat |
| `Space-ci` | `CodeCompanionInline` | Inline AI edit |
| `Space-cw` | Toggle Neocodeium | Toggle AI completion |

### Java (`Space-j`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-jd` | `jdtls.test_class` | Java test class |
| `Space-jn` | `jdtls.test_nearest_method` | Java test nearest |
| `Space-ji` | `jdtls.organize_imports` | Java organize imports |

### Wiki (`Space-w`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-wi` | `WikiJournalIndex` | Wiki journal index |

### Debug (`Space-d`)

| Key | Action | Description |
|-----|--------|-------------|
| `Space-dt` | `DapStepOut` | Step out |
| `Space-dc` | `DapContinue` | Continue execution |
| `Space-dx` | `DapTerminate` | Stop debugging |
| `Space-do` | `DapStepOver` | Step over |
| `Space-di` | `DapStepInto` | Step into |
| `Space-dB` | `set_breakpoint(condition)` | Conditional breakpoint |

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
---
name: saveas-dialog
description: VimStar's custom Save As dialog implementation. A keyboard-driven directory browser with file creation and save functionality.
---

# Save As Dialog

VimStar implements a custom Save As dialog in `/lua/saveas/` that replaces Neovim's default `:saveas` with a keyboard-driven directory browser. The dialog is triggered via `<leader>k s` (Save menu → Save As) or by calling `require("saveas").open()`.

## Architecture

**Files:**
- `/lua/saveas/init.lua` — Public API (`M.open(opts)`)
- `/lua/saveas/dialog.lua` — Core implementation (windows, keymaps, state)
- `/lua/saveas/browser.lua` — Directory listing helper

## Usage

```lua
require("saveas").open({
  start_path = "/path/to/start",  -- optional, defaults to current buffer's dir or cwd
  on_save = function(full_path) end,  -- optional callback
  on_cancel = function() end,  -- optional callback
})
```

## Keybindings (in browser window)

| Key | Action |
|-----|--------|
| `j` / `k` / `<Up>` / `<Down>` | Navigate entries |
| `<CR>` / `<Enter>` | Enter selected directory |
| `<BS>` / `<C-h>` / `.` | Go up one directory level |
| `d` | Create new subdirectory in current directory |
| `i` / `s` | Save file in current directory (prompts for filename) |
| `<Esc>` / `q` / `Q` | Cancel and close |

## Behavior

1. **Directory browser** (top pane): Shows only directories. Files are hidden since this is a "Save As" dialog — you navigate to a folder, then provide a filename.
2. **Input pane** (bottom): Shows current directory, current filename (if set), and help text.
3. **Create directory (`d`)**: Prompts for a name, creates it via `vim.uv.fs_mkdir`, then refreshes the browser so the user can immediately enter it.
4. **Save (`i`/`s`)**: Prompts for a filename (defaults to current buffer's name), then runs `:saveas` on the original buffer.

## State Management

The dialog maintains state in a local `state` table:
- `cwd` — current working directory (normalized)
- `entries` — list of `{name, path, is_dir}` from `browser.list_directory()`
- `selected_idx` / `top_line` — scrolling/selection state
- `filename` — user-provided filename (shown in input pane)
- `save_buf` — the original buffer to save (captured at open time)

## Rendering

- `_render_browser()` — Lists visible entries with `>` prefix for selection
- `_render_input()` — Shows current path, filename, and keybind hints

## Adding Features

To add new keybindings:
1. Add handler function in `M._setup_keymaps()`
2. Register with `set("key", handler)`
3. Update help text in `M._render_input()`

Example: The `d` key for directory creation was added this way.

## Constraints

- Requires Neovim 0.11+ (checked in `require_min_version()`)
- Uses `vim.ui.input()` async API (works on 0.11 and 0.12 identically)
- Only shows directories in browser (files are hidden by design)
- Creates directories with mode `493` (0755 octal)
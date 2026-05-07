---
layout: page
title: "Writing Features"
description: "Markdown, spell check, Pandoc publishing, and more"
permalink: /writing/
---

VimStar is optimized for writing, especially Markdown.

## Default Filetype

New buffers default to Markdown (via autocmd in `vim-options.lua:41`):

```lua
vim.cmd("autocmd BufEnter * if &filetype == '' | setlocal ft=markdown | endif")
```

## Spell Check

Spell checking is enabled automatically for prose filetypes:

```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "typst", "tex", "plaintex", "latex" },
  callback = function() vim.opt_local.spell = true end,
})
```

**Enable/disable on demand:**
- `Space-os` = Enable spell check
- `Space-oo` = Disable spell check

## Word Count

The lualine status bar shows word count (configured in `lualine.lua:22-25`):

```lua
function()
  return vim.fn.wordcount().words .. " words"
end,
```

Press `Space-?` to see buffer-local keymaps for the current word count shortcut.

## Pandoc Publishing

VimStar defines a `:Pandoc` user command (in `vim-options.lua:52-63`) and keybindings:

| Key | Format | Description |
|-----|--------|-------------|
| `Space-pb` | PDF (book) | Uses `~/.VimStar/templates/book.tex` |
| `Space-pp` | PDF (article) | Uses `~/.VimStar/templates/article-handout.tex` |
| `Space-po` | ODT | OpenDocument format |

**Manual Pandoc:**
```vim
:Pandoc pdf
:Pandoc html
:Pandoc odt
:Pandoc docx
```

### Pandoc Templates

Location: `~/.VimStar/templates/`

- `book.tex` - Full book formatting with cover
- `article-handout.tex` - Article or handout format
- `planner-page.tex` - Planner page format (via `Space-pe`)

## Markdown Preview

### Live Preview

Start preview: `Space-op`  
Stop preview: `Space-oq`

Uses `live-preview.nvim` plugin.

### RenderMarkdown

Toggle markdown rendering: `Space-ob`

Uses `render-markdown.nvim` for in-buffer rendering.

## Markmap (Mindmaps)

| Key | Action |
|-----|--------|
| `Space-om` | Open markmap |
| `Space-m` | Save markmap |
| `Space-ow` | Watch markmap (auto-update) |

## Vim-Pencil

Writing-focused features via `vim-pencil` plugin:

- Soft wrap mode enabled
- Automatic formatting disabled (manual only)

## Typst Support

Typst files get preview support:

| Key | Action |
|-----|--------|
| `Space-ot` | Toggle Typst preview |

Uses `typst-preview.nvim` plugin.

## Marp Slides

Convert Markdown to slides:

```bash
# Start Marp server (default port 8084)
npm install -g @marp-team/marp-cli
````

## Common Shortcuts

| Action | Key | Command |
|--------|-----|-------|
| Toggle markdown preview | `Space-ob` | `RenderMarkdown toggle` |
| Toggle live preview | `Space-op` | `LivePreview start` |
| Stop live preview | `Space-oq` | `LivePreview close` |
| Open markmap | `Space-om` | `MarkmapOpen` |
| Save markmap | `Space-ps` | `MarkmapSave` |
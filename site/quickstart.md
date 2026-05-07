---
layout: page
title: "Quick Start"
description: "Your first 5 minutes with VimStar"
permalink: /quickstart/
---

Welcome to VimStar! Here's what to do in your first 5 minutes.

## 1. Launch VimStar

```bash
nvim
```

You'll see the ASCII art dashboard (alpha-nvim) and a list of most-recently-used files.

## 2. See the Keymaps

Press `Space` in normal mode to see the available menus:

- `Space-k` = Block and Save
- `Space-o` = Onscreen Format  
- `Space-p` = Print Controls
- `Space-q` = Quick Menu
- `Space-c` = Code (AI)
- `Space-d` = Debug
- `Space-f` = Find
- `Space-g` = Git
- `Space-w` = Wiki

Press `Space-?` to see buffer-local keymaps via which-key.

## 3. Write Something

VimStar defaults new buffers to Markdown:

```bash
:edit new-file.md
```

Start typing. You'll notice:
- Spell check is enabled
- Word count appears in the status bar
- Tabs are 2 spaces (expandtab)

## 4. Publish to PDF

Open a Markdown file and press:

- `Space-pb` = Convert to PDF (book template)
- `Space-pp` = Convert to PDF (article template)

Behind the scenes, this runs pandoc with your configured templates.

## 5. Try the AI Assistant

Press `Space-cc` to open CodeCompanion chat with Ollama (default model: `qwen3-coder-next-32k`).

Type a prompt like: "Explain the quicksort algorithm"

## 6. Navigate Files

- `Space-fs` = Find files (Telescope)
- `C-p` = Quick find files (Telescope)
- `C-n` = Toggle Neo-tree file explorer
- `Space-fp` = Find git-tracked files only

## 7. Try the Wiki

Open your journal:

```bash
:Wiki日记
````

(Defaults to `~/Share/pim/pkm` - customize in `vimstar-user.lua`)

## Next Steps

- Read the full [Keybindings Reference](/keybindings)
- Explore [Writing Features](/writing)
- Learn about [Coding Support](/coding)
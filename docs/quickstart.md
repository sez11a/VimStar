---
layout: single
title: "Quick Start"
description: "Your first 5 minutes with VimStar"
permalink: /quickstart/
sidebar: 
  nav: "main"
toc: true
---

Welcome to VimStar! Here's what to do in your first 5 minutes.

## 1. Launch VimStar

```bash
nvim
```

Press `e` to start a new file or press `Space-ko` to open an existing file. 

## 2. Write Something

1. VimStar is still Neovim, so press `i` to begin writing in Markdown. Completion is on by default. To toggle it, hit `Esc` to go back to Normal mode and then press `Space-oc`. 

1. To preview your document, press `Space-op`. 

1. If you have Pandoc and LaTeX or Typst installed, press `Space-p` and the relevant command from the menu to produce a PDF in the same folder as your file. 

1. Use WordStar-inspired commands to save (`Space-ks`), save and exit (`Space-kx`), or abandon changes and exit (`Space-kq`).

## 3. Try the AI Assistant

If you have [Ollama](https://ollama.com) installed, make sure the [qwen3.6:27b](https://ollama.com/library/qwen3.6) model is available and press `Space-cc` to chat. Type a prompt like "Explain the quicksort algorithm." 

## 4. Navigate Files

- `Space-ko` to browse your file system
- `Space-fs` = Find files 
- `Space-fs` = Find files in the current folder
- `Space-kt` = Toggle Neo-tree file explorer
- `Space-fp` = Find git-tracked files only

## 5. Try the Wiki

1. Customize the Wiki location in `vimstar-user.lua` by setting `vim.g.wiki_root` and then restarting VimStar. 

1. `Space-ww` opens the first Wiki page. 

1. `Space-w-Space-w` opens today's journal page. 

For more information, see the Wiki documentation by typing `:help wiki`. 

## Next Steps

- Read the full [Reference](/reference)
- Explore [Writing Features](/writing)
- Learn about [Coding Support](/coding)
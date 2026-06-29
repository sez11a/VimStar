---
layout: single
title: "Writing Features"
description: "Markdown, spell check, Pandoc publishing, and more"
permalink: /writing/
sidebar: 
  nav: "main"
toc: true
---

VimStar was inspired by Robert J. Sawyer’s essay "[WordStar: A Writer’s Word Processor](https://www.sfwriter.com/wordstar.htm)." I had the idea to combine the power of Vim's movement with "the longhand metaphor" of working with large blocks of text, like books, novels, and short stories. VimStar's main function is to turn Neovim into a word processor, with all the power of Vim navigation at your fingertips and a menu system inspired by WordStar. New files default to the Markdown file type, but VimStar also includes plugins to support writing in HTML, LaTeX, and Typst. As soon as you save your file, the syntax switches. 

Word count is available on-screen at all times, so writers can keep track of their progress. 

## WordStar-enhanced Block Functions 

VimStar brings back one of the most beloved features of classic WordStar: **persistent marked blocks**. You can mark a block, continue writing or editing freely anywhere in the document (or even switch windows), and later decide to copy or move it-—-exactly like Mr. Sawyer does it in WordStar.

**Key Commands (under Space-K Block & Save)**
- `Space kb` — Mark block begin
- `Space kk` — Mark block end (block highlights with your current Visual style)
- `Space kc` — Copy (i.e., paste) block to cursor
- `Space kv` — Move block to cursor
- `Space ky` — Delete block
- `Space kh` — Toggle block highlight on/off
- `Space kn` — Toggle column (rectangular) mode

**Quick Navigation (under Space-Q)**
- `Space qb` — Jump to block begin
- `Space qk` — Jump to block end
- `Space qv` — Jump to where the block was moved from (after a move)

### Why This Matters

Unlike modern editors that force you to act on a selection immediately, VimStar's blocks stay marked indefinitely. Mark the beginning of a paragraph, keep writing for ten minutes, mark the end, and then decide where it belongs. This is the longhand flexibility from Sawyer's essay. Now it's available in a modern, extensible Neovim environment optimized for serious writing! And if you don't like it, that's fine: use Neovim's Visual mode like you always have. It's the best of both worlds. 

### Tips

- The highlight automatically updates as you edit.
- It works great with Markdown, LaTeX, Typst, etc.
- Column mode is ideal for tables or code alignment.

## Word Processing Formats 

- Markdown
- HTML
- LaTeX, with [VimTex](https://github.com/lervag/vimtex) for previews and compiling
- Typst, with [typst-preview](https://github.com/chomosuke/typst-preview.nvim) for live previews

Markdown syntax is "polished" by default, but you can see the raw syntax via `Space-ob`. 

Markdown files can be converted to various formatted PDFs or to an ODT (OpenDocument format) for use with [LibreOffice](https://www.libreoffice.org). Writers can now use a distraction-free, efficient environment to work their magic. You can do the formatting later via LibreOffice or automatically via the provided Pandoc templates---and new ones are being created all the time. 

## File Conversion with Pandoc

Beyond the Pandoc print functions in the `Space-p` menu, VimStar defines a `:Pandoc` user command so you can convert your file to any format Pandoc supports:

```vim
:Pandoc pdf
:Pandoc html
:Pandoc odt
:Pandoc docx
```

Pandoc templates ship with VimStar, including an article template and a full-on digest-size paperback book format, complete with chapter headings, headers, footers, and a table of contents. Update your `~/.VimStar` folder regularly via Git to grab new templates as they are created! 

## Supports the Full Creative Experience 

From the beginning of your project to the end, VimStar helps you along the way: 

- Use [Markmap](https://github.com/Zeioth/markmap.nvim) to outline your project before starting to write. 
- Use [Live Preview](https://github.com/brianhuster/live-preview.nvim) (Markdown), [Typst Preview](https://github.com/chomosuke/typst-preview.nvim) (Typst), or [Vimtex](https://github.com/lervag/vimtex) to preview your work. 
- Export your work to a pre-formatted PDF or any other format to ready it for publishing. 

As inspired by WordStar, preview functions appear in the Onscreen Format (`Space-o`) menu, and exporting is done by "printing" from the Print Controls (`Space-p`) menu. 


## Marp Slides

Do you mainly create slides? VimStar supports that too, via [Marp](https://github.com/mpas/marp-nvim)! Now you can version control your presentations in a plain text format, ideal for writing teams. 

## Technical Writing 

VimStar was designed for technical writing by a technical writer with decades of experience. Full Git support appears via [Fugitive](https://github.com/tpope/vim-fugitive). Use the `Space-g` menu or commands to add, commit, blame, diff, and more. VimStar fits neatly into any docs-as-code methodology, providing all the power any technical writer needs to produce great content.
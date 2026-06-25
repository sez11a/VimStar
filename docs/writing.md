---
layout: single
title: "Writing Features"
description: "Markdown, spell check, Pandoc publishing, and more"
permalink: /writing/
sidebar: 
  nav: "main"
toc: true
---

VimStar's main function is to turn Neovim into a word processor, with all the power of Vim navigation at your fingertips and a menu system inspired by WordStar. New files default to the Markdown file type, but VimStar also includes plugins to support writing in HTML, LaTeX, and Typst. As soon as you save your file, the syntax switches. 

Word count is available on-screen at all times, so writers can keep track of their progress. 

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
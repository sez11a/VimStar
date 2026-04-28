# Project: VimStar

## Purpose

- VimStar is a Neovim distribution optimized for writing, but also containing support for code. 
- Its main purpose is to be the best Markdown editor available, while also enabling various publishing processes. 
- Users should be able to write Markdown and then publish it in a variety of ways, including articles, fully formatted books in PDF, and more. 
- Users should be able to use a docs as code methodology with Git to view and edit changes made by multiple users. 
- Code support includes various languages including Java, Lua, and Python, along with integrated local AI. 

## Architecture

- Multiple Lua scripts supporting various plugins and functionality. 
- Entry point: `init.lua`. 
- Other Lua scripts are contained in `/lua`. 
- Keymaps are centralized in `/lua/keymaps.lua` and configured via the Whichkey plugin. 
- A user-customizable file called `vimstar-user.lua` enables end users to customize their own installations.
- The [Lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager manages plugins.
- [Mason](https://github.com/mason-org/mason.nvim) manages packages, such as formatters and linters.
- [Tree-Sitter](https://github.com/tree-sitter/tree-sitter) manages syntax highlighting.

## Core Behavior 

- VimStar assumes writing from the start, defaulting new files to Markdown and enabling spell checking. 
- The status line counts the number of words in the file being edited.
- Writing code is also supported and encouraged: the editor supports code completion, debugging, and integrates AI code assist tools.
- Markdown files can be converted to PDFs via various hotkeys. 
- A local wiki is integrated for taking notes. 
---
name: vimstar-purpose
description: The reasons why VimStar was created, what it's for, and the problems it solves. 
---
# VimStar Purpose 

VimStar is a Neovim distribution inspired by WordStar, an old DOS word processor that certain authors such as Robert J. Sawyer and George R.R. Martin still use today. WordStar had unique keyboard-driven features that help authors who create at the keyboard in their craft. VimStar re-implements some WordStar features such as its block functions, and its menu system is inspired by WordStar. 

The intent is to combine the power of Neovim and WordStar together to create a writing and editing environment ideal for content creators of all types---novelists, technical writers, marketing writers, and more---while also supporting writing code as a secondary goal. WordStar did this with its "Document" and "Non Document" modes. VimStar does it dynamically through Neovim's file types. 

# When to Use This Skill

- At the first prompt
- When you need to understand why VimStar's design choices were made

# Design Philosophies

- Menus are implemented with Which Key (https://github.com/folke/which-key.nvim)
- Menus use Space as a prefix, where WordStar used the Control key. 
- In Neovim terms, this means Space is the leader key.
- Menus are purposefully organized the same way WordStar's menus were. 
  - Block and Save (Space-k): buffer management, saving, quitting, blocks
  - Onscreen Format (Space-o): code actions, formatting, preview
  - Print Controls (Space-p): Pandoc publishing, markmap
  - Quick Menu (Space-q): Cursor movement, block navigation, Lazy, Mason, and Tree-Sitter
- Other menus are implemented for more modern and coding functions
  - Find (Space-f): Find files, grep files
  - Git (Space-g): Git functions
  - Code (Space-c): Integrated LLM functions via CodeCompanion (https://github.com/olimorris/codecompanion.nvim)
  - Java (Space-j): Java functions
  - Wiki (Space-w): Wiki functions from wiki.vim (https://github.com/lervag/wiki.vim)
- Keymaps that rely on external dependencies should always gracefully degrade by checking whether they are installed.
- Several features are unique to VimStar and don't appear in any other Neovim distribution 
  - WordStar's block functions are implemented in `./lua/vimstar/blocks.lua`
  - VimStar implements a custom Save As dialog box in `./lua/saveas/`
  - The WordStar Diamond is implemented in `./lua/vimstar/functions.lua`
  - The template system in `./templates` transforms Markdown documents into PDFs or ODT files with specific formatting
- Some features are for WordStar nostalgia purposes, and are not enabled by default. 
  - A WordStar Blue color scheme in `./colors/wordstar-blue.vim` implements WordStar 7.0d's default color scheme
  - A font that mimics the old DOS VGA font modified to include Nerd Font symbols is included in `./fonts` if users want to use it in a terminal or a GUI such as Neovim-qt or Neovide to mimic WordStar's look.

# Architecture

- **Entry point**: `init.lua` 
- **Core functions:** `/lua/vimstar/*.lua`. Contains VimStar-specific functionality that duplicates WordStar functionality. WordStar's block functions for defining, copying, moving, deleting, and switching blocks, as well as cursor movement to current and former block locations are implemented. 
- **Plugin config**: `/lua/plugins/*.lua` - each exports a table via `return {}`
- **User customization**: `vimstar-user.lua` loads after core config for user overrides. Users can customize plugins in `/lua/user/plugins` by adding Lua files there; it is ignored by Git. 
- **Loading Order**: 
  1. `init.lua` - Entry point
  2. `vim-options.lua` - Core settings
  3. Lazy.nvim loads:
     - `plugins/` directory (core plugins)
     - `user/plugins/` directory (custom user plugins) 
  4. `keymaps.lua` - Keybindings
  5. `vimstar-user.lua` - User overrides
- **Neovim Version Support**: Supports Neovim 0.11+. This requires a special Tree-Sitter configuration that loads different versions of the plugin for 0.11- and 0.12+. See the `version-support` skill when touching version detection or Tree-Sitter configuration. 
- **Keymaps**: `/lua/keymaps.lua` uses Space as leader; registered via which-key `wk.add()`; requires `/lua/saveas` module for custom Save As dialog box

# Critical Paths

- **Markdown by default**: filetype defaults to markdown; spell-check enabled for prose filetypes
- **Publishing**: Markdown files can be converted to various other formats with the `Space-p` menu via Pandoc and Typst; use the `./agents/skills/vimstar-templates` skill when requested to edit or create a template.
- **Debugging**: Python (DAP), Go (DAP), Java (attach to port 5005); `Space-dt` toggles breakpoint
- **Wiki**: Uses `wiki.vim` with custom templates; `~/.VimStar/wiki/templates/`
- **AI**: CodeCompanion with Ollama (model is configurable via `vimstar-user.lua`); `Space-cc` opens chat

# Dependency-Gated Plugin Loading

VimStar uses a smart plugin loading system that only installs plugins when their dependencies are available:

### Dependency Checking (`/lua/vimstar/depcheck.lua`)

- `has_executable(name)` - Check if binary exists in PATH  
- `has_pandoc()`, `has_typst()` - Publishing tools availability  
- `has_python_debugger()`, `has_go_debugger()`, `has_java_debugger()` - Debug adapter via Mason  
- `has_ollama()` - HTTP check for Ollama API server availability  
- `has_yarn()` - For markmap-cli installation

### Conditional Installation (`/lua/plugins/*.lua`)

Plugins are loaded only when their dependencies satisfy conditions:
| Plugin File | Installed When... |
|-------------|-------------------|
| `mason.lua` | node/npm for web LSPs, git for tree-sitter-cli |  
| `wiki.lua` | yarn available (for markmap.nvim) |
| `typst.lua` | typst binary found |
| `debugging.lua` | Python/Go/Java debugger detected via Mason/VENV |
| `ai-code.lua` | Ollama server responding at localhost:11434 |

### Keymaps with Graceful Degradation (`/lua/keymaps.lua`)

Keymaps check dependencies and show helpful messages instead of errors when unavailable. For example, pressing `<leader>pb` (Typst PDF export) shows "Please install Pandoc and Typst for this feature" if missing.

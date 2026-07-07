# Project: VimStar

## Quick Start

- Run Neovim to load the distribution; plugins install automatically via Lazy.nvim
- Press Space to see keymaps; Space-? shows buffer-local keymaps via which-key

## Architecture

- **Entry point**: `init.lua` (loads modules in order: `vim-options`, `lazy`, `keymaps`, `vimstar-user`)
- **Core functions:** `/lua/vimstar/*.lua`. Contains VimStar-specific functionality that duplicates WordStar functionality. WordStar's block functions for defining, copying, moving, deleting, and switching blocks, as well as cursor movement to current and former block locations are implemented. 
- **Plugin config**: `/lua/plugins/*.lua` - each exports a table via `return {}`
- **User customization**: `vimstar-user.lua` loads after core config for user overrides. No other files can be customized, or users introduce potential Git conflicts.
- **Keymaps**: `/lua/keymaps.lua` uses Space as leader; registered via which-key `wk.add()`

## Critical Paths

- **Markdown focus**: filetype defaults to markdown; spell-check enabled for prose filetypes
- ** Publishing**: Markdown files can be converted to various other formats with the `Space-p` menu via Pandoc
- **Debugging**: Python (DAP), Go (DAP), Java (attach to port 5005); `Space-dt` toggles breakpoint
- **Wiki**: Uses `wiki.vim` with journal templates; `~/.VimStar/wiki/templates/`
- **AI**: CodeCompanion with Ollama (model `gemma4:31b`); `Space-cc` opens chat

## LSP & Tools (via Mason)

**LSPs**: lua_ls, html, cssls, ts_ls, pylsp, tinymist, clangd  
**Tools**: tree-sitter-cli, texlab, jdtls, markmap-cli, debugpy

## Keybindings (Space-prefixed)

- **Block:** `Space-kn` toggle column mode, `Space-kb` begin, `Space-kk` end, `space-kh` hide/show, `Space-ku` toggle previous, `Space-kc` copy, `Space-kv` move, `Space-ky` delete, `Space-k<` unmark, `Space-qb` jump to begin, `Space-qk` jump to end, `Space-qv` jump to move source
- **Movement:** `Space-qe` jump to top, `Space-qs` jump to left, `Space-qd` jump to right, `Space-qx` jump to bottom, `Space-qp` jump to previous position
- **Find**: `Space-fs` files, `Space-fp` git files, `Space-fz` grep  
- **Git**: `Space-gs` status, `Space-gb` browse HEAD, `Space-gm` diff master  
- **Buffers**: `Space-ke` new, `Space-kj` close, `Space-kb` switch, `Space-kx` save+quit  
- **Format**: `Space-oa` code actions, `Space-of` format, `Space-od` definition  
- **Preview**: `Space-op` markdown live preview, `Space-oq` stop preview  
- **Plugins**: `Space-ql` Lazy, `Space-qm` Mason, `Space-qt` TSUpdate  

## Installation

- **Linux**: `curl -sLf https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.sh | bash`
- **macOS**: `curl -sLf https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.sh | bash`
- **Windows**: `Set-ExecutionPolicy Bypass -Scope Process -Force; irm https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.ps1 | iex`
- Installs to `~/.VimStar` (symlinked to Neovim config dir: `~/.config/nvim` on Linux, `~/Library/Application Support/nvim` on macOS, `$env:LOCALAPPDATA/nvim` on Windows)

## Important Constraints

- **Map leader**: Both `<leader>` and `<localleader>` are Space (`vim.g.mapleader = " "`)
- **Color scheme**: Default is `onedark`; modify `vimstar-user.lua` to change
- **Wiki root**: Defaults to `~/.VimStar/wiki`; override in `vimstar-user.lua`
- **Spell check**: Enabled for markdown, typst, tex, plaintex, latex filetypes only
- **Indent**: 2 spaces, expandtab by default; 4 spaces for everything else via tabset.nvim.
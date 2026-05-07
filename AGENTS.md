# Project: VimStar

## Quick Start

- Run Neovim to load the distribution; plugins install automatically via Lazy.nvim
- Press Space to see keymaps; Space-? shows buffer-local keymaps via which-key

## Architecture

- **Entry point**: `init.lua` (loads modules in order: `vim-options`, `lazy`, `keymaps`, `vimstar-user`)
- **Plugin config**: `/lua/plugins/*.lua` - each exports a table via `return {}`
- **User customization**: `vimstar-user.lua` loads after core config for user overrides
- **Keymaps**: `/lua/keymaps.lua` uses Space as leader; registered via which-key `wk.add()`

## Critical Paths

- **Markdown focus**: filetype defaults to markdown; spell-check enabled for prose filetypes
- ** Publishing**: `Space-pb` (book PDF), `Space-pp` (article PDF) via Pandoc
- **Debugging**: Python (DAP), Go (DAP), Java (attach to port 5005); Space-dt toggles breakpoint
- **Wiki**: Uses `wiki.vim` with journal templates; `~/.VimStar/wiki/templates/`
- **AI**: CodeCompanion with Ollama (model `qwen3-coder-next-32k`); Space-cc opens chat

## LSP & Tools (via Mason)

**LSPs**: lua_ls, html, cssls, ts_ls, pylsp, tinymist, clangd  
**Tools**: tree-sitter-cli, texlab, jdtls, markmap-cli, debugpy

## Keybindings (Space-prefixed)

- **Find**: `Space-fs` files, `Space-fp` git files, `Space-fz` grep  
- **Git**: `Space-gs` status, `Space-gb` browse HEAD, `Space-gm` diff master  
- **Buffers**: `Space-ke` new, `Space-kj` close, `Space-kb` switch, `Space-kx` save+quit  
- **Format**: `Space-oa` code actions, `Space-of` format, `Space-od` definition  
- **Preview**: `Space-op` markdown live preview, `Space-oq` stop preview  
- **Plugins**: `Space-ql` Lazy, `Space-qm` Mason, `Space-qt` TSUpdate  

## Installation

- **Linux/macOS**: `curl -sLf https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.sh | bash`
- **Windows**: `Set-ExecutionPolicy Bypass -Scope Process -Force; irm https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.ps1 | iex`
- Installs to `~/.VimStar` (symlinked to `~/.config/nvim` on Linux)

## Important Constraints

- **Map leader**: Both `<leader>` and `<localleader>` are Space (`vim.g.mapleader = " "`)
- **Color scheme**: Default is `onedark`; modify `vimstar-user.lua` to change
- **Wiki root**: Defaults to `~/Share/pim/pkm`; override in `vimstar-user.lua`
- **Spell check**: Enabled for markdown, typst, tex, plaintex, latex filetypes only
- **Indent**: 2 spaces, expandtab (except Java: 4 spaces via tabset.nvim)
- **Opacity**: Neovide sets `neovide_normal_opacity = 0.8`, `window_blurred = true` 
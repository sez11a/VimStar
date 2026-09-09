# Project: VimStar

## Quick Start

- Run Neovim to load the distribution; plugins install automatically via Lazy.nvim
- Press Space to see keymaps; Space-? shows buffer-local keymaps via which-key

## Architecture

- **Entry point**: `init.lua` (loads modules in order: `vim-options`, `lazy`, `keymaps`, `vimstar-user`)
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
- **Keymaps**: `/lua/keymaps.lua` uses Space as leader; registered via which-key `wk.add()`

## Critical Paths

- **Markdown focus**: filetype defaults to markdown; spell-check enabled for prose filetypes
- ** Publishing**: Markdown files can be converted to various other formats with the `Space-p` menu via Pandoc; see the Book Template section below for the book layout's font settings
- **Debugging**: Python (DAP), Go (DAP), Java (attach to port 5005); `Space-dt` toggles breakpoint
- **Wiki**: Uses `wiki.vim` with journal templates; `~/.VimStar/wiki/templates/`
- **AI**: CodeCompanion with Ollama (model `qwen3.8:latest`); `Space-cc` opens chat

## Book Template (Typst): templates/typst/book-bookly.typ

Layout for a digest-sized paperback (5.5x8.5in), invoked via Pandoc (`<Space>pk` → `Pandoc pdf --to pdf --pdf-engine typst --template .../book-bookly.typ`).

- **Fonts** are centralized in two `#let` variables at the top of the template (`body-font`, `heading-font`). Every font site (bookly `fonts:`, body `#set text`, level-1/2/3/4 headings, running header, figure captions) references one of these two — change a font there, not at the call sites.
- **Per-document overrides** via YAML headers: `body-font` (serif, body text) and `heading-font` (sans, headings + captions + running header). Set via Pandoc `$if(...)$`; when unset (or the named font isn't installed) the template falls through a cross-OS list (Times/Georgia/Noto/DejaVu/Liberation for serif; Arial/Helvetica/Verdana/Noto/DejaVu/Liberation for sans). An installed user font takes precedence.
- **Default look**: body = Libertinus Serif, headings/captions = Gillius ADF (both not standard on Windows/macOS — that's why the fallback lists exist).

### Typst gotchas (learned while debugging the heading font)
- A global `#show text: set text(font: …)` rule fires on the inner text of *every* element and is the nearest scope to the heading's text, so it **overrides** a less-nested `#show heading: set text(font: …)` rule. That was the original "headings render in the body font" bug — fixed by removing the global rule. Do not reintroduce a global `#show text` font rule.
- Style lower-level headings with a `set text(…)` show rule (keeps the element a real **block** heading, so it breaks to its own line and stays in `outline`/ToC). Do **not** replace the heading with a bare `#text(…)[#it.body]` element — that makes it inline, which drops the following paragraph onto the same line and removes it from the ToC.
- Verify font changes with `pdffonts out.pdf` (lists embedded families) and `pdftotext -layout` (checks line breaks); Pandoc emits a harmless "unknown font family" warning for any fallback entry not installed on the compiling machine.

## LSP & Tools (via Mason)

**LSPs**: lua_ls, html, cssls, ts_ls, pylsp, tinymist, clangd  
**Tools**: tree-sitter-cli, texlab, jdtls, markmap-cli, debugpy

## Dependency-Gated Plugin Loading

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
Keymaps check dependencies and show helpful messages instead of errors when unavailable. For example, pressing `<leader>pB` (Typst PDF export) shows "Please install Pandoc and Typst for this feature" if missing.

## Keybindings (Space-prefixed)

- **Block:** `Space-kn` toggle column mode, `Space-kb` begin, `Space-kk` end, `space-kh` hide/show, `Space-ku` toggle previous, `Space-kc` copy, `Space-kv` move, `Space-ky` delete, `Space-k<` unmark, `Space-qb` jump to begin, `Space-qk` jump to end, `Space-qv` jump to move source
- **Movement:** `Space-qe` jump to top, `Space-qs` jump to left, `Space-qd` jump to right, `Space-qx` jump to bottom, `Space-qp` jump to previous position
- **Find**: `Space-fs` files, `Space-fp` git files, `Space-fz` grep  
- **Git**: `Space-gs` status, `Space-gb` browse HEAD, `Space-gm` diff master  
- **Buffers**: `Space-ke` new, `Space-kj` close, `Space-kb` switch, `Space-kx` save+quit  
- **Format**: `Space-oa` code actions, `Space-of` format, `Space-od` definition  
- **Preview**: `Space-op` markdown live preview, `Space-oq` stop preview  
- **Publish**: `Space-pk` book (Typst), `Space-pP` article/handout (Typst), `Space-pE` planner (Typst), `Space-pS` submission (.odt), `Space-po` generic .odt
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
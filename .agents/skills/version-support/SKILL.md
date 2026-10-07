---
name: version-support
description: How VimStar supports both Neovim 0.11 and 0.12+, and the Tree-Sitter configuration specifics. This is a tricky, well-troubled area; read this before touching version detection, plugin branch selection, or Tree-Sitter install/on-demand behavior.
---

## Version detection

Version branching is decided once, at startup, in `init.lua:5`:

```lua
local _is_modern = (_v.major == 0 and _v.minor >= 12) or _v.major > 0
vim.g.tree_sitter_branch = _is_modern and "main" or "master"
```

- The `master` branch supports Neovim **0.11**.
- The `main` branch is a full rewrite and requires Neovim **0.12+**.
- Do **not** mix them up. The branch selection lives in `init.lua`; never hardcode a branch elsewhere.

## Treesitter configuration (`lua/plugins/treesitter.lua`)

The plugin loads `nvim-treesitter` from `vim.g.tree_sitter_branch` (already resolved by `init.lua`). It then branches its config on `is_modern`:

```lua
local is_modern = vim.version().major == 0 and vim.version().minor >= 12
```

### Modern path (0.12+, `main` branch)

- Calls `require("nvim-treesitter").setup({ install_dir = ... })` and prepends the parser dir to the runtimepath.
- Uses a `FileType` autocmd (not `highlight`/`indent.enable`, which no longer exist in `main`). This autocmd also drives on-demand parser installation (see below).
- The `main` branch exposes `require('nvim-treesitter').install({ lang })` (a no-op if already installed; asynchronous).

### Non-modern path (0.11, `master` branch)

- Uses the legacy `require("nvim-treesitter.configs").setup({ ... auto_install = true })` API.
- Appends the parser dir to the runtimepath.

## Parser dependency checks (`lua/plugins/depcheck.lua`)

Not every user has every compiler/tool, and some parsers require compiling. To avoid errors on fresh installs:

- `has_cc()` — checks for `cc`, `gcc`, or `clang`.
- `PARSER_REQUIREMENTS[lang]` — per-grammar requirement tables:
  - `markdown`, `markdown_inline`, `c` → `{"git", "cc"}` (these are C-family grammars and need a compiler).
  - `typescript` → `{"git", "node"}` (TS grammar needs node/npm).
  - Any parser **not** in the table falls back to `{"git"}` only.
- `check_parser_requirements(lang)` — returns a list of human-readable messages for each missing requirement.
- `report()` — surfaces the message to the user via a WARN notify; never throws.

## On-demand parser installation

The default pre-install list was removed (users without needed tools should not see errors at first run). Instead, parsers install automatically when their filetype is first opened:

In the modern `FileType` autocmd, `vim.treesitter.start(buf, ft)` is attempted; on failure it checks `depcheck.check_parser_requirements(ft)`, reports missing tools (e.g. "Cannot install markdown tree-sitter parser: install git...", "install a C compiler..."), else runs `require('nvim-treesitter').install({ ft })`.

## Gotchas learned

- `main` is the modern branch now; `master` is frozen. `master` supports 0.11; do not attempt `main` on 0.11.
- `install_dir` (modern) = legacy `parser_install_dir`; and the modern parser dir must be **prepended** to the runtimepath so its parsers/queries win over Neovim's built-ins.
- The `master` branch is frozen "for backward compatibility only"; future changes belong on `main`.
- The `master` README notes it requires `tar`/`curl` and a C compiler on the modern side, and `tree-sitter-cli` — keep these in mind when extending `PARSER_REQUIREMENTS`.

---
layout: page
title: "Coding Support"
description: "LSPs, debugging, and AI assistant"
permalink: /coding/
---

VimStar includes robust support for code development, powered by LSP and Mason.

## LSP Support (via Mason)

Install LSPs via `Space-qm` (Mason) or the command line.

### Installed LSPs

| LSP | Language | Configuration |
|-----|----------|---------------|
| `lua_ls` | Lua | Diagnostics for vim globals enabled |
| `html` | HTML | Full support |
| `cssls` | CSS | Full support |
| `ts_ls` | TypeScript | Inlay hints enabled |
| `pylsp` | Python | pycodestyle, pyflakes, pylint enabled |
| `tinymist` | Typst | Full support |
| `clangd` | C/C++ | `-std=c11` fallback |

### ts_ls Configuration

TypeScript LSP has inlay hints enabled for parameter names, types, and return values.

### pylsp Configuration

Python LSP has multiple linters enabled:
- pycodestyle
- pyflakes  
- pylint
- mccabe
- rope_completion

## Debugging (via DAP)

All debugging is configured via `nvim-dap`.

### Python Debugging

**Launch current file:**
1. Open Python file
2. Press `Space-dt` to set breakpoint
3. Press `Space-dc` to start debugging

**Pytest (verbose):**
1. Open test file
2. Use DAP configuration (via DAP UI or attach)

**Debugpy path:**
- Uses Mason's debugpy: `~/.local/share/nvim/mason/packages/debugpy/venv/bin/python`
- Or virtual environment if `VIRTUAL_ENV` is set

### Go Debugging

Pre-configured via `nvim-dap-go`:
- `Space-dt` = Toggle breakpoint
- `Space-dc` = Continue

### Java Debugging

**Attach to running process:**
- Host: `127.0.0.1`
- Port: `5005`

**Keymaps in Java files:**
- `Space-df` = Run test class
- `Space-dn` = Run nearest method test
- `Space-oi` = Organize imports

**Setup:**
1. Install JDTLS via Mason
2. Run Java with debug agent: `java -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005`
3. Press `Space-dc` to attach

## AI Assistant (CodeCompanion)

**Models**: Ollama (`qwen3-coder-next-32k`)

### Keybindings

| Key | Action |
|-----|-------|
| `Space-cc` | Toggle AI chat |
| `Space-ci` | Inline AI edit |
| `Space-ca` | AI actions on selection |

### Setup

1. Install Ollama: https://ollama.ai
2. Pull the model: `ollama pull qwen3-coder-next-32k`
3. Start Ollama daemon
4. Press `Space-cc` to chat

### Neocodeium (Alternative)

| Key | Action |
|-----|-------|
| `Space-cw` | Toggle Neocodeium |

## LSP Keybindings (buffer-local)

When LSP attaches to a buffer, these keybindings become available:

| Key | Action |
|-----|-------|
| `K` | Show hover documentation |
| `gD` | Go to declaration |
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gR` | Show references |
| `ga` | Show code actions |

## Code Formatting

`Space-of` = Format buffer (via LSP if available)

## Indentation Rules

- **Default**: 2 spaces, expandtab
- **Java**: 4 spaces, no expandtab (via tabset.nvim)

Configure in `writing-stuff.lua` tabset.nvim section.

## Language-Specific Configs

### Java

**JDTLS setup** in `java.lua`:
- Workspace cache: `~/.cache/jdtls/workspace/`
- Config directory: `~/.local/share/nvim/mason/packages/jdtls/`
- JDK: Zulu 21 (change in config if using different JDK)
- Gradle/Maven: Automatic import

### TypeScript/JavaScript

**Inlay hints** enabled in `lsp-config.lua:46-53`:
- Parameter names: all
- Parameter types: true
- Variable types: true
- Function return types: true

## LSP Status

Check LSP status in lualine status bar (right side shows active clients).
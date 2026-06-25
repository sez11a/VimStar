---
layout: single
title: "Coding Support"
description: "LSPs, debugging, and AI assistant"
sidebar: 
  nav: "main"
toc: true
permalink: /coding/
---

VimStar includes robust support for code development, powered by Mason, a package manager for LSP (Language Server Protocol) servers, DAP (Debug Adapter Protocol) servers, linters, and formatters.

VimStar installs several tools by default, but you can install whatever you want via `Space-qm`. 

## LSP Support (via Mason)

During the install, Mason installs these pre-configured LSPs: 


| LSP | Language | Configuration |
|-----|----------|---------------|
| `lua_ls` | Lua | Diagnostics for vim globals enabled |
| `html` | HTML | Full support |
| `cssls` | CSS | Full support |
| `ts_ls` | TypeScript | Inlay hints enabled |
| `jdtls` | Java | Full support | 
| `clangd` | C/C++ | `-std=c11` fallback |
| `pylsp` | Python | pycodestyle, pyflakes, pylint enabled |
| `texlab` | LaTeX | Full support |
| `tinymist` | Typst | Full support |

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

All debugging is configured via `nvim-dap` for Python, Go, and Java.

Pre-configured via `nvim-dap-go`:
- `Space-dt` = Toggle breakpoint
- `Space-dc` = Continue

### Python Debugging

**Pytest (verbose):**
1. Open test file
2. Use DAP configuration (via DAP UI or attach)

**Debugpy path:**
- Uses Mason's debugpy. 
- Or virtual environment if `VIRTUAL_ENV` is set

### Java Debugging

**Attach to running process:**
- Host: `127.0.0.1`
- Port: `5005`

**Keymaps in Java files:**
- `Space-df` = Run test class
- `Space-dn` = Run nearest method test
- `Space-oi` = Organize imports

**Setup:**
1. Run Java with debug agent: `java -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005`.
1. Press `Space-dc` to attach.

## AI Assistant (CodeCompanion)

**Pre-configured model**: Ollama for local LLMs. Default model is `qwen3.6:27b`. 

### Keybindings

| Key | Action |
|-----|-------|
| `Space-cc` | Toggle AI chat |
| `Space-ci` | Inline AI edit |
| `Space-ca` | AI actions on selection |

### Setup

1. Install [Ollama](https://ollama.com).
1. Pull the model: `ollama pull qwen3.6:27b`
1. Start Ollama daemon.
1. Increase the default context on the model by creating a `Modelfile`: 
  
   ```
   FROM qwen3.6:27b 
   PARAMETER num_ctx [size]
   ```

   Depending on your RAM, use 32768 (32k), 65536 (64k), 131072 (128k), or 262144 (256k). 

1. Create the model: 

   ```bash
   ollama create qwen3.6:27b-[size] -f Modelfile
   ```

   For example, 

   ```bash
   ollama create qwen3.6:27b-256k -f Modelfile
   ```

1. Edit `vimstar-user.lua` and change `vim.g.ollama_model` to your new, higher context model: 

   ```lua
   vim.g.ollama_model = "qwen3.6:27b-256k"
   ```

1. Press `Space-cc` to chat

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

- **Markdown:** 2 spaces, expandtab
- **Java:** 4 spaces, no expandtab (via tabset.nvim)
- **Everything Else:** 4 spaces, expandtab

## Language-Specific Configs

### Java

Configure your JDK in `vimstar-user.lua`: 

```lua
vim.g.java_sdk_path = "/path/to/your/jdk"
```

Gradle/Maven build scripts import Java projects. If you don't have one, only basic syntax highlighting occurs.

### TypeScript/JavaScript

**Inlay hints** enabled:
- Parameter names: all
- Parameter types: true
- Variable types: true
- Function return types: true

## LSP Status

Check LSP status in lualine status bar (right side shows active clients).
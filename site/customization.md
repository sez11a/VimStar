---
layout: page
title: "Customization"
description: "How to customize VimStar"
permalink: /customization/
---

VimStar is designed for easy customization without forking the entire repository.

## User Configuration

**File**: `~/.VimStar/lua/vimstar-user.lua`

This file loads after core configuration, allowing you to override settings.

### Color Scheme

```lua
-- Comment out current, uncomment desired:
-- vim.cmd.colorscheme "carbonfox"
-- vim.cmd.colorscheme "catppuccin"
-- vim.cmd.colorscheme "cyberdream"
-- vim.cmd.colorscheme "edge"
-- vim.cmd.colorscheme "modus"
-- vim.cmd.colorscheme "moonfly"
-- vim.cmd.colorscheme "onedark"  -- Default
-- vim.cmd.colorscheme "purify"
-- vim.cmd.colorscheme "tokyonight-night"
```

### Wiki Root

```lua
vim.g.wiki_root = '~/custom/wiki/path'
```

### Transparency (Neovide)

In `init.lua`, uncomment and adjust:

```lua
if vim.g.neovide then 
  vim.g.neovide_normal_opacity = 0.8  -- 0-1, 1 = fully opaque
  vim.g.neovide_window_blurred = true
end
```

## Core Configuration

### Keymaps

Edit `lua/keymaps.lua` to add custom keybindings.

```lua
wk.add({
  { "<leader>x", group = "Custom" },
  { "<leader>xx", "<cmd>echom 'Hello'<CR>", desc = "Example" },
})
```

### Plugin Configuration

Each plugin is in `lua/plugins/*.lua` and returns a table:

```lua
return {
  {
    "plugin/author",
    config = function()
      require("plugin").setup({
        setting = "value"
      })
    end
  }
}
````

**To override**: Copy the plugin file to `lua/plugins/custom/`, edit, and it will load.

## LSP Settings

Edit `lua/plugins/lsp-config.lua` for LSP-specific options.

### Add New LSP

```lua
vim.lsp.config("new_ls", {
  capabilities = capabilities,
})
vim.lsp.enable("new_ls")
```

### Modify Existing LSP

```lua
-- In lsp-config.lua
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = { includeParameterNameHints = "all" },
    },
  },
})
```

## Mason Tools

Edit `lua/plugins/mason.lua` to add/remove LSPs and tools:

```lua
mason_lspconfig.setup({
  ensure_installed = {
    'new_ls',
  },
})

mason_tool_installer.setup({
  ensure_installed = {
    "new-tool",
  }
})
```

## Indentation

Edit `lua/plugins/writing-stuff.lua` tabset.nvim section:

```lua
require("tabset").setup({
  defaults = {
    tabwidth = 2,  -- Change default
    expandtab = true,
  },
  languages = {
    java = {
      tabwidth = 4,
      expandtab = false,
    },
  }
})
```

## Loading Order

1. `init.lua` - Entry point
2. `vim-options.lua` - Core settings
3. `lazy.setup("plugins")` - Plugins
4. `keymaps.lua` - Keybindings  
5. `vimstar-user.lua` - User overrides

## Tips

- Use `:Lazy` to reload plugins after changes
- Use `:lua reload()` in Neovim for config reload
- Check `:scriptnames` to see which config files loaded
- Use `:messages` to see plugin errors

## Presets

See `vimstar-user-template` for default user config.
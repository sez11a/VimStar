---
layout: page
title: "Customization"
description: "How to customize VimStar"
permalink: /customization/
---

VimStar is designed for easy customization without forking the entire repository.

## User Configuration

**File**: `~/.VimStar/lua/vimstar-user.lua`

This file loads after core configuration. Settings here override other defaults. If you see a setting elsewhere, override it in this file. Do not edit the other files; otherwise, you won't be able to update VimStar from GitHub (you'll have conflicts). 

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
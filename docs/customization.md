---
layout: single
title: "Customization"
description: "How to customize VimStar"
sidebar: 
  nav: "main"
toc: true
permalink: /customization/
---

You can customize VimStar without forking the entire repository. I wanted everyone to be able to add whatever they want and still update VimStar via `Space-qu`. This gives you the freedom to add to VimStar any plugins and configuration you need. 

There are two places where you can add your customizations: 

1. `vimstar-user.lua` (easy)
1. `lua/user/plugins/` (advanced)

These can be understood as "easy" configuration and "advanced" configuration.

## Easy Configuration

**File**: `~/.VimStar/lua/vimstar-user.lua`

This file loads after core configuration. Settings here override other defaults. If you see a setting elsewhere that you want to change (i.e., like indent size, etc.), override it in this file. Do not edit other files except for what's under the `lua/user` directory; otherwise, you won't be able to update VimStar from GitHub (you'll have conflicts). 

### Color Scheme

```lua
-- Comment out current, uncomment desired:
-- vim.cmd.colorscheme "carbonfox"
-- vim.cmd.colorscheme "catppuccin"
vim.cmd.colorscheme "cyberdream"
-- vim.cmd.colorscheme "edge"
-- vim.cmd.colorscheme "modus"
-- vim.cmd.colorscheme "moonfly"
-- vim.cmd.colorscheme "onedark"  
-- vim.cmd.colorscheme "purify"
-- vim.cmd.colorscheme "tokyonight-night"
```

### Wiki Root

```lua
vim.g.wiki_root = '~/custom/wiki/path'
```

Once you customize the wiki's location, you can then sync those files via Syncthing, Nextcloud, Dropbox, or other software to your phone or other systems where you need your notes. 

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
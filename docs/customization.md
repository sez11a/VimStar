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

## Advanced Configuration

**Directory**: `~/.VimStar/lua/user/plugins/`

Here, you can add your own Neovim plugins that persist through VimStar updates. By default, the install creates a file named `init.lua` in this folder ready to contain your plugin configurations. Per the Lazy plugin manager, add your plugins in this format: 

```lua
-- ~/.VimStar/lua/user/plugins/init.lua
return {
  {
    "username/my-plugin",
    config = function()
      require("my-plugin").setup({ option = "value" })
    end,
  },
}
```

Adding your plugins here keeps them separate from core configuration so you can update via `Space-qu`. Since Git ignores the directory, your customizations don't conflict with future VimStar updates. Be sure to back up or sync your configuration somewhere in case you must reinstall later! 

## Loading Order

1. `init.lua` - Entry point
2. `vim-options.lua` - Core settings
3. Lazy.nvim loads:
   - `plugins/` directory (core plugins)
   - `user/plugins/` directory (custom user plugins) 
4. `keymaps.lua` - Keybindings
5. `vimstar-user.lua` - User overrides

## Tips

- Use `:Lazy` to reload plugins after changes
- Use `:lua reload()` in Neovim for config reload
- Check `:scriptnames` to see which config files loaded
- Use `:messages` to see plugin errors

## Presets

See `vimstar-user-template` for default user config.
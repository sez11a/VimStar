---
layout: single
title: "Customization"
description: "How to customize VimStar"
sidebar: 
  nav: "main"
toc: true
permalink: /customization/
---

You can customize VimStar without forking the entire repository. Add whatever plugins and configuration you need and still update VimStar via `Space-qu`.

There are two places where you can add your customizations:

1. `vimstar-user.lua` (easy)
1. `lua/user/plugins/` (advanced)

Start with the easy configuration first. 

## Easy Configuration

**File**: `~/.VimStar/lua/vimstar-user.lua`

This file loads after core configuration, so settings here override other defaults. Do not edit other files except what is under `lua/user`; otherwise, edits conflict when you update VimStar from GitHub.

### Color Scheme

Comment out the current scheme and uncomment the one you prefer:

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

Once you customize the wiki's location, sync those files via Syncthing, Nextcloud, Dropbox, or other software to your phone or other systems where you need your notes.

### User Snippets

VimStar bundles snippets in `~/.VimStar/snippets/` (snipmate format, loaded by [LuaSnip](https://github.com/L3MON4D3/LuaSnip)). Store your own snippets in a separate directory outside VimStar so they survive updates.

1. Add `vim.g.vimstar_user_snippets = "~/my-snippets"` to `~/.VimStar/lua/vimstar-user.lua`, replacing `~/my-snippets` with the path to your snippets directory.

1. Place `*.snippets` files in that directory, one per filetype (for example, `python.snippets` or `lua.snippets`).

Snippets in your directory take precedence over built-in snippets when triggers collide.

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

Adding your plugins here keeps them separate from core configuration so you can update via `Space-qu`. Git ignores the directory, so your customizations don't conflict with future VimStar updates. Back up or sync your configuration somewhere in case you must reinstall later.

## Loading Order

1. `init.lua`---Entry point
1. `vim-options.lua`---Core settings
1. Lazy.nvim loads:
   - `plugins/` directory (core plugins)
   - `user/plugins/` directory (custom user plugins)
1. `keymaps.lua`---Keybindings
1. `vimstar-user.lua`---User overrides

## Tips

- Use `:Lazy` to reload plugins after changes
- Use `:lua reload()` in Neovim for config reload
- Check `:scriptnames` to see which config files loaded
- Use `:messages` to see plugin errors

## Presets

See `vimstar-user-template` for default user config.

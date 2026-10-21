---
layout: single
title: Your Own Snippets, Outside of VimStar
date: 2026-10-21
excerpt: "Add custom snippets in a directory of your choosing"
sidebar:
  nav: "main"
---

I've added a small but handy feature: you can now keep your own snippets in a directory outside of VimStar, so they survive updates.

VimStar already bundles snippets in `~/.VimStar/snippets/`, but editing files inside the repo means your changes get clobbered the next time you pull. With `vim.g.vimstar_user_snippets`, you point VimStar at your own snippets directory-—-say `~/my-snippets`-—-and drop `*.snippets` files there, one per filetype. They load alongside the built-in ones, and yours take precedence when triggers collide.

This keeps your custom snippets completely separate from VimStar, so you can update via `Space-qu` without worrying about merge conflicts.

Head over to the [Customization docs](/customization/) for the details. Enjoy!

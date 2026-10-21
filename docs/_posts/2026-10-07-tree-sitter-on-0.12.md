---
layout: single
title: Tree-Sitter on Neovim 0.12
date: 2026-10-07
excerpt: "Notes for upgrading to Neovim 0.12 without breaking syntax highlighting"
sidebar:
  nav: "main"
---

Neovim 0.12 rewrote much of the Tree-Sitter API, so `nvim-treesitter` runs a completely different code path on 0.12+ than it does on 0.11 and earlier. VimStar supports both, but people moving from 0.11 up to 0.12 should know some things so syntax highlighting keeps working.

## What changed in VimStar

Previously VimStar defined Tree-Sitter as **two** separate plugins: one pointed at the `main` branch for 0.12 and one at the `master` branch for everything else. Lazy's dedup logic treats both specs as the same repository (they share a URL), so it collapses them into one plugin and installs whichever branch happens to win the merge. On 0.11 that left the plugin in a broken, half-installed state that showed as `Disabled` in the Lazy list and never cloned. In other words, I had a bug. 

The fix is to use a **single** plugin spec and select the branch by version:

- init.lua:5 detects 0.12+ and sets `vim.g.tree_sitter_branch = "main"`, otherwise `"master"`.
- lua/plugins/treesitter.lua uses one spec (`branch = ts_branch`) and runs the new or legacy configuration from there.

There's only one plugin and one URL now, so nothing collapses, and the right branch always clones. If you're still on 0.11, nothing changes for you-—-the version detection handles it automatically. But people upgrading from 0.11 to 0.12 should read on, because the branch is only half of the story.

## The lockfile is the tricky part

The branch is only half of the story. Lazy keeps the exact commit of every plugin in `lazy-lock.json`, and that file survives the upgrade to Neovim 0.12. If it still holds the commit of the `master` branch, Lazy restores that commit on every install, even though VimStar asks for `main`. The result is the old code running against the new Neovim, and the error messages that come with it (`attempt to call field 'get_available' (a nil value)` and friends).

VimStar does not trust the lockfile blindly. On startup it looks at the branch that is actually checked out, and when it is the wrong one it switches the checkout to the branch this Neovim needs and rewrites the lockfile, so the wrong commit cannot come back. The same repair runs when the plugin is installed from scratch, which means a fresh machine and an upgraded machine end up in the same state.

Because the lockfile is per machine, this only ever hits the machines that were upgraded while the old entry was still around.

## Steps when upgrading to 0.12

1. **Update VimStar first.** Update VimStar using your usual update command (`Space-qu`). Without this the old dual-plugin config is still in place and Tree-Sitter remains broken.
2. **Clear any stale Tree-Sitter clone from the old config.** If you previously had the broken dual-plugin setup, remove:
   - `~/.local/share/nvim/lazy/nvim-treesitter`
   - `~/.local/state/nvim` (this drops any stale Lazy state)
3. **Let the parsers be built.** The Markdown grammars are compiled while Lazy installs the plugin, and the rest of the grammars are compiled the first time you open a file of that type. `Space-qt` does both in one go: it refreshes the parsers that are installed and builds the ones that the files you have open still need.

## Verifying it worked

Run `Space-ql` and check that `nvim-treesitter` is listed as **Installed** (not `Disabled`) and that the clone lives under `~/.local/share/nvim/lazy/nvim-treesitter` on the `main` branch. Tree-Sitter highlighting, expression-based folding, and Tree-Sitter indentation should all be active in supported filetypes.

## Still not working?

- Confirm `nvim --version` reports `0.12` (or higher). The branch selection depends on it.
- Make sure VimStar itself was updated in the same step — the auto-detection only exists in newer builds.
- If highlighting is still missing after `Space-qt`, run it again; some parsers can take a moment to compile.

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

There's only one plugin and one URL now, so nothing collapses, and the right branch always clones. If you're still on 0.11, nothing changes for you-—-the version detection handles it automatically. But people upgrading from 0.11 to 0.12 should follow the steps below.

## Steps when upgrading to 0.12

1. **Update VimStar first.** Update VimStar using your usual update command (`Space-qu`). Without this the old dual-plugin config is still in place and Tree-Sitter remains broken.
2. **Clear any stale Tree-Sitter clone from the old config.** If you previously had the broken dual-plugin setup, remove:
   - `~/.local/share/nvim/lazy/nvim-treesitter`
   - `~/.local/state/nvim` (this drops any stale Lazy state)
3. **Rebuild Tree-Sitter parsers for 0.12.** After VimStar is updated, run `Space-qt` so parsers are compiled against the new 0.12 API. Lazy runs this install automatically once you've cleared the stale clone.

## Verifying it worked

Run `Space-ql` and check that `nvim-treesitter` is listed as **Installed** (not `Disabled`) and that the clone lives under `~/.local/share/nvim/lazy/nvim-treesitter` on the `main` branch. Tree-Sitter highlighting, expression-based folding, and Tree-Sitter indentation should all be active in supported filetypes.

## Still not working?

- Confirm `nvim --version` reports `0.12` (or higher). The branch selection depends on it.
- Make sure VimStar itself was updated in the same step — the auto-detection only exists in newer builds.
- If highlighting is still missing after `Space-qt`, run it again; some parsers can take a moment to compile.

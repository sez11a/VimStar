---
layout: single
title: Git Improvements for Pull Request Reviews
date: 2026-10-17
excerpt: "Merginal for PR browsing, and a three-way diff for side-by-side comparisons"
sidebar:
  nav: "main"
---
I've added some nice Git features to help you review pull requests right in VimStar.

## Merginal

Merginal is a powerful Git tool that gives you a beautiful interface for browsing and managing pull requests. With `<leader>gl`, you can now open Merginal to see

- All your open and closed PRs
- Files changed in each PR
- Inline diffs and comments
- The ability to merge, rebase, and close PRs without ever leaving Neovim

It's like having GitHub's PR interface, but keyboard-driven and inside your editor.

## Three-Way Diff

When you're reviewing a PR, it's often useful to see how your changes compare across three branches: the base branch, your current working branch, and the PR's target branch. `<leader>g3` opens a fancy three-panel diff that shows

- **Left panel**: The base branch (master/main) side of the file
- **Middle panel**: Your current working version (what you're editing)
- **Right panel**: The other branch you're comparing against

This is perfect for understanding exactly what's changing and why.  Call `<leader>g3`, enter the base branch when prompted, then the other branch to compare. The layout splits your screen into three sections with `diffthis` enabled for each, so you can see all the changes side-by-side.

Both features are designed to make pull request reviews smoother and faster. This is great for technical writing and coding, where you have to compare two different submissions to the base. Enjoy!

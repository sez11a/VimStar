---
layout: single
title: Ask Before You Update
date: 2026-10-08
excerpt: "Space-qu now checks for a new version before pulling"
sidebar:
  nav: "main"
---

`Space-qu` updates VimStar by pulling from the website first, then opens the latest announcement in your browser and asks whether you want to install it.

## Why

Previously `Space-qu` ran `git pull` every time, on a machine that might be offline, with no indication of what changed. The new flow separates *finding out what's new* from *actually updating*. If there's a post you haven't seen, it opens the article in your browser, waits for your answer, and only runs `git pull` when you confirm. Run it again to pull without re-confirming.

## What happens when you press it

- **There's a new post.** The browser opens the article, and a dialog shows the title and date, then asks whether to install the update. Confirming it runs `git pull` and remembers what it saw; declining stops.
- **Nothing is new.** VimStar runs a routine `git pull` and tells you it's already at the current version. No dialog, no browser.
- **You're offline.** The feed fetch fails, VimStar tells you to connect, and it does nothing. No pull happens, because a pull can't work offline anyway.

## The version counter

After the first successful update, `Space-qu` records the new post's date in `~/.local/state/nvim/vimstar/latest_update_date`. Next run it compares the current date to that file. Matching dates mean already current; a newer date means a new update. A missing file counts as "new," which is the right behavior on a fresh install.

## When updates land

The list lives on the [updates section](/VimStar/updates/) of the VimStar site. Check there if the browser won't open or you want the text alongside the prompt.

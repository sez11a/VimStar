---
layout: single
title: Ask Before You Update
date: 2026-10-08
excerpt: "Space-qu now checks for a new version before pulling"
sidebar:
  nav: "main"
---

`Space-qu` now shows the latest update announcement in your browser and asks whether you want to install it.

## Why

Previously `Space-qu` ran `git pull` with no indication of what changed. The new flow separates *finding out what's new* from *actually updating*. If there's a post you haven't seen, it opens the article in your browser, waits for your answer, and only runs `git pull` when you confirm. Run it again to pull without re-confirming.

## What Happens

If nothing is new, VimStar runs a routine `git pull` and tells you it's already at the current version. No dialog, no browser. If there's a new post, the browser opens the article, a dialog shows the title and date, ahd then asks whether to install the update. Confirming it runs `git pull` and remembers what it saw; declining stops. If you're offline, the feed fetch fails, VimStar tells you to connect, and it does nothing. No pull happens, because a pull can't work offline anyway.

## The Version Counter

After the first successful update, `Space-qu` records the new post's date in a file in Neovim's `state` directory. Next run it compares the current date to that file. A missing file counts as "new," which is the right behavior on a fresh install.

## Update History

The list lives on the [updates section](/VimStar/updates/) of the VimStar site. Check there if the browser won't open or you want the text alongside the prompt.

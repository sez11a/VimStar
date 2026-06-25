---
layout: single
title: "Wiki System"
description: "Wiki for journaling, note-taking, and knowledge management"
permalink: /wiki/
sidebar: 
  nav: "main"
toc: true
---

VimStar includes a personal wiki system for journaling, note-taking, and knowledge management. These are stored as Markdown files in a directory configurable in `vimstar-user.lua`. The [wiki.vim](https://github.com/lervag/wiki.vim) plugin provides the wiki functionality, and it has excellent documentation available [online](https://github.com/lervag/wiki.vim/blob/master/doc/wiki.txt) or via `:help wiki`. 

# Configure 

You can configure where your wiki is stored. This is excellent for integrating it with other notes applications, such as Nextcloud notes. 

1. Open `lua/vimstar-user.lua`. 

1. Find the `vim.g.wiki_root` variable and change it to the folder you want: 

   ```lua
   vim.g.wiki_root = "~/Documents/notes"
   ```

Now you're ready to use the wiki. 

# Quick Start 

The wiki has two functions: 

1. It functions as a standard, linkable wiki with a home page. 

2. It functions as a Personal Information Manager you can use for your daily tasks and notes, using the *Finishing Well* system outlined in my (@sez11a) upcoming book of the same name. 

## Using a Personal Wiki

You can create a personal wiki out of Markdown files you organize yourself. 

1. Use `Space-ww` to open the default wiki page. 

1. Add whatever information you want here. Most home pages contain links to the other sections of the site. Links can be wiki-style links or Markdown links relative to the folder in which you created the wiki. For example, this is a possible home page: 

   ```markdown
   # My Wiki 

   [[Notes]]

   [[Roles]]

   [[Tasks]]

   [[Agendas]]

   [[Projects]]

   [[Goals]]

   ```

1. If you want more control over the location and names of the Markdown files, use Markdown-style links: 

   ```markdown
   # My Wiki

   [Notes](/notes/notes.md)

   (etc)
   ```

1. In Normal mode, pressing `Enter` on one of those links takes you to its page, where you can create whole hierarchies of pages. 

## Using the *Finishing Well* System

Since I've written an entire book on the *Finishing Well* system, it would be impossible to cover everything in the book here. If you're familiar with the book, you'll notice the categories above map to the categories of forms you use in the analog system. Use Roles, Tasks, Agendas, Projects, and Goals as you would in the analog system, with a new, linked Wiki file to cover each Role, Task category, person you have an Agenda for, Project you're working on, and Goal that you have. 

The wiki has templates keyed to folder names: 

- Tasks: `/tasks` 
- Agendas: `/agendas`
- Projects: `/projects`
- Roles: `/roles`

Your daily journal is easy to access. Hit `Space-w-Space-w` to open today's journal. You'll see a new Markdown file is created for today, where you can put your schedule for today, any tasks you want to complete today, any role tasks you have, and your journal notes for the day. 

There is no weekly form in this version; it's similar to the analog planner version that way. 

A link to access this month's form appears at the top of your daily journal. Move the cursor to it and press *Enter* to access it and plan out your month. 

I find it helpful to split the VimStar window vertically (`:vsplit`) with the month on the right and the day on the left. 

## Journal Navigation

| Key | Action |
|-----|-------|
| `[w` | Previous journal entry |
| `]w` | Next journal entry |
| `Space-wi` | Open journal index |


## File Naming Convention

- Daily: `YYYY/MM/DD.md`
- Monthly: `YYYY/MM/plan.md`


## Integration

The wiki uses Markdown files. The same spell check, Pandoc, and Markmap features apply.
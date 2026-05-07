---
layout: page
title: "Wiki System"
description: "Journaling with wiki.vim templates"
permalink: /wiki/
---

VimStar includes a wiki system for journaling, note-taking, and knowledge management.

## Wiki Plugin

Uses `wiki.vim` plugin configured in `lua/plugins/wiki.lua`.

## Journal Navigation

| Key | Action |
|-----|-------|
| `[w` | Previous journal entry |
| `]w` | Next journal entry |
| `<leader>wi` | Open journal index |

## Journal Templates

Located in `~/.VimStar/wiki/templates/`:

| Template | Usage |
|----------|-------|
| `daily.md` | Daily journal entries |
| `monthly.md` | Monthly planning |
| `project.md` | Project documentation |
| `notes.md` | General notes |
| `agenda.md` | Meeting agendas |
| `actions.md` | Action items |

## Default Root Directory

Location: `~/Share/pim/pkm` (configurable in `vimstar-user.lua`)

```lua
vim.g.wiki_root = '~/Share/pim/pkm'
```

## File Naming Convention

- Daily: `YYYY/MM/DD.md`
- Monthly: `YYYY/MM/summary.md`
- Weekly: `YYYY/week_V.md`

## Monthly Template

When creating a monthly plan, the template inserts:

```markdown
---
title: [Month Year]
---

[Browse Monthly Plan](/journal/YYYY/MM/plan.md)

# Schedule

# Actions

# Roles

# Notes
```

## Creating a New Entry

1. Open wiki: `:Wiki diary`
2. Or navigate with `[w`/`]w`
3. Date is auto-inserted for daily entries

## Wiki Linking

wiki.vim supports wiki-style links:

```
[[2024/01/15]]  -- Link to daily entry
[[project:My Project]]
```

## Customization

Edit `lua/plugins/wiki.lua` to:
- Change template locations
- Add new template match functions
- Modify date format

## Integration

Wikis work alongside Markdown files. The same spell check, pandoc, and markmap features apply.
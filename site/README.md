---
layout: default
title: "VimStar - Documentation Site"
---

# VimStar Documentation Site

This directory contains the Jekyll site source for documenting VimStar.

## Site Structure

```
site/
├── _config.yml          # Jekyll configuration
├── Gemfile              # Ruby dependencies
├── index.md             # Home page
├── _pages/              # Documentation pages
│   ├── install.md
│   ├── quickstart.md
│   ├── keybindings.md
│   ├── writing.md
│   ├── coding.md
│   ├── wiki.md
│   ├── customization.md
│   ├── troubleshooting.md
│   └── license.md
├── _layouts/            # HTML layouts
│   ├── default.html
│   ├── home.html
│   └── page.html
├── _includes/           # Reusable components
├── assets/
│   └── css/
│       └── style.css    # Theme styles
└── README.md            # This file
```

## Development

### Requirements

- Ruby 2.7+ (or use Bundler)
- Bundler (install: `gem install bundler`)

### Running Locally

```bash
cd site
bundle install
bundle exec jekyll serve
````

The site will be available at `http://localhost:4000/VimStar/`.

### Building for GitHub Pages

The site is configured for GitHub Pages at `https://sez11a.github.io/VimStar/`.

To preview before committing:

```bash
bundle exec jekyll build --destination _site
````

## Content Guidelines

### Writing Style

- **Concise**: Get to the point quickly
- **Action-oriented**: Use imperative voice ("Press Space-k" not "You should press")
- **Code-first**: Show examples before explanations
- **WordStar-aware**: Mention heritage where relevant

### File Format

- Use Markdown (`.md`)
- Include front matter:
  ```yaml
  ---
  layout: page
  title: "Title"
  description: "Short description"
  permalink: /path/
  ---
  ```
- Add `##` headers for sections
- Use code blocks with language identifiers: ```bash

### Linking

- Use relative links: `[Title](/path/)`
- GitHub Pages prefix: The site lives at `/VimStar/`

### Screenshots

Place in `site/assets/images/` and reference as:

```markdown
![Caption](./images/filename.png)
````

## Updating the Site

1. Edit/add pages in `_pages/`
2. Update navigation in `_config.yml` if needed
3. Update `index.md` for major changes
4. Test locally with `bundle exec jekyll serve`
5. Commit and push - GitHub Pages auto-deploys

## Adding a New Page

1. Create `site/_pages/newpage.md`
2. Add to `site/_config.yml` nav section
3. Add link in navigation or index as needed

## Troubleshooting

### Missing gems

```bash
bundle install
````

### Layout not found

Ensure `_layouts/` exists and contains the layout file.

### Liquid errors

Check YAML front matter syntax - ensure all quotes are balanced.

## Deployment

The site deploys automatically to GitHub Pages when pushing to the repo root.
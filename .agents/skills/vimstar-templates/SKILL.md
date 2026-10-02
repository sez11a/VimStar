---
name: vimstar-templates
description: Templates in VimStar are Pandoc templates that transform a Markdown file into other formats and layouts. 
---

Templates in VimStar use Pandoc (https://pandoc.org) to transform Markdown files into other formats with professional layouts. You can find all the templates available in the `./templates` directory, separated into their directories by their type (i.e., typst, odt). New templates should always be generated there, by their type. 

Typst is tricky for LLMs; it's new, so there aren't many examples to reference. Below are some things we've learned. 

## Typst gotchas (learned while debugging the heading font)

- A global `#show text: set text(font: …)` rule fires on the inner text of *every* element and is the nearest scope to the heading's text, so it **overrides** a less-nested `#show heading: set text(font: …)` rule. That was the original "headings render in the body font" bug — fixed by removing the global rule. Do not reintroduce a global `#show text` font rule.
- Style lower-level headings with a `set text(…)` show rule (keeps the element a real **block** heading, so it breaks to its own line and stays in `outline`/ToC). Do **not** replace the heading with a bare `#text(…)[#it.body]` element — that makes it inline, which drops the following paragraph onto the same line and removes it from the ToC.
- Verify font changes with `pdffonts out.pdf` (lists embedded families) and `pdftotext -layout` (checks line breaks); Pandoc emits a harmless "unknown font family" warning for any fallback entry not installed on the compiling machine.

## Book Template: templates/typst/book-bookly.typ

Layout for a digest-sized paperback (5.5x8.5in), invoked via Pandoc (`<Space>pk` → `Pandoc pdf --to pdf --pdf-engine typst --template .../book-bookly.typ`).

- **Fonts** are centralized in two `#let` variables at the top of the template (`body-font`, `heading-font`). Every font site (bookly `fonts:`, body `#set text`, level-1/2/3/4 headings, running header, figure captions) references one of these two — change a font there, not at the call sites.
- **Per-document overrides** via YAML headers: `body-font` (serif, body text) and `heading-font` (sans, headings + captions + running header). Set via Pandoc `$if(...)$`; when unset (or the named font isn't installed) the template falls through a cross-OS list (Times/Georgia/Noto/DejaVu/Liberation for serif; Arial/Helvetica/Verdana/Noto/DejaVu/Liberation for sans). An installed user font takes precedence.
- **Default look**: body = Libertinus Serif, headings/captions = Gillius ADF (both not standard on Windows/macOS — that's why the fallback lists exist).


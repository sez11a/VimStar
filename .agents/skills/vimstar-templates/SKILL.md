---
name: vimstar-templates
description: Templates in VimStar are Pandoc templates that transform a Markdown file into other formats and layouts. 
---

Templates in VimStar use Pandoc (https://pandoc.org) to transform Markdown files into other formats with professional layouts. You can find all the templates available in the `./templates` directory, separated into their directories by their type (i.e., typst, odt). New templates should always be generated there, by their type. 

## Template Customization System

Users can override built-in templates without modifying the VimStar installation. The system works via `lua/vimstar/templates.lua`:

- **Resolver module**: `lua/vimstar/templates.lua` exports `resolve(rel_path)`, `pandoc_template(rel_path)`, `reference_doc(rel_path)`, and `lua_filter(rel_path)`.
- **User config**: Users set `vim.g.vimstar_user_templates` in `vimstar-user.lua` to a directory containing their customized templates.
- **Fallback behavior**: The resolver checks the user directory first; if a custom template exists, it's used. Otherwise falls back to `~/.VimStar/templates/`.
- **Structure mirroring**: Custom templates mirror the relative path under the user directory (e.g., `typst/book.typ`, `odt/shunn-modern-reference.odt`).

### Adding New Templates (for VimStar maintainers)

When adding a new template to VimStar:

1. **Place it in `templates/<type>/<name>.typ`** (or `.odt`/`.lua` for ODT reference docs and filters).

2. **Use the resolver in keymaps** (`lua/keymaps.lua`):
   ```lua
   local templates = require("vimstar.templates")
   -- For Typst PDF templates:
   vim.cmd("Pandoc pdf --to pdf --pdf-engine typst " .. templates.pandoc_template("typst/new-template.typ"))
   -- For ODT reference docs:
   reference_doc = templates.resolve("odt/custom-reference.odt")
   -- For Lua filters:
   filter = templates.resolve("odt/custom-filter.lua")
   ```

3. **Document the relative path** in the `vimstar-user-template` file so users know what to override.

4. **The user-templates directory is git-ignored** (in `.gitignore`), so user customizations survive updates.

Typst is tricky for LLMs; it's new, so there aren't many examples to reference. Below are some things we've learned. Existing Typst templates to crib from: `book.typ` (simplest), `article-handout.typ`, `planner-page.typ`, `submission-format.typ`, `book-bookly.typ` (uses the `bookly` package), and `report.typ`.

## How VimStar runs Pandoc

The `Pandoc` user command (`lua/vimstar/functions.lua`) builds a single shell command:

```
pandoc -i <current file> -o <current file:r>.<args>
```

So `:Pandoc pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/report.typ` expands to `pandoc -i foo.md -o foo.pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/report.typ`. Consequences:

- **The keymap can only pass the flags written in it.** In particular `--toc`, `--toc-depth`, and `--number-sections` are **not** passed, so `$toc$` is unset and any template that needs a table of contents must emit `#outline(...)` **unconditionally** — wrapping it in `$if(toc)$…$endif$` produces no ToC (`book-bookly.typ` does this).
- The output path is built by concatenating `-o <basename>.` with the argument list, so the **first argument token must be the extension** (`pdf`), followed by the real flags.
- `--template` **replaces Pandoc's built-in Typst template entirely**, so the template must emit `$body$` itself (plus `$title$`, the `#outline`, etc.) — nothing is added around it.
- The command runs from **Neovim's current working directory**, and `expand('%')` is relative to it. The docs tell users to `<Space>kl` (change the working directory to the open file) before exporting so relative image paths resolve.
- Add a sibling keymap entry in `lua/keymaps.lua` under the `<Space>p` group for each new template (follow the existing `depcheck.has_pandoc()` guard + `vim.cmd("Pandoc pdf …")` pattern), and add a matching `yaml-<name>` snippet to `snippets/markdown.snippets`.

## Pandoc template syntax (the `$…$` layer)

The template file is a **Pandoc template** that happens to contain Typst; Pandoc substitutes `$…$` placeholders *before* Typst ever sees the output.

- Any YAML key becomes a variable of the same name (`paper:` → `$paper$`), and standard keys (`title`, `subtitle`, `author`) work too. Unknown placeholders (`$foo$`) are silently replaced with nothing, and `$if(foo)$…$else$…$endif$` is false for unset/empty values.
- **Quote placement:** to place a variable inside Typst string quotes, put the quotes *inside* the conditional: `$if(paper)$"$paper$"$else$"a4"$endif$`. Writing `"$paper"` (a `$` with no closing `$`) makes Pandoc fail with `unexpected "\""`.
- **Interpolated variables are plain text, not code.** In `#text(...)[$left-header$]` the value becomes literal text — do **not** write `#$left-header$`, which yields `#Project Phoenix` and a Typst parse error. Keep the `#` only on real function calls (`#h(1fr)`, `#line(...)`).
- In a hand-written `.typ` (no Pandoc), `$…$` is Typst **math** mode, so such a file can't be used to test `$var$` substitution — always test through `pandoc --template`.

## Typst gotchas

- A global `#show text: set text(font: …)` rule fires on the inner text of *every* element and is the nearest scope to the heading's text, so it **overrides** a less-nested `#show heading: set text(font: …)` rule. That was the original "headings render in the body font" bug — fixed by removing the global rule. Do not reintroduce a global `#show text` font rule.
- Style lower-level headings with a `set text(…)` show rule (keeps the element a real **block** heading, so it breaks to its own line and stays in `outline`/ToC). Do **not** replace the heading with a bare `#text(…)[#it.body]` element — that makes it inline, which drops the following paragraph onto the same line and removes it from the ToC.
- A **chapter-style level‑1 heading** *is* replaced, but wrap block-level elements around it so it stays a block and in the ToC. `book-bookly.typ`/`report.typ` pattern:
  ```
  #show heading.where(level: 1): it => {
    pagebreak()
    v(1em)
    text(font: heading-font, size: 20pt, weight: "bold")[#it.body]
    v(0.3em)
    line(length: 100%, stroke: 0.75pt)
    v(0.6em)
  }
  ```
  Confirm with `pdftotext -layout` that the following paragraph still starts on its own line and the heading still appears in the outline.
- **`#front-matter` / `#main-matter` are `bookly` functions, not Typst builtins.** Only templates that `#import "@preview/bookly:…": *` may use them. Self-contained templates separate front/main matter with sequential `#set page(...)` + `#counter(page).update(1)` calls instead.
- **`#set` rules merge.** A later `#set page(header: …)` overrides only `header`; `paper`/`margin` set earlier are preserved. This is how a template changes headers/footers mid-document without repeating the whole page setup.
- **Page counters:** reset with `#counter(page).update(1)`; display with `counter(page).display("1")` (arabic) or `display("i")` (lowercase roman — **not** `"r"`, which errors with "invalid numbering pattern"). Parity is `calc.even(here().page())` / `calc.odd(...)`.
- **`pagebreak()`** starts the next page; **`pagebreak(to: "odd")`** forces a recto page and can leave a blank page — choose deliberately (a report wants plain `pagebreak()`, a book often wants `"odd"`).
- `place(center, …)` inside a `footer`/`header` context centers the number; use `align(left, …)` / `align(right, …)` otherwise. `align(center + horizon)` centers a block vertically on the page (good for a title page).
- Typst paper names are `"us-letter"` and `"a4"` (there is no `"letter"`). Draw a rule with `line(length: 100%, stroke: …)`, add space with `v(...)`, and separate two texts with `#h(1fr)`. Figure captions: `#show figure.caption: set text(...)`.
- **Font lists:** `#set text(font: ("First", "Second", …), fallback: true)` tries each family in order, and `fallback: true` additionally allows any system font for glyphs none of them have. Every VimStar template uses this cross-OS list pattern, with the lists held in `#let body-font` / `#let heading-font` variables (overridable per document via `$if(body-font)$`).
- **Variable fonts are not supported by Typst** (0.14). If the named family is installed *only* as a variable font (e.g. `Alegreya[wght].ttf`), Typst cannot reach non-default weights: `**bold**` silently renders at the regular weight while `*italic*` still works (the family ships a separate italic *face* file). The build prints `warning: variable fonts are not currently supported … try installing a static version`. The fallback list does **not** rescue this — the family *is* installed, so Typst never falls through to the next entry (fallback is per-glyph, not per-weight). Fix by installing static faces, or by naming a family that ships real static bold files. On this machine Alegreya is variable-only (`/usr/share/fonts/google/alegreya/Alegreya[wght].ttf`); `install-alegreya-static.sh` in the repo root synthesizes static Regular/Bold/Italic/BoldItalic faces with `fonttools varLib.instancer --update-name-table` and installs them to `~/.local/share/fonts/alegreya`. `--update-name-table` is essential — without it the Bold instance still advertises itself as "Regular" and Typst ignores it. After installing statics the warning can persist (the system variable font is still indexed) but bold renders; confirm with `pdffonts` (a `…-Bold` face appears) and `pdftohtml -xml` (the bold run is wrapped in `<b>`). The `yaml-*` snippets therefore default to families with static faces (Typst bundles Libertinus Serif/Sans).
- Typst emits `warning: unknown font family: x` for every fallback-list entry not installed on the compiling machine. These are harmless — Typst just moves to the next font. (The `variable fonts are not currently supported` warning is *not* harmless — it means bold is silently missing; see above.)

## Verification toolkit

Compile the way VimStar does, then inspect the output:

```
pandoc -i doc.md -o doc.pdf --to pdf --pdf-engine typst --template ~/.VimStar/templates/typst/<name>.typ
pdftotext -layout doc.pdf -     # structure: headings on their own lines, ToC entries, page numbers, running-header text
pdfinfo doc.pdf | grep -i size  # paper size: 612x792 = Letter, 595x842 = A4
pdffonts doc.pdf                # embedded font families
```

- Line/rule drawings are invisible to `pdftotext`. To confirm a rule rendered, rasterize and measure: `pdftoppm -r 100 -f <page> -l <page> -gray doc.pdf out`, then (in Python) count dark pixels per row of the resulting PGM (P5 binary PNM, parseable without any imaging library) — a full-width rule shows a single row with ~(text-width-in-px) dark pixels.
- **Bold/italic integrity:** `pdffonts` should embed a `…-Bold` (and `…-Italic`) face; `pdftohtml -xml -stdout doc.pdf | grep -E '<b>|<i>'` should wrap the bold/italic runs. A missing `-Bold` face plus a `variable fonts are not currently supported` warning means the body font is a variable font — see the gotcha above.
- To read the **substituted** Typst without compiling, run the same command with `-t typst -o out.typ` (i.e. drop `--to pdf`) and inspect `out.typ` — this shows exactly what Pandoc produced from `$…$` and is the fastest way to catch quoting/substitution mistakes.
- Force a chapter onto a continuation page (many paragraphs) to verify running headers, since a short chapter fits one page and never shows one.

## Book Template: templates/typst/book-bookly.typ

Layout for a digest-sized paperback (5.5x8.5in), invoked via Pandoc (`<Space>pk` → `Pandoc pdf --to pdf --pdf-engine typst --template .../book-bookly.typ`).

- **Fonts** are centralized in two `#let` variables at the top of the template (`body-font`, `heading-font`). Every font site (bookly `fonts:`, body `#set text`, level-1/2/3/4 headings, running header, figure captions) references one of these two — change a font there, not at the call sites.
- **Per-document overrides** via YAML headers: `body-font` (serif, body text) and `heading-font` (sans, headings + captions + running header). Set via Pandoc `$if(...)$`; when unset (or the named font isn't installed) the template falls through a cross-OS list (Times/Georgia/Noto/DejaVu/Liberation for serif; Arial/Helvetica/Verdana/Noto/DejaVu/Liberation for sans). An installed user font takes precedence.
- **Default look**: body = Libertinus Serif, headings/captions = Libertinus Sans (both not standard on Windows/macOS — that's why the fallback lists exist).

## Report Template: templates/typst/report.typ

Layout for RFP responses, white papers, and other formal documents, invoked via Pandoc (`<Space>pr` → `--template .../report.typ`). Self-contained (no `bookly` import, unlike `book-bookly.typ`).

- **Structure**: title page (no page number) → front matter in lowercase roman numerals (`#counter(page).update(1)`, footer `counter(page).display("i")`, no running header) holding the table of contents → main body in arabic (`#counter(page).update(1)` again, running header, footer `display("1")`).
- **Running header** is built from `left-header`/`right-header` (falling back to `title`/`author`) and is suppressed on a page that opens with a level-1 heading via `query(heading.where(level: 1)).any(h => h.location().page() == here().page())`.
- Level-1 headings force `pagebreak()` and are followed by a full-width `line()` rule; levels 2–4 use the block-preserving `set text(...)` form (see the gotcha above).
- **Fonts** follow the same `body-font`/`heading-font` fallback scheme as the Book template; body text is 12pt. The `yaml-report` snippet exposes all of the report's headers.

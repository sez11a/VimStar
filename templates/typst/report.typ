// Report template for Typst
// Intended for use with Pandoc in VimStar: RFP responses, white papers, and
// other formal documents.

// === Fonts ===
// Override in the document's YAML header with `body-font` (serif) and
// `heading-font` (sans). Each fallback list is ordered so the first *installed*
// font on Windows, macOS, or Linux wins.
#let body-font = (
  $if(body-font)$
  "$body-font$",
  $endif$
  "Libertinus Serif",
  "Times New Roman",
  "Georgia",
  "Noto Serif",
  "DejaVu Serif",
  "Liberation Serif",
)

#let heading-font = (
  $if(heading-font)$
  "$heading-font$",
  $endif$
  "Libertinus Sans",
  "Arial",
  "Helvetica",
  "Verdana",
  "Noto Sans",
  "DejaVu Sans",
  "Liberation Sans",
)

// === Colors ===
// Accent color for the subtitle, the running header, and the header's rule.
// Change this single value to retheme all three. (Typst's built-in `navy` is a
// much darker #001f3f; this is the classic navy blue.)
#let accent-color = rgb("#000080")

// === Page setup ===
// Paper size comes from `paper: "us-letter"` or `paper: "a4"` (default: a4).
#set page(
  paper: $if(paper)$"$paper$"$else$"a4"$endif$,
  margin: (top: 1in, bottom: 1in, left: 1in, right: 1in),
)

// Body text: 12pt serif, English hyphenation, justified.
#set text(
  font: body-font,
  fallback: true,
  lang: "en",
  12pt,
)
#set par(justify: true)

// Figure captions use the sans heading font.
#show figure.caption: set text(font: heading-font, size: 11pt)

// === Title page (no page numbers) ===
#set page(header: none, footer: none)
#align(center + horizon)[
  #block[
    #text(font: heading-font, size: 28pt, weight: "bold")[$title$]
    $if(subtitle)$
    #v(0.6em)
    #text(font: heading-font, size: 16pt, fill: accent-color)[$subtitle$]
    $endif$
    #v(1.2em)
    #text(size: 12pt)[$author$]
  ]
]
#pagebreak()

// === Front matter ===
// First section: lowercase roman numerals, centered at the bottom, no running
// header. Contains the table of contents, generated from the first two heading
// levels.
#set page(
  header: none,
  footer: context {
    place(center, counter(page).display("i"))
  },
)
#counter(page).update(1)

// The table of contents is emitted unconditionally (the `Pandoc` command does
// not pass `--toc`), and includes the first two heading levels.
#outline(title: "Table of Contents", depth: 2)

// === Main body ===
// Arabic numerals, reset to 1, with a running header built from the
// `left-header` and `right-header` YAML values (defaulting to the title and
// author when those are not given).
#set page(
  header: context {
    // Suppress the running header on a page that opens with a chapter.
    let starts-chapter = query(heading.where(level: 1))
      .any(h => h.location().page() == here().page())
    if starts-chapter {
      none
    } else {
      v(0.6em)
      text(font: heading-font, size: 10pt, fill: accent-color)[
        $if(left-header)$$left-header$$else$$title$$endif$
        #h(1fr)
        $if(right-header)$$right-header$$else$$author$$endif$
      ]
      v(0.3em)
      line(length: 100%, stroke: 0.4pt + accent-color)
    }
  },
  footer: context {
    place(center, counter(page).display("1"))
  },
)
#counter(page).update(1)

// === Headings ===
// Each level-1 heading begins a new chapter on a fresh page and is set off
// from the body by a horizontal rule. (Modeled on book-bookly.typ.)
#show heading.where(level: 1): it => {
  pagebreak()
  v(1em)
  text(font: heading-font, size: 20pt, weight: "bold")[#it.body]
  v(0.3em)
  line(length: 100%, stroke: 0.75pt)
  v(0.6em)
}

#show heading.where(level: 2): set text(font: heading-font, size: 16pt, weight: "bold")
#show heading.where(level: 3): set text(font: heading-font, size: 14pt, weight: "bold")
#show heading.where(level: 4): set text(font: heading-font, size: 12pt, weight: "bold")
#show heading.where(level: 2): set heading(numbering: none)
#show heading.where(level: 3): set heading(numbering: none)
#show heading.where(level: 4): set heading(numbering: none)

$body$

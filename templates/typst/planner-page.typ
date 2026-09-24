// Planner-page template for Typst (booklet layout)
// Intended for use with Pandoc to convert Markdown to PDF

// For booklet folding (physical printing):
// 5.5×8.5" pages, landscape orientation, binding on right
#set page(
  width: 5.5in,
  height: 8.5in,
  flipped: true,
  binding: right,
  margin: 0.5in,
  columns: 2,
)

// Fonts can be overridden in the document's YAML header via `body-font`
// (serif) and `heading-font` (sans). Each fallback list is ordered so the
// first *installed* font on Windows, macOS, or Linux wins.
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
  "Gillius ADF",
  "Arial",
  "Helvetica",
  "Verdana",
  "Noto Sans",
  "DejaVu Sans",
  "Liberation Sans",
)

// Font setup - body text uses the serif body-font
#set text(
  font: body-font,
  fallback: true,
  10pt
)

#set columns(gutter: 0.24in)

// Headings (all levels) use the sans heading-font via set-text show rules,
// keeping them real block headings (so they stay on their own line and in the outline)
#show heading.where(level: 1): set text(
  font: heading-font,
)

#show heading.where(level: 2): set text(
  font: heading-font,
)

#show heading.where(level: 3): set text(
  font: heading-font,
)

#show heading.where(level: 4): set text(
  font: heading-font,
)

$title$

$subtitle$

$author$

$body$
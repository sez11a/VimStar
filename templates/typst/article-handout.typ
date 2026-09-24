// Article/Handout template for Typst
// Intended for use with Pandoc to convert Markdown to PDF

// Page setup: US-letter with 1in margins
#set page("us-letter", margin: 1in, numbering: "1", number-align: center,)

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
  11pt,
)

// Heading 1: real block heading using the sans heading-font, keeps its underline
#show heading.where(level: 1): it => block(width: 100%)[
  #set text(font: heading-font)
  #it
  #v(-0.85em)
  #line(length: 100%, stroke: 0.5pt)
]

// Lower-level headings (2+) use the sans heading-font via set-text show rules,
// keeping them real block headings (so they stay on their own line and in the outline)
#show heading.where(level: 2): set text(
  font: heading-font,
)

#show heading.where(level: 3): set text(
  font: heading-font,
)

#show heading.where(level: 4): set text(
  font: heading-font,
)

// Title block uses the body-font (serif), matching the body text
#(align(center)[#text(font: body-font, weight: "bold", size: 20pt)[$title$]])

#(align(center)[#text(font: body-font, weight: "bold", size: 18pt)[$subtitle$]])

#(align(center)[#smallcaps[#text(font: body-font, size: 16pt)[$author$]]])

// NOTE: For small-caps support, install Libertinus Serif Small Caps font variant.
// Alternatively, modify YAML to pass author name already in caps.
// If you override `body-font` via YAML, make sure that font also has a small-caps variant.

$body$
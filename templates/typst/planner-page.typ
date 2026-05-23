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

// Font setup
#set text(
  font: ("Libertinus Serif", "Noto Serif", "Noto Sans", "DejaVu Sans", "Helvetica", "Arial"),
  fallback: true,
  10pt
)

#set columns(gutter: 0.24in)

$title$

$subtitle$

$author$

$body$

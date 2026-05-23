// Book template for Typst
// Intended for use with Pandoc to convert Markdown to PDF

// Custom 5.5×8.5" book size (standard trade book size)
#set page(
  width: 5.5in,
  height: 8.5in,
  binding: left,
  margin: 0.75in
)

// Font setup
#set text(
  font: ("Libertinus Serif", "Noto Serif", "Noto Sans", "DejaVu Sans", "Helvetica", "Arial"),
  fallback: true,
  11pt
)

$title$

$subtitle$

$author$

$body$

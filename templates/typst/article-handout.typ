// Article/Handout template for Typst
// Intended for use with Pandoc to convert Markdown to PDF

// Page setup: US-letter with 1in margins
#set page("us-letter", margin: 1in)

// Font setup
#set text(
  font: ("Libertinus Serif", "Noto Serif", "Noto Sans", "DejaVu Sans"),
  fallback: true,
  11pt
)

$title$

$subtitle$

$author$

$body$

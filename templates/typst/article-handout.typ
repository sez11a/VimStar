// Article/Handout template for Typst
// Intended for use with Pandoc to convert Markdown to PDF

// Page setup: US-letter with 1in margins
#set page("us-letter", margin: 1in)

// Font setup (only font is supported in text set rule)
#set text(
  font: ("Libertinus Serif", "Noto Serif", "Noto Sans", "DejaVu Sans", "Helvetica", "Arial"),
  fallback: true,
  11pt
)

// Headings with underlines (same as LaTeX)
#show heading: (h: h) => {
  let rule = hrule(length: 100%, weight: 0.5pt)
  block(
    flow: flow(),
    spacing: 1em,
    stack(v: h.body, rule)
  )
}

// Title block: center-aligned (heading level 1)
#show heading.where(level: 1): align(center)[
  text(1.4em, weight: "bold", "Title")
]

// Images: full width (Typst default)
#show image: (img) => {
  img.with(width: 100%)
}

// Only page numbers in footer (centered)
#set page(numbering: "1", number-align: center + bottom)

// Planner-page template for Typst (booklet layout)
// Intended for use with Pandoc to convert Markdown to PDF

// For booklet folding (physical printing):
// 5.5×8.5" pages, landscape orientation, binding on right
#set page(
  width: 5.5in,
  height: 8.5in,
  flipped: true,           // landscape
  binding: right,          // binding on right for folding
  margin: 0.5in,
  columns: 2,
)

// Font setup
#set text(
  font: ("Libertinus Serif", "Noto Serif", "Noto Sans", "DejaVu Sans", "Helvetica", "Arial"),
  fallback: true,
  10pt  // slightly smaller for compact layout
)

// Set column gap separately
#set columns(gutter: 0.24in)

// Headings: underlined (same as other templates)
#show heading: (h: h) => {
  let rule = hrule(length: 100%, weight: 0.5pt)
  block(
    flow: flow(),
    spacing: 1em,
    stack(v: h.body, rule)
  )
}

// Images: full width for compact layout
#show image: (img) => {
  img.with(width: 100%)
}

// No headers/footers: clean, minimalist layout
// (page numbers would be added here if desired)

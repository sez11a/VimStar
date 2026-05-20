// Book template for Typst
// Intended for use with Pandoc to convert Markdown to PDF

// Custom 5.5×8.5" book size (standard trade book size)
#set page(
  width: 5.5in,
  height: 8.5in,
  binding: left,  // standard binding on left
  margin: 0.75in
)

// Font setup
#set text(
  font: ("Libertinus Serif", "Noto Serif", "Noto Sans", "DejaVu Sans", "Helvetica", "Arial"),
  fallback: true,
  11pt
)

// Underline heading style
#show heading: (h: h) => {
  let rule = hrule(length: 100%, weight: 0.5pt)
  block(
    flow: flow(),
    spacing: 1.5em,
    stack(v: h.body, rule)
  )
}

// Title page: simple centered
#show heading.where(level: 1): align(center)[
  text(size: 1.4em, weight: "bold", "Title")
]

// Images: 100% width (Typst default)
#show image: (img) => {
  img.with(width: 100%)
}

// Headers and footers
#set page(
  header: context [
    #set text(9pt)
    #if counter(page).get().first() > 1 [
      metadata.title
    ]
  ],
  footer: context [
    #set text(9pt)
    #counter(page).display("1", both: false)
  ],
  number-align: right + bottom
)

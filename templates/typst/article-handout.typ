// Article/Handout template for Typst
// Intended for use with Pandoc to convert Markdown to PDF

// Page setup: US-letter with 1in margins
#set page("us-letter", margin: 1in)

// Font setup
#set text(
  font: "Libertinus Serif",
)

#show heading: it => block(width: 100%)[
  #it
  #v(-0.85em)
  #line(length: 100%, stroke: 0.5pt)
]

#show heading.where(level: 2): it => { text(size: 12pt, weight: "bold")[#it ] }
#show heading.where(level: 3): it => { text(size: 12pt, weight: "bold")[#it ] }
#show heading.where(level: 4): it => { text(size: 12pt, weight: "bold")[ #it ] }

#(align(center)[#text(font: "Libertinus Serif", weight: "bold", size: 20pt)[$title$]])

#(align(center)[#text(weight: "bold", size: 18pt)[$subtitle$]])

#(align(center)[#text(font: "Libertinus Serif", size: 16pt)[$author$]])

// NOTE: For small-caps support, install Libertinus Serif Small Caps font variant.
// Alternatively, modify YAML to pass author name already in caps.

$body$

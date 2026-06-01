// Bookly paperback book template (classic theme)
// Designed for Pandoc-to-Typst conversion in VimStar

//#let paper-size = (width: 5.5in, height: 8.5in)
#let bookRed = rgb("#c1002a")

// Title page (outside of bookly's show rules)
$if(title)$
#set page(
  width: 5.5in,
  height: 8.5in,
  margin: (inside: 1in, outside: 0.5in, top: 0.75in, bottom: 0.75in),
  header: none,
  footer: none,
)

#align(center + horizon)[
#box(
  fill: bookRed,
  width: 80%,
  inset: 1em,
)[
  #text(fill: white, size: 2em, weight: "bold")[$title$]
]

  #v(1em)
  #line(stroke: 2pt + bookRed, length: 60%)
  #v(0.75em)

  #text(fill: bookRed, size: 3.5em, weight: "bold")[$title$]

  $if(subtitle)$
  #v(0.6em)
  #text(size: 1.6em)[#em[$subtitle$]]
  #v(0.6em)
  $endif$

  #v(0.5em)
  #line(stroke: 2pt + bookRed, length: 60%)
  #v(1em)

  #text(size: 1.5em, weight: "medium")[$author$]
]

#pagebreak(to: "odd")
$endif$

// Bookly takes over for document structure, TOC, and body
#import "@preview/bookly:3.1.1": *

#show: bookly.with(
  title: "untitled",
  author: "none",
  theme: classic,
  lang: "en",
  title-page: none,
  config-options: (
    open-right: true,
    alt-margins: false,
  ),
)

#set page(
  width: 5.5in,
  height: 8.5in,
  margin: (inside: 1in, outside: 0.5in, top: 0.75in, bottom: 0.75in),
  header: none,
  footer: context {
      let num = counter(page).display()
      if calc.even(here().page()) {
        align(left, num)
      } else {
        align(right, num)
      }
    }

)

#set text(
  font: ("Libertinus Serif", "Noto Serif", "Noto Sans", "DejaVu Sans"),
  fallback: true,
  lang: "en",
  11pt,
)

// Chapter headings: 18pt Libertinus Sans, wrapped within margins
#show heading.where(level: 1): it => {
  v(1em)
  text(
    font: ("Libertinus Sans", "Noto Sans"),
    size: 18pt,
    weight: "bold",
  )[
    #it.body
  ]
  v(0.5em)
}

// Fully-justified body text with automatic hyphenation
#set par(justify: true)

$if(toc)$
#tableofcontents
$endif$

$body$
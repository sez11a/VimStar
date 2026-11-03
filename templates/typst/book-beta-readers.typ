// Beta Readers Book template (Typst)
// For beta readers of a book in progress. Formatted like the book template
// (book-bookly.typ), except that pages are centered on a letter-size (or A4,
// per the `paper` YAML header) page with large margins all around for beta
// readers to add margin notes.
// Designed for Pandoc-to-Typst conversion in VimStar

// === Front matter pages (outside bookly's scope) ===
// === Bookly takes over ===
#import "@preview/bookly:3.1.1": *

// Fonts can be overridden in the document's YAML header via `body-font`
// (serif) and `heading-font` (sans). Each fallback list is ordered so the first
// *installed* font on Windows, macOS, or Linux wins.
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
  "Libertinus Sans",
  "Arial",
  "Helvetica",
  "Verdana",
  "Noto Sans",
  "DejaVu Sans",
  "Liberation Sans",
)

#show: bookly.with(
  title: "$title$",
  author: "$author$",
  theme: classic,
  lang: "en",
  title-page: [],
  config-options: (
    open-right: true,
    alt-margins: false,
  ),
  fonts: (
    body: body-font,
    heading: heading-font,   // optional — some versions support it
    math: ("IosevkaTermSlab NF", "New Computer Modern Math"),  // required
    raw: ("IosevkaTermSlab NF", "Fira Code", "Source Code Pro"), // required
  ),
)

// Beta-reader layout: the book page (5.5 x 8.5 in, digest-sized, with the text
// insets used by the book template) centered on a larger page (letter or A4, per
// the `paper` YAML header, which defaults to us-letter), with large margins all
// around so beta readers have room to add margin notes.
#let beta-reader-margins = if "$paper$" == "a4" {
  (top: 1.6in, bottom: 1.6in, left: 1.38in, right: 1.38in)
} else {
  (top: 1.25in, bottom: 1.25in, left: 1.5in, right: 1.5in)
}
#set page(
  paper: $if(paper)$"$paper$"$else$"us-letter"$endif$,
  margin: beta-reader-margins,
  header: none,
  footer: none,
)

// Pre-title (page 1)
#align(center + horizon)[
  #v(40%)
  #text(size: 18pt, weight: "bold")[$title$]
  $if(subtitle)$
  #v(0.4em)
  //#text(size: 14pt)[#em[$subtitle$]]
  #text(size: 14pt)[$subtitle$]
  $endif$
]

#pagebreak(to: "odd")

// Full Title Page (page 3)
#align(center + horizon)[
  #v(1em)
  #line(stroke: 2pt, length: 60%)
  #v(0.75em)
  #text(size: 3.5em, weight: "bold")[$title$]
  $if(subtitle)$
  #v(0.6em)
  //#text(size: 1.6em)[#em[$subtitle$]]
  #text(size: 1.6em)[$subtitle$]
  #v(0.6em)
  $endif$
  #v(0.5em)
  #line(stroke: 2pt, length: 60%)
  #v(1em)
  #text(size: 1.5em, weight: "medium")[$author$]
]

#pagebreak()

// Copyright (page 4)
#align(center)[
  #v(40%)
  #text(size: 10pt)[Copyright © #datetime.today().year() $if(copyright-holder)$$copyright-holder$$else$$author$$endif$.]
  #v(0.3em)
  #text(size: 10pt)[All rights reserved.]
  $if(isbn)$
  #v(0.3em)
  #text(size: 10pt)[ISBN: $isbn$]
  $endif$
]

$if(dedication)$
#pagebreak()
#align(center + horizon)[
  #v(20%)
  #emph(text(size: 12pt)[$dedication$])
]
$endif$

// Get ready for the ToC 

#set page(header: none, 
  footer: context {
    let num = counter(page).display("i")
    if calc.even(here().page()) {
      align(left, num)
    } else {
      align(right, num)
    }
  })


// Front-matter 
#front-matter[
  #counter(page).update(1)
  #outline(title: [Contents], depth: 3)
]

// Get ready for Main Matter 

#set page(
  paper: $if(paper)$"$paper$"$else$"us-letter"$endif$,
  margin: beta-reader-margins,
  header: context {
    import "@preview/hydra:0.6.2": hydra

    // Check if this page starts with a level-1 heading (chapter)
    let is-chapter-start = query(heading.where(level: 1))
      .any(h => h.location().page() == here().page())

    if is-chapter-start {
      none  // ← suppress header + rule on chapter opener pages
    } else {
      // Normal pages: Chapter (left) | Author (right)
      let header-font = heading-font
      let header-size = 9.5pt
      let header-weight = "regular"
      let header-color = black
      let rule-dy = 0.65em
      let rule-length = 100%
      let rule-stroke = 0.75pt + gray.darken(40%)

      if calc.odd(here().page()) {
        align(right)[
          #text(font: header-font, size: header-size, weight: header-weight, fill: header-color)[
            #states.author.get()
          ]
        ]
        place(dx: 0%, dy: rule-dy, line(length: rule-length, stroke: rule-stroke))
      } else {
        align(left)[
          #text(font: header-font, size: header-size, weight: header-weight, fill: header-color)[
            #hydra(1)
          ]
        ]
        place(dx: 0%, dy: rule-dy, line(length: rule-length, stroke: rule-stroke))
      }

      v(0.6em)
    }
  },

  footer: context {
      let num = counter(page).display()
      if calc.even(here().page()) {
        align(left, num)
      } else {
        align(right, num)
      }
    }
)

// Body text
#set text(
  font: body-font,
  fallback: true,
  lang: "en",
  11pt,
)
#set par(justify: true)

// Basic Chapter headings (level 1)
// #show heading.where(level: 1): it => {
//   pagebreak(to: "odd")
//   v(1em)
//   align(left)[
//     #text(
//       font: heading-font,
//       size: 18pt,
//       weight: "bold",
//     )[#it.body]
//   ]
//   v(0.5em)
// }

// Advanced chapter headings with "Chapter X" prefix 
#show heading.where(level: 1): it => {
  pagebreak(to: "odd")
  v(2em)   // space before chapter start
  
  // Design with CHAPTER above
  // align(center)[
  //  #text(
  //    font: heading-font,
  //    size: 11pt,
  //    weight: "bold",
  //    tracking: 2pt,          // spreads the letters nicely
  //  )[
  //    CHAPTER #counter(heading.where(level: 1)).display()
  //  ]
    
  //  #v(0.8em)
    
  //  #text(
  //    font: heading-font,
  //    size: 24pt,
  //    weight: "bold",
  //  )[
  //    #it.body
  //  ]
  // ]

  // Left Aligned
  align(left)[
    #text(
      font: heading-font,
      size: 13pt,
      weight: "bold",
      fill: rgb("#444")
    )[CHAPTER #counter(heading.where(level: 1)).display()]
    
    #v(0.3em)
    
    #text(
      font: heading-font,
      size: 22pt,
      weight: "bold"
    )[#it.body]
  ]
  v(1.5em)   // space after chapter title
}

// === Lower-level headings (2+) - use the sans heading font ===
#show heading.where(level: 2): set text(
  font: heading-font,
  size: 14pt,
  weight: "bold",
)

#show heading.where(level: 3): set text(
  font: heading-font,
  size: 12pt,
  weight: "bold",
)

#show heading.where(level: 4): set text(
  font: heading-font,
  size: 11pt,
  weight: "bold",
)
// Add more levels if you use them (level: 5, etc.)
// Remove numbering from headings level 2 and below
#show heading.where(level: 2): set heading(numbering: none)
#show heading.where(level: 3): set heading(numbering: none)
#show heading.where(level: 4): set heading(numbering: none)

// Picture (and other figure) captions use the sans font
#show figure.caption: set text(
  font: heading-font,
  size: 11pt,
)

// Style hyperlinks as blue, underlined text
#show link: it => text(fill: rgb("#0000EE"))[#underline(stroke: 0.5pt)[#it]]

// Fully-justified body text with automatic hyphenation
#set par(justify: true)

// Main-matter 
#main-matter[
  #set page(numbering: "1")
  #counter(page).update(1)
  $body$
]
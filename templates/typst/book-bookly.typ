// Bookly paperback book template (classic theme, B&W)
// Designed for Pandoc-to-Typst conversion in VimStar

// === Front matter pages (outside bookly's scope) ===
// === Bookly takes over ===
#import "@preview/bookly:3.1.1": *

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
    body: ("Libertinus Serif", "Noto Serif", "Noto Sans", "DejaVu Sans"),
    heading: ("Gillius ADF", "Noto Sans"),   // optional — some versions support it
    math: ("IosevkaTermSlab NF", "New Computer Modern Math"),  // required
    raw: ("IosevkaTermSlab NF", "Fira Code", "Source Code Pro"), // required
  ),
)

#set page(
  width: 5.5in,
  height: 8.5in,
  margin: (inside: 1in, outside: 0.5in, top: 0.75in, bottom: 0.75in),
  header: none,
  footer: none,
)

#show text: set text(font: ("Libertinus Serif", "Noto Serif"))

// Pre-title (page 1)
#align(center + horizon)[
  #v(40%)
  #text(size: 18pt, weight: "bold")[$title$]
  $if(subtitle)$
  #v(0.4em)
  #text(size: 14pt)[#em[$subtitle$]]
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
  #text(size: 1.6em)[#em[$subtitle$]]
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
  #text(size: 10pt)[Copyright © #datetime.today().year() $author$.]
  #v(0.3em)
  #text(size: 10pt)[All rights reserved.]
]

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
  width: 5.5in,
  height: 8.5in,
  margin: (inside: 1in, outside: 0.5in, top: 0.75in, bottom: 0.75in),
  header: context {
    import "@preview/hydra:0.6.2": hydra

    // Check if this page starts with a level-1 heading (chapter)
    let is-chapter-start = query(heading.where(level: 1))
      .any(h => h.location().page() == here().page())

    if is-chapter-start {
      none  // ← suppress header + rule on chapter opener pages
    } else {
      // Normal pages: Chapter (left) | Author (right)
      let header-font = ("Gillius ADF", "Noto Serif")
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
  font: ("Libertinus Serif", "Noto Serif", "Noto Sans", "DejaVu Sans"),
  fallback: true,
  lang: "en",
  11pt,
)

// Basic Chapter headings (level 1)
// #show heading.where(level: 1): it => {
//   pagebreak(to: "odd")
//   v(1em)
//   align(left)[
//     #text(
//       font: ("Gillius ADF", "Noto Sans"),
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
  //    font: ("Gillius ADF", "Noto Sans"),
  //    size: 11pt,
  //    weight: "bold",
  //    tracking: 2pt,          // spreads the letters nicely
  //  )[
  //    CHAPTER #counter(heading.where(level: 1)).display()
  //  ]
    
  //  #v(0.8em)
    
  //  #text(
  //    font: ("Gillius ADF", "Noto Sans"),
  //    size: 24pt,
  //    weight: "bold",
  //  )[
  //    #it.body
  //  ]
 // ]

  // Design with line
  // align(center)[
  // #text(font: ("Gillius ADF", "Noto Sans"), size: 10pt, weight: "bold")[
  //   CHAPTER #counter(heading.where(level: 1)).display()
//   ]
  
//   #v(0.4em)
//   #line(length: 40%, stroke: 1.5pt)   // or use a symbol: ★ ★ ★
//   #v(0.6em)
  
//   #text(font: ("Gillius ADF", "Noto Sans"), size: 26pt, weight: "bold")[
//     #it.body
//   ]
// ]

  // Left Aligned
align(left)[
  #text(
    font: ("Gillius ADF", "Noto Sans"),
    size: 13pt,
    weight: "bold",
    fill: rgb("#444")
  )[CHAPTER #counter(heading.where(level: 1)).display()]
  
  #v(0.3em)
  
  #text(
    font: ("Gillius ADF", "Noto Sans"),
    size: 22pt,
    weight: "bold"
  )[#it.body]
]
  v(1.5em)   // space after chapter title
}

// === Lower-level headings (2+) - use Gillius ADF (sans) ===
#show heading.where(level: 2): set text(
  font: ("Gillius ADF", "Noto Sans"),
  size: 14pt,      // adjust size as needed
  weight: "bold",
)

#show heading.where(level: 3): set text(
  font: ("Gillius ADF", "Noto Sans"),
  size: 12pt,
  weight: "bold",
)

#show heading.where(level: 4): set text(
  font: ("Gillius ADF", "Noto Sans"),
  size: 11pt,
  weight: "bold",
)
// Add more levels if you use them (level: 5, etc.)
// Remove numbering from headings level 2 and below
#show heading.where(level: 2): set heading(numbering: none)
#show heading.where(level: 3): set heading(numbering: none)
#show heading.where(level: 4): set heading(numbering: none)

// Fully-justified body text with automatic hyphenation
#set par(justify: true)

// Main-matter 
#main-matter[
  #set page(numbering: "1")
  #counter(page).update(1)
  $body$
]

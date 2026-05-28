// Book template for Typst
// Intended for use with Pandoc to convert Markdown to PDF

// Custom 5.5x8.5" book size (standard trade paperback)
// Wider left margin accounts for gutter binding
#set page(
  width: 5.5in,
  height: 8.5in,
  margin: (
    inside: 1in, 
    outside: 0.5in,
    top: 0.75in,
    bottom: 0.75in,
  ),
  footer: context {
      let num = counter(page).display()
      if calc.even(here().page()) {
        align(left, num)
      } else {
        align(right, num)
      }
    }
)

// Font setup with English language for proper hyphenation
#set text(
  font: ("Libertinus Serif", "Noto Serif", "Noto Sans", "DejaVu Sans"),
  fallback: true,
  lang: "en",
  11pt,
)

// Fully-justified body text with automatic hyphenation
#set par(justify: true)

// Force chapter (level-1) headings to start on recto (odd-numbered) pages
#show heading.where(level: 1): it => {
  pagebreak(to: "odd")
  it
}

// Page numbers: simple number, left on even pages, right on odd pages
// #show page: self => page(
//   footer: self.footer + context {
//     let n = locate().page.number
//     // Check parity without modulo operator
//     let even = n - n / 2 * 2
//     align(if even == 0 { left } else { right })[
//       text(8pt)[#n]
//     ]
//   },
//   self.body,
// )

#set page(footer: none)
$title$

$subtitle$

$author$

#pagebreak()
#set page(footer: context {
    let num = counter(page).display()
    if calc.even(here().page()) {
      align(left, num)
    } else {
      align(right, num)
    }
  })

$body$

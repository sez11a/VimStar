#let horizontalrule = align(center)[
  #v(0.8em)
  #text(size: 12pt)[\#]
  #v(0.8em)
]

#set page(
  paper: "us-letter",
  margin: 1in,
  numbering: "1",
  header: context {
    if counter(page).get().first() > 1 {
      set text(size: 12pt, font: "Libertinus Serif")
      align(right)[
        $if(surname)$$surname$$endif$ / $if(shorttitle)$$shorttitle$$endif$ / #counter(page).display()
      ]
    }
  },
  footer: none,
)

#set text(
    font: (
      "Times New Roman",      // Windows / macOS
      "Liberation Serif",     // common free metric-compatible substitute
      "Libertinus Serif",     // always available (Typst embeds it)
      "Nimbus Roman",         // another common free Times clone
      "serif",                 // last-resort generic
  ),
  size: 12pt,
  fill: black,
)

#set par(
  leading: 1.15em,
  spacing: 1.15em,
  first-line-indent: 0.5in,
  justify: false,
)

#grid(
  columns: (1fr, auto),
  align: (top + left, top + right),
  [
    #set par(first-line-indent: 0pt, spacing: 0.55em)
    $if(name)$$name$ \
    $endif$
    $if(address)$$address$ \
    $endif$
    $if(city)$$city$ \
    $endif$
    $if(phone)$$phone$ \
    $endif$
    $if(email)$$email$$endif$
    $if(affiliation)$ $affiliation$$endif$
  ],
  [
    $if(wordcount)$$wordcount$$endif$
  ]
)

#v(1.8in)

#align(center)[
  $if(title)$$title$$endif$
]

#v(1.2em)

#align(center)[
  by $if(author)$$author$$endif$
]

#v(1.5em)

$body$

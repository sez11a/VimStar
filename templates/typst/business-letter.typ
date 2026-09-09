// Business letter template for Typst
// Intended for use with Pandoc to convert Markdown to PDF

// Page setup: US-letter with 1in margins
#set page("us-letter", margin: 1in)

// Font setup with English language for proper hyphenation
#set text(
  font: (
    "Libertinus Serif",
    "Times New Roman",
    "Georgia",
    "Noto Serif",
    "DejaVu Serif",
    "Liberation Serif",
  ),
  fallback: true,
  lang: "en",
  12pt,
)

// Style hyperlinks as blue, underlined text
#show link: it => text(fill: rgb("#0000EE"))[#underline(stroke: 0.5pt)[#it]]

// Sender block, right-aligned: date, then name and address.
// Fields stay inside ONE paragraph so the `\` breaks render at
// within-paragraph leading (tight), like lines in LibreOffice's
// Default Paragraph Style.
#align(right)[
  $if(date)$$date$ \ $endif$$if(date)$#v(1em)$endif$
  $if(from-name)$$from-name$ \ $endif$
  $if(from-address-1)$$from-address-1$ \ $endif$
  $if(from-address-2)$$from-address-2$$endif$
]

#v(1em)

// Recipient block, left-aligned: name, company, then address
#align(left)[
  $if(to-name)$$to-name$ \ $endif$
  $if(to-company-name)$$to-company-name$ \ $endif$
  $if(to-address-1)$$to-address-1$ \ $endif$
  $if(to-address-2)$$to-address-2$$endif$
]

#v(1em)

$if(salutation)$$salutation$,$endif$

$body$

$if(complimentary-close)$
#v(1em)
#align(left)[
  $complimentary-close$,
  \
  \
  \
  \
  $if(from-name)$$from-name$$endif$
]
$endif$
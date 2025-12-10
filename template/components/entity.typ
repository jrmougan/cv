#let entity = item => [
  #text(weight: "bold")[#item.company] — #text(style: "italic")[#item.position]
  #h(1fr)
  #text(size: 9pt, fill: gray)[#item.date]
  #v(1pt)
  #item.description
  #v(6pt)
]

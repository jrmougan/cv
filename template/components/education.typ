#let education_item = item => [
  #text(weight: "bold")[#item.institution] — #text(style: "italic")[#item.degree]
  #h(1fr)
  #text(size: 9pt, fill: gray)[#item.date]
  #if "description" in item and item.description != "" [
    #v(1pt)
    #item.description
  ]
  #v(6pt)
]

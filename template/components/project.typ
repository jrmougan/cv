#let project_item = item => [
  #text(weight: "bold")[#item.name]
  #if "url" in item and item.url != "" [
    — #link(item.url)[#text(style: "italic", fill: blue)[#item.url]]
  ]
  #v(1pt)
  #item.description
  #v(6pt)
]

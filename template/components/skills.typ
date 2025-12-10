#let skills_item = item => [
  #grid(
    columns: (20%, 1fr),
    gutter: 10pt,
    align(right, text(weight: "bold")[#item.category]), [#item.items.join(", ")],
  )
  #v(3pt)
]

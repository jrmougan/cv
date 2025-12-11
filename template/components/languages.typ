#let language_item = (item, metadata) => [
  #grid(
    columns: (30%, 1fr),
    gutter: 10pt,
    align(right, text(weight: "bold", size: eval(metadata.styles.sizes.normal))[#item.language]),
    text(size: eval(metadata.styles.sizes.normal))[#item.level],
  )
  #v(3pt)
]

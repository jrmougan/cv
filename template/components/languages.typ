#let language_item = (item, metadata) => [
  #block(below: 6pt)[
    #text(weight: "bold", size: eval(metadata.styles.sizes.normal))[#item.language]
    #h(4pt)
    #text(size: eval(metadata.styles.sizes.normal), fill: rgb(metadata.styles.colors.secondary))[#item.level]
  ]
]

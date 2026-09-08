#let language_item = (item, metadata) => box[
  #text(weight: "bold", size: eval(metadata.styles.sizes.item_h3))[#item.language]
  #h(3pt)
  #text(size: eval(metadata.styles.sizes.item_h3), fill: rgb(metadata.styles.colors.secondary))[#item.level]
]

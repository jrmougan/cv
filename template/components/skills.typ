#let skills_item = (item, metadata) => [
  #grid(
    columns: 1fr,
    gutter: 5pt,
    align(left, text(weight: "bold", size: eval(metadata.styles.sizes.normal))[#item.category]),
    [
      #(
        item
          .items
          .enumerate()
          .map(((i, text_item)) => {
            if calc.even(i) {
              text(weight: "bold", fill: rgb(metadata.styles.colors.accent), size: eval(
                metadata.styles.sizes.normal,
              ))[#text_item]
            } else {
              text(fill: rgb(metadata.styles.colors.secondary), size: eval(metadata.styles.sizes.normal))[#text_item]
            }
          })
          .join(", ")
      )
    ],
  )
  #v(3pt)
]

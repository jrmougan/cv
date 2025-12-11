#let skills_item = (item, metadata) => [
  #grid(
    columns: (20%, 1fr),
    gutter: 10pt,
    align(right, text(weight: "bold")[#item.category]),
    [
      #(
        item
          .items
          .enumerate()
          .map(((i, text_item)) => {
            if calc.even(i) {
              text(weight: "bold", fill: rgb(metadata.styles.colors.accent))[#text_item]
            } else {
              text(fill: rgb(metadata.styles.colors.secondary))[#text_item]
            }
          })
          .join(", ")
      )
    ],
  )
  #v(3pt)
]

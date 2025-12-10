#let education_item = (item, metadata) => [
  #block(breakable: false)[
    #grid(
      columns: (32pt, auto),
      gutter: 10pt,
      if "logo" in item and item.logo != "" {
        image("../../" + item.logo, width: 32pt)
      } else {
        none
      },
      [
        #text(weight: "bold")[#item.institution] — #text(style: "italic", fill: rgb(metadata.styles.colors.secondary))[#item.degree]
        #h(1fr)
        #text(size: eval(metadata.styles.sizes.normal), fill: rgb(metadata.styles.colors.secondary))[#item.date]
        #if "description" in item and item.description != "" [
          #v(1pt)
          #item.description
        ]
      ],
    )
  ]
  #v(6pt)
]

#let education_item = (item, metadata) => [
  #block(breakable: false)[
    #grid(
      columns: (32pt, 1fr),
      gutter: 12pt,
      if "logo" in item and item.logo != "" {
        box(
          radius: 4pt,
          clip: true,
          image("../../" + item.logo, width: 100%),
        )
      } else {
        none
      },
      [
        #pad(bottom: 0pt, [
          #text(weight: "bold", size: eval(metadata.styles.sizes.item_h1))[#item.institution]
          #h(1fr)
          #text(size: eval(metadata.styles.sizes.item_h3), fill: rgb(metadata.styles.colors.secondary))[#item.date]
        ])
        #text(style: "italic", fill: rgb(metadata.styles.colors.secondary), size: eval(
          metadata.styles.sizes.item_h2,
        ))[#item.degree]
        #if "description" in item and item.description != "" [
          #v(2pt)
          #text(size: eval(metadata.styles.sizes.normal))[#item.description]
        ]
      ],
    )
  ]
  #v(4pt)
]

#let entity = (item, metadata) => [
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
        #text(weight: "bold")[#item.company] — #text(style: "italic", fill: rgb(metadata.styles.colors.secondary))[#item.position]
        #h(1fr)
        #text(size: 9pt, fill: rgb(metadata.styles.colors.secondary))[#item.date]
        #v(1pt)
        #item.description
      ],
    )
  ]
  #v(6pt)
]

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
        #text(weight: "bold", size: eval(metadata.styles.sizes.item_h1))[#item.company] — #text(style: "italic", fill: rgb(metadata.styles.colors.secondary), size: eval(metadata.styles.sizes.item_h2))[#item.position]
        #h(1fr)
        #text(size: eval(metadata.styles.sizes.item_h3), fill: rgb(metadata.styles.colors.secondary))[#item.date]
        #v(1pt)
        #item.description
        #if "tasks" in item and item.tasks != none {
          v(5pt)
          for task in item.tasks [
            - #task
          ]
        }
      ],
    )
  ]
  #v(6pt)
]

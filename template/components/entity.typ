#let entity = (item, metadata) => [
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
          #text(weight: "bold", size: eval(metadata.styles.sizes.item_h1))[#item.company]
          #h(1fr)
          #text(size: eval(metadata.styles.sizes.item_h3), fill: rgb(metadata.styles.colors.secondary))[#item.date]
        ])
        #text(style: "italic", fill: rgb(metadata.styles.colors.secondary), size: eval(
          metadata.styles.sizes.item_h2,
        ))[#item.position]
        #text(size: eval(metadata.styles.sizes.normal))[#item.description]
        #if "tasks" in item and item.tasks != none {
          v(2pt)
          for task in item.tasks [
            #block(width: 100%, below: 2pt)[
              #box(width: 6pt)[•] #text(size: eval(metadata.styles.sizes.normal))[#task]
            ]
          ]
        }
      ],
    )
  ]
  #v(4pt)
]

#let entity = (item, metadata) => [
  #block(breakable: true, width: 100%)[
    #grid(
      columns: (auto, 1fr, auto),
      gutter: 10pt,
      // Column 1: Logo
      if "logo" in item and item.logo != "" {
        box(radius: 2pt, clip: true, image("../../" + item.logo, height: 22pt))
      } else {
        none
      },
      // Column 2: Company + Position
      align(left)[
        #text(weight: "bold", size: eval(metadata.styles.sizes.item_h1))[#item.company]
        #v(-5pt)
        #text(weight: "light", style: "italic", fill: rgb(metadata.styles.colors.secondary), size: eval(
          metadata.styles.sizes.item_h2,
        ))[#text(item.position)]
      ],
      // Column 3: Location + Date
      align(right)[
        #if "location" in item and item.location != "" {
          text(weight: "medium", size: eval(metadata.styles.sizes.item_h3), fill: rgb(
            metadata.styles.colors.accent,
          ))[#item.location]
          [\ ]
        }
        #text(style: "italic", size: eval(metadata.styles.sizes.item_h3), fill: rgb(
          metadata.styles.colors.secondary,
        ))[#item.date]
      ],
    )
    #v(0pt) // Space between header grid and content
    #block(width: 100%, below: 5pt)[
      #text(size: eval(metadata.styles.sizes.normal))[#item.description]
    ]
    #if "tasks" in item and item.tasks != none {
      block(width: 100%)[
        #for task in item.tasks [
          #box(width: 6pt)[•] #text(size: eval(metadata.styles.sizes.normal))[#task] \
        ]
      ]
    }
  ]
  #v(1pt) // Space between entity items
]

#let education_item = (item, metadata) => [
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
      // Column 2: Institution + Degree
      align(left)[
        #text(weight: "bold", size: eval(metadata.styles.sizes.item_h1))[#item.institution]
        #v(-5pt)
        #text(weight: "light", style: "italic", fill: rgb(metadata.styles.colors.secondary), size: eval(
          metadata.styles.sizes.item_h2,
        ))[#item.degree]
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

    // Content
    #if "description" in item and item.description != "" [
      #v(5pt)
      #block(width: 100%)[
        #text(size: eval(metadata.styles.sizes.normal))[#item.description]
      ]
    ]
  ]
  #v(5pt)
]

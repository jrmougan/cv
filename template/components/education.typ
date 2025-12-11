#let education_item = (item, metadata) => [
  #block(breakable: true)[
    #grid(
      columns: (24%, 1fr),
      gutter: 0pt,
      // Column 1: Date and Location
      align(right, pad(right: 12pt, [
        #let dates = item.date.split(" - ")
        #text(weight: "medium", size: eval(metadata.styles.sizes.item_h3), fill: rgb(
          metadata.styles.colors.secondary,
        ))[
          #dates.join([\ ])
        ]
        #if "location" in item and item.location != "" [
          \
          #v(2pt)
          #text(style: "italic", size: eval(metadata.styles.sizes.item_h3), fill: rgb(
            metadata.styles.colors.secondary,
          ))[#item.location]
        ]
      ])),
      // Column 2: Content
      block(
        stroke: (left: 0.5pt + rgb(metadata.styles.colors.secondary)),
        inset: (left: 12pt),
        width: 100%,
        [
          #grid(
            columns: (auto, 1fr),
            gutter: 8pt,
            if "logo" in item and item.logo != "" {
              box(
                radius: 2pt,
                clip: true,
                image("../../" + item.logo, width: 24pt),
              )
            } else { none },
            [
              #text(weight: "bold", size: eval(metadata.styles.sizes.item_h1))[#item.institution]
              \
              #text(style: "italic", weight: "medium", fill: rgb(metadata.styles.colors.secondary), size: eval(
                metadata.styles.sizes.item_h2,
              ))[#item.degree]
            ],
          )

          #v(-6pt)
          #block(width: 100%)[
            #if "description" in item and item.description != "" [
              #text(size: eval(metadata.styles.sizes.normal))[#item.description]
            ]
          ]
        ],
      ),
    )
  ]
  #v(6pt)
]

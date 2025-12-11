#let entity = (item, metadata) => [
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
                image("../../" + item.logo, width: 24pt), // Increased logo size slightly
              )
            } else { none },
            [
              #text(weight: "bold", size: eval(metadata.styles.sizes.item_h1))[#item.company]
              \
              #text(style: "italic", weight: "medium", fill: rgb(metadata.styles.colors.secondary), size: eval(
                metadata.styles.sizes.item_h2,
              ))[#item.position]
            ],
          )

          #v(-6pt)
          #block(width: 100%)[
            #text(size: eval(metadata.styles.sizes.normal))[#item.description]
            #if "tasks" in item and item.tasks != none {
              v(-6pt)
              for task in item.tasks [
                #block(width: 100%, below: 3pt)[
                  #box(width: 6pt)[•] #text(size: eval(metadata.styles.sizes.normal))[#task]
                ]
              ]
            }
          ]
        ],
      ),
    )
  ]
  #v(6pt) // Reduced spacing to fit content
]

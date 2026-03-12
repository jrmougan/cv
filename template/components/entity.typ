#import "skills.typ": skill_tags

#let entity = (item, metadata) => [
  #let is_quiet = "quiet" in item and item.quiet
  #let primary_color = if is_quiet { rgb("#aaaaaa") } else { rgb(metadata.styles.colors.primary) }
  #let secondary_color = if is_quiet { rgb("#bbbbbb") } else { rgb(metadata.styles.colors.secondary) }
  #let accent_color = if is_quiet { rgb("#aaaaaa") } else { rgb(metadata.styles.colors.accent) }
  #let text_color = if is_quiet { rgb("#bbbbbb") } else { rgb(metadata.styles.colors.text) }

  #block(breakable: true, width: 100%)[
    #grid(
      columns: (auto, 1fr, auto),
      gutter: 10pt,
      // Column 1: Logo
      if "logo" in item and item.logo != "" {
        box(radius: 2pt, clip: true, image("../../" + item.logo, height: 22pt))
      } else {
        h(22pt)
        none
      },
      // Column 2: Company + Position
      align(left)[
        #text(weight: "bold", size: eval(metadata.styles.sizes.item_h1), fill: primary_color)[#item.company]
        #v(-5pt)
        #text(weight: "light", style: "italic", fill: secondary_color, size: eval(
          metadata.styles.sizes.item_h2,
        ))[#text(item.position)]
      ],
      // Column 3: Location + Date
      align(right)[
        #if "location" in item and item.location != "" {
          text(weight: "medium", size: eval(metadata.styles.sizes.item_h3), fill: accent_color)[#item.location]
          [\ ]
        }
        #text(style: "italic", size: eval(metadata.styles.sizes.item_h3), fill: secondary_color)[#item.date]
      ],
    )
    #v(0pt) // Space between header grid and content
    #block(width: 100%, below: 5pt)[
      #text(size: eval(metadata.styles.sizes.normal), fill: text_color)[#item.description]
    ]
    #if "tasks" in item and item.tasks != none {
      block(width: 100%)[
        #for task in item.tasks [
          #box(width: 6pt)[#text(fill: secondary_color)[•]] #text(
            size: eval(metadata.styles.sizes.normal),
            fill: text_color,
          )[#task] \
        ]
      ]
    }
    #if "tags" in item and item.tags.len() > 0 {
      skill_tags(item.tags, metadata)
    }
  ]
  #v(1pt) // Space between entity items
]

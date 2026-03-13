#import "skills.typ": skill_tags

#let education_item = (item, metadata) => [
  #block(breakable: false, width: 100%, below: 6pt)[
    #grid(
      columns: (auto, 1fr, auto),
      column-gutter: 6pt,
      row-gutter: 0pt,
      align: (left + horizon, left + top, right + top),
      // Column 1: Logo
      if "logo" in item and item.logo != "" {
        box(radius: 2pt, clip: true, image("../../" + item.logo, height: 16pt))
      } else {
        none
      },
      // Column 2: Institution + Degree
      stack(dir: ttb, spacing: 1pt,
        text(weight: "bold", size: eval(metadata.styles.sizes.item_h1))[#item.institution],
        text(weight: "regular", style: "italic", fill: rgb(metadata.styles.colors.secondary), size: eval(metadata.styles.sizes.item_h2))[#item.degree],
      ),
      // Column 3: Location + Date
      stack(dir: ttb, spacing: 1pt,
        if "location" in item and item.location != "" {
          text(weight: "medium", size: eval(metadata.styles.sizes.item_h3), fill: rgb(metadata.styles.colors.secondary))[#item.location]
        },
        text(style: "italic", size: eval(metadata.styles.sizes.item_h3), fill: rgb(metadata.styles.colors.secondary))[#item.date],
      ),
    )

    // Content
    #if "description" in item and item.description != "" [
      #block(width: 100%, above: 2pt)[
        #text(size: eval(metadata.styles.sizes.normal))[#item.description]
      ]
    ]
    // Skill tags
    #if "tags" in item and item.tags.len() > 0 {
      skill_tags(item.tags, metadata)
    }
  ]
]

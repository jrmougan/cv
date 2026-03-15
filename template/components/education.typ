#import "skills.typ": skill_tags

#let education_item = (item, metadata) => [
  #block(breakable: false, width: 100%, below: 18pt)[
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
      stack(dir: ttb, spacing: 4pt,
        text(weight: "bold", size: eval(metadata.styles.sizes.item_h1), fill: rgb(metadata.styles.colors.primary))[#item.institution],
        text(weight: "regular", style: "italic", fill: rgb(metadata.styles.colors.secondary), size: eval(metadata.styles.sizes.item_h2))[#item.degree],
      ),
      // Column 3: Location + Date
      stack(dir: ttb, spacing: 4pt,
        if "location" in item and item.location != "" {
          box[
            #text(weight: "bold", fill: rgb(metadata.styles.colors.secondary))[\@]
            #h(1pt)
            #text(weight: "medium", size: eval(metadata.styles.sizes.item_h3), fill: rgb(metadata.styles.colors.primary))[#item.location]
          ]
        },
        text(style: "italic", size: eval(metadata.styles.sizes.item_h3), fill: rgb(metadata.styles.colors.secondary))[#item.date],
      ),
    )

    // Content
    #if "description" in item and item.description != "" [
      #block(width: 100%, above: 6pt)[
        #text(size: eval(metadata.styles.sizes.normal))[#item.description]
      ]
    ]
    // Skill tags
    #if "tags" in item and item.tags.len() > 0 {
      skill_tags(item.tags, metadata)
    }
  ]
]

#import "skills.typ": skill_tags

#let project_item = (item, metadata) => [
  #block(breakable: false, below: 18pt)[
    #grid(
      columns: (1fr, auto),
      column-gutter: 6pt,
      align(left + horizon, text(weight: "bold", fill: rgb(metadata.styles.colors.primary), size: eval(metadata.styles.sizes.item_h1))[#item.name]),
      if "url" in item and item.url != "" {
        align(right + horizon, link(item.url)[
          #text(style: "italic", fill: rgb(metadata.styles.colors.accent), size: eval(
            metadata.styles.sizes.item_h3,
          ))[#item.url]
        ])
      } else { none },
    )
    #block(above: 6pt)[
      #text(size: eval(metadata.styles.sizes.normal))[#item.description]
    ]
    #if "tags" in item and item.tags.len() > 0 {
      skill_tags(item.tags, metadata)
    }
  ]
]

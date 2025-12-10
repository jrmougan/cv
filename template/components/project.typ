#let project_item = (item, metadata) => [
  #block(breakable: false)[
    #grid(
      columns: (1fr, auto),
      gutter: 10pt,
      align(left + horizon, text(weight: "bold", size: eval(metadata.styles.sizes.item_h1))[#item.name]),
      if "url" in item and item.url != "" {
        align(right + horizon, link(item.url)[
          #text(style: "italic", fill: rgb(metadata.styles.colors.accent), size: eval(
            metadata.styles.sizes.normal,
          ))[#item.url]
        ])
      } else { none },
    )
    #v(2pt)
    #text(size: eval(metadata.styles.sizes.normal))[#item.description]
  ]
  #v(8pt)
]

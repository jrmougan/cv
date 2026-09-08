#let education_item = (item, metadata) => [
  #block(breakable: false, width: 100%, below: 9pt)[
    #grid(
      columns: (1fr, auto), column-gutter: 10pt,
      align: (left + top, right + top),
      stack(dir: ttb, spacing: 3pt,
        text(weight: "medium", size: eval(metadata.styles.sizes.item_h2))[#item.degree],
        text(fill: rgb(metadata.styles.colors.secondary), size: eval(metadata.styles.sizes.item_h3))[#item.institution],
      ),
      text(size: eval(metadata.styles.sizes.item_h3), fill: rgb(metadata.styles.colors.secondary))[#item.date.replace(" - ", " – ")],
    )
    #if item.at("description", default: "") != "" {
      block(above: 4pt)[#item.description]
    }
  ]
]

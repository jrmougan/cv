#let entity = (item, metadata) => [
  #let secondary = rgb(metadata.styles.colors.secondary)
  #block(breakable: true, width: 100%, below: 16pt)[
    #block(breakable: false, sticky: true)[
      #grid(
        columns: (1fr, auto), column-gutter: 12pt,
        align: (left + top, right + top),
        stack(dir: ttb, spacing: 4pt,
          text(weight: "semibold", size: eval(metadata.styles.sizes.item_h1))[#item.position],
          text(size: eval(metadata.styles.sizes.item_h2), fill: secondary)[#item.company],
        ),
        stack(dir: ttb, spacing: 4pt,
          text(size: eval(metadata.styles.sizes.item_h3), fill: secondary)[#item.date.replace(" - ", " – ")],
          if item.at("location", default: "") != "" {
            text(size: eval(metadata.styles.sizes.item_h3), fill: secondary)[#item.location]
          },
        ),
      )
    ]
    #if item.at("description", default: "") != "" {
      block(width: 100%, above: 6pt, below: 5pt, breakable: false, sticky: true)[#item.description]
    }
    #if item.at("tasks", default: ()) != none and item.at("tasks", default: ()).len() > 0 {
      set list(tight: false, marker: text(fill: secondary)[•], indent: 0pt, body-indent: 10pt, spacing: 7pt)
      list(..item.tasks)
    }
  ]
]

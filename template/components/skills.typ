#let skills_item = (item, metadata) => [
  #block(breakable: false, width: 100%)[
    #block(breakable: false, below: 15pt)[
      #let legend_color = rgb(metadata.styles.colors.text)

      #let pill(text_content, dots) = text(
        fill: legend_color,
        size: 5pt,
        weight: "medium",
      )[#text_content #h(1pt) #text(size: 6pt)[#dots]]

      #pill(metadata.labels.expert, "●●●")
      #h(6pt)
      #pill(metadata.labels.proficient, "●●○")
      #h(6pt)
      #pill(metadata.labels.basic, "●○○")
    ]

    #let categories = ("frontend", "backend", "data", "tools", "others")

    #for cat in categories [
      #let cat_items = item.items.filter(s => "cat" in s and s.cat == cat).sorted(key: s => s.val).rev()

      #if cat_items.len() > 0 [
        #block(below: 10pt)[
          #text(weight: "bold", size: eval(metadata.styles.sizes.item_h3), fill: rgb(
            metadata.styles.colors.text,
          ))[#upper(cat.at(0))#cat.slice(1)]
          #v(3pt)
          #block[
            #grid(
              columns: (1fr, 1fr, 1fr, 1fr),
              gutter: 5pt,
              ..cat_items.map(s => {
                let color = rgb(metadata.styles.colors.categories.at(cat))
                let val = s.val

                let dots = if val >= 9 {
                  "●●●"
                } else if val >= 6 {
                  "●●○"
                } else {
                  "●○○"
                }

                text(fill: color, size: 8pt, weight: "medium")[#s.name #h(1pt) #text(size: 6pt)[#dots]]
              })
            )
          ]
        ]
      ]
    ]
  ]
]

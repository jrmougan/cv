#let skills_item = (item, metadata) => [
  #block(breakable: false, width: 100%)[
    #block(breakable: false, below: 15pt)[
      #let legend_color = rgb(metadata.styles.colors.text)

      #box(inset: (x: 4pt, y: 3pt), radius: 4pt, fill: legend_color, baseline: 20%, text(
        fill: white,
        size: 6pt,
        weight: "bold",
      )[#metadata.labels.expert])
      #h(3pt)
      #box(
        inset: (x: 3pt, y: 2pt),
        radius: 4pt,
        fill: legend_color.lighten(85%),
        stroke: 0.5pt + legend_color,
        baseline: 20%,
        text(fill: legend_color, size: 6pt, weight: "medium")[#metadata.labels.proficient],
      )
      #h(3pt)
      #box(inset: (x: 3pt, y: 2pt), radius: 4pt, stroke: 0.5pt + legend_color, baseline: 20%, text(
        fill: legend_color,
        size: 6pt,
        weight: "regular",
      )[#metadata.labels.basic])
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
            #(
              cat_items
                .map(s => {
                  let color = rgb(metadata.styles.colors.categories.at(cat))
                  let val = s.val

                  if val >= 9 {
                    // Advanced: Solid Fill
                    box(
                      inset: (x: 4pt, y: 3pt),
                      radius: 4pt,
                      fill: color,
                      baseline: 20%,
                      text(fill: white, size: 7pt, weight: "bold")[#s.name],
                    )
                  } else if val >= 6 {
                    // Intermediate: Faint Fill
                    box(
                      inset: (x: 3pt, y: 2pt),
                      radius: 4pt,
                      fill: color.lighten(85%),
                      stroke: 0.5pt + color,
                      baseline: 20%,
                      text(fill: color, size: 7pt, weight: "medium")[#s.name],
                    )
                  } else {
                    // Basic: Outline Only
                    box(
                      inset: (x: 3pt, y: 2pt),
                      radius: 4pt,
                      stroke: 0.5pt + color,
                      baseline: 20%,
                      text(fill: color, size: 7pt, weight: "regular")[#s.name],
                    )
                  }
                })
                .join(h(4pt))
            )
          ]
        ]
      ]
    ]
  ]
]

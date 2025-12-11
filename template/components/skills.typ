#let skills_item = (item, metadata) => [
  #block(breakable: false, width: 100%)[
    #align(center)[
      #(
        item
          .items
          .sorted(key: s => s.val)
          .rev()
          .map(skill => {
            let val = skill.val
            let size_factor = calc.max(0.75, val * 0.16)
            let base_size = eval(metadata.styles.sizes.normal)
            let font_size = base_size * size_factor

            let color = if "cat" in skill {
              rgb(metadata.styles.colors.categories.at(skill.cat))
            } else {
              rgb(metadata.styles.colors.secondary)
            }

            box(inset: 3pt)[
              #text(size: font_size, fill: color, weight: "bold")[#skill.name]
            ]
          })
          .join()
      )
    ]
    #v(6pt)
    #align(center)[
      #(
        metadata
          .styles
          .colors
          .categories
          .pairs()
          .map(pair => {
            let (cat, color_hex) = pair
            box[
              #box(height: 8pt, width: 8pt, radius: 4pt, fill: rgb(color_hex))
              #h(4pt)
              #text(size: eval(metadata.styles.sizes.item_h3), weight: "bold", fill: rgb(
                metadata.styles.colors.text,
              ))[#upper(cat.at(0))#cat.slice(1)]
            ]
            h(12pt)
          })
          .join()
      )
    ]
  ]
  #v(6pt)
]

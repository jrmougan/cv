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

            let color = if val >= 9 {
              rgb(metadata.styles.colors.accent)
            } else if val >= 7 {
              rgb(metadata.styles.colors.primary)
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
  ]
  #v(6pt)
]

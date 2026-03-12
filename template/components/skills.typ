#let skills_item = (item, metadata) => {
  let cats = metadata.styles.colors.categories

  // Build chip content inline
  let chips = item.items.map(skill => {
    let cat = if "cat" in skill { skill.cat } else { "tools" }
    let color = rgb(cats.at(cat, default: cats.at("tools")))
    let bg = color.lighten(85%)

    box(
      inset: (x: 5pt, y: 3.5pt),
      radius: 3pt,
      fill: bg,
    )[#text(fill: color, size: 7.5pt, weight: "semibold")[#skill.name]]
  })

  // Legend builder
  let legend(color_key, label) = {
    let color = rgb(cats.at(color_key))
    box[#text(fill: color, size: 6pt, weight: "bold")[■]
      #h(2pt)
      #text(fill: rgb(metadata.styles.colors.secondary), size: 5.5pt, weight: "medium")[#label]]
  }

  // Render
  block(width: 100%, below: 6pt)[
    #set par(leading: 6pt)
    #chips.join(h(4pt))
  ]

  block[
    #legend("frontend", "Frontend")
    #h(8pt)
    #legend("backend", "Backend & Data")
    #h(8pt)
    #legend("tools", "DevOps & QA")
  ]
}

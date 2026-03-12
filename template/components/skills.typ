// Reusable skill tags component
// Renders an inline flow of colored chips for technology tags
// Usage: skill_tags(item.tags, metadata)

#let skill_tags(tags, metadata) = {
  if tags.len() == 0 { return }

  let cats = metadata.styles.colors.categories

  // Build skill name -> category lookup from shared skills data
  let skill_lookup = (:)
  if "skills" in metadata {
    for skill_group in metadata.skills {
      for skill in skill_group.items {
        skill_lookup.insert(skill.name, skill.cat)
      }
    }
  }

  let chips = tags.map(tag => {
    let cat = skill_lookup.at(tag, default: "tools")
    let color = rgb(cats.at(cat, default: cats.at("tools")))
    let bg = color.lighten(85%)

    box(
      inset: (x: 5pt, y: 3pt),
      radius: 3pt,
      fill: bg,
    )[#text(fill: color, size: 7pt, weight: "semibold")[#tag]]
  })

  block(width: 100%, above: 8pt)[
    #set par(leading: 5pt)
    #chips.join(h(3pt))
  ]
}

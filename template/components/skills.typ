// Reusable skill tags component
// Renders an inline flow of colored chips for technology tags
// Usage: skill_tags(item.tags, metadata)

#let skill_tags(tags, metadata) = {
  if tags.len() == 0 { return }

  let cats = metadata.styles.colors.categories
  let tag-size = if "tag" in metadata.styles.sizes {
    eval(metadata.styles.sizes.tag)
  } else {
    6.5pt
  }

  let term-color = rgb(metadata.styles.colors.terminal_text)
  let dim-color = rgb(metadata.styles.colors.header_dim)

  let chips = tags.map(tag => [
    // Style as JSON bracket list:  [React]
    #text(fill: dim-color)[\[]#text(fill: term-color, size: tag-size, weight: "medium")[#tag]#text(fill: dim-color)[\]]
  ])

  block(width: 100%, above: 4pt)[
    #set par(leading: 3pt)
    #chips.join(h(2pt))
  ]
}

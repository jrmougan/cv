// Text remains selectable and individual technology names never split across lines.
#let skill_tags(tags, metadata) = {
  if tags.len() == 0 { return }
  block(width: 100%, above: 4pt)[
    #set text(font: metadata.styles.fonts.base, size: eval(metadata.styles.sizes.tag), fill: rgb(metadata.styles.colors.terminal_text))
    #set par(leading: 2pt)
    #tags.map(tag => box[#tag]).join([ · ])
  ]
}

// Render the CV selection; the complete inventory remains in the data.
#let skills_section(groups, metadata) = {
  let labels = (
    es: (frontend: "Frontend", backend: "Backend", tools: "Herramientas", gamedev: "Videojuegos"),
    en: (frontend: "Frontend", backend: "Backend", tools: "Tools", gamedev: "Game development"),
    gl: (frontend: "Frontend", backend: "Backend", tools: "Ferramentas", gamedev: "Videoxogos"),
  ).at(metadata.lang)
  let items = groups.map(group => group.items).flatten().filter(item => item.at("featured", default: true))
  let categories = items.map(item => item.at("cat", default: "")).dedup()
  for category in categories {
    block(width: 100%, breakable: false, below: 4pt)[
      #set text(size: eval(metadata.styles.sizes.item_h3))
      #if category != "" {
        text(weight: "bold")[#labels.at(category, default: category): ]
      }
      #items.filter(item => item.at("cat", default: "") == category).map(item => box[#item.name]).join([ · ])
    ]
  }
}

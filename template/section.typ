#let seccion = (titulo, metadata) => {
  show heading: it => block(width: 100%, above: 13pt, below: 8pt, sticky: true)[
    #set text(size: eval(metadata.styles.sizes.section_title), weight: "semibold",
      tracking: 0.9pt, fill: rgb(metadata.styles.colors.section_title), font: metadata.styles.fonts.section_title)
    #upper(it.body)
  ]
  heading(level: 1, numbering: none, titulo)
}

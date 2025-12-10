#let seccion = (titulo, metadata) => [
  #v(8pt)
  #block(below: 8pt)[
    #text(
      size: 12pt,
      weight: "bold",
      fill: rgb(metadata.styles.colors.primary),
    )[#titulo]
  ]
  #line(length: 100%, stroke: (thickness: 1pt, paint: rgb(metadata.styles.colors.primary), dash: "dashed"))
  #v(4pt)
]

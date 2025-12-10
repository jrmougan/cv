#let seccion = (titulo, metadata) => [
  #v(10pt)
  #text(
    size: 12pt,
    weight: "bold",
    fill: rgb(metadata.styles.colors.primary),
  )[#titulo]

  #line(length: 100%, stroke: (thickness: 1pt, paint: rgb(metadata.styles.colors.primary)))
  #v(6pt)
]

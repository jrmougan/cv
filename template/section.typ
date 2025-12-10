#let seccion = (titulo, metadata) => [
  #v(5pt)
  #block(below: 6pt)[
    #text(
      size: eval(metadata.styles.sizes.section_title),
      weight: "bold",
      fill: rgb(metadata.styles.colors.primary),
    )[#titulo]
  ]
  #line(length: 100%, stroke: (thickness: 0.9pt, dash: "dotted", paint: rgb(metadata.styles.colors.primary)))
  #v(3pt)
]

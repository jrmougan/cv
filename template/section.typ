#let seccion = (titulo, metadata) => [
  #v(2pt)
  #block(below: 3pt)[
    #text(
      size: eval(metadata.styles.sizes.section_title),
      weight: "bold",
      fill: rgb(metadata.styles.colors.primary),
    )[#titulo]
  ]
  #line(length: 100%, stroke: (thickness: 0.9pt, dash: "dotted", paint: rgb(metadata.styles.colors.primary)))
  #v(2pt)
]

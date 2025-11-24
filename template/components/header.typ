#let header = (nombre, titulo, contacto) => [
  align(center, [
  text(size: 22pt, weight: "bold")[#nombre]
  text(size: 12pt, fill: gray)[#titulo]

  #v(6pt)
  text(size: 9pt)[#contacto]
  ])

  #v(12pt)
]

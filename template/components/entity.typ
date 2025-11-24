#let entity = item => [
  #text(weight: "bold")[#item.empresa] — #item.cargo
  #text(size: 9pt, fill: gray)[#item.fecha]
  #v(3pt)
  #item.desc
  #v(6pt)
]

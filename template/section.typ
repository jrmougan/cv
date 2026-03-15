#let seccion = (titulo, metadata) => [
  #block(width: 100%, above: 16pt, below: 8pt)[
    #grid(
      columns: (auto, 1fr),
      align: (left, horizon),
      gutter: 8pt,
      box(
        inset: (x: 0pt, y: 3pt),
      )[
        #set align(horizon)
        #let clean-title = (
          lower(titulo).replace("ó", "o").replace("á", "a").replace("é", "e").replace("í", "i").replace("ú", "u")
        )

        #text(
          size: eval(metadata.styles.sizes.section_title),
          weight: "bold",
          fill: rgb(metadata.styles.colors.section_title),
          font: metadata.styles.fonts.terminal.at(0),
        )[ #upper(titulo) ]
      ],
      line(length: 100%, stroke: (thickness: 1pt, paint: rgb(metadata.styles.colors.section_title), dash: "dashed")),
    )
  ]
]

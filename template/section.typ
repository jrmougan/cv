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
        #let icon-path = "icons/" + lower(titulo) + ".svg"
        // Try to load icon, if not exists, just show text.
        // Typst panics on missing image, so we just use an if-else based on the known names
        #let icon-map = (
          "experiencia": "experience",
          "educacion": "education",
          "education": "education",
          "experience": "experience",
          "proyectos": "projects",
          "projects": "projects",
          "idiomas": "languages",
          "languages": "languages",
        )
        #let clean-title = (
          lower(titulo).replace("ó", "o").replace("á", "a").replace("é", "e").replace("í", "i").replace("ú", "u")
        )

        #if clean-title in icon-map [
          #let fname = icon-map.at(clean-title)
          #box(align(horizon, image("/icons/" + fname + ".svg", width: 10pt)))
          #h(4pt)
        ]
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

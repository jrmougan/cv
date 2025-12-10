#let personal_info(icon, text) = [
  *#icon*
  #h(1pt)
  #text
]


#let header(
  metadata,
  profilePhoto,
) = {
  grid(
    columns: (auto, auto),
    align: center,
    stroke: red,
    gutter: 3pt,
    grid.cell(colspan: 2, fill: red)[
      #text(
        size: 18pt,
        weight: "bold",
        font: metadata.styles.fonts.base,
      )[#metadata.personal_info.name]
      #text(font: metadata.styles.fonts.base)[#metadata.personal_info.position]
    ],

    grid.cell()[#box(radius: 100%, profilePhoto, clip: true, height: 100pt)],

    grid.cell()[
      #personal_info(text(metadata.labels.location + ":", font: metadata.styles.fonts.base), text(metadata.personal_info.contact.address)) |
      #personal_info(text(metadata.labels.phone + ":", font: metadata.styles.fonts.base), text(metadata.personal_info.contact.phone)) |
      #personal_info(text(metadata.labels.email + ":", font: metadata.styles.fonts.base), text(
        metadata.personal_info.contact.email,
      ))
    ],
  )
}


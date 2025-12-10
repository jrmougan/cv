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
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    gutter: 10pt,
    [
      #text(
        size: 24pt,
        weight: "bold",
        fill: rgb(metadata.styles.colors.primary),
        font: metadata.styles.fonts.base,
      )[#metadata.personal_info.name]

      #v(5pt)

      #text(
        size: 14pt,
        fill: rgb(metadata.styles.colors.secondary),
        font: metadata.styles.fonts.base,
      )[#metadata.personal_info.position]

      #v(10pt)

      #set text(fill: rgb(metadata.styles.colors.text), font: metadata.styles.fonts.base)
      #grid(
        columns: (auto, auto),
        gutter: 10pt,
        align: left,
        personal_info(text(metadata.labels.location + ":", weight: "bold"), text(
          metadata.personal_info.contact.address,
        )),
        personal_info(text(metadata.labels.phone + ":", weight: "bold"), text(metadata.personal_info.contact.phone)),

        personal_info(text(metadata.labels.email + ":", weight: "bold"), text(metadata.personal_info.contact.email)),
        // Add Link if present
        if "link" in metadata.personal_info.contact [
          #link("https://" + metadata.personal_info.contact.link)[#metadata.personal_info.contact.link]
        ],
      )
    ],
    box(radius: 50%, profilePhoto, clip: true, height: 100pt),
  )

  line(length: 100%, stroke: (thickness: 2pt, paint: rgb(metadata.styles.colors.primary)))
}
}

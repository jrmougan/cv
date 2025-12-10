#import "@preview/fontawesome:0.5.0": *

#let personal_info = (icon, content) => [
  #box(icon)
  #h(5pt)
  #content
]

#let header(
  metadata,
  profilePhoto,
) = [
  #grid(
    columns: (auto, 1fr),
    gutter: 15pt,
    align: (left + top, right + horizon),
    box(
      radius: 50%,
      clip: true,
      height: 75pt,
      profilePhoto,
    ),
    align(right)[
      #text(
        size: 32pt,
        weight: "black",
        fill: rgb(metadata.styles.colors.primary),
        font: metadata.styles.fonts.base,
      )[#metadata.personal_info.name]

      #text(
        size: 10pt,
        weight: "bold",
        fill: rgb(metadata.styles.colors.secondary),
        tracking: 1pt,
        font: metadata.styles.fonts.base,
      )[#upper(metadata.personal_info.position)]

      #set text(fill: rgb(metadata.styles.colors.text), size: 9pt, font: metadata.styles.fonts.base)

      // Address
      #text(style: "italic")[#metadata.personal_info.contact.address]

      // Contact Info Row with Separators
      #block(width: 100%)[
        #align(right)[
          #stack(
            dir: ltr,
            spacing: 8pt,
            personal_info(fa-phone(), text(metadata.personal_info.contact.phone)),
            text([|]),
            personal_info(fa-envelope(), text(metadata.personal_info.contact.email)),
            if "link" in metadata.personal_info.contact {
              text([|])
              personal_info(fa-linkedin(), link(
                "https://" + metadata.personal_info.contact.link,
              )[#metadata.personal_info.contact.link])
            },
          )
        ]
      ]

      #v(6pt)

    ],
  )
]

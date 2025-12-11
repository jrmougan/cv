#import "@preview/fontawesome:0.6.0": *

#let personal_info = (icon, content) => [
  #box(icon)
  #h(5pt)
  #content
]

#let header(
  metadata,
) = [
  #grid(
    columns: (auto, 1fr),
    gutter: 15pt,
    align: (left + top, right + horizon),
    box(
      radius: 50%,
      clip: true,
      height: 75pt,
      image("../../" + metadata.personal_info.photo),
    ),
    align(right)[
      #text(
        size: eval(metadata.styles.sizes.header_name),
        weight: "black",
        fill: rgb(metadata.styles.colors.primary),
      )[#metadata.personal_info.name]

      #v(-16pt)

      #text(
        size: eval(metadata.styles.sizes.header_position),
        weight: "bold",
        style: "italic",
        fill: rgb(metadata.styles.colors.secondary),
        tracking: 1pt,
      )[<#metadata.personal_info.position />]

      #set text(
        fill: rgb(metadata.styles.colors.text),
        size: eval(metadata.styles.sizes.normal),
      )

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
            personal_info(fa-envelope(), link("mailto:" + metadata.personal_info.contact.email)),
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

      // Language Selector
      #if "all_langs" in metadata {
        align(right)[
          #let langs = metadata.all_langs
          #let buttons = ()
          #for l in langs {
            if l == metadata.lang {
              buttons.push(text(weight: "bold", fill: rgb(metadata.styles.colors.primary))[#upper(l)])
            } else {
              buttons.push(link(label("cv-" + l), text(fill: rgb(metadata.styles.colors.secondary))[#upper(l)]))
            }
          }
          #buttons.join(h(5pt) + text(fill: rgb(metadata.styles.colors.secondary))[|] + h(5pt))
        ]
      }

    ],
  )
]

#let pixel-icon(name, size: 7pt) = {
  box(height: size, baseline: 15%, image("../../icons/" + name + ".svg"))
}

#let header(
  metadata,
) = {
  let bg = rgb(metadata.styles.colors.header_bg)
  let accent = rgb(metadata.styles.colors.accent)
  let white-text = rgb(metadata.styles.colors.header_text)
  let term-text = rgb(metadata.styles.colors.terminal_text)
  let dim = rgb(metadata.styles.colors.header_dim)

  // Full-bleed dark header — terminal style
  block(
    width: 100%,
    inset: (x: 0pt, top: 0pt, bottom: 8pt),
    outset: (x: 1cm, top: 0.7cm),
    fill: bg,
    below: 4pt,
  )[
    #set text(font: metadata.styles.fonts.terminal, size: 8.5pt, fill: term-text)
    #set par(leading: 6pt)

    // Language selector — top-right, above grid
    #if "all_langs" in metadata {
      align(right)[
        #let langs = metadata.all_langs
        #let buttons = ()
        #for l in langs {
          if l == metadata.lang {
            buttons.push(text(weight: "bold", fill: term-text)[\[#upper(l)\]])
          } else {
            buttons.push(link(label("cv-" + l), text(fill: dim)[#upper(l)]))
          }
        }
        #buttons.join(h(4pt))
      ]
    }

    #grid(
      columns: (1fr, auto),
      gutter: 12pt,
      align: (left + horizon, right + horizon),

      // Left column — terminal text
      align(left)[
        #let prompt = text(fill: accent)[jeromo\@citius:\~\$]
        #prompt ./show-cv \

        #text(fill: white-text)[Name:    ] #metadata.personal_info.name \
        #text(fill: white-text)[Role:    ] #metadata.personal_info.position \
        #pixel-icon("location-pin") #h(2pt) #metadata.personal_info.contact.address \
        #pixel-icon("phone") #h(2pt) #metadata.personal_info.contact.phone #h(4pt) #text(fill: dim)[|] #h(
          4pt,
        ) #pixel-icon("mail") #h(2pt) #link("mailto:" + metadata.personal_info.contact.email, text(
          fill: term-text,
        )[#metadata.personal_info.contact.email]) #if "link" in metadata.personal_info.contact [
          #h(4pt) #text(fill: dim)[|] #h(4pt) #pixel-icon("linkedin") #h(2pt) #link(
            "https://" + metadata.personal_info.contact.link,
            text(fill: term-text)[LinkedIn],
          )
        ]
      ],

      // Photo
      box(
        radius: 4pt,
        clip: true,
        height: 60pt,
        stroke: 2pt + term-text,
        image("../../" + metadata.personal_info.photo),
      ),
    )
  ]
}

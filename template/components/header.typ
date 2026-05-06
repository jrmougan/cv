

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
        #text(weight: "bold", fill: dim)[NAME:] #h(2pt) #metadata.personal_info.name \
        #text(weight: "bold", fill: dim)[ROLE:] #h(2pt) #metadata.personal_info.position \
        #text(weight: "bold", fill: dim)[LOC:] #h(2pt) #metadata.personal_info.contact.address #if "availability" in metadata.personal_info [
          #h(4pt) #text(fill: dim)[|] #h(4pt) #text(weight: "bold", fill: dim)[AVAIL:] #h(2pt) #metadata.personal_info.availability
        ] \
        #text(weight: "bold", fill: dim)[TEL:] #h(2pt) #metadata.personal_info.contact.phone #h(4pt) #text(fill: dim)[|] #h(
          4pt,
        ) #text(weight: "bold", fill: dim)[MAIL:] #h(2pt) #link("mailto:" + metadata.personal_info.contact.email, text(
          fill: term-text,
        )[#metadata.personal_info.contact.email]) #if "link" in metadata.personal_info.contact [
          \
          #text(weight: "bold", fill: dim)[LINK:] #h(2pt) #link(
            "https://" + metadata.personal_info.contact.link,
            text(fill: term-text)[#metadata.personal_info.contact.link],
          )
        ] #if "github" in metadata.personal_info.contact [
          #h(4pt) #text(fill: dim)[|] #h(4pt) #text(weight: "bold", fill: dim)[GITHUB:] #h(2pt) #link(
            "https://" + metadata.personal_info.contact.github,
            text(fill: term-text)[#metadata.personal_info.contact.github],
          )
        ]
      ],

      // Photo (hidden when show_photo is false)
      if metadata.at("show_photo", default: true) {
        box(
          radius: 4pt,
          clip: true,
          height: 60pt,
          stroke: 2pt + term-text,
          image("../../" + metadata.personal_info.photo),
        )
      },
    )
  ]
}

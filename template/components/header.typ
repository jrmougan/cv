#let header(metadata) = {
  let info = metadata.personal_info
  let contact = info.contact
  let primary = rgb(metadata.styles.colors.primary)
  let secondary = rgb(metadata.styles.colors.secondary)
  let url(value) = if value.starts-with("https://") or value.starts-with("http://") { value } else { "https://" + value }

  block(width: 100%, breakable: false, below: 10pt)[
    #set text(font: metadata.styles.fonts.base)
    #set par(leading: 4pt)
    #grid(
      columns: (1fr, auto), column-gutter: 14pt,
      align: (left + top, right + top),
      [
        #text(size: eval(metadata.styles.sizes.header_name), weight: "semibold", fill: rgb(metadata.styles.colors.header_text))[#info.name]
        #v(5pt)
        #text(size: eval(metadata.styles.sizes.header_position), weight: "medium", fill: primary)[#info.position]
        #v(8pt)
        #text(size: 8.5pt, fill: secondary)[
          #contact.address#if "availability" in info [ · #info.availability] \
          #link("mailto:" + contact.email)[#contact.email] · #link("tel:" + contact.phone.replace(" ", ""))[#contact.phone] \
          #if "portfolio" in contact { link(url(contact.portfolio))[#contact.portfolio.replace("https://", "")] }
          #if "link" in contact [ · #link(url(contact.link))[LinkedIn]]
          #if "github" in contact [ · #link(url(contact.github))[GitHub]]
        ]
      ],
      if metadata.at("show_photo", default: true) and "photo" in info {
        box(radius: 3pt, clip: true,
          image("../../" + info.photo, width: 49pt, height: 62pt, fit: "cover"))
      },
    )
  ]
}

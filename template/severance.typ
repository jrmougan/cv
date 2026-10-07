// Papeleria de una columna calcada del manual "Official Workplace Guidelines"
// (fanmade, 22 paginas). Las medidas y colores estan tomados del propio PDF:
// el azul petroleo se muestreo de la pagina 3 (#095567) y la banda de filetes
// de la portada (7 lineas de ~2pt separadas ~2,4pt, sangradas al borde derecho).
#let severance-cv(data, doc) = {
  let paper = rgb("#FCFCFB")
  let ink = rgb("#171D25")
  let accent = rgb("#0A5567")   // muestreado del manual
  let secondary = rgb("#53636B")
  let sans = data.styles.fonts.base
  let mono = "Courier Prime"
  let info = data.personal_info
  let contact = info.contact
  let captions = (
    es: (summary: "Perfil profesional", stack: "Tecnologías:"),
    en: (summary: "Professional profile", stack: "Technologies:"),
    gl: (summary: "Perfil profesional", stack: "Tecnoloxías:"),
  ).at(data.lang)
  let url(value) = if value.starts-with("https://") or value.starts-with("http://") { value } else { "https://" + value }

  // Escala de ritmo vertical. Cada salto es ~1,5x el anterior, de modo que la
  // jerarquia (linea < bloque < ficha < seccion) se lee sin medir.
  let sp-tight = 3pt      // titulo de ficha -> organizacion (par de cabecera)
  let sp-inner = 8pt      // entre bloques dentro de una misma ficha
  let sp-entry = 12pt     // entre fichas de una misma seccion
  let sp-section = 18pt   // sobre el titulo de seccion
  let sp-heading = 9pt    // bajo el titulo de seccion
  let body-leading = 5pt

  let page-margin-x = 1.8cm
  let page-margin-top = 1.5cm

  set page(
    paper: "a4", fill: paper,
    margin: (x: page-margin-x, top: page-margin-top, bottom: 1.4cm),
    footer-descent: 0pt,
    footer: context block(width: 100%, stroke: (top: 0.6pt + ink), inset: (top: 6pt))[
      #set text(font: sans, size: 7pt, fill: secondary)
      #grid(columns: (1fr, auto), align: (left, right),
        if data.all_langs.len() > 1 {
          data.all_langs.map(lang => {
            if lang == data.lang { text(weight: "bold")[#upper(lang)] }
            else { link(label("cv-" + lang))[#upper(lang)] }
          }).join(h(9pt))
        } else { text(weight: "bold", tracking: 1.2pt)[CURRICULUM VITAE / #upper(data.lang)] },
        [Page 001-#counter(page).display("01")],
      )
    ],
  )
  // El manual compone absolutamente toda la prosa en una grotesca; la mono
  // aparece solo en los datos de maquina (codigos de memoria, etiquetas de
  // diagrama, teclas). Aqui se respeta esa division.
  set text(font: sans, size: 9pt, fill: ink, lang: data.lang, hyphenate: false)
  set par(leading: body-leading, spacing: 4pt)
  [#metadata(data.lang) #label("cv-" + data.lang)]

  // Banda de filetes paralelos: el motivo estructural del manual. Sangra hasta
  // el borde derecho del papel, como en las portadas y en la pagina 20.
  let stripes(count, weight, gap) = stack(dir: ttb, spacing: gap,
    ..range(count).map(_ => line(length: 100% + page-margin-x, stroke: weight + ink)))
  let band-height = 7 * 1.2pt + 6 * 1.45pt

  // Retrato de expediente: el original cuadrado se reencuadra a 4:5 dentro de
  // la maqueta, centrado en el sujeto y sin huecos blancos.
  let show-photo = data.at("show_photo", default: true) and "photo" in info
  let photo-width = 62pt
  let photo-height = 77.9pt
  let portrait() = box(
    width: photo-width, height: photo-height,
    clip: true, inset: 0pt, stroke: 1pt + ink,
    place(top + left, dx: -28pt, dy: -4pt,
      image("../" + info.photo, width: 125pt, height: 125pt))
  )

  // Fila de clasificacion, calcada de "SECURITY OPERATIONAL MANUAL" / "Page 001-01".
  grid(columns: (1fr, auto),
    text(font: sans, size: 7pt, weight: "bold", tracking: 1.2pt)[CURRICULUM VITAE],
    text(font: sans, size: 7.5pt)[Ref. #info.name.split(" ").map(part => part.first()).join()-01 / #upper(data.lang)],
  )
  v(9pt)

  // Matriz de identidad. El nombre va en caja alta y baja, como todos los
  // titulos del manual: en 22 paginas no hay un solo titular en versales.
  grid(
    columns: if show-photo { (photo-width, 1fr, auto) } else { (1fr, auto) },
    column-gutter: if show-photo { (16pt, 16pt) } else { (18pt,) },
    align: if show-photo { (left + horizon, left + horizon, right + horizon) } else { (left + horizon, right + horizon) },
    ..if show-photo { (portrait(),) } else { () },
    [
      #set par(leading: 4.5pt)
      #let name-parts = info.name.split(" ")
      #text(font: sans, size: 21pt, weight: "bold")[
        #name-parts.slice(0, 2).join(" ") \ #name-parts.slice(2).join(" ")
      ]
    ],
    [
      #set text(font: sans, size: 8pt, fill: secondary)
      #set par(leading: 4.5pt)
      #link("tel:" + contact.phone.replace(" ", ""))[#text(fill: secondary)[#contact.phone]] \
      #link("mailto:" + contact.email)[#text(fill: secondary)[#contact.email]] \
      #if "portfolio" in contact { link(url(contact.portfolio))[#text(fill: accent)[#contact.portfolio.replace("https://", "")]] } \
      #if "link" in contact { link(url(contact.link))[#text(fill: accent)[LinkedIn]] }
      #if "github" in contact [ · #link(url(contact.github))[#text(fill: accent)[GitHub]]] \
      #box[#contact.address] \
      #if "availability" in info [#text(fill: secondary)[#info.availability]]
    ],
  )
  v(11pt)

  // Banda con la etiqueta del puesto recuadrada sobre los filetes: es el
  // dispositivo de la pagina 20 del manual (titulo, banda y rotulo encajado).
  block(width: 100%, height: 22pt)[
    #place(left + horizon, box(width: 100%, stripes(7, 1.2pt, 1.45pt)))
    #place(left + horizon, box(fill: paper, stroke: 1pt + ink, inset: (x: 7pt, y: 4.5pt))[
      #text(font: sans, size: 8pt, weight: "bold", tracking: 1.1pt)[#upper(info.position)]
    ])
  ]
  v(sp-section, weak: true)

  // Linea de telemetria "Tecnologias: ..." con sangria francesa. Los terminos
  // van en mono porque son datos de inventario, como los codigos de la figura 22C.
  let tech-line(tags) = block(width: 100%, above: sp-inner)[
    #grid(columns: (auto, 1fr), column-gutter: 4pt, align: (left + top, left + top),
      text(font: sans, size: 7.5pt, weight: "bold", fill: accent)[#captions.stack],
      {
        set text(font: mono, size: 7.5pt, fill: secondary, tracking: 0.2pt)
        set par(leading: 4.2pt)
        tags.map(t => box[#t]).join([~· ])
      },
    )
  ]

  let section-number = 0
  let section(title, number) = {
    // Barra negra con el rotulo en blanco y un filete simple hasta el margen: es
    // la cabecera de protocolo (pp. 17-19) con su subrayado. La banda de filetes
    // paralelos NO se repite aqui: en el manual es un divisor de pagina que
    // aparece una sola vez, y multiplicado por seccion se empasta en una mancha.
    show heading: it => block(width: 100%, above: sp-section, below: sp-heading, sticky: true)[
      #grid(columns: (auto, 1fr), column-gutter: 9pt, align: horizon,
        box(fill: ink, inset: (x: 6pt, y: 4pt))[
          #text(font: sans, size: 7.5pt, weight: "bold", fill: white, tracking: 1pt)[
            #numbering("01", number)#h(6pt)#box(width: 0.7pt, height: 7pt, fill: white, baseline: 1pt)#h(6pt)#upper(it.body)
          ]
        ],
        line(length: 100%, stroke: 0.7pt + ink),
      )
    ]
    heading(level: 1, numbering: none, title)
  }

  if "summary" in info {
    section-number += 1
    section(captions.summary, section-number)
    // "Proper Response": filete negro de 2pt en el margen y texto en petroleo
    // destacado, como los bloques de respuesta de las paginas 3 y 11-15.
    block(width: 100%, stroke: (left: 2pt + ink), inset: (left: 9pt, y: 3pt), below: sp-entry)[
      #set text(font: sans, size: 10pt, weight: "semibold", fill: accent)
      #set par(leading: 5.5pt)
      #info.summary
    ]
  }

  if "experience" in data and data.experience.len() > 0 {
    section-number += 1
    section(data.labels.experience, section-number)
    for item in data.experience {
      block(width: 100%, breakable: false, below: sp-entry)[
        #grid(columns: (1fr, auto), column-gutter: 10pt, align: (left + horizon, right + horizon),
          text(font: sans, size: 10pt, weight: "bold")[#item.position],
          text(font: sans, size: 8pt, fill: secondary)[#item.date.replace(" - ", " – ")],
        )
        #block(above: sp-tight, below: 0pt)[
          #text(font: sans, size: 8.5pt, fill: secondary)[#item.company#if item.at("location", default: "") != "" [ | #item.location]]
        ]
        #if item.at("description", default: "") != "" {
          block(above: sp-inner, below: 0pt)[#item.description]
        }
        #let tasks = item.at("tasks", default: ())
        #if tasks != none and tasks.len() > 0 {
          set list(marker: text(font: sans, size: 9pt, fill: secondary)[–], indent: 4pt, body-indent: 7pt, spacing: 5pt)
          block(above: sp-inner, below: 0pt)[
            #list(..tasks)
          ]
        }
        #if item.at("tags", default: ()).len() > 0 {
          tech-line(item.tags.slice(0, calc.min(item.tags.len(), 10)))
        }
      ]
    }
  }
  if "education" in data and data.education.len() > 0 {
    section-number += 1
    section(data.labels.education, section-number)
    for item in data.education {
      block(width: 100%, breakable: false, below: sp-entry)[
        #grid(columns: (1fr, auto), column-gutter: 10pt, align: (left + horizon, right + horizon),
          text(font: sans, size: 9.5pt, weight: "semibold")[#item.degree],
          text(font: sans, size: 8pt, fill: secondary)[#item.date.replace(" - ", " – ")],
        )
        #let loc = item.at("location", default: "")
        #let is-redundant = loc == "" or item.institution.contains(loc) or (loc.contains("Coruña") and item.institution.contains("Coruña"))
        #block(above: sp-tight, below: 0pt)[
          #text(font: sans, size: 8.5pt, fill: secondary)[#item.institution#if not is-redundant [ | #loc]]
        ]
        #if item.at("description", default: "") != "" { block(above: sp-inner, below: 0pt)[#item.description] }
        #if item.at("tags", default: ()).len() > 0 { tech-line(item.tags) }
      ]
    }
  }
  if "projects" in data and data.projects.len() > 0 {
    section-number += 1
    section(data.labels.projects, section-number)
    for item in data.projects {
      block(width: 100%, breakable: false, below: sp-entry)[
        #text(font: sans, size: 9.5pt, weight: "bold")[#item.name]
        #if item.at("url", default: "") != "" [ | #link(url(item.url))[#text(size: 8pt, fill: accent)[#item.url]]]
        #block(above: sp-inner, below: 0pt)[#item.description]
        #if item.at("tags", default: ()).len() > 0 { tech-line(item.tags) }
      ]
    }
  }
  if "languages" in data and data.languages.len() > 0 {
    section-number += 1
    section(data.labels.languages, section-number)
    // Recuadros de esquina viva y filete fino: los de los codigos de memoria
    // (p. 17) y las teclas del protocolo (p. 19). El manual no usa redondeos.
    block(width: 100%, breakable: false, below: sp-entry)[
      #data.languages.map(item => box(inset: (y: 1pt))[
        #text(font: sans, size: 9pt, weight: "bold")[#item.language]
        #h(5pt)
        #box(stroke: 0.6pt + ink, inset: (x: 5pt, y: 2.5pt))[
          #text(font: mono, size: 7.5pt, fill: ink)[#item.level]
        ]
      ]).join([#h(18pt)])
    ]
  }
  doc
}

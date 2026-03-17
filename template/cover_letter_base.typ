#import "components/header.typ": header

#let cover_letter_cv(
  metadata,
  letter_data,
) = {
  // Set page background if defined
  let bg-color = if "background" in metadata.styles.colors {
    rgb(metadata.styles.colors.background)
  } else {
    white
  }

  set page(
    fill: bg-color,
    margin: (x: 2cm, y: 1.5cm),
  )
  set text(
    fill: rgb(metadata.styles.colors.text),
    font: metadata.styles.fonts.mono,
    size: eval(metadata.styles.sizes.normal),
  )
  set par(leading: 0.75em, justify: true)

  // Header (uses CV's header)
  header(metadata)

  v(24pt)

  // Recipient info
  block(width: 100%)[
    #set align(left)
    #text(weight: "bold")[#letter_data.to]
  ]

  v(12pt)

  // Date
  block(width: 100%)[
    #set align(right)
    #letter_data.date
  ]

  v(24pt)

  // Subject
  if "subject" in letter_data [
    #block(width: 100%)[
      #set align(left)
      #text(weight: "bold", fill: rgb(metadata.styles.colors.primary))[
        #upper(letter_data.subject)
      ]
    ]
    v(12pt)
  ]

  // Opening
  block(width: 100%)[
    #letter_data.opening
  ]

  v(12pt)

  // Body
  block(width: 100%)[
    #letter_data.body
  ]

  v(24pt)

  // Closing & Signature
  block(width: 100%)[
    #letter_data.closing \
    #v(12pt)
    #text(weight: "bold", fill: rgb(metadata.styles.colors.primary))[#metadata.personal_info.name]
  ]
}

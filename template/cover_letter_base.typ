#import "components/header.typ": header

#let cover_letter_cv(
  cv_data,
  letter_data,
) = {
  // Set page background if defined
  let bg-color = if "background" in cv_data.styles.colors {
    rgb(cv_data.styles.colors.background)
  } else {
    white
  }

  set page(
    fill: bg-color,
    margin: (x: 2cm, y: 1.5cm),
  )
  set text(
    fill: rgb(cv_data.styles.colors.text),
    font: cv_data.styles.fonts.mono,
    size: eval(cv_data.styles.sizes.normal),
  )
  set par(leading: 0.75em, justify: true)

  // Create an anchor for this language (required by header's language selector)
  [#metadata(cv_data.lang) #label("cv-" + cv_data.lang)]

  // Header (uses CV's header, without photo)
  header(cv_data + (show_photo: false))

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
      #text(weight: "bold", fill: rgb(cv_data.styles.colors.primary))[
        #upper(letter_data.subject)
      ]
    ]
    #v(12pt)
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
    #text(weight: "bold", fill: rgb(cv_data.styles.colors.primary))[#cv_data.personal_info.name]
  ]

  // Footer — QR portfolio + LinkedIn (same as CV)
  let contact = cv_data.personal_info.contact
  if "qr_portfolio" in contact and "portfolio" in contact {
    let secondary = rgb(cv_data.styles.colors.secondary)
    let term = rgb(cv_data.styles.colors.terminal_text)
    let muted = rgb(cv_data.styles.colors.muted)

    place(bottom + center,
      dx: 0pt,
      dy: 1.5cm,
      block(
        width: 100% + 4cm,
        inset: (x: 12pt, top: 6pt, bottom: 6pt),
        stroke: (top: 0.3pt + muted),
      )[
        #set text(font: cv_data.styles.fonts.terminal, size: 6.5pt)
        #grid(
          columns: (auto, 1fr, auto),
          align: (left + horizon, left + horizon, right + horizon),
          column-gutter: 12pt,

          // Left — LinkedIn QR + URL
          if "link" in contact {
            grid(
              columns: (auto, auto),
              align: (left + horizon, left + horizon),
              column-gutter: 8pt,
              if "qr_linkedin" in contact {
                image("../" + contact.qr_linkedin, width: 28pt, height: 28pt)
              },
              stack(dir: ttb, spacing: 2pt,
                text(fill: secondary, weight: "bold")[LINKEDIN],
                link("https://" + contact.link,
                  text(fill: term)[#contact.link]
                ),
              ),
            )
          },

          // Center — empty spacer
          [],

          // Right — portfolio URL + QR
          grid(
            columns: (auto, auto),
            align: (right + horizon, right + horizon),
            column-gutter: 8pt,
            stack(dir: ttb, spacing: 2pt,
              text(fill: secondary, weight: "bold")[PORTFOLIO],
              link(contact.portfolio,
                text(fill: term)[#contact.portfolio]
              ),
            ),
            image("../" + contact.qr_portfolio, width: 28pt, height: 28pt),
          ),
        )
      ]
    )
  }
}

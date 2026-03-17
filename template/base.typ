#import "components/header.typ": header
#import "components/entity.typ": entity
#import "components/education.typ": education_item
#import "components/project.typ": project_item
#import "components/languages.typ": language_item
#import "section.typ": seccion

#let cv(
  cv_data,
  doc,
) = {
  // Set page background if defined
  let bg-color = if "background" in cv_data.styles.colors {
    rgb(cv_data.styles.colors.background)
  } else {
    white
  }

  set page(
    fill: bg-color,
    margin: (x: 1cm, y: 0.7cm),
  )
  set text(
    fill: rgb(cv_data.styles.colors.text),
    font: cv_data.styles.fonts.mono,
    size: eval(cv_data.styles.sizes.normal),
  )
  set par(leading: 0.75em)

  // Create an anchor for this language
  [#metadata(cv_data.lang) #label("cv-" + cv_data.lang)]

  header(
    cv_data,
  )

  if "summary" in cv_data.personal_info [
    #block(above: 8pt, below: 10pt)[
      #text(
        size: eval(cv_data.styles.sizes.normal),
        style: "italic",
        fill: rgb(cv_data.styles.colors.secondary),
      )[
        #cv_data.personal_info.summary
      ]
    ]
  ]

  if "experience" in cv_data {
    seccion(cv_data.labels.experience, cv_data)
    for item in cv_data.experience {
      entity(item, cv_data)
    }
  }

  if "education" in cv_data {
    seccion(cv_data.labels.education, cv_data)
    for item in cv_data.education {
      education_item(item, cv_data)
    }
  }

  if "projects" in cv_data {
    seccion(cv_data.labels.projects, cv_data)
    for item in cv_data.projects {
      project_item(item, cv_data)
    }
  }

  if "languages" in cv_data {
    seccion(cv_data.labels.languages, cv_data)
    for item in cv_data.languages {
      language_item(item, cv_data)
    }
  }

  // Footer — QR portfolio + LinkedIn
  let contact = cv_data.personal_info.contact
  if "qr_portfolio" in contact and "portfolio" in contact {
    let secondary = rgb(cv_data.styles.colors.secondary)
    let term = rgb(cv_data.styles.colors.terminal_text)
    let muted = rgb(cv_data.styles.colors.muted)

    place(bottom + center,
      dx: 0pt,
      dy: 0.7cm,
      block(
        width: 100% + 2cm,
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

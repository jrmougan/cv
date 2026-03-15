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
}

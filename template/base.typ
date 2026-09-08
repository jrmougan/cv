#import "components/header.typ": header
#import "components/entity.typ": entity
#import "components/education.typ": education_item
#import "components/project.typ": project_item
#import "components/languages.typ": language_item
#import "components/skills.typ": skills_section
#import "section.typ": seccion

#let cv(cv_data, doc) = {
  let secondary = rgb(cv_data.styles.colors.secondary)
  let footer-content = context {
    set text(font: cv_data.styles.fonts.base, size: 8pt, fill: secondary)
    grid(columns: (1fr, auto), align: (left, right),
      if cv_data.all_langs.len() > 1 {
        cv_data.all_langs.map(lang => {
          let title = upper(lang)
          if lang == cv_data.lang { text(weight: "semibold", fill: rgb(cv_data.styles.colors.primary))[#title] }
          else { link(label("cv-" + lang))[#title] }
        }).join(h(9pt))
      } else { [] },
      counter(page).display("1"),
    )
  }

  set page(
    paper: "a4",
    fill: rgb(cv_data.styles.colors.at("background", default: "#FFFFFF")),
    margin: (x: 1.6cm, top: 1.35cm, bottom: 1.4cm),
    footer: footer-content,
    footer-descent: 0pt,
  )
  set text(
    fill: rgb(cv_data.styles.colors.text),
    font: cv_data.styles.fonts.base,
    size: eval(cv_data.styles.sizes.normal),
    lang: cv_data.lang,
    hyphenate: false,
  )
  set par(leading: 0.6em, spacing: 5pt)

  [#metadata(cv_data.lang) #label("cv-" + cv_data.lang)]
  header(cv_data)

  if "summary" in cv_data.personal_info {
    block(above: 3pt, below: 4pt)[#cv_data.personal_info.summary]
  }
  if "experience" in cv_data {
    seccion(cv_data.labels.experience, cv_data)
    for item in cv_data.experience { entity(item, cv_data) }
  }
  if "education" in cv_data {
    seccion(cv_data.labels.education, cv_data)
    for item in cv_data.education { education_item(item, cv_data) }
  }
  if "projects" in cv_data {
    seccion(cv_data.labels.projects, cv_data)
    for item in cv_data.projects { project_item(item, cv_data) }
  }
  if "skills" in cv_data and cv_data.skills.len() > 0 {
    let title = cv_data.labels.at("skills", default: (es: "Habilidades", en: "Skills", gl: "Habilidades").at(cv_data.lang))
    seccion(title, cv_data)
    skills_section(cv_data.skills, cv_data)
  }
  if "languages" in cv_data {
    seccion(cv_data.labels.languages, cv_data)
    // Keep the short language list together; no isolated proficiency line.
    block(breakable: false)[
      #cv_data.languages.map(item => language_item(item, cv_data)).join([ · ])
    ]
  }
  doc
}

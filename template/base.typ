#import "components/header.typ": header
#import "components/entity.typ": entity
#import "components/education.typ": education_item
#import "components/project.typ": project_item
#import "components/skills.typ": skills_item
#import "components/languages.typ": language_item
#import "section.typ": seccion

#let cv(
  metadata,
  profilePhoto: image("../img/profile-photo.png"),
  doc,
) = {
  // Set page background if defined
  let bg-color = if "background" in metadata.styles.colors {
    rgb(metadata.styles.colors.background)
  } else {
    white
  }

  set page(
    fill: bg-color,
    margin: 1cm, // Reduced margin to fit content
  )
  set text(
    fill: rgb(metadata.styles.colors.text),
    font: metadata.styles.fonts.base,
  )

  header(
    metadata,
    profilePhoto,
  )

  if "summary" in metadata.personal_info [
    #pad(bottom: 10pt, top: 5pt)[
      #text(
        size: eval(metadata.styles.sizes.normal),
        style: "italic",
        fill: rgb(metadata.styles.colors.text),
      )[
        #metadata.personal_info.summary
      ]
    ]
  ]

  if "experience" in metadata {
    seccion(metadata.labels.experience, metadata)
    for item in metadata.experience {
      entity(item, metadata)
    }
  }

  if "education" in metadata {
    seccion(metadata.labels.education, metadata)
    for item in metadata.education {
      education_item(item, metadata)
    }
  }

  if "projects" in metadata {
    seccion(metadata.labels.projects, metadata)
    for item in metadata.projects {
      project_item(item, metadata)
    }
  }

  if "skills" in metadata {
    seccion(metadata.labels.skills, metadata)
    for item in metadata.skills {
      skills_item(item, metadata)
    }
  }

  if "languages" in metadata {
    seccion(metadata.labels.languages, metadata)
    for item in metadata.languages {
      language_item(item, metadata)
    }
  }
}

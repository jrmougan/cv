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
  header(
    metadata,
    profilePhoto,
  )

  if "experience" in metadata {
    seccion(metadata.labels.experience)
    for item in metadata.experience {
      entity(item)
    }
  }

  if "education" in metadata {
    seccion(metadata.labels.education)
    for item in metadata.education {
      education_item(item)
    }
  }

  if "projects" in metadata {
    seccion(metadata.labels.projects)
    for item in metadata.projects {
      project_item(item)
    }
  }

  if "skills" in metadata {
    seccion(metadata.labels.skills)
    for item in metadata.skills {
      skills_item(item)
    }
  }

  if "languages" in metadata {
    seccion(metadata.labels.languages)
    for item in metadata.languages {
      language_item(item)
    }
  }
}

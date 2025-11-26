#import "components/header.typ": header
#import "components/entity.typ": entity
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

  /*   seccion(
    "Perfil",
    entity(
      profilePhoto,
      metadata.profileDescription,
    )
  ) */
}

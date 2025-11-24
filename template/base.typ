#import "components/header.typ": header
#import "components/entity.typ": entity
#import "section.typ": seccion

#let cv = (
  nombre,
  titulo,
  contacto,
) => [
  // Encabezado
  #header(nombre, titulo, contacto)
  #text[#lorem(45)]
]
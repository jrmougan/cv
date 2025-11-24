// Base del CV
#import "styles.typ": cargar-estilos
#import "components/header.typ": header
#import "components/entity.typ": entity
#import "section.typ": seccion

#let cv = ({
  nombre,
  titulo,
  contacto,
  experiencia: exp,
  educacion: edu,
  habilidades: skills,
  proyectos: proy,
}) => [
  #cargar-estilos()

  // Encabezado
  #header(nombre, titulo, contacto)

  // Contenido
  #if exp != none [
    #seccion("Experiencia")
    #exp.map(x => exp-block(x))
  ]

  #if edu != none [
    #seccion("Educación")
    #edu.map(x => edu-block(x))
  ]

  #if skills != none [
    #seccion("Habilidades")
    #skill-block(skills)
  ]

  #if proy != none [
    #seccion("Proyectos")
    #proy.map(x => project-block(x))
  ]
]
#import "template/base.typ": cv

#cv(
  nombre: "Juan Pérez",
  titulo: "Desarrollador Full Stack",
  contacto: "juanperez@example.com · +34 600 123 456 · Madrid",

  experiencia: (
    (
      empresa: "TechCorp",
      cargo: "Software Engineer",
      fecha: "2021–2024",
      desc: "Desarrollo de microservicios en Go y APIs REST."
    ),
    (
      empresa: "OpenDev",
      cargo: "Full Stack Developer",
      fecha: "2019–2021",
      desc: "Aplicaciones web con React, Node.js y PostgreSQL."
    )
  ),

  educacion: (
    (
      institucion: "Universidad Autónoma",
      titulo: "Ingeniería Informática",
      fecha: "2015–2019"
    )
  ),

  habilidades: (
    "Go", "Rust", "Python", "React", "SQL", "Docker", "Kubernetes"
  ),

  proyectos: (
    (
      nombre: "Proyecto Atlas",
      enlace: "github.com/juan/atlas",
      desc: "Plataforma de análisis de datos en tiempo real."
    )
  )
)

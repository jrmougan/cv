# Propuesta: currículum de una columna inspirado en Severance

La composición se ajusta a `workplace_guidelines_fanmade.pdf`, el manual fanmade de
22 páginas. Las páginas son rasterizadas, así que además de revisarlas visualmente se
midieron sobre el propio archivo (rasterizado con `pdftoppm`) el color de acento, el
número y el grosor de los filetes y su sangrado.

## Auditoría contra el manual

Lo que el manual hace, y cómo lo aplica la plantilla:

| Rasgo del manual | Evidencia | En la plantilla |
| --- | --- | --- |
| Toda la prosa en una grotesca; la monoespaciada aparece **solo** en datos de máquina | pp. 3–16 íntegras en sans; mono únicamente en los códigos de memoria de la figura 22C (p. 17), las etiquetas del diagrama de flujo (p. 18) y las teclas (p. 19) | Geist para prosa, títulos, fechas y contacto; Courier Prime reservado al inventario de tecnologías y a los códigos de nivel de idioma |
| Ningún titular en versales; todos en caja alta y baja | «Official Workplace Guidelines», «Input Survey», «Security Office Protocol», «Senior Refiner Morning Checklist», «Employee Shift Schedule» | El nombre pasa a caja alta y baja. Las versales quedan solo donde el manual las usa: rótulos dentro de barras y recuadros |
| Azul petróleo para respuestas y códigos | muestreado en la p. 3: `#095567` | `#0A5567` (antes `#155D70`, demasiado claro) |
| Banda de filetes paralelos como divisor maestro | portada: 7 líneas de ~2 pt separadas ~2,4 pt; llega hasta el borde derecho del papel (x=594,7 pt de 595,7 pt) | 7 líneas de 1,2 pt con 1,45 pt de separación, sangradas al borde derecho. Aparece **una sola vez**, en la cabecera: repetida por sección se empastaba en una mancha gris, y el manual tampoco la repite dentro de una página |
| Rótulo recuadrado encajado sobre la banda | p. 20: título, banda y caja con «MACRODATA REFINEMENT» | El puesto va en una caja de filete negro montada sobre la banda de cabecera |
| Cabecera de protocolo: barra negra con el rótulo en blanco y subrayado | pp. 17–19 | Los títulos de sección son barra negra con número y rótulo en blanco, con un filete simple de 0,7 pt hasta el margen |
| Bloque de respuesta: filete negro de 2 pt y texto petróleo destacado | pp. 3 y 11–15 | El perfil profesional usa filete negro de 2 pt y texto petróleo en semibold |
| Recuadros de esquina viva, filete fino, sin relleno de color | códigos de memoria (p. 17), teclas `SHIFT`/`CTRL` (p. 19) | Los niveles de idioma pasan de cápsulas redondeadas con fondo azulado a recuadros rectos de 0,6 pt |
| Identificador de página en sans regular arriba a la derecha | «Page 001-01» (pp. 3–15), «SECURITY OPERATIONAL MANUAL» (pp. 17–19) | Fila superior con `CURRICULUM VITAE` y `Ref. JRM-01 / ES`; pie con `Page 001-01` |

Se conserva la columna única institucional. La paleta usa tinta `#171D25`,
acento petróleo `#0A5567`, secundario `#53636B` y papel blanco suave `#FCFCFB`.
La numeración de secciones sigue el contenido presente y se reinicia por idioma.

## Cabecera institucional y fotografía

Tras medir el manual, la cabecera reproduce la anatomía de sus portadas
(logotipo, titular en caja alta y baja, banda de filetes y rótulo encajado):

1. **Fondo de papel continuo**: todo el documento se asienta sobre el papel blanco
   marfil `#FCFCFB`, sin bloques de color sintéticos que rompan la lectura.
2. **Fila de clasificación**: arriba figuran la categoría `CURRICULUM VITAE`
   (versalita en negrita, como «SECURITY OPERATIONAL MANUAL») y el identificador
   `Ref. JRM-01 / ES` en sans regular, calcado de «Page 001-01».
3. **Fotografía enmarcada de credencial**: retrato 4:5 (62 × 77,9 pt) con filete de
   1 pt en tinta negra. El reencuadre (`dx: -28pt`, `dy: -4pt` sobre 125 pt) centra
   la cabeza con headroom natural y elimina márgenes blancos.
4. **Nombre en caja alta y baja**: en 22 páginas el manual no compone un solo titular
   en versales, así que el nombre abandona las mayúsculas y queda en Geist bold a 21 pt,
   centrado ópticamente (`horizon`) respecto a la foto y a la columna de contacto.
5. **Banda de identidad con el puesto encajado**: bajo el nombre, la banda de 7 filetes
   sangra hasta el borde derecho del papel y lleva el puesto en una caja de filete negro
   montada encima. Es el dispositivo de la página 20 del manual.
6. **Títulos de sección como cabecera de protocolo**: barra negra con el número y el
   rótulo en blanco (pp. 17–19) y un filete simple de 0,7 pt hasta el margen. La banda
   de filetes paralelos no se repite aquí: en el manual es un divisor de página que
   aparece una sola vez, y multiplicada por sección se empastaba en una mancha gris.
   La numeración sigue el contenido presente y se reinicia por idioma.
7. **Perfil profesional como «Proper Response»**: filete negro de 2 pt en el margen y
   texto en petróleo semibold a 10 pt, como los bloques de respuesta de las pp. 3 y 11–15.
8. **Registro monoespaciado acotado**: Courier Prime queda reservado al inventario de
   tecnologías y a los códigos de nivel de idioma, que son los equivalentes de los
   códigos de memoria y las teclas del manual. La prosa, las fechas y el contacto van
   en Geist.
9. **Escala de ritmo vertical explícita**: se eliminaron los estiramientos no lineales de
   `v(1fr)` y los espaciados sueltos, que dejaban la ficha de cada empleo pegada en un
   solo bloque compacto. La plantilla define una única escala —`sp-tight` 3 pt
   (cargo → empresa), `sp-inner` 8 pt (entre bloques de una ficha), `sp-entry` 12 pt
   (entre fichas) y `sp-section` 18 pt / `sp-heading` 9 pt (secciones)— y todos los
   apartados la reutilizan. La progresión aproximada 1 : 2,5 : 4 : 6 hace que la
   jerarquía se lea sin medir.
10. **Línea de tecnologías con sangría francesa**: `Tecnologías:` ocupa su propia columna
   de una rejilla, así las continuaciones se alinean bajo el primer término en lugar de
   volver al margen izquierdo.
11. **Márgenes**: 1,8 cm laterales, 1,5 cm superior y 1,4 cm inferior. Las bandas de
   filetes sangran a propósito por el margen derecho, como en el manual.

`img/profile-photo.jpeg` no se modifica. El original es cuadrado (800 × 800 px)
con el sujeto descentrado a la izquierda. El reencuadre a 4:5 se realiza
dentro de la maquetación mediante un contenedor con dimensiones explícitas y
recorte calibrado (`dx: -28pt`, `dy: -4pt` sobre escala de 125 pt), lo que centra
con precisión la cabeza (eje horizontal en torno a x=380 px), proporciona margen
superior natural (headroom) sin cortar el pelo ni la frente, muestra hombros y
cuello con naturalidad, y elimina cualquier banda en blanco o deformación.

La foto se controla con `show_photo`, la misma opción que ya usaban las cartas
de presentación. Está activa por omisión y se desactiva con `--input photo=off`,
que devuelve la cabecera a dos columnas. Si `personal_info.photo` no existe en
los datos, ambas plantillas la omiten sin error.

## Generar la propuesta

```sh
mkdir -p previews
typst compile --font-path fonts --ignore-system-fonts --input style=severance --input lang=es main.typ previews/cv-severance-es.pdf
```

Añadir `--input photo=off` para la versión sin fotografía.

Usar `lang=en` o `lang=gl` para los otros idiomas; omitir `lang` genera un PDF
con los tres. Con los datos actuales, cada idioma ocupa una página A4.

La plantilla original continúa siendo la predeterminada. También se puede
seleccionar explícitamente con `--input style=classic`. Las cartas mantienen su
plantilla original.

## Fuentes

Geist compone la prosa, los títulos y los rótulos; Courier Prime solo el inventario
de tecnologías y los códigos de nivel de idioma.

Courier Prime Regular, Bold e Italic se incluyen en `fonts/`, junto con su
licencia SIL Open Font License en `fonts/CourierPrime-OFL.txt`. Proceden del
[repositorio oficial de Google Fonts](https://github.com/google/fonts/tree/main/ofl/courierprime).
Las fuentes están incrustadas en los PDF. No se necesitan fuentes del sistema.

## Edición del contenido

Se conserva la edición breve acordada para mantener una página: presentación
y tareas resumidas en los tres idiomas, los cuatro empleos, sus fechas,
responsabilidades principales, formación e idiomas. Se abrevian las denominaciones
de estudios y se omiten detalles secundarios, como STOMP/SockJS en las tareas.
Git, ESLint y GitHub Copilot permanecen en el inventario de habilidades con
`featured = false`.

Estos cambios están en `cv_data.toml` y también se reflejan en la variante clásica.
La adaptación a la nueva referencia visual no elimina más contenido.

## Implementación y comprobación

- `template/severance.typ` contiene la composición y la paleta de la propuesta.
- Los datos se siguen leyendo de `cv_data.toml`, con enlaces activos y texto
  seleccionable. Las secciones están localizadas en los tres idiomas.
- Verificado con Typst 0.15.0 y exclusivamente las fuentes locales: una página
  por idioma, tres páginas en el PDF multilingüe y revisión visual de español,
  inglés y gallego. Comprobada la extracción del contenido, las fuentes incrustadas
  y la compilación de la variante clásica y de la carta de ejemplo.

Los PDF y PNG de `previews/` son artefactos locales y están ignorados por Git.

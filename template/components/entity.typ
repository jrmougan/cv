#import "skills.typ": skill_tags

#let entity = (item, metadata) => [
  #let is_quiet = "quiet" in item and item.quiet
  #let primary_color = if is_quiet { rgb(metadata.styles.colors.muted) } else { rgb(metadata.styles.colors.primary) }
  #let secondary_color = if is_quiet { rgb(metadata.styles.colors.muted).lighten(15%) } else { rgb(metadata.styles.colors.secondary) }
  #let accent_color = if is_quiet { rgb(metadata.styles.colors.muted) } else { rgb(metadata.styles.colors.primary) }
  #let text_color = if is_quiet { rgb(metadata.styles.colors.muted).lighten(15%) } else { rgb(metadata.styles.colors.text) }

  #block(breakable: true, width: 100%, below: 14pt)[
    // Header grid — NEVER breaks across pages
    #block(breakable: false)[
      #grid(
        columns: (auto, 1fr, auto),
        column-gutter: 6pt,
        row-gutter: 0pt,
        align: (left + horizon, left + top, right + top),
        // Column 1: Logo
        if "logo" in item and item.logo != "" {
          box(radius: 2pt, clip: true, image("../../" + item.logo, height: 16pt))
        } else {
          box(width: 16pt, height: 16pt)
        },
        // Column 2: Company + Position
        stack(dir: ttb, spacing: 4pt,
          text(weight: "bold", size: eval(metadata.styles.sizes.item_h1), fill: primary_color)[#item.company],
          text(weight: "regular", style: "italic", fill: secondary_color, size: eval(metadata.styles.sizes.item_h2))[#item.position],
        ),
        // Column 3: Location + Date
        stack(dir: ttb, spacing: 4pt,
          if "location" in item and item.location != "" {
            box[
              #text(weight: "bold", fill: secondary_color)[\@]
              #h(1pt)
              #text(weight: "medium", size: eval(metadata.styles.sizes.item_h3), fill: accent_color)[#item.location]
            ]
          },
          text(style: "italic", size: eval(metadata.styles.sizes.item_h3), fill: secondary_color)[#item.date],
        ),
      )
    ]
    // Description
    #block(width: 100%, above: 6pt, below: 4pt)[
      #text(size: eval(metadata.styles.sizes.normal), fill: text_color)[#item.description]
    ]
    // Tasks — terminal style lists
    #if "tasks" in item and item.tasks != none and item.tasks.len() > 0 {
      block(width: 100%, above: 6pt)[
        #set list(
          marker: text(fill: secondary_color, weight: "bold", size: 6pt)[\>],
          indent: 0pt,
          body-indent: 6pt,
          spacing: 5pt,
        )
        #set text(size: eval(metadata.styles.sizes.normal), fill: text_color)
        #list(..item.tasks)
      ]
    }
    // Skill tags
    #if "tags" in item and item.tags.len() > 0 {
      skill_tags(item.tags, metadata)
    }
  ]
]

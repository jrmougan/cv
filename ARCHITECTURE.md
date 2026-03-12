# Architecture

## Overview

This is a **Typst-based multilingual CV/resume** project. It generates a professional CV in multiple languages (currently Spanish and English) from a single codebase, using a data-driven, component-based architecture.

The project cleanly separates **content** (`cv_data.toml`), **styling** (`metadata.toml`), and **layout** (`template/*.typ`). Adding a new language requires only adding data to the TOML file -- no template changes needed.

## Directory Structure

```
.
├── main.typ                          # Entry point - orchestrates compilation
├── cv_data.toml                      # All CV content (shared + per-language)
├── metadata.toml                     # Style/theme configuration (fonts, colors, sizes)
├── template/
│   ├── base.typ                      # Main cv() function - page setup + section orchestration
│   ├── section.typ                   # seccion() - section title with dotted rule
│   ├── metadata.toml.schema.json     # JSON Schema for metadata validation (draft-07)
│   └── components/
│       ├── header.typ                # Profile photo, name, contact info, language selector
│       ├── entity.typ                # Work experience entry (supports "quiet" mode)
│       ├── education.typ             # Education entry
│       ├── project.typ               # Project entry with URL link
│       ├── skills.typ                # Categorized skills grid with dot proficiency rating
│       └── languages.typ             # Spoken language entry
├── fonts/
│   ├── Font Awesome 7 Brands-Regular-400.otf
│   ├── Font Awesome 7 Free-Regular-400.otf
│   └── Font Awesome 7 Free-Solid-900.otf
├── img/
│   ├── profile-photo.jpeg            # Candidate's profile photo
│   └── logos/                        # Company/institution logos for experience & education
│       ├── fallback_image.png
│       ├── logo_citius.png
│       ├── logo_csm.png
│       ├── logo_usc.png
│       ├── logo_xunta.png
│       ├── logo-emais.png
│       └── sdweb_logo.png
├── .vscode/
│   ├── settings.json                 # Tinymist config: uses only local ./fonts/
│   └── extensions.json               # Recommends TOML extension
└── .gitignore                        # Ignores *.pdf
```

## Dependency Graph

```
main.typ
├── reads: metadata.toml              (style configuration)
├── reads: cv_data.toml               (content data)
└── imports: template/base.typ        (cv function)
    ├── imports: template/section.typ  (seccion function)
    └── imports: template/components/
        ├── header.typ                 → @preview/fontawesome:0.6.0 (external)
        │                              → img/profile-photo.jpeg
        ├── entity.typ                 → img/logos/*.png
        ├── education.typ              → img/logos/*.png
        ├── project.typ
        ├── skills.typ
        └── languages.typ
```

### External Dependencies

| Package | Version | Used In | Purpose |
|---|---|---|---|
| `@preview/fontawesome` | `0.6.0` | `header.typ` | Phone, envelope, and LinkedIn icons in the contact row |

This is the **only** external Typst package. It is fetched automatically by the Typst package manager on first compilation.

## Compilation Flow

```
1. main.typ loads metadata.toml (styles) and cv_data.toml (content)
2. Defines available languages: ("es", "en")
3. For each language:
   a. Merges shared config (styles) + shared data (personal_info base)
   b. Gets language-specific data (labels, experience, education, etc.)
   c. Deep-merges personal_info (shared name/photo + lang-specific position/summary)
   d. Produces final metadata dict = shared + lang-data + merged personal_info + lang + all_langs
   e. Calls cv(metadata, []) which renders all sections
   f. Inserts pagebreak between languages (not after the last one)
```

Each language variant gets a `#label("cv-<lang>")` anchor, enabling the interactive language selector in the header to link between variants within the same PDF.

## Section Rendering Order

Inside `base.typ`, sections are rendered in this fixed order:

1. **Header** -- photo, name, position, contact info, language selector
2. **Summary** -- italic paragraph (from `personal_info.summary`, rendered only if present)
3. **Experience** -- iterates `cv_data.experience` entries
4. **Education** -- iterates `cv_data.education` entries
5. *(pagebreak)*
6. **Projects** -- iterates `cv_data.projects` (wired up but no data populated yet)
7. **Skills** -- iterates `cv_data.skills` with categorized dot ratings
8. **Languages** -- iterates `cv_data.languages`

Each section is conditionally rendered: it only appears if its corresponding key exists in the data.

## Visual Theme

| Property | Value |
|---|---|
| Background | Warm parchment `#F5F0E6` |
| Primary color | Dark brown `#2B1B17` |
| Secondary color | Muted brown `#544e45` |
| Accent color | Deep red `#741e09` |
| Font | Courier New (monospace) |
| Section dividers | Dotted horizontal rules |
| Profile photo | Circular clip, 75pt |
| Icons | Font Awesome 7 (phone, envelope, LinkedIn) |

## Tooling

| Tool | Purpose |
|---|---|
| **Typst compiler** | `typst compile main.typ` to build the PDF |
| **VS Code + Tinymist** | IDE support with live preview; configured to use only `./fonts/` (no system fonts) |
| **even-better-toml** | VS Code extension for TOML editing (recommended in `.vscode/extensions.json`) |
| **Git** | Branch `migration_to_typst` -- project was migrated from another format to Typst |

## Key Design Decisions

- **Data-driven**: All content lives in TOML files. Templates never contain hardcoded text.
- **Multi-language at the core**: Languages are iterated in `main.typ`, not handled via conditional logic inside components. Components are language-agnostic.
- **Labels are localized**: UI strings (section titles, proficiency levels) come from `cv_data.toml` per language, not from template code.
- **Quiet mode**: Work experience entries can be flagged as `quiet = true` to render in gray (used for the musician period to show career continuity without visual emphasis).
- **No build script**: Compilation is done directly with the `typst` CLI. No Makefile or task runner.

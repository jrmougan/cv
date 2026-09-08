# Typst components

The CV uses local Geist fonts, an A4 single-column reading flow, and a white
background with charcoal text and a single blue accent. All content comes from `cv_data.toml`; presentation comes
from `metadata.toml` and the components below.

## Build

Run from the repository root with Typst and the bundled fonts:

```sh
# Default: Spanish, English, Galician in one document.
typst compile --ignore-system-fonts --font-path fonts main.typ /tmp/cv-all.pdf

# One language for an individual application.
typst compile --ignore-system-fonts --font-path fonts --input lang=es main.typ /tmp/cv-es.pdf
typst compile --ignore-system-fonts --font-path fonts --input lang=en main.typ /tmp/cv-en.pdf
typst compile --ignore-system-fonts --font-path fonts --input lang=gl main.typ /tmp/cv-gl.pdf
```

`lang=all` explicitly selects the default. Unsupported languages fail with an
explanatory assertion. The single-language PDF omits the language navigation;
the default document keeps internal ES / EN / GL links in the footer. With the current data,
the combined PDF has three pages and each separate PDF has one page. Content
flows naturally if future additions require more pages; it is never truncated
or automatically reduced to fit.

## Component reference

| Function | File | Behavior |
|---|---|---|
| `cv(cv_data, doc)` | `template/base.typ` | Configures A4, fonts, language, margins and a reserved footer; renders header, summary, experience, education, projects, skills and languages, followed by `doc`. |
| `header(metadata)` | `template/components/header.typ` | Prominent name and role, address and availability, linked phone/email/LinkedIn/optional GitHub/portfolio, and optional photograph. |
| `seccion(titulo, metadata)` | `template/section.typ` | Semantic level-one heading in spaced blue capitals; sticks to the following content and appears in the PDF outline. |
| `entity(item, metadata)` | `template/components/entity.typ` | Prominent role, secondary company, muted dates/location, description and bullets. Heading and introduction stay with following content; the task list can flow across pages. |
| `education_item(item, metadata)` | `template/components/education.typ` | Unbroken degree/institution entry with dates and optional description. |
| `project_item(item, metadata)` | `template/components/project.typ` | Unbroken project name, optional linked URL, description and tags. |
| `skill_tags(tags, metadata)` | `template/components/skills.typ` | Selectable technology names separated by middle dots; an individual name stays together. |
| `skills_section(groups, metadata)` | `template/components/skills.typ` | Renders `groups[].items[].name` unless `featured = false`, grouped by `cat` in source order. Uses translated category names; unknown categories keep their name. |
| `language_item(item, metadata)` | `template/components/languages.typ` | Inline language and proficiency pair. The parent keeps the short list together and lets pairs wrap between entries. |

## Data and layout details

- Body text uses `styles.fonts.base` (Geist), 10.5 pt with 0.6 em leading.
  The name uses 25 pt semibold, role 12 pt, experience roles 11 pt,
  company/degree names 9.5 pt, dates and skills 8.5 pt, and section headings
  9 pt semibold with letter spacing. Navigation also uses Geist.
- The CV sets `text.lang` for each language and disables automatic hyphenation
  to help copy/paste. Name and author are included in PDF document metadata.
- Margins are 1.6 cm horizontally, 1.35 cm above and 1.4 cm below. The
  reserved footer contains an absolute page number and, in multilingual
  documents, internal language links. It does not overlay the body.
- Contact links live in the header. LinkedIn and optional GitHub use short
  clickable labels; the portfolio domain stays visible. QR codes, company
  logos and per-entry technology lists are omitted from the CV.
- Skills use the existing `skills = [{ items: [{ name, cat, val }, ...] }]`
  shape. `val` remains accepted but is not presented as a subjective score.
  Optional `featured = false` hides a skill from the CV while retaining it in
  the full inventory; omitted `featured` defaults to true.
  `labels.skills` supplies the heading when present, with ES/EN/GL fallbacks.
- An experience item's legacy `quiet` flag is accepted but does not lower text
  contrast. All experience remains readable against the page background.
- Images resolve relative to their component: `../../` from components and
  `../` from the base template. No remote packages are required.
- The cover-letter template shares the header and base font. Its existing
  company selection and multilingual behavior remain available through
  `compile_letters.typ`.

## Verification

```sh
pdfinfo /tmp/cv-all.pdf
pdffonts /tmp/cv-all.pdf
pdftotext -layout /tmp/cv-all.pdf /tmp/cv-all.txt
pdftoppm -f 1 -singlefile -scale-to 1500 -png /tmp/cv-all.pdf /tmp/cv-preview
```

Review every language after editing content. Confirm complete contacts, roles,
dates, education, technology names and language levels in extracted text;
check that headings, dates and the reserved footer do not collide with body content.

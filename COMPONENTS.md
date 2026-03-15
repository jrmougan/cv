# Components Reference

This document describes every Typst function in the project: its signature, expected data, rendered output, and special behavior.

## Function Overview

| Function | File | Signature | Description |
|---|---|---|---|
| `cv` | `template/base.typ:9` | `cv(cv_data, doc)` | Main entry point. Sets up page and renders all sections in order. |
| `seccion` | `template/section.typ:1` | `seccion(titulo, metadata)` | Section heading with bold title + dotted horizontal rule. |
| `header` | `template/components/header.typ:9` | `header(metadata)` | Profile photo, name, position, contact row, language selector. |
| `personal_info` | `template/components/header.typ:3` | `personal_info(icon, content)` | Helper: icon + text inline pair (used internally by header). |
| `entity` | `template/components/entity.typ:1` | `entity(item, metadata)` | Work experience entry with logo, company, position, tasks. |
| `education_item` | `template/components/education.typ:1` | `education_item(item, metadata)` | Education entry with logo, institution, degree. |
| `project_item` | `template/components/project.typ:1` | `project_item(item, metadata)` | Project entry with name, URL link, description. |
| `skills_item` | `template/components/skills.typ:1` | `skills_item(item, metadata)` | Categorized skills grid with dot proficiency ratings. |
| `language_item` | `template/components/languages.typ:1` | `language_item(item, metadata)` | Spoken language with proficiency level. |

## Detailed Component Documentation

---

### `cv(cv_data, doc)` -- `template/base.typ:9`

**Purpose**: Main orchestrator function. Sets up the page and renders all CV sections.

**Parameters**:
- `cv_data` (dict): The merged metadata dictionary (see DATA_MODEL.md for full schema).
- `doc` (content): Unused content block. Passed as `[]` from `main.typ`. Exists as a legacy parameter from when this was a show-rule wrapper.

**Behavior**:
1. Extracts background color from `cv_data.styles.colors.background` (falls back to white).
2. Sets page: `fill: bg-color`, `margin: 1cm`.
3. Sets base text: fill from `colors.text`, font from `fonts.base`.
4. Creates a `#label("cv-<lang>")` anchor for cross-language linking.
5. Renders sections in order: header → summary → experience → education → *(pagebreak)* → projects → skills → languages.
6. Each section is **conditionally rendered** -- only if its key exists in `cv_data`.

---

### `seccion(titulo, metadata)` -- `template/section.typ:1`

**Purpose**: Renders a section heading.

**Parameters**:
- `titulo` (string): The section title text (comes from `cv_data.labels.<section>`).
- `metadata` (dict): Full metadata dict (used for styles).

**Rendered Output**:
```
  [bold, 16pt, primary color] Section Title
  ............................................  (dotted line, full width)
```

**Styling Used**: `sizes.section_title`, `colors.primary`.

---

### `header(metadata)` -- `template/components/header.typ:9`

**Purpose**: Renders the CV header with personal information and navigation.

**Parameters**:
- `metadata` (dict): Full metadata dict.

**Layout**: Two-column grid (`auto`, `1fr`):
- **Left column**: Circular-clipped profile photo (75pt height, 50% border radius).
- **Right column** (right-aligned):
  - Name: bold/black weight, `sizes.header_name`, `colors.primary`.
  - Position: italic, `sizes.header_position`, `colors.secondary`, 1pt tracking, wrapped in `<position />` syntax.
  - Address: italic, `sizes.normal`.
  - Contact row: Phone | Email | LinkedIn (with Font Awesome icons via `fa-phone()`, `fa-envelope()`, `fa-linkedin()`). LinkedIn is rendered as a clickable link.
  - Language selector: Shows all languages from `metadata.all_langs`. Current language is bold/primary; others are clickable links pointing to `label("cv-<lang>")`.

**External Dependencies**: `@preview/fontawesome:0.6.0`.

**Data Used**: `personal_info.{name, photo, position, contact.{address, phone, email, link}}`, `all_langs`, `lang`.

---

### `entity(item, metadata)` -- `template/components/entity.typ:1`

**Purpose**: Renders a single work experience entry.

**Parameters**:
- `item` (dict): A single experience entry from `cv_data.experience`.
- `metadata` (dict): Full metadata dict.

**Layout**: Three-column grid (`auto`, `1fr`, `auto`):
- **Column 1**: Company logo (22pt height, 2pt border radius). Falls back to empty space if no logo.
- **Column 2**: Company name (bold, `item_h1`) + position (italic, `item_h2`).
- **Column 3**: Location (`item_h3`, accent color) + date (italic, `item_h3`).
- **Below grid**: Description text + bulleted task list.

**Special Behavior -- Quiet Mode**:
When `item.quiet == true`, all colors are overridden to grays:
- `primary_color` → `#aaaaaa`
- `secondary_color` → `#bbbbbb`
- `accent_color` → `#aaaaaa`
- `text_color` → `#bbbbbb`

This is used for the musician/teacher period to show career continuity without visual emphasis.

**Expected `item` Fields**:

| Field | Required | Type | Notes |
|---|---|---|---|
| `company` | yes | string | |
| `position` | yes | string | |
| `date` | yes | string | Free-text date range |
| `description` | yes | string | |
| `logo` | no | string | Relative path to logo image |
| `location` | no | string | |
| `tasks` | no | string[] | Rendered as bullet points |
| `quiet` | no | bool | Enables grayed-out rendering |

---

### `education_item(item, metadata)` -- `template/components/education.typ:1`

**Purpose**: Renders a single education entry.

**Parameters**:
- `item` (dict): A single education entry from `cv_data.education`.
- `metadata` (dict): Full metadata dict.

**Layout**: Three-column grid (`auto`, `1fr`, `auto`):
- **Column 1**: Institution logo (22pt height). Hidden if not provided.
- **Column 2**: Institution name (bold, `item_h1`) + degree (italic, `item_h2`).
- **Column 3**: Location (`item_h3`, accent color) + date (italic, `item_h3`).
- **Below grid**: Optional description text (only if non-empty).

**Expected `item` Fields**:

| Field | Required | Type | Notes |
|---|---|---|---|
| `institution` | yes | string | |
| `degree` | yes | string | |
| `date` | yes | string | Free-text date range |
| `logo` | no | string | Relative path to logo image |
| `location` | no | string | |
| `description` | no | string | Only rendered if non-empty |

---

### `project_item(item, metadata)` -- `template/components/project.typ:1`

**Purpose**: Renders a single project entry.

**Parameters**:
- `item` (dict): A single project entry from `cv_data.projects`.
- `metadata` (dict): Full metadata dict.

**Layout**: Two-column grid (`1fr`, `auto`):
- **Left**: Project name (bold, `item_h1`).
- **Right**: URL as a clickable link (italic, accent color). Hidden if no URL.
- **Below**: Description text.

**Note**: This component is wired up in `base.typ` but no project data currently exists in `cv_data.toml`.

**Expected `item` Fields**:

| Field | Required | Type | Notes |
|---|---|---|---|
| `name` | yes | string | |
| `description` | yes | string | |
| `url` | no | string | Rendered as clickable link |

---

### `skills_item(item, metadata)` -- `template/components/skills.typ:1`

**Purpose**: Renders the full skills section with a legend and categorized skill grid.

**Parameters**:
- `item` (dict): A single skills entry from `cv_data.skills` (contains an `items` array).
- `metadata` (dict): Full metadata dict.

**Layout**:

1. **Legend bar**: Shows proficiency levels with dot indicators:
   - `Expert ●●●` | `Proficient ●●○` | `Basic ●○○`
   - Labels come from `metadata.labels.{expert, proficient, basic}`.

2. **Category groups**: Iterates over 5 categories in fixed order:
   `frontend` → `backend` → `data` → `tools` → `others`

   For each category:
   - Category name as header (capitalized, bold, `item_h3`).
   - 4-column grid of skills, sorted by `val` descending.
   - Each skill: `Name ●●●` colored by category color from `metadata.styles.colors.categories.<cat>`.

**Proficiency Mapping**:

| Value | Dots | Level |
|---|---|---|
| `val >= 9` | ●●● | Expert |
| `val >= 6` | ●●○ | Proficient |
| `val < 6` | ●○○ | Basic |

**Expected `item` Fields**:
- `items` (array): Each element has `{ name: string, val: int(1-10), cat: string }`.

---

### `language_item(item, metadata)` -- `template/components/languages.typ:1`

**Purpose**: Renders a single spoken language entry.

**Parameters**:
- `item` (dict): A single language entry from `cv_data.languages`.
- `metadata` (dict): Full metadata dict.

**Layout**: Two-column grid (`12%`, `1fr`):
- **Left**: Language name (bold, right-aligned, `sizes.normal`).
- **Right**: Proficiency level (`sizes.normal`).

**Expected `item` Fields**:

| Field | Required | Type |
|---|---|---|
| `language` | yes | string |
| `level` | yes | string |

---

## Component Conventions

All components in this project follow these conventions:

1. **Signature pattern**: `(item, metadata)` for content components; `(metadata)` for the header; `(titulo, metadata)` for section headings.
2. **Metadata access**: Components access styles via `metadata.styles.{fonts, sizes, colors}`. Sizes are strings that must be passed through `eval()`.
3. **Color access**: Always via `rgb(metadata.styles.colors.<key>)`.
4. **Conditional fields**: Components check for optional fields with `"field" in item and item.field != ""` before rendering.
5. **Image paths**: Logos and photos are referenced relative to the component file location, prefixed with `../../` (since components are in `template/components/`).
6. **No hardcoded text**: All user-facing strings come from `metadata.labels` or from the data itself.

## How to Create a New Component

1. Create a new file `template/components/<name>.typ`.

2. Define your function following the convention:
   ```typst
   #let my_component = (item, metadata) => [
     // Access styles
     #let size = eval(metadata.styles.sizes.normal)
     #let color = rgb(metadata.styles.colors.primary)

     // Render content
     #text(size: size, fill: color)[#item.title]
   ]
   ```

3. Import it in `template/base.typ`:
   ```typst
   #import "components/<name>.typ": my_component
   ```

4. Add a rendering block in the `cv` function body:
   ```typst
   if "<section_key>" in cv_data {
     seccion(cv_data.labels.<section_key>, cv_data)
     for item in cv_data.<section_key> {
       my_component(item, cv_data)
     }
   }
   ```

5. Add data to `cv_data.toml` under each language block, and add a label for the section title.

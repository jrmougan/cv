# Data Model

This document describes the data schemas, merge logic, and the final data structure that flows through the project.

## Source Files

| File | Role |
|---|---|
| `cv_data.toml` | All CV content: shared personal info + per-language sections (labels, experience, education, skills, languages) |
| `metadata.toml` | Style/theme configuration: fonts, font sizes, colors, skill category colors |

## metadata.toml Schema

```toml
[config]
default_language = "es"             # string: default language code

[shared.styles.fonts]
base = ["Courier New"]              # string[]: font family stack

[shared.styles.sizes]
header_name = "25pt"                # string (evaluable): name in header
header_position = "10pt"            # string (evaluable): position subtitle
normal = "7pt"                      # string (evaluable): body text
item_h1 = "10pt"                    # string (evaluable): entity/education title
item_h2 = "8pt"                     # string (evaluable): entity/education subtitle
item_h3 = "8pt"                     # string (evaluable): location/date text
section_title = "16pt"              # string (evaluable): section heading

[shared.styles.colors]
background = "#F5F0E6"              # string: page background
primary = "#2B1B17"                 # string: headings, name, section titles
secondary = "#544e45"               # string: subtitles, dates, separators
accent = "#741e09ff"                # string: location text, links
text = "#2B1B17"                    # string: body text

[shared.styles.colors.categories]   # Per-skill-category colors
frontend = "#2e8b97ff"
backend = "#e07a5f"
tools = "#3d405b"
data = "#81b29a"
others = "#3d405b"
test = "#3d405b"
```

> **Note**: All size values are strings like `"7pt"` that get passed to Typst's `eval()` at runtime. This allows dynamic size resolution from TOML data.

## cv_data.toml Schema

### Shared Section

```toml
[shared.personal_info]
name = "string"                     # Full name (language-independent)
photo = "string"                    # Relative path to profile photo

[shared.personal_info.contact]
email = "string"                    # Email address
phone = "string"                    # Phone number
address = "string"                  # Physical address
link = "string"                     # LinkedIn URL (without https://)
```

### Per-Language Sections (`[es]`, `[en]`, etc.)

#### Labels

```toml
[<lang>.labels]
location = "string"                 # UI label for "Location"
phone = "string"                    # UI label for "Phone"
email = "string"                    # UI label for "Email"
education = "string"                # Section title for education
experience = "string"               # Section title for experience
projects = "string"                 # Section title for projects
skills = "string"                   # Section title for skills
languages = "string"                # Section title for languages
present = "string"                  # Word for "Present" in date ranges
expert = "string"                   # Skill proficiency label: expert
proficient = "string"               # Skill proficiency label: proficient
basic = "string"                    # Skill proficiency label: basic
```

#### Personal Info (language-specific overrides)

```toml
[<lang>.personal_info]
position = "string"                 # Job title (localized)
summary = "string"                  # Professional summary paragraph (localized)
```

#### Experience Entries

```toml
[[<lang>.experience]]
company = "string"                  # Company name
logo = "string"                     # (optional) Relative path to company logo
position = "string"                 # Job title at this company
location = "string"                 # Work location
date = "string"                     # Date range (free text)
description = "string"              # Brief description of the role
tasks = ["string"]                  # List of key responsibilities/achievements
quiet = false                       # (optional, default false) If true, entry renders grayed out
```

#### Education Entries

```toml
[[<lang>.education]]
institution = "string"              # Institution name
logo = "string"                     # (optional) Relative path to institution logo
degree = "string"                   # Degree or certification name
location = "string"                 # Institution location
date = "string"                     # Date range (free text)
description = "string"              # (optional) Additional details
```

#### Project Entries

```toml
[[<lang>.projects]]                 # Currently not populated in the data
name = "string"                     # Project name
url = "string"                      # (optional) Project URL
description = "string"              # Project description
```

#### Skills

```toml
[[<lang>.skills]]
items = [
  { name = "string", val = 0, cat = "string" }
]
```

| Field | Type | Description |
|---|---|---|
| `name` | string | Skill name displayed in the grid |
| `val` | int (1-10) | Proficiency value. Mapped to dots: `>=9` → ●●● (expert), `>=6` → ●●○ (proficient), `<6` → ●○○ (basic) |
| `cat` | string | Category key: `"frontend"`, `"backend"`, `"data"`, `"tools"`, `"others"` |

#### Spoken Languages

```toml
[[<lang>.languages]]
language = "string"                 # Language name
level = "string"                    # Proficiency level (free text)
```

## Data Merge Logic

The merge happens in `main.typ` (lines 9-19) for each language iteration:

```
Step 1: shared = config.shared + data.shared
         ↳ Combines styles (from metadata.toml) with shared personal_info (from cv_data.toml)

Step 2: lang-data = data.<lang>
         ↳ Gets language-specific block (labels, personal_info overrides, experience, etc.)

Step 3: personal_info = shared.personal_info + lang-data.personal_info
         ↳ Deep merge: shared provides name/photo/contact, lang provides position/summary
         ↳ Lang-specific keys OVERRIDE shared keys if there's a conflict

Step 4: metadata = shared + lang-data + { personal_info, lang, all_langs }
         ↳ Final dict: all shared data + all lang data + corrected personal_info + language context
         ↳ The personal_info override in step 3 is necessary because the simple + merge
           in step 4 would otherwise overwrite the entire shared personal_info with the
           lang-specific one (which lacks name/photo/contact)
```

## Final `cv_data` Dictionary

This is the structure every component receives as its `metadata` parameter:

```
{
  // Language context
  lang: "es" | "en",                        // Current language code
  all_langs: ("es", "en"),                   // All available languages (for selector)

  // Styles (from metadata.toml)
  styles: {
    fonts: { base: ["Courier New"] },
    sizes: {
      header_name, header_position, normal,
      item_h1, item_h2, item_h3, section_title
    },
    colors: {
      background, primary, secondary, accent, text,
      categories: { frontend, backend, tools, data, others, test }
    },
  },

  // Localized UI labels
  labels: {
    location, phone, email, education, experience,
    projects, skills, languages, present,
    expert, proficient, basic
  },

  // Personal information (merged shared + lang)
  personal_info: {
    name: "string",                          // From shared
    photo: "string",                         // From shared
    position: "string",                      // From lang
    summary: "string",                       // From lang
    contact: {                               // From shared
      email, phone, address, link
    }
  },

  // Content arrays (from lang-specific data)
  experience: [ { company, logo?, position, location, date, description, tasks, quiet? } ],
  education: [ { institution, logo?, degree, location, date, description? } ],
  projects: [ { name, url?, description } ],     // Wired up but currently empty
  skills: [ { items: [ { name, val, cat } ] } ],
  languages: [ { language, level } ],
}
```

## How-To Guides

### Add a New Language

1. In `cv_data.toml`, add a new `[<lang>]` block (e.g., `[fr]`) with all required sub-sections: `labels`, `personal_info`, `experience`, `education`, `skills`, `languages`.
2. In `main.typ`, add the language code to the `langs` tuple:
   ```typst
   #let langs = ("es", "en", "fr")
   ```
3. That's it. The merge logic and components are language-agnostic.

### Add a New CV Section

1. Create a component file in `template/components/` (e.g., `certifications.typ`).
2. Define your rendering function following the `(item, metadata)` signature convention.
3. In `template/base.typ`:
   - Import the new component at the top.
   - Add a conditional rendering block (following the existing pattern):
     ```typst
     if "certifications" in cv_data {
       seccion(cv_data.labels.certifications, cv_data)
       for item in cv_data.certifications {
         certification_item(item, cv_data)
       }
     }
     ```
4. In `cv_data.toml`, add the data under each language block and a label in `labels`.
5. Optionally add a label entry for the section title in each `[<lang>.labels]` block.

### Modify Styles

All visual styling is controlled from `metadata.toml`:
- **Change fonts**: Edit `shared.styles.fonts.base`
- **Change sizes**: Edit any value under `shared.styles.sizes` (must be valid Typst size strings like `"10pt"`)
- **Change colors**: Edit any value under `shared.styles.colors` (hex color strings, optionally with alpha)
- **Change skill category colors**: Edit `shared.styles.colors.categories.<category>`

No `.typ` files need to be modified for style changes.

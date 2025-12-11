#import "template/base.typ": cv
#let config = toml("metadata.toml")
#let data = toml("cv_data.toml")

// Define available languages
#let langs = ("es", "en")

// Iterate over languages and render them sequentially
#for lang in langs {
  // Prepare data
  // Merge shared configuration (styles) and shared content (personal info)
  let shared = config.at("shared", default: (:)) + data.at("shared", default: (:))
  let lang-data = data.at(lang, default: (:))

  // Merge specific complex objects that are split between shared and language
  let personal_info = shared.at("personal_info", default: (:)) + lang-data.at("personal_info", default: (:))

  // Final metadata is shared + language + merged override + all_langs
  let metadata = shared + lang-data + (personal_info: personal_info, lang: lang, all_langs: langs)

  // Use the cv function to generate content
  // We pass empty content [] as the 'doc' because we are not using it as a show rule wrapper anymore
  cv(metadata, [])

  // Add a pagebreak between languages, but not after the last one
  if lang != langs.last() {
    pagebreak()
  }
}

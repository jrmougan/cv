#import "template/cover_letter_base.typ": cover_letter_cv

#let config = toml("metadata.toml")
#let data = toml("cv_data.toml")

// The company TOML to use, passed via --sys-inputs company=name
// Default to 'example' if not provided
#let company_name = sys.inputs.at("company", default: "example")
#let letter_path = "letters/" + company_name + ".toml"
#let letter_data = toml(letter_path)

// Define available languages (from the letter data keys)
#let langs = ("es", "en", "gl")

#for lang in langs {
  if lang in letter_data {
    // Prepare metadata (same logic as main.typ)
    let shared = config.at("shared", default: (:)) + data.at("shared", default: (:))
    let lang-data = data.at(lang, default: (:))
    let personal_info = shared.at("personal_info", default: (:)) + lang-data.at("personal_info", default: (:))
    let metadata = shared + lang-data + (personal_info: personal_info, lang: lang, all_langs: langs)

    // Merge shared letter data with language-specific data
    let letter_shared = letter_data.at("shared", default: (:))
    let letter_lang = letter_shared + letter_data.at(lang)

    // Render the cover letter for this language
    cover_letter_cv(metadata, letter_lang)

    // Add a pagebreak between languages in the same PDF
    if lang != langs.last() {
      pagebreak()
    }
  }
}

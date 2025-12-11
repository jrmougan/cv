#import "template/base.typ": cv
#let config = toml("metadata.toml")
#let data = toml("cv_data.toml")

// Select language: External var > Config > Default "es"
#let lang = if sys.inputs.keys().contains("lang") {
  sys.inputs.lang
} else if "config" in config and "default_language" in config.config {
  config.config.default_language
} else {
  "es"
}

// Prepare data
// Merge shared configuration (styles) and shared content (personal info)
#let shared = config.at("shared", default: (:)) + data.at("shared", default: (:))
#let lang-data = data.at(lang, default: (:))

// Merge specific complex objects that are split between shared and language
#let personal_info = shared.at("personal_info", default: (:)) + lang-data.at("personal_info", default: (:))

// Final metadata is shared + language + merged override
#let metadata = shared + lang-data + (personal_info: personal_info)

#show: cv.with(
  metadata,
);

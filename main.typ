#import "template/base.typ": cv
#let toml-data = toml("metadata.toml")

// Select language: External var > Config > Default "es"
#let lang = if sys.inputs.keys().contains("lang") {
  sys.inputs.lang
} else if "config" in toml-data and "default_language" in toml-data.config {
  toml-data.config.default_language
} else {
  "es"
}

// Prepare data
#let shared = toml-data.at("shared", default: (:))
#let lang-data = toml-data.at(lang, default: (:))

// Merge specific complex objects that are split between shared and language
#let personal_info = shared.at("personal_info", default: (:)) + lang-data.at("personal_info", default: (:))

// Final metadata is shared + language + merged override
#let metadata = shared + lang-data + (personal_info: personal_info)

#show: cv.with(
  metadata,
  profilePhoto: image("img/profile-photo.png"),
);

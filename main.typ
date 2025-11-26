#import "template/base.typ": cv
#let metadata = toml("metadata.toml")

#show: cv.with(
  metadata,
  profilePhoto: image("img/profile-photo.png"),
);

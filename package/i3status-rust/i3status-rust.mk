################################################################################
#
# i3status-rust
#
################################################################################

I3STATUS_RUST_VERSION = v0.33.0
I3STATUS_RUST_SITE = $(call github,greshake,i3status-rust,$(I3STATUS_RUST_VERSION))
I3STATUS_RUST_LICENSE = GPL3
I3STATUS_RUST_LICENSE_FILES = LICENSE
I3STATUS_RUST_DEPENDENCIES += alsa-utils upower lm-sensors
I3STATUS_RUST_CARGO_BUILD_OPTS += --no-default-features

$(eval $(cargo-package))

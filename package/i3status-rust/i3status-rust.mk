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

define I3STATUS_RUST_INSTALL_TARGET_CMDS
	# TODO fix path
    $(INSTALL) -D -m 0755 -t $(TARGET_DIR)/usr/bin $(@D)/target/aarch64-unknown-linux-gnu/release/i3status-rs

	# use $(INSTALL)
	mkdir -p $(TARGET_DIR)/usr/share/i3status-rust
	cp -rv $(@D)/files/icons $(TARGET_DIR)/usr/share/i3status-rust/
	cp -rv $(@D)/files/themes $(TARGET_DIR)/usr/share/i3status-rust/
endef

$(eval $(cargo-package))

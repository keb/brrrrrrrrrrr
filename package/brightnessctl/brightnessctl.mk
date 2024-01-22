################################################################################
#
# brightnessctl
#
################################################################################

BRIGHTNESSCTL_VERSION = 0.5.1
BRIGHTNESSCTL_SITE = https://github.com/Hummer12007/brightnessctl
BRIGHTNESSCTL_SITE_METHOD = git
BRIGHTNESSCTL_LICENSE = MIT
BRIGHTNESSCTL_LICENSE_FILES = LICENSE

define BRIGHTNESSCTL_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) CFLAGS="$(TARGET_CFLAGS) -D'VERSION=\"$(BRIGHTNESSCTL_VERSION)\"'" -C $(@D)
endef

define BRIGHTNESSCTL_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/brightnessctl $(TARGET_DIR)/usr/bin/brightnessctl
endef

$(eval $(generic-package))

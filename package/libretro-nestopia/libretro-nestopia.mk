################################################################################
#
# NESTOPIA
#
################################################################################

LIBRETRO_NESTOPIA_VERSION = 2cef539e0df9ae5c8e6adf830a37f5d122bf5f05
LIBRETRO_NESTOPIA_SITE = $(call github,libretro,nestopia,$(LIBRETRO_NESTOPIA_VERSION))
LIBRETRO_NESTOPIA_LICENSE = GPL-2.0
LIBRETRO_NESTOPIA_LICENSE_FILES = COPYING

define LIBRETRO_NESTOPIA_BUILD_CMDS
	# -O2 is faster
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) CFLAGS="$(TARGET_CFLAGS) -fno-lto" CXXFLAGS="$(TARGET_CXXFLAGS) -fno-lto" $(MAKE) -C $(@D)/libretro
endef

define LIBRETRO_NESTOPIA_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/libretro/nestopia_libretro.so $(TARGET_DIR)/usr/lib/libretro/nestopia_libretro.so
endef

$(eval $(generic-package))

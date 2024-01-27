################################################################################
#
# libretro-atari800
#
################################################################################

LIBRETRO_ATARI800_VERSION = 410d7bf0c215f3444793a9cec51c129e7b67c400
LIBRETRO_ATARI800_SITE = $(call github,libretro,libretro-atari800,$(LIBRETRO_ATARI800_VERSION))
LIBRETRO_ATARI800_LICENSE = MPL-2.0
LIBRETRO_ATARI800_LICENSE_FILES = LICENSE

define LIBRETRO_ATARI800_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) CFLAGS="$(TARGET_CFLAGS) -fno-lto" CXXFLAGS="$(TARGET_CXXFLAGS) -fno-lto" $(MAKE) -C $(@D)
endef

define LIBRETRO_ATARI800_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/atari800_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/atari800_libretro.so
endef

$(eval $(generic-package))

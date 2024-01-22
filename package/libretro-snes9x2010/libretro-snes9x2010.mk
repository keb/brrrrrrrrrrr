################################################################################
#
# SNES9X2010
#
################################################################################

LIBRETRO_SNES9X2010_VERSION = d8b10c4cd7606ed58f9c562864c986bc960faaaf
LIBRETRO_SNES9X2010_SITE = $(call github,libretro,snes9x2010,$(LIBRETRO_SNES9X2010_VERSION))
LIBRETRO_SNES9X2010_LICENSE = COPYRIGHT
LIBRETRO_SNES9X2010_LICENSE_FILES = LICENSE
LIBRETRO_SNES9X2010_NON_COMMERCIAL = y

define LIBRETRO_SNES9X2010_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define LIBRETRO_SNES9X2010_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/snes9x2010_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/snes9x2010_libretro.so
endef

$(eval $(generic-package))

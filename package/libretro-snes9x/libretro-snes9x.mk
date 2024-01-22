################################################################################
#
# SNES9X
#
################################################################################

LIBRETRO_SNES9X_VERSION = f0001ab42866d8088fcffcc41c89c4e7513a6212
LIBRETRO_SNES9X_SITE = $(call github,snes9xgit,snes9x,$(LIBRETRO_SNES9X_VERSION))
#LIBRETRO_SNES9X_SITE = $(call github,libretro,snes9x,$(LIBRETRO_SNES9X_VERSION))
LIBRETRO_SNES9X_LICENSE = COPYRIGHT
LIBRETRO_SNES9X_LICENSE_FILES = LICENSE
LIBRETRO_SNES9X_NON_COMMERCIAL = y

define LIBRETRO_SNES9X_BUILD_CMDS
	$(SED) "s|-O3|-O2|g" $(@D)/libretro/Makefile
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/libretro
endef

define LIBRETRO_SNES9X_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/libretro/snes9x_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/snes9x_libretro.so
endef

$(eval $(generic-package))

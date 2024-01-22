################################################################################
#
# libretro-hatari
#
################################################################################

LIBRETRO_HATARI_VERSION = a4c9eb0bb79e47a2870c12b04566c1f8d25e4bf3
LIBRETRO_HATARI_SITE = $(call github,libretro,hatari,$(LIBRETRO_HATARI_VERSION))
LIBRETRO_HATARI_LICENSE = MPL-2.0
LIBRETRO_HATARI_LICENSE_FILES = LICENSE

define LIBRETRO_HATARI_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) -f Makefile.libretro
endef

define LIBRETRO_HATARI_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/hatari_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/hatari_libretro.so
endef

$(eval $(generic-package))

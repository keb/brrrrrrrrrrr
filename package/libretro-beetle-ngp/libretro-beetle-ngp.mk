################################################################################
#
# libretro-beetle-ngp
#
################################################################################

LIBRETRO_BEETLE_NGP_VERSION = 673c3d924ff33d71c6a342b170eff5359244df1f
LIBRETRO_BEETLE_NGP_SITE = $(call github,libretro,beetle-ngp-libretro,$(LIBRETRO_BEETLE_NGP_VERSION))
LIBRETRO_BEETLE_NGP_LICENSE = MPL-2.0
LIBRETRO_BEETLE_NGP_LICENSE_FILES = LICENSE

define LIBRETRO_BEETLE_NGP_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(LTO_FLAGS) $(MAKE) -C $(@D)
endef

define LIBRETRO_BEETLE_NGP_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mednafen_ngp_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mednafen_ngp_libretro.so
endef

$(eval $(generic-package))

################################################################################
#
# libretro-picodrive
#
################################################################################

LIBRETRO_PICODRIVE_VERSION = d907d65692a45e126d0c7d6685cc8792b52bc577
LIBRETRO_PICODRIVE_SITE = https://github.com/libretro/picodrive
LIBRETRO_PICODRIVE_LICENSE = COPYRIGHT
LIBRETRO_PICODRIVE_LICENSE_FILES = COPYING
LIBRETRO_PICODRIVE_NON_COMMERCIAL = y
LIBRETRO_PICODRIVE_GIT_SUBMODULES=y
LIBRETRO_PICODRIVE_SITE_METHOD=git

define LIBRETRO_PICODRIVE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(LTO_FLAGS) $(MAKE) -C $(@D) -f Makefile.libretro platform=aarch64
endef

define LIBRETRO_PICODRIVE_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/picodrive_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/picodrive_libretro.so
endef

$(eval $(generic-package))

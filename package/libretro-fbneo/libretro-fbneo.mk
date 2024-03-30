################################################################################
#
# FBNEO
#
################################################################################

LIBRETRO_FBNEO_VERSION = bd746271f5a77bfcb31851eacc18488d8f488e1c
LIBRETRO_FBNEO_SITE = $(call github,libretro,FBNeo,$(LIBRETRO_FBNEO_VERSION))
LIBRETRO_FBNEO_LICENSE = COPYRIGHT
LIBRETRO_FBNEO_DEPENDENCIES = libzlib
LIBRETRO_FBNEO_LICENSE_FILES = LICENSE.md
LIBRETRO_FBNEO_NON_COMMERCIAL = y

define LIBRETRO_FBNEO_BUILD_CMDS
	#$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/src/burner/libretro generate-files
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(LTO_FLAGS) $(MAKE) -C $(@D)/src/burner/libretro EXTERNAL_ZLIB=1 INCLUDE_AVI_RECORDING=0 generate-files all
endef

define LIBRETRO_FBNEO_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/src/burner/libretro/fbneo_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/fbneo_libretro.so
endef

$(eval $(generic-package))

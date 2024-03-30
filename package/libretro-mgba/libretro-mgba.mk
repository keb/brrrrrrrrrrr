################################################################################
#
# MGBA
#
################################################################################

LIBRETRO_MGBA_VERSION = 314bf7b676f5b820f396209eb0c7d6fbe8103486
LIBRETRO_MGBA_SITE = $(call github,libretro,mgba,$(LIBRETRO_MGBA_VERSION))
LIBRETRO_MGBA_LICENSE = MPL-2.0
LIBRETRO_MGBA_LICENSE_FILES = LICENSE

define LIBRETRO_MGBA_BUILD_CMDS
	#$(SED) "s|-O2|-O3|g" $(@D)/Makefile.libretro
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(LTO_FLAGS) $(MAKE) -C $(@D) -f Makefile.libretro
endef

define LIBRETRO_MGBA_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mgba_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mgba_libretro.so
endef

$(eval $(generic-package))

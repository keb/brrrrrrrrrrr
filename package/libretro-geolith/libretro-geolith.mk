################################################################################
#
# GEOLITH
#
################################################################################

LIBRETRO_GEOLITH_VERSION = 38d3454ab4419f2be840d90400e66c596795d5c9
LIBRETRO_GEOLITH_SITE = $(call github,libretro,geolith-libretro,$(LIBRETRO_GEOLITH_VERSION))
LIBRETRO_GEOLITH_LICENSE = BSD-3-Clause
LIBRETRO_GEOLITH_LICENSE_FILES = LICENSE

define LIBRETRO_GEOLITH_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(LTO_FLAGS) $(MAKE) -C $(@D)/libretro
endef

define LIBRETRO_GEOLITH_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/libretro/geolith_libretro.so $(TARGET_DIR)/usr/lib/libretro/geolith_libretro.so
endef

$(eval $(generic-package))

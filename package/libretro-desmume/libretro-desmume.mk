################################################################################
#
# DESMUME
#
################################################################################

LIBRETRO_DESMUME_VERSION = 4ee1bb1d6a6c9695baea49d0c2dff34c10187502
LIBRETRO_DESMUME_SITE = $(call github,libretro,desmume,$(LIBRETRO_DESMUME_VERSION))
LIBRETRO_DESMUME_DEPENDENCIES = libpcap
LIBRETRO_DESMUME_LICENSE = GPL-2.0+
LIBRETRO_DESMUME_LICENSE_FILES = license.txt

define LIBRETRO_DESMUME_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) platform=linux-nogl -C $(@D)/desmume/src/frontend/libretro
endef

define LIBRETRO_DESMUME_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/desmume/src/frontend/libretro/desmume_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/desmume_libretro.so
endef

$(eval $(generic-package))

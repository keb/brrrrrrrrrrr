################################################################################
#
# LIBRETRO CORE INFO
#
################################################################################

LIBRETRO_CORE_INFO_VERSION = 63fc405d19f64b6559fe6428e719756a7979e596
LIBRETRO_CORE_INFO_SITE = $(call github,libretro,libretro-core-info,$(LIBRETRO_CORE_INFO_VERSION))
LIBRETRO_CORE_INFO_LICENSE = GPL-2.0
LIBRETRO_CORE_INFO_LICENSE_FILES = COPYING

define LIBRETRO_CORE_INFO_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/libretro/info
	cp $(@D)/*.info $(TARGET_DIR)/usr/share/libretro/info/
endef

$(eval $(generic-package))

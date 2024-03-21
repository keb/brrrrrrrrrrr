################################################################################
#
# LIBRETRO CORE INFO
#
################################################################################

LIBRETRO_CORE_INFO_VERSION = dab6fd87f661ce306bb867e9cd10f14dd40c10e9
LIBRETRO_CORE_INFO_SITE = $(call github,libretro,libretro-core-info,$(LIBRETRO_CORE_INFO_VERSION))
LIBRETRO_CORE_INFO_LICENSE = GPL-2.0
LIBRETRO_CORE_INFO_LICENSE_FILES = COPYING

define LIBRETRO_CORE_INFO_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/libretro/info
	cp $(@D)/*.info $(TARGET_DIR)/usr/share/libretro/info/
endef

$(eval $(generic-package))

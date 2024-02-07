################################################################################
#
# LIBRETRO ASSETS OZONE
#
################################################################################

LIBRETRO_ASSETS_OZONE_VERSION = 923b711dc6772a168d83dc8915e9260730fcf3a1
LIBRETRO_ASSETS_OZONE_SITE = $(call github,libretro,retroarch-assets,$(LIBRETRO_ASSETS_OZONE_VERSION))
LIBRETRO_ASSETS_OZONE_LICENSE = GPL-2.0
LIBRETRO_ASSETS_OZONE_LICENSE_FILES = COPYING

define LIBRETRO_ASSETS_OZONE_INSTALL_TARGET_CMDS
	$(INSTALL) -dm 755 "${TARGET_DIR}"/usr/share/retroarch/assets
	cp -dr --no-preserve=ownership $(@D)/ozone "${TARGET_DIR}"/usr/share/retroarch/assets/

	# need monochrome icons
	$(INSTALL) -dm 755 "${TARGET_DIR}"/usr/share/retroarch/assets/xmb
	cp -dr --no-preserve=ownership $(@D)/xmb/monochrome "${TARGET_DIR}"/usr/share/retroarch/assets/xmb/
endef

$(eval $(generic-package))

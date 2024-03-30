################################################################################
#
# GENESIS-PLUS-GX
#
################################################################################

LIBRETRO_GENESISPLUSGX_VERSION = 3b85b2496275e1e308544eaf18150a472f943ad1
LIBRETRO_GENESISPLUSGX_SITE = $(call github,libretro,Genesis-Plus-GX,$(LIBRETRO_GENESISPLUSGX_VERSION))
LIBRETRO_GENESISPLUSGX_LICENSE = COPYRIGHT
LIBRETRO_GENESISPLUSGX_LICENSE_FILES = LICENSE.txt
LIBRETRO_GENESISPLUSGX_NON_COMMERCIAL = y

define LIBRETRO_GENESISPLUSGX_BUILD_CMDS
	#$(SED) "s|-O2|-O3|g" $(@D)/Makefile.libretro
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(LTO_FLAGS) $(MAKE) -C $(@D) -f Makefile.libretro
endef

define LIBRETRO_GENESISPLUSGX_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/genesis_plus_gx_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/genesis_plus_gx_libretro.so
endef

$(eval $(generic-package))

################################################################################
#
# MAME2003_PLUS
#
################################################################################

LIBRETRO_MAME2003_PLUS_VERSION = c76d6ea5bbcbb5d2862414544babf95360bfbd99
LIBRETRO_MAME2003_PLUS_SITE = $(call github,libretro,mame2003-plus-libretro,$(LIBRETRO_MAME2003_PLUS_VERSION))
LIBRETRO_MAME2003_PLUS_LICENSE = MAME
LIBRETRO_MAME2003_PLUS_NON_COMMERCIAL = y

define LIBRETRO_MAME2003_PLUS_BUILD_CMDS
	#$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	mkdir -p $(@D)/obj/mame/cpu/ccpu
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(LTO_FLAGS) $(MAKE) -C $(@D)
endef

define LIBRETRO_MAME2003_PLUS_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mame2003_plus_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mame2003_plus_libretro.so
endef

$(eval $(generic-package))

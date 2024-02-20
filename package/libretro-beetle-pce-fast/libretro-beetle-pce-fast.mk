################################################################################
#
# libretro-beetle-pce-fast
#
################################################################################
# Version: Commits on Feb 16, 2024
LIBRETRO_BEETLE_PCE_FAST_VERSION = d97d9558fe218ea04821788cee1f2c03556e818a
LIBRETRO_BEETLE_PCE_FAST_SITE = $(call github,libretro,beetle-pce-fast-libretro,$(LIBRETRO_BEETLE_PCE_FAST_VERSION))
LIBRETRO_BEETLE_PCE_FAST_LICENSE = GPLv2
LIBRETRO_BEETLE_PCE_FAST_LICENSE_FILES  = COPYING

define LIBRETRO_BEETLE_PCE_FAST_BUILD_CMDS
    $(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) \
        GIT_VERSION="-$(shell echo $(LIBRETRO_BEETLE_PCE_FAST_VERSION) | cut -c 1-7)"
    $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define LIBRETRO_BEETLE_PCE_FAST_INSTALL_TARGET_CMDS
    $(INSTALL) -D $(@D)/mednafen_pce_fast_libretro.so \
        $(TARGET_DIR)/usr/lib/libretro/mednafen_pce_fast_libretro.so
endef

$(eval $(generic-package))

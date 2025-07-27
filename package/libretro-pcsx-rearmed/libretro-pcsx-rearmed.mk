################################################################################
#
# PCSX-REARMED
#
################################################################################

LIBRETRO_PCSX_REARMED_VERSION = 6365a756c02d25c76bf90c78e42316b46f876c49
LIBRETRO_PCSX_REARMED_SITE = $(call github,libretro,pcsx_rearmed,$(LIBRETRO_PCSX_REARMED_VERSION))
LIBRETRO_PCSX_REARMED_LICENSE = GPL-2.0
LIBRETRO_PCSX_REARMED_LICENSE_FILES = COPYING

define LIBRETRO_PCSX_REARMED_BUILD_CMDS
	$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" \
		CFLAGS="$(TARGET_CFLAGS) -flto=auto" \
		CXXFLAGS="$(TARGET_CXXFLAGS) -flto=auto" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		-C $(@D) -f Makefile.libretro
endef

define LIBRETRO_PCSX_REARMED_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/pcsx_rearmed_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/pcsx_rearmed_libretro.so
endef

$(eval $(generic-package))
################################################################################
#
# libretro-pcsx
#
################################################################################
# Version: Commits on Feb 14, 2024
LIBRETRO_PCSX_VERSION = 9aefd427e47e1cdf94578e1913054bc14a44bab6
LIBRETRO_PCSX_SITE = $(call github,libretro,pcsx_rearmed,$(LIBRETRO_PCSX_VERSION))
LIBRETRO_PCSX_LICENSE = GPLv2
LIBRETRO_PCSX_DEPENDENCIES += retroarch

LIBRETRO_PCSX_EXTRA_OPTIONS =
LIBRETRO_PCSX_PLATFORM = $(LIBRETRO_PLATFORM)

# else ifeq ($(BR2_aarch64),y)
LIBRETRO_PCSX_PLATFORM = unix
LIBRETRO_PCSX_EXTRA_OPTIONS = DYNAREC=ari64
# else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86_64_ANY),y)
# LIBRETRO_PCSX_PLATFORM = unix
# LIBRETRO_PCSX_EXTRA_OPTIONS = HAVE_LIGHTREC=1 LIGHTREC_CUSTOM_MAP=0
# endif

define LIBRETRO_PCSX_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile.libretro platform="$(LIBRETRO_PCSX_PLATFORM)" $(LIBRETRO_PCSX_EXTRA_OPTIONS) \
        GIT_VERSION="-$(shell echo $(LIBRETRO_PCSX_VERSION) | cut -c 1-7)"
endef

define LIBRETRO_PCSX_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/pcsx_rearmed_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/pcsx_rearmed_libretro.so
endef

$(eval $(generic-package))

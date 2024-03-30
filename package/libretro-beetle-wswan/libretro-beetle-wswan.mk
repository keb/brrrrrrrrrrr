################################################################################
#
# libretro-beetle-wswan
#
################################################################################

LIBRETRO_BEETLE_WSWAN_VERSION = 32bf70a3032a138baa969c22445f4b7821632c30
LIBRETRO_BEETLE_WSWAN_SITE = $(call github,libretro,beetle-wswan-libretro,$(LIBRETRO_BEETLE_WSWAN_VERSION))
LIBRETRO_BEETLE_WSWAN_LICENSE = MPL-2.0
LIBRETRO_BEETLE_WSWAN_LICENSE_FILES = LICENSE

define LIBRETRO_BEETLE_WSWAN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(LTO_FLAGS) $(MAKE) -C $(@D)
endef

define LIBRETRO_BEETLE_WSWAN_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mednafen_wswan_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mednafen_wswan_libretro.so
endef

$(eval $(generic-package))

################################################################################
#
# libretro-prosystem
#
################################################################################

LIBRETRO_PROSYSTEM_VERSION = 4202ac5bdb2ce1a21f84efc0e26d75bb5aa7e248
LIBRETRO_PROSYSTEM_SITE = $(call github,libretro,prosystem-libretro,$(LIBRETRO_PROSYSTEM_VERSION))
LIBRETRO_PROSYSTEM_LICENSE = MPL-2.0
LIBRETRO_PROSYSTEM_LICENSE_FILES = LICENSE

define LIBRETRO_PROSYSTEM_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(LTO_FLAGS) $(MAKE) -C $(@D)
endef

define LIBRETRO_PROSYSTEM_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/prosystem_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/prosystem_libretro.so
endef

$(eval $(generic-package))

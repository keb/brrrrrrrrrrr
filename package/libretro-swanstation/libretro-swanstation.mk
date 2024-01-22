################################################################################
#
# SWANSTATION
#
################################################################################

LIBRETRO_SWANSTATION_VERSION = afb6bc73c7ce522190b19ec3e3c8a14eb264bdeb
LIBRETRO_SWANSTATION_SITE = $(call github,libretro,swanstation,$(LIBRETRO_SWANSTATION_VERSION))
LIBRETRO_SWANSTATION_LICENSE = GPL-3.0
LIBRETRO_SWANSTATION_LICENSE_FILES = LICENSE

LIBRETRO_SWANSTATION_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
LIBRETRO_SWANSTATION_CONF_OPTS += -DBUILD_LIBRETRO_CORE=ON -DUSE_EGL=OFF -DBUILD_SHARED_LIBS=OFF

LIBRETRO_SWANSTATION_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS)"
LIBRETRO_SWANSTATION_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS)"

define LIBRETRO_SWANSTATION_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/swanstation_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/swanstation_libretro.so
endef

$(eval $(cmake-package))

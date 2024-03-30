################################################################################
#
# SWANSTATION
#
################################################################################

LIBRETRO_SWANSTATION_VERSION = 77aeeea58a45cccae7a8be37645f8f5a27ff101b
LIBRETRO_SWANSTATION_SITE = $(call github,libretro,swanstation,$(LIBRETRO_SWANSTATION_VERSION))
LIBRETRO_SWANSTATION_LICENSE = GPL-3.0
LIBRETRO_SWANSTATION_LICENSE_FILES = LICENSE

LIBRETRO_SWANSTATION_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
LIBRETRO_SWANSTATION_CONF_OPTS += -DBUILD_LIBRETRO_CORE=ON -DUSE_EGL=OFF -DBUILD_SHARED_LIBS=OFF

LIBRETRO_SWANSTATION_CONF_OPTS += -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -flto=auto"
LIBRETRO_SWANSTATION_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -flto=auto"

define LIBRETRO_SWANSTATION_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/swanstation_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/swanstation_libretro.so
endef

$(eval $(cmake-package))

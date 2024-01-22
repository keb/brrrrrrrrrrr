################################################################################
#
# libretro-vecx
#
################################################################################

LIBRETRO_VECX_VERSION = a401c268e425dc8ae6a301e7fdb9a9e96f39b8ea
LIBRETRO_VECX_SITE = $(call github,libretro,libretro-vecx,$(LIBRETRO_VECX_VERSION))
LIBRETRO_VECX_LICENSE = MPL-2.0
LIBRETRO_VECX_LICENSE_FILES = LICENSE

LIBRETRO_VECX_CFLAGS = -O0

define LIBRETRO_VECX_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/ -f Makefile.libretro HAS_GPU=1 HAS_GLES=1 V=1
endef

define LIBRETRO_VECX_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/vecx_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/vecx_libretro.so
endef

$(eval $(generic-package))

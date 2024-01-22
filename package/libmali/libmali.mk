################################################################################
#
# libmali
#
################################################################################

# based off of buildroot rockchip-libmali package
LIBMALI_VERSION = ad4c28932c3d07c75fc41dd4a3333f9013a25e7f
LIBMALI_LICENSE = Proprietary
LIBMALI_LICENSE_FILES = END_USER_LICENCE_AGREEMENT.txt
LIBMALI_INSTALL_STAGING = YES
LIBMALI_DEPENDENCIES = mesa3d
LIBMALI_SITE = $(call github,Txwv,rockchip-linux-libmali,$(LIBMALI_VERSION))
LIBMALI_DEPENDENCIES = host-patchelf libdrm
#LIBMALI_PROVIDES = libegl libgles libgbm
LIBMALI_LIB=libmali-bifrost-g52-g2p0-gbm.so

# We need to create:
# - The symlink that matches the library SONAME (libmali.so.1)
# - The .so symlinks needed at compile time by the compiler (*.so)
LIBMALI_LIB_SYMLINKS = \
	libmali.so.1 \
	libMali.so \
	libEGL.so \
	libgbm.so \
	libGLESv1_CM.so \
	libGLESv2.so

define LIBMALI_INSTALL_CMDS
	$(INSTALL) -D -m 0755 \
		$(@D)/lib/aarch64-linux-gnu/$(LIBMALI_LIB) \
		$(1)/usr/lib/$(LIBMALI_LIB)

	$(HOST_DIR)/bin/patchelf --set-soname libmali.so.1 \
		$(1)/usr/lib/$(LIBMALI_LIB)

	$(foreach symlink,$(LIBMALI_LIB_SYMLINKS), \
		ln -sf $(LIBMALI_LIB) $(1)/usr/lib/$(symlink)
	)
endef

define LIBMALI_INSTALL_TARGET_CMDS
	$(call LIBMALI_INSTALL_CMDS,$(TARGET_DIR))
endef

define LIBMALI_INSTALL_STAGING_CMDS
	$(call LIBMALI_INSTALL_CMDS,$(STAGING_DIR))
endef
$(eval $(generic-package))

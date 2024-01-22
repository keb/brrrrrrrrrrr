################################################################################
#
# retroarch
#
################################################################################

RETROARCH_VERSION = c1130b8775f6d316120baf3d9342f8cdd5d60439
RETROARCH_SITE = $(call github,libretro,RetroArch,$(RETROARCH_VERSION))
RETROARCH_DEPENDENCIES = host-pkgconf libdrm alsa-lib freetype eudev libpng libglvnd libgles mesa3d
RETROARCH_LICENSE = GPL-3.0-or-later
RETROARCH_LICENSE_FILES = COPYING
RETROARCH_CONF_OPTS += \
		--disable-audiomixer \
		--disable-cdrom \
		--disable-discord \
		--disable-mpv \
		--disable-opengl1 \
		--disable-opengl_core \
		--disable-oss \
		--disable-pulse \
		--disable-sdl2 \
		--disable-videocore \
		--disable-vulkan \
		--disable-vulkan_display \
		--disable-wayland \
		--disable-x11 \
		--enable-alsa \
		--enable-egl \
		--enable-freetype \
		--enable-kms \
		--enable-odroidgo2 \
		--enable-opengl \
		--enable-opengles \
		--enable-opengles3 \
		--enable-opengles3_2 \
		--enable-udev \
		--enable-zlib \

define RETROARCH_CONF_FIX
    $(SED) "s|-\([IL]\)/usr|-\1$(STAGING_DIR)/usr|g" $(@D)/config.mk
endef

RETROARCH_POST_CONFIGURE_HOOKS += RETROARCH_CONF_FIX

define RETROARCH_CONFIGURE_CMDS
	(cd $(@D); rm -f config.mk; \
		$(TARGET_CONFIGURE_ARGS) \
        $(TARGET_CONFIGURE_OPTS) \
        CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include/drm -flto" \
        CXXFLAGS="$(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include/drm -flto" \
        LDFLAGS="$(TARGET_LDFLAGS) -ldrm" \
        CROSS_COMPILE="$(HOST_DIR)/bin/" \
        PKG_CONFIG_PATH="$(STAGING_DIR)/usr/lib/pkgconfig/" \
        ./configure $(RETROARCH_CONF_OPTS) \
    )
endef

define RETROARCH_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/retroarch $(TARGET_DIR)/usr/bin
	$(INSTALL) -D $(@D)/retroarch.cfg $(TARGET_DIR)/etc/
	$(INSTALL) -D $(@D)/retroarch.cfg $(TARGET_DIR)/usr/share/libretro/retroarch.cfg
endef


$(eval $(autotools-package))

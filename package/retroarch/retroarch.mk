################################################################################
#
# retroarch
#
################################################################################

RETROARCH_VERSION = v1.18.0
RETROARCH_SITE = $(call github,libretro,RetroArch,$(RETROARCH_VERSION))
RETROARCH_DEPENDENCIES = host-pkgconf libdrm alsa-lib freetype eudev libpng libglvnd libgles mesa3d
RETROARCH_LICENSE = GPL-3.0-or-later
RETROARCH_LICENSE_FILES = COPYING
RETROARCH_CONF_OPTS += \
		--disable-al \
		--disable-audiomixer \
		--disable-blissbox \
		--disable-bsv_movie \
		--disable-builtinbearssl \
		--disable-builtinflac \
		--disable-builtinmbedtls \
		--disable-builtinzlib \
		--disable-cdrom \
		--disable-coreaudio \
		--disable-crtswitchres \
		--disable-discord \
		--disable-dr_mp3 \
		--disable-dsound \
		--disable-ffmpeg \
		--disable-imageviewer \
		--disable-jack \
		--disable-kms \
		--disable-materialui \
		--disable-microphone \
		--disable-mpv \
		--disable-networkgamepad \
		--disable-nvda \
		--disable-opengl1 \
		--disable-oss \
		--disable-parport \
		--disable-pulse \
		--disable-qt \
		--disable-rpiled \
		--disable-sdl \
		--disable-sdl2 \
		--disable-sixel \
		--disable-ssa \
		--disable-systemd \
		--disable-systemmbedtls \
		--disable-video_filter \
		--disable-videocore \
		--disable-videoprocessor \
		--disable-vulkan \
		--disable-vulkan_display \
		--disable-wasapi \
		--disable-winmm \
		--disable-x11 \
		--disable-xaudio \
		--enable-alsa \
		--enable-builtinglslang \
		--enable-egl \
		--enable-freetype \
		--enable-opengl \
		--enable-opengl_core \
		--enable-opengles \
		--enable-opengles3 \
		--enable-opengles3_2 \
		--enable-slang \
		--enable-spirv_cross \
		--enable-tinyalsa \
		--enable-udev \
		--enable-wayland \
		--enable-wifi \
		--enable-zlib \

define RETROARCH_CONF_FIX
    $(SED) "s|-\([IL]\)/usr|-\1$(STAGING_DIR)/usr|g" $(@D)/config.mk
endef

RETROARCH_POST_CONFIGURE_HOOKS += RETROARCH_CONF_FIX

define RETROARCH_CONFIGURE_CMDS
	(cd $(@D); rm -f config.mk; \
		$(TARGET_CONFIGURE_ARGS) \
        $(TARGET_CONFIGURE_OPTS) \
        CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include/drm -flto=auto" \
        CXXFLAGS="$(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include/drm -flto=auto" \
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

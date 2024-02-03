include $(sort $(wildcard $(BR2_EXTERNAL_BRRRRRRRRRR_PATH)/package/*/*.mk))

TARGET_CFLAGS = -mtune=cortex-a55 -mcpu=cortex-a55+crc+crypto+fp+simd -Ofast -U_FORTIFY_SOURCE -fno-stack-protector -fno-stack-clash-protection -fomit-frame-pointer -flto
# -mfloat-abi=hard -mfpu=neon-fp-armv8
TARGET_CXXFLAGS = $(TARGET_CFLAGS)

# these break on lto
NCURSES_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -fno-lto"
READLINE_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -fno-lto"

MESA3D_CONF_OPTS := $(subst -Dgallium-vc4-neon=disabled,,${MESA3D_CONF_OPTS})
SWAY_DEPENDENCIES := $(subst systemd,,${SWAY_DEPENDENCIES})

#BR_NO_CHECK_HASH_FOR += $(SWAY_SOURCE) $(WLROOTS_SOURCE) $(WAYLAND_PROTOCOLS_SOURCE) $(LIBXKBCOMMON_SOURCE)

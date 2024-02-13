include $(sort $(wildcard $(BR2_EXTERNAL_BRRRRRRRRRR_PATH)/package/*/*.mk))

TARGET_CFLAGS = -mtune=cortex-a55 -mcpu=cortex-a55+crc+crypto+fp+simd -Ofast -U_FORTIFY_SOURCE -fno-stack-protector -fno-stack-clash-protection -fomit-frame-pointer -flto=auto
TARGET_CXXFLAGS = $(TARGET_CFLAGS)

# these break on lto
NCURSES_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -fno-lto"
READLINE_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -fno-lto"

MESA3D_CONF_OPTS := $(subst -Dgallium-vc4-neon=disabled,,${MESA3D_CONF_OPTS})

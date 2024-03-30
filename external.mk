include $(sort $(wildcard $(BR2_EXTERNAL_BRRRRRRRRRR_PATH)/package/*/*.mk))

LTO_FLAGS = CFLAGS="$(TARGET_CFLAGS) -flto=auto" CXXFLAGS="$(TARGET_CXXFLAGS) -flto=auto"

TARGET_CFLAGS = -mtune=cortex-a55 -mcpu=cortex-a55+crc+crypto+fp+simd -Ofast -U_FORTIFY_SOURCE -fno-stack-protector -fno-stack-clash-protection -fomit-frame-pointer
TARGET_CXXFLAGS = $(TARGET_CFLAGS)

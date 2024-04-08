################################################################################
#
# sayidle
#
################################################################################

SWAYIDLE_VERSION = bc795df418fd069aacc8a773c14b01dcb5148dc3
SWAYIDLE_SITE = $(call github,swaywm,swayidle,$(SWAYIDLE_VERSION))
SWAYIDLE_DEPENDENCIES = wayland wayland-protocols
SWAYIDLE_LICENSE = MIT
SWAYIDLE_LICENSE_FILES = LICENSE

$(eval $(meson-package))

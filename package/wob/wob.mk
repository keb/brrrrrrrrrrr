################################################################################
#
# wob
#
################################################################################

WOB_VERSION = 729e5c68215547eb8939c4c1778f58cca36b2bc0
WOB_SITE = $(call github,francma,wob,$(WOB_VERSION))
WOB_DEPENDENCIES = host-pkgconf inih wayland wayland-protocols
WOB_LICENSE = ISC
WOB_LICENSE_FILES = LICENSE

$(eval $(meson-package))

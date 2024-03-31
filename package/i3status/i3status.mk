################################################################################
#
# i3status
#
################################################################################

I3STATUS_VERSION = c07b9ca5baee47a85cb745985703080ae8d56fc7
I3STATUS_SITE = $(call github,i3,i3status,$(I3STATUS_VERSION))
I3STATUS_LICENSE = GPL3
I3STATUS_LICENSE_FILES = LICENSE
I3STATUS_DEPENDENCIES += alsa-lib yajl libconfuse libnl
I3STATUS_CONF_OPTS += -Dpulseaudio=false

$(eval $(meson-package))

################################################################################
#
# evsieve
#
################################################################################

EVSIEVE_VERSION = ce4983a8311e8d56766952f3a27146447b71b407
EVSIEVE_SITE = $(call github,KarsMulder,evsieve,$(EVSIEVE_VERSION))
EVSIEVE_LICENSE = GPL
EVSIEVE_LICENSE_FILES = LICENSE
EVSIEVE_DEPENDENCIES += libevdev

$(eval $(cargo-package))

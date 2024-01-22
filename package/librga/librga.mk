################################################################################
#
# librga
#
################################################################################

LIBRGA_VERSION = ccfec13d6c48e3f0c7f24810b3dac162c40cdda8
LIBRGA_SITE = $(call github,Caesar-github,linux-rga,$(LIBRGA_VERSION))
LIBRGA_DEPENDENCIES = host-pkgconf libdrm
LIBRGA_INSTALL_STAGING = YES
LIBRGA_LICENSE = Apache-2.0
LIBRGA_LICENSE_FILES = COPYING
LIBRGA_CONF_OPTS  = -DCMAKE_BUILD_TARGET=cmake_linux
LIBRGA_CONF_OPTS += -DCMAKE_C_COMPILER="$(TARGET_CC)"
LIBRGA_CONF_OPTS += -DCMAKE_CXX_COMPILER="$(TARGET_CXX)"

$(eval $(cmake-package))

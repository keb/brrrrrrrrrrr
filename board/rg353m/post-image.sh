#!/bin/bash

support/scripts/genimage.sh -c "${BR2_EXTERNAL_BRRRRRRRRRR_PATH}/board/rgarc/genimage.cfg"

(cd ${BINARIES_DIR} && md5sum Image initrd.gz rootfs.erofs > sums)

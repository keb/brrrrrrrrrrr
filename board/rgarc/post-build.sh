#!/bin/bash

set -euo pipefail

BOARD_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

mkdir -p ${BINARIES_DIR}
mkdir -p ${TARGET_DIR}/boot
mkdir -p ${TARGET_DIR}/userdata
sed -i ${TARGET_DIR}/etc/ssh/sshd_config -e "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/"
rm -f ${TARGET_DIR}/etc/init.d/{S01syslogd,S02klogd,S01seedrng}
rm -f ${TARGET_DIR}/etc/acpi/events/powerbtn
mv ${TARGET_DIR}/etc/init.d/S40iwd ${TARGET_DIR}/etc/init.d/K40iwd || true
mv ${TARGET_DIR}/etc/init.d/S50sshd ${TARGET_DIR}/etc/init.d/K50sshd || true
sed -i ${TARGET_DIR}/etc/init.d/K40iwd -e 's/IWD_ARGS=""/IWD_ARGS="-i p2p0 -I wlan0"/'

cp -v ${BOARD_DIR}/extlinux.conf ${BINARIES_DIR}/
cp -v ${BOARD_DIR}/linux ${BINARIES_DIR}/
cp -v ${BOARD_DIR}/rk3566-rg-arc.dtb ${BINARIES_DIR}/
cp -v ${BOARD_DIR}/uboot.bin ${BINARIES_DIR}/
cp -v ${BOARD_DIR}/resource.bin ${BINARIES_DIR}/
cp -v ${BOARD_DIR}/initrd.gz ${BINARIES_DIR}/
cp -v ${BOARD_DIR}/idbloader.bin ${BINARIES_DIR}/
cp -rv ${BOARD_DIR}/iwd/ ${BINARIES_DIR}/

cp ${TARGET_DIR}/usr/share/libretro/retroarch.cfg ${TARGET_DIR}/etc/retroarch.cfg
cat ${BOARD_DIR}/retroarch.cfg >> ${TARGET_DIR}/etc/retroarch.cfg

rm -rf ${TARGET_DIR}/usr/lib/dri
# personal stuff
install -D -m 600 ~/.ssh/id_ed25519.pub ${TARGET_DIR}/root/.ssh/authorized_keys

# make reproducible
sed -i ${TARGET_DIR}/usr/lib/libstdc++.so.*.py -e "s/$USER/user/g"
sed -i ${TARGET_DIR}/lib/libstdc++.so.*.py -e "s/$USER/user/g"

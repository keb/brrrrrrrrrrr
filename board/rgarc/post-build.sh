#!/bin/bash

set -euo pipefail

BOARD_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

mkdir -p ${BINARIES_DIR}
mkdir -p ${TARGET_DIR}/boot
mkdir -p ${TARGET_DIR}/userdata
sed -i ${TARGET_DIR}/etc/ssh/sshd_config -e "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/"
rm -f ${TARGET_DIR}/etc/init.d/{S01syslogd,S02klogd,S01seedrng}
rm -f ${TARGET_DIR}/etc/acpi/events/powerbtn
mv ${TARGET_DIR}/etc/init.d/S40iwd ${TARGET_DIR}/etc/init.d/K40iwd 2> /dev/null || true
mv ${TARGET_DIR}/etc/init.d/S50sshd ${TARGET_DIR}/etc/init.d/K50sshd 2> /dev/null || true
mv ${TARGET_DIR}/etc/init.d/S49chrony ${TARGET_DIR}/etc/init.d/K49chrony 2> /dev/null || true
#cp -v ${LINUX_TARGET_DIR}/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg-arc-d.dtb ${BINARIES_DIR}/

# copy dtbs
rm -rf "${BINARIES_DIR}/rockchip"
mkdir -p "${BINARIES_DIR}/rockchip"
find "${TARGET_DIR}"/../build/linux-*/ -name rk3566-anbernic-rg-arc\*.dtb -exec cp -f {} "${BINARIES_DIR}/rockchip/" \;

cp -v ${BOARD_DIR}/extlinux.conf ${BINARIES_DIR}/
cp -rv ${BOARD_DIR}/iwd/ ${BINARIES_DIR}/

cp ${TARGET_DIR}/usr/share/libretro/retroarch.cfg ${TARGET_DIR}/etc/retroarch.cfg
cat ${BOARD_DIR}/retroarch.cfg >> ${TARGET_DIR}/etc/retroarch.cfg

# personal stuff
install -D -m 600 ~/.ssh/id_ed25519.pub ${TARGET_DIR}/root/.ssh/authorized_keys

# make reproducible
sed -i ${TARGET_DIR}/usr/lib/libstdc++.so.*.py -e "s/$USER/user/g"
sed -i ${TARGET_DIR}/lib/libstdc++.so.*.py -e "s/$USER/user/g"

# initrd
temp_dir=$(mktemp -d)
install -D -m 775 ${BOARD_DIR}/init ${temp_dir}/
install -D -m 775 ${TARGET_DIR}/bin/busybox ${temp_dir}/bin/busybox
install -D -m 775 ${TARGET_DIR}/usr/bin/evtest ${temp_dir}/bin/evtest
install -D -m 775 ${TARGET_DIR}/lib/ld-linux-aarch64.so.1 ${temp_dir}/lib/ld-linux-aarch64.so.1
install -D -m 775 ${TARGET_DIR}/lib/libresolv.so.2 ${temp_dir}/lib/libresolv.so.2
install -D -m 775 ${TARGET_DIR}/lib/libresolv.so.2 ${temp_dir}/lib64/libresolv.so.2
install -D -m 775 ${TARGET_DIR}/lib/libc.so.6 ${temp_dir}/lib64/libc.so.6
mkdir -p ${temp_dir}/sbin
ln -sf ../bin/busybox ${temp_dir}/sbin/switch_root
apps=('[' '[[' ash cat clear cp dmesg echo ls mkdir mount mv rm sleep test umount)
for app in "${apps[@]}"; do
    ln -sf busybox ${temp_dir}/bin/$app
done

(cd $temp_dir && find . | cpio --create --format=newc | gzip -c > ${BINARIES_DIR}/initrd.gz)

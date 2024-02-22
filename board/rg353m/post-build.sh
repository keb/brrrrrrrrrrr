#!/bin/bash

# shellcheck disable=SC2086

set -euo pipefail

BOARD_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

mkdir -p ${BINARIES_DIR}
mkdir -p ${TARGET_DIR}/boot
mkdir -p ${TARGET_DIR}/userdata
sed -i ${TARGET_DIR}/etc/ssh/sshd_config -e "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/"
rm -f ${TARGET_DIR}/etc/init.d/{S01syslogd,S02klogd,S01seedrng}
rm -f ${TARGET_DIR}/etc/acpi/events/powerbtn
mv ${TARGET_DIR}/etc/init.d/S40iwd ${TARGET_DIR}/etc/init.d/S70iwd 2> /dev/null || true
mv ${TARGET_DIR}/etc/init.d/S49chrony ${TARGET_DIR}/etc/init.d/S91chrony 2> /dev/null || true
mv ${TARGET_DIR}/etc/init.d/S50sshd ${TARGET_DIR}/etc/init.d/S92sshd 2> /dev/null || true

# copy dtbs
rm -rf "${BINARIES_DIR}/rockchip"
mkdir -p "${BINARIES_DIR}/rockchip"
find "${TARGET_DIR}"/../build/linux-*/ -name rk3566-anbernic-rg-arc\*.dtb -exec cp -f {} "${BINARIES_DIR}/rockchip/" \;

cp -v ${BOARD_DIR}/extlinux.conf ${BINARIES_DIR}/
mkdir -p ${BINARIES_DIR}/iwd

cp ${TARGET_DIR}/usr/share/libretro/retroarch.cfg ${TARGET_DIR}/etc/retroarch.cfg
cat ${BOARD_DIR}/retroarch.cfg >> ${TARGET_DIR}/etc/retroarch.cfg

# personal stuff
${BOARD_DIR}/post-build-personal.sh || true

# initrd
temp_dir=$(mktemp -d)

install -D -m 775 ${BOARD_DIR}/init ${temp_dir}/init
for bin in bin/busybox usr/bin/evtest usr/sbin/gdisk usr/sbin/partprobe; do
    install -D -m 775 ${TARGET_DIR}/${bin} ${temp_dir}/${bin}
done

for lib in lib/ld-linux-aarch64.so.1 lib64/libresolv.so.2 usr/lib64/libparted.so.2 lib64/libblkid.so.1 lib64/libuuid.so.1 usr/lib64/libreadline.so.8 usr/lib64/libncurses.so.6 lib64/libc.so.6 lib64/libstdc++.so.6 lib64/libm.so.6 lib64/libgcc_s.so.1; do
    install -D -m 775 ${TARGET_DIR}/${lib} ${temp_dir}/${lib}
done

mkdir -p ${temp_dir}/lib && cp -rv ${BOARD_DIR}/../rootfs_overlay/lib/firmware ${temp_dir}/lib/

install -D -m 775 ${BOARD_DIR}/brrr_logo ${temp_dir}/logo
mkdir -p ${temp_dir}/sbin/
ln -sf ../bin/busybox ${temp_dir}/sbin/switch_root
ln -sf ../bin/busybox ${temp_dir}/sbin/mkfs.ext2
ln -sf ../bin/busybox ${temp_dir}/sbin/halt

apps=('[' '[[' ash cat clear cp dmesg echo ls mkdir mount mv rm usleep sleep test umount md5sum)
for app in "${apps[@]}"; do
    ln -sf busybox ${temp_dir}/bin/$app
done

(cd $temp_dir && find . | cpio --create --format=newc | gzip -c > ${BINARIES_DIR}/initrd.gz)

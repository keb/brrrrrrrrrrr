# BRRRRRRRRRR

## Features

- Linux 6.8.2
- bcachefs support w/ zstd compression
- RetroArch 1.18
- Sway
- Upgradable and reset to factory
- Ludicrous mode by default: instant suspend/resume with poweroff fallback
- Ridiculous mode (like quick mode), enable by holding 'A' on startup

## How to build

### Prerequisites

- A recent Linux distribution (e.g., Ubuntu 20.04 or 22.04, but not 18.04)
- Buildroot and its requirements, as described at https://buildroot.org/
- Additionally, the package `libssl-dev` has to be installed

There are several ways to set up such prerequisites, e.g.,

- Using an existing Linux distribution, cloning buildroot https://github.com/buildroot/buildroot to `buildroot` and checking out tag `2024.02.1`
- Using a docker, see `Dockerfile`
- Using a VM, see `Vagrantfile`

### Building the image

1. Clone this repo to `brrrrrrrrrr`
2. In the buildroot dir, run `for i in /path/to/brrrrrrrrrr/buildroot*.patch; do patch -p1 < $i; done`
3. Then run `make O=rgarc BR2_EXTERNAL=/path/to/brrrrrrrrrr rgarc_defconfig`
4. `cd rgarc` and run `make -jN`, where `N` is the number of simultaneous jobs (consider available cpus, cores and hyperthreading)
5. Image to flash will be in `output/images/BRRRRRRRRRR-rgarc.img`

Note that building the image can take anywhere from minutes to hours, depending mostly on the
amount of CPUs/cores available. There are no notable hard disk space requirements.

### rg-arc-d users note

rg-arc-d emmc needs to be wiped in order to be able to boot mainline Linux. Note
that this is destructive and we cannot take any responsibility. Backup your emmc
if you want it back.

1. From power off and sd ejected, hold down power and volume down to get into Android recovery
2. Use `adb shell` to get a root shell:
3. [Optional] Backup emmc partition: `dd if=/dev/mmcblk0 of=<some sd card location> bs=4M`
4. Run `dd if=/dev/zero of=/dev/block/mmcblk0 bs=512 count=2` or alternatively,
   `dd if=/dev/zero of=/dev/block/mmcblk0 bs=4M` to wipe the whole thing.

## Usage

### Networking

#### Via RetroArch

1. Ensure Settings > Driver > Wi-Fi is set to "iwd"
2. Setting > Wi-Fi > Connect to Network
3. Select SSID and enter passphrase via on-screen keyboard

#### Via configuration files

Add iwd ssid config in `/boot/iwd/` according to 
https://wiki.archlinux.org/title/iwd#WPA-PSK and 
https://man.archlinux.org/man/iwd.network.5

### SSH and SFTP

You can connect to your device via SSH and SFTP, as follows
1. Enable and configure networking
2. Note the device's IP shown in Information > Network Information
3. Connect via SSH or SFTP using login/pass: `root` / `BRRRRRRRRRR`

### On-device terminal

Connecting an external keyboard to the OTG USB port, you can switch to tty2 from Sway/RetroArch by
pressing ctrl+alt+f2, and switch back to Sway/RetroArch by alt-f1. The same login/pass as for SSH and SFTP apply.

### On boot

Hold `L1` to enter Recovery Menu.

### Global

- Power:              Suspend
- F + Power:          Power off
- volup:              volume up
- voldown:            volume down
- select + volup:     brightness up
- select + voldown:   brightness down
- F + volup:          enable wifi
- F + voldown:        disable wifi

### RetroArch

Refer to RetroArch settings

### Storage

- Filesystems supported: exfat, vfat, ntfs, ext{2,3,4}, bcachefs
- `mmcblk1p2` is an ext4 overlay over root `/`.
- `/userdata` mounted and tried in this order: `mmcblk2`, `mmcblk2p1`, `mmcblk1p3`, or none (will
  write directly to overlay in `/userdata`)

### Updating

- Copy `rootfs.erofs`, `initrd.gz`, `Image`, `sums` to `/boot/update/`.
- On next reboot, these files will overwrite the existing files on the device

## FAQ

*Q1: How do I make customizations?*

A1: Make changes to this tree and rebuild.

## Acknowledgements

- Macromorgan
- JELOS team
- Johnny On Flame
- wuaalb
- Trooper\_Max

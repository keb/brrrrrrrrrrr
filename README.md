# BRRRRRRRRRR

## Features

- Linux 6.8-rc2
- Support for ntfs, vfat, bcachefs w/ zstd
- Retroarch
- Sway
- Upgradable and reset to factory

## How to build

1. Clone buildroot https://github.com/buildroot/buildroot
2. Clone this report to somewhere and checkout `rgarc-ml` branch
3. In the buildroot dir, run `patch -p1 < buildroot.patch` from where you checked out brrrrrrrr
4. Then run `make BR2_EXTERNAL=/path/to/BRRRRRRRRRR rgarc_defconfig`
3. Run `make`
4. Image to flash will be in `output/images/BRRRRRRRRRR-rgarc.img`

## Usage

### Networking

iwd configs are in `/boot/iwd`, there is an example to copy/rename.

### On boot

- Hold TL:            Factory reset. RESET will be printed.

### Global

- Power:              Power off
- F + Power:          Reboot
- select + volup:     enable networking
- select + voldown:   disable networking
- volup:              volume up
- voldown:            volume down
- F + volup:          brightness up
- F + voldown:        brightness down

### RetroArch

Check/customize settings

### Storage

- `mmcblk1p2` is an ext4 overlay over root `/`
- /userdata mounted and tried in this order: mmcblk2, mmcblk2p1, mmcblk1p3, or none (will
  write to overlay)

## FAQ

*Q1: How do I make customizations?*

A1: Make changes to this tree and rebuild.

## Acknowledgements

- Macromorgan
- JELOS team
- Johnny On Flame
- Trooper\_Max

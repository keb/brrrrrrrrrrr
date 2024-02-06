# BRRRRRRRRRR

## Features

- Linux 6.8-rc3
- bcachefs support w/ zstd compression
- Recent Retroarch
- Sway
- Upgradable and reset to factory
- Ridiculous mode (like quick mode), disable by holding 'A' on startup

## How to build

1. Clone this repo to `brrrrrrrr`
2. Clone buildroot https://github.com/buildroot/buildroot to `buildroot`
3. In the buildroot dir, run `patch -p1 < /path/to/brrrrrrrr/buildroot.patch`
4. Then run `make BR2_EXTERNAL=/path/to/BRRRRRRRRRR rgarc_defconfig`
3. Run `make`
4. Image to flash will be in `output/images/BRRRRRRRRRR-rgarc.img`

## Usage

### NOTE: rg-arc-s

If you have the -s variant, then uncomment it in `/boot/extlinux/extlinux.conf`
and comment the other one.

### Networking

iwd configs are in `/boot/iwd`, there is an example to copy/rename. Read
https://wiki.archlinux.org/title/iwd#WPA-PSK or
https://man.archlinux.org/man/iwd.network.5 for more information.

### First boot

Stuff that is updated online isn't included to keep the surface area small and
ensure you are up to date. On first boot after enabling networking, go to
`Online Updater` and at minimum, update:

- Core Info Files
- Assets

Recommended to also update databases if you build playlists and shaders if you
want 'em.

### On boot

- Hold TL:            Factory reset. RESET will be printed.

### Global

- Power:              Power off
- select + volup:     enable network
- select + voldown:   disable network
- volup:              volume up
- voldown:            volume down
- F + volup:          brightness up
- F + voldown:        brightness down

### RetroArch

Check/customize settings

### Storage

- Filesystems supported: exfat, vfat, ntfs, ext{2,3,4}, bcachefs
- `mmcblk1p2` is an ext4 overlay over root `/`.
- /userdata mounted and tried in this order: mmcblk2, mmcblk2p1, mmcblk1p3, or none (will
  write directly to overlay in /userdata)

### Updating

- Copy rootfs.squashfs to /boot/update/

## FAQ

*Q1: How do I make customizations?*

A1: Make changes to this tree and rebuild.

## Acknowledgements

- Macromorgan
- JELOS team
- Johnny On Flame
- Trooper\_Max

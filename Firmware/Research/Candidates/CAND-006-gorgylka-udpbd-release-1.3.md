# CAND-006 - UDPBD___A5-V11.zip Release 1.3 (GorGylka)

## Basic Info

| Item | Value |
|---|---|
| Candidate ID | CAND-006 |
| Original Filename | UDPBD___A5-V11.zip |
| Source Repository | GorGylka/UDPBD-A5-V11 |
| Source URL | https://github.com/GorGylka/UDPBD-A5-V11/releases/download/1.3/UDPBD___A5-V11.zip |
| Source HTML | https://github.com/GorGylka/UDPBD-A5-V11/releases/tag/1.3 |
| Source Type | GitHub Release |
| Release Tag | 1.3 |
| Release Name | Release_3 |
| Release Date | 2025-11-01 |
| File Type | ZIP archive (contains firmware, bootloader, PS2 files) |
| File Size | 27970177 bytes (approx 26.7 MB) |
| SHA256 | 8957b90dc2393038f8d12b221610083e6b58afb1cb116b63466ed96b87daf9a4 |
| Status | Documented |
| Research Date | 2026-05-22 |

---

## What Is In This Release

Per the GorGylka README and release notes, this ZIP bundle contains:

- `lede-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin` - OpenWrt LEDE 17.01.7 sysupgrade image
- `uboot_usb_256_03.img` - USB-bootable U-Boot for 32 MB RAM boards (256 Mbit)
- `OpenWRT_17.01.7_MX25L3205.bin` - 4 MB hardware flash dump for CH341A programmer
- PS2-side files including FMCB, OPL (UDPBD build), psxmemcard content

---

## Release Notes

From the GitHub release notes:

```
-Added pre-configured MC image for SD2PSX / PSXMemCard Gen2 / PSXMemCard Gen1 / PicoMemcard+ users
-Added pre-configured 8MB MC image
```

---

## RAM Compatibility

| Item | Value |
|---|---|
| Target RAM | 32 MB (256 Mbit) |
| Required Board | A5-V11 with 4 MB flash and 32 MB RAM |

Per the GorGylka README: "You must have 4MB Flash / 32MB RAM"

Do NOT use on boards with 16 MB RAM.

---

## Firmware Details

The embedded OpenWrt image is based on LEDE 17.01.7 (LEDE = precursor to OpenWrt 18.06).

The image is a `squashfs-sysupgrade` type, intended for flashing via the running OpenWrt system or via stock firmware.

The `MX25L3205` in `OpenWRT_17.01.7_MX25L3205.bin` refers to the Macronix MX25L3205D 4 MB SPI flash chip commonly found on the A5-V11.

The `_03` suffix in `uboot_usb_256_03.img` suggests this is revision 3 of the WErt/4PDA community USB-boot U-Boot.

---

## PS2 Use

This bundle is specifically designed for PlayStation 2 UDPBD (UDP Block Device) use.

Features:
- exFAT USB drive support for PS2 game storage
- FMCB (Free McBoot) memory card image
- OPL (Open PS2 Loader) configured for UDPBD
- Supports up to 2TB USB drives
- Reported speed: 4.2 MB/s

---

## Source Notes

GorGylka is a known PS2 community member.

The firmware is based on established OpenWrt LEDE 17.01.7 with UDPBD modifications.

The SHA256 hash is published by GitHub as part of the release asset metadata.

This is the most recent release (as of research date 2026-05-22) and includes hardware flash dump support added in Release 1.2.

---

## Risk Warning

- This ZIP contains a full firmware bundle including a bootloader replacement.
- The `uboot_usb_256_03.img` is a bootloader file - flashing the wrong bootloader bricks the router.
- Only use on 4 MB flash / 32 MB RAM boards.
- The software install method requires telnet access to stock firmware.
- The hardware method requires a CH341A or compatible SPI programmer.

---

## Comparison

See: `Firmware/Research/Comparisons/COMP-006-gorgylka-udpbd-release-1.3.md`

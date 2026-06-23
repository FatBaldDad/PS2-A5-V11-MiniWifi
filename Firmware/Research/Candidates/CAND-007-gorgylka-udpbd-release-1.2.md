# CAND-007 - UDPBD_A5-V11.zip Release 1.2 (GorGylka)

## Basic Info

| Item | Value |
|---|---|
| Candidate ID | CAND-007 |
| Original Filename | UDPBD_A5-V11.zip |
| Source Repository | GorGylka/UDPBD-A5-V11 |
| Source URL | https://github.com/GorGylka/UDPBD-A5-V11/releases/download/1.2/UDPBD_A5-V11.zip |
| Source HTML | https://github.com/GorGylka/UDPBD-A5-V11/releases/tag/1.2 |
| Source Type | GitHub Release |
| Release Tag | 1.2 |
| Release Name | Release_2 |
| Release Date | 2025-10-18 |
| File Type | ZIP archive (contains firmware, bootloader, PS2 files) |
| File Size | 8637320 bytes (approx 8.2 MB) |
| SHA256 | 0164e4678980ec123774fd62cd2af7faf5cd3b3fe9367605ee0c70ffd938b58f |
| Status | Documented |
| Research Date | 2026-05-22 |

---

## What Is In This Release

Per the GorGylka README and release notes, this ZIP bundle includes:

- `lede-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin` - OpenWrt LEDE 17.01.7 sysupgrade image
- `uboot_usb_256_03.img` - USB-bootable U-Boot for 32 MB RAM boards (256 Mbit)
- `OpenWRT_17.01.7_MX25L3205.bin` - 4 MB hardware flash dump for CH341A programmer
- PS2-side files

---

## Release Notes

From the GitHub release notes:

```
-speed improvement
-4mb dump for hardware flasher
```

This release introduced the 4 MB full flash dump (`OpenWRT_17.01.7_MX25L3205.bin`) for users who cannot use the software install method and need to directly program the flash chip.

---

## RAM Compatibility

| Item | Value |
|---|---|
| Target RAM | 32 MB (256 Mbit) |
| Required Board | A5-V11 with 4 MB flash and 32 MB RAM |

Per the GorGylka README: "You must have 4MB Flash / 32MB RAM"

---

## Relationship To CAND-006

CAND-007 is an earlier release than CAND-006.

| Property | CAND-007 (Release 1.2) | CAND-006 (Release 1.3) |
|---|---|---|
| File size | 8637320 bytes | 27970177 bytes |
| Release date | 2025-10-18 | 2025-11-01 |
| Hardware flash dump | Added in this release | Present |
| Speed improvements | Yes (vs 1.1) | Based on 1.2 |
| PS2 Memory Card images | Basic | Extended (SD2PSX, Gen2, Gen1, PicoMemcard) |

The much smaller size of 1.2 vs 1.3 (8.2 MB vs 26.7 MB) is explained by the additional PS2 memory card image variants added in 1.3.

---

## The 4 MB Hardware Flash Dump

The `OpenWRT_17.01.7_MX25L3205.bin` file introduced in this release is a complete 4 MB SPI flash image.

This is intended for the CH341A programmer hardware method.

Important notes about this file:

- It is a complete flash image for the MX25L3205D 4 MB SPI flash
- It includes U-Boot, the LEDE 17.01.7 firmware, and the USB-boot bootloader
- This is a pre-configured image from one specific A5-V11 board
- Factory partition data (MAC address, Wi-Fi calibration) from the original board may be embedded
- Using this on a different board will overwrite that board's factory data
- This is a third-party flash dump, not an official OEM image

This file should be treated with caution.

---

## Source Notes

GorGylka Release 1.2 is the baseline for the UDPBD project.

The SHA256 hash is published by GitHub as part of the release asset metadata.

---

## Risk Warning

- The hardware flash dump overwrites ALL flash contents including factory calibration data.
- Using another board's factory partition can cause Wi-Fi calibration issues or wrong MAC address.
- Only use on 4 MB flash / 32 MB RAM boards.
- The software install method is preferred over the hardware flash dump method when possible.

---

## Comparison

See: `Firmware/Research/Comparisons/COMP-007-gorgylka-udpbd-release-1.2.md`

# COMP-006 - Comparison: GorGylka UDPBD Release 1.3 vs OEM Dump

## Summary

This document compares CAND-006 (GorGylka UDPBD-A5-V11 Release 1.3 bundle) against the known A5-V11 OEM dump structure.

---

## Files Compared

| Item | Value |
|---|---|
| Candidate Bundle | UDPBD___A5-V11.zip (Release 1.3) |
| Candidate Source | GorGylka/UDPBD-A5-V11 |
| Bundle SHA256 | 8957b90dc2393038f8d12b221610083e6b58afb1cb116b63466ed96b87daf9a4 |
| Bundle Size | 27970177 bytes |
| OEM Dump | Not available in this repo (board-specific) |
| Comparison Type | Bundle metadata analysis vs known OEM structure |

Note: The ZIP bundle has not been extracted and analyzed at byte level. The comparison below is based on documented contents and known file metadata.

---

## Bundle Contents

The ZIP bundle is reported to contain:

| File | Purpose | Type |
|---|---|---|
| lede-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin | OpenWrt LEDE 17.01.7 firmware | Sysupgrade image |
| uboot_usb_256_03.img | USB-boot capable U-Boot for 32 MB RAM | Bootloader |
| OpenWRT_17.01.7_MX25L3205.bin | 4 MB full flash dump | Hardware flash image |
| FMCB-OPENTUNA/ folder | PS2 Free McBoot + OpenTuna | PS2 memory card files |
| OPNPS2LD...UDPBD.elf | Open PS2 Loader UDPBD build | PS2 ELF |

---

## Firmware Component Comparison

### lede-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin

| Property | Candidate | OEM Stock |
|---|---|---|
| OS | OpenWrt LEDE 17.01.7 | Vendor firmware |
| Kernel era | 4.4.x (LEDE 17.01.7) | Older vendor kernel |
| Web UI | LuCI (OpenWrt) | Vendor web UI |
| Flash target | 4 MB flash | 4 MB flash |
| Image type | squashfs sysupgrade | N/A (not sysupgrade format) |
| Wi-Fi calibration | Read from factory partition | Read from factory partition |

The sysupgrade image is a standard OpenWrt LEDE 17.01.7 build.

This is the same OpenWrt LEDE version referenced in many A5-V11 OpenWrt guides.

### uboot_usb_256_03.img

| Property | Candidate | OEM Stock U-Boot |
|---|---|---|
| USB boot support | Yes | No |
| RAM config | 256 Mbit (32 MB) | 256 Mbit (32 MB) typical |
| Builder | WErt/4PDA community | Ralink/vendor |
| File size | Not individually measured (inside ZIP) | 105-128 KB typical |

This is expected to be the same or very similar to CAND-004 (WErt/4PDA uboot256).

### OpenWRT_17.01.7_MX25L3205.bin

This is a complete 4 MB SPI flash image for direct hardware programming.

| Property | Value |
|---|---|
| Target flash chip | Macronix MX25L3205D (4 MB) |
| Contents | U-Boot + env + factory partition + LEDE 17.01.7 kernel + rootfs |
| Size | 4 MB (4194304 bytes expected) |
| Factory data | From GorGylka's specific board (not universal) |

**Critical warning:** This flash dump contains factory data from one specific board.

Flashing this on another board will overwrite:
- That board's MAC address
- That board's Wi-Fi calibration data
- That board's RF calibration data

---

## Flash Layout Comparison

Expected flash layout inside OpenWRT_17.01.7_MX25L3205.bin (based on standard A5-V11 + LEDE 17.01.7):

| Partition | Offset | Size | Contents |
|---|---|---|---|
| u-boot | 0x00000 | varies | WErt/4PDA USB-boot U-Boot |
| u-boot-env | 0x20000 or after | 64 KB | U-Boot environment |
| factory | 0x30000 or similar | 64 KB | GorGylka board factory data |
| firmware (kernel+rootfs) | 0x40000 | ~3.75 MB | LEDE 17.01.7 squashfs image |

**This partition layout may differ from a stock OEM flash.**

---

## Comparison With OEM Dump

| Property | GorGylka Bundle | OEM Stock A5-V11 |
|---|---|---|
| Flash size compatibility | 4 MB flash | 4 MB flash |
| Bootloader | USB-boot WErt/4PDA U-Boot | Ralink stock U-Boot |
| Firmware OS | LEDE 17.01.7 (OpenWrt) | Vendor firmware |
| Web UI | LuCI | Vendor web UI |
| PS2 support | Full UDPBD setup | None |
| Factory partition | Overwritten from one specific board | Board-original factory data |
| MAC address | From GorGylka's board | From this board's original flash |

---

## Overall Assessment

| Property | Result |
|---|---|
| PS2 UDPBD suitability | High (specifically designed for this) |
| A5-V11 compatibility | Yes (tested, requires 4 MB flash / 32 MB RAM) |
| Hardware flash dump safety | Low (overwrites factory data from another board) |
| Sysupgrade method safety | Higher (preserves existing factory partition) |
| Source trust level | High (active GitHub project, documented releases) |
| Ready to use (sysupgrade method) | Possible - but verify board hardware first |
| Ready to use (hardware flash method) | Only if factory data loss is acceptable |

---

## Recommended Use

For PS2 UDPBD use, the sysupgrade install method is preferred.

The sysupgrade install method:
1. Writes only the kernel/rootfs using `mtd_write`
2. Replaces the bootloader with `uboot_usb_256_03.img`
3. Preserves the original factory partition

The hardware flash method is a last resort and will replace factory partition data.

---

## Status

Comparison Status: Documented (bundle not yet extracted for byte-level analysis)

# COMP-007 - Comparison: GorGylka UDPBD Release 1.2 vs OEM Dump

## Summary

This document compares CAND-007 (GorGylka UDPBD-A5-V11 Release 1.2 bundle) against the known A5-V11 OEM dump structure.

---

## Files Compared

| Item | Value |
|---|---|
| Candidate Bundle | UDPBD_A5-V11.zip (Release 1.2) |
| Candidate Source | GorGylka/UDPBD-A5-V11 |
| Bundle SHA256 | 0164e4678980ec123774fd62cd2af7faf5cd3b3fe9367605ee0c70ffd938b58f |
| Bundle Size | 8637320 bytes |
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
| PS2 files | Basic OPL/FMCB files | PS2 ELF and data |

---

## Relationship To Release 1.3 (CAND-006)

Release 1.2 introduced the core components that were updated in Release 1.3.

| Property | Release 1.2 (CAND-007) | Release 1.3 (CAND-006) |
|---|---|---|
| Bundle size | 8637320 bytes (8.2 MB) | 27970177 bytes (26.7 MB) |
| Core firmware | LEDE 17.01.7 | LEDE 17.01.7 (same) |
| Bootloader | uboot_usb_256_03.img | uboot_usb_256_03.img (same or updated) |
| 4 MB hardware dump | Yes (introduced in 1.2) | Yes |
| Extra PS2 MC images | Basic | SD2PSX, Gen1/Gen2 PSXMemCard, PicoMemcard+ |
| Release notes | speed improvement + 4MB dump | Added MC images for extra hardware |

The core firmware and bootloader components are believed to be identical or nearly identical between 1.2 and 1.3.

The size difference (8.2 MB vs 26.7 MB) is explained by the additional memory card image variants added in Release 1.3.

---

## Firmware Component Comparison

### lede-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin

This is the same OpenWrt LEDE 17.01.7 base image as in Release 1.3.

See COMP-006 for detailed firmware comparison notes.

### uboot_usb_256_03.img

This is the same WErt/4PDA USB-boot U-Boot as in Release 1.3.

See COMP-006 and CAND-004 for bootloader comparison notes.

### OpenWRT_17.01.7_MX25L3205.bin

This 4 MB hardware flash dump was introduced in Release 1.2.

| Property | Value |
|---|---|
| Target flash chip | Macronix MX25L3205D (4 MB) |
| Size | 4 MB (4194304 bytes expected) |
| Factory data | From GorGylka's specific board |

**Critical warning:** See COMP-006 for factory partition overwrite warning.

---

## Comparison With OEM Dump

The comparison is substantially the same as COMP-006.

See COMP-006-gorgylka-udpbd-release-1.3.md for the full comparison.

Key differences in this release (1.2) vs the OEM dump:

| Property | Release 1.2 | OEM Stock |
|---|---|---|
| Flash size | 4 MB | 4 MB |
| Bootloader | USB-boot U-Boot | Ralink stock U-Boot |
| OS | LEDE 17.01.7 | Vendor firmware |
| PS2 support | UDPBD | None |
| Factory data in HW dump | GorGylka's board | This board's original data |

---

## Overall Assessment

| Property | Result |
|---|---|
| PS2 UDPBD suitability | High |
| Core firmware same as 1.3 | Yes (believed identical) |
| Hardware flash dump safety | Low (overwrites factory data) |
| Sysupgrade method safety | Higher |
| Source trust level | High |
| Prefer over 1.2 | Use Release 1.3 for most use cases |

---

## Recommendation

If choosing between Release 1.2 and Release 1.3, prefer Release 1.3 (CAND-006).

Release 1.3 has the same core firmware with additional PS2 memory card support.

Release 1.2 is documented here for reference and for cases where only the smaller bundle download is needed.

---

## Status

Comparison Status: Documented (bundle not yet extracted for byte-level analysis)

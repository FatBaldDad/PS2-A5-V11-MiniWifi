# COMP-001 - Comparison: uboot128.img (JiapengLi) vs OEM Dump

## Summary

This document compares CAND-001 (uboot128.img from JiapengLi/OpenWrt-RT5350) against the known A5-V11 OEM dump structure.

---

## Files Compared

| Item | Value |
|---|---|
| Candidate | uboot128.img |
| Candidate Source | JiapengLi/OpenWrt-RT5350 |
| Candidate SHA256 | de7d3c5842defd10cc0cc1457bc7e634aaf13e543905c06b11084eaf96f7d1a1 |
| OEM Dump | Not available in this repo (board-specific) |
| Comparison Type | Candidate analysis vs known OEM structure |

---

## File Size Comparison

| File | Size |
|---|---|
| uboot128.img | 105472 bytes (103 KB) |
| Stock A5-V11 U-Boot partition | 128 KB (131072 bytes) typical |
| Fit in stock U-Boot partition? | Yes - 105472 < 131072 |

The candidate bootloader (105472 bytes) fits within the standard 128 KB U-Boot partition.

---

## File Type Comparison

| Property | uboot128.img | Typical OEM A5-V11 U-Boot |
|---|---|---|
| Format | U-Boot legacy uImage | U-Boot legacy uImage |
| Architecture | MIPS | MIPS |
| SoC | Ralink RT5350 | Ralink RT5350 |
| Load address | 0x80200000 | 0x80200000 (typical) |
| Entry point | 0x80200000 | 0x80200000 (typical) |
| Image type | Standalone Program | Standalone Program |
| Magic bytes (offset 0) | 27 05 19 56 | 27 05 19 56 (uImage magic) |

The format is consistent with a legitimate A5-V11 bootloader image.

---

## Strings Analysis

Key strings found in uboot128.img:

| String | Significance |
|---|---|
| `U-Boot 1.1.3 (Jul 31 2013 - 23:35:04)` | OpenWrt-era U-Boot build for RT5350 |
| `Ralink UBoot Version` | Confirms Ralink/MediaTek origin |
| `Board: Ralink APSoC` | Ralink APSoC confirmation |
| `RT5350 #` | U-Boot prompt, confirms RT5350 |
| `MX25L12805D`, `MX25L25635E`, `S25FL128P` | Supported flash chips (4 MB options) |
| `kernel_addr=BFC40000` | Kernel load address |
| `DRAM_SIZE: %d Mbits` | DRAM size detection |

---

## Partition Layout Comparison

| Property | uboot128.img | Typical OEM A5-V11 |
|---|---|---|
| U-Boot partition offset | 0x00000 | 0x00000 |
| U-Boot size | 105472 bytes | ~105-128 KB typical |
| Kernel address | 0xBFC40000 | 0xBFC40000 (typical) |
| RAM layout | 0x80200000 | 0x80200000 (typical) |

The partition addressing matches expected OEM layout.

---

## Bootloader Structure Comparison

| Feature | uboot128.img | OEM U-Boot (typical) |
|---|---|---|
| U-Boot version | 1.1.3 | 1.1.3 (common) |
| USB boot | Not present | Not present (stock) |
| TFTP boot | Present | Present |
| SPI flash commands | Present | Present |
| DRAM config | EEPROM | EEPROM |

---

## RAM Configuration Assessment

The `128` in the filename indicates this bootloader is configured for **128 Mbit (16 MB) DRAM**.

Stock A5-V11 boards most commonly ship with 32 MB RAM (256 Mbit).

**Do not flash this bootloader on a 32 MB RAM board.**

If this board has 16 MB RAM, this bootloader is structurally compatible.

---

## Overall Assessment

| Property | Result |
|---|---|
| Format compatibility | Compatible (valid RT5350 U-Boot image) |
| Partition fit | Yes (fits in 128 KB U-Boot partition) |
| Kernel address compatible | Yes |
| RAM compatibility | 16 MB RAM only |
| Source trust level | Medium-High (GitHub, referenced in many OpenWrt guides) |
| Ready to flash | NO - must confirm 16 MB RAM first |

---

## Required Steps Before Use

1. Confirm board RAM is 16 MB (128 Mbit DRAM) via UART boot log
2. Confirm board is an A5-V11 RT5350F
3. Backup original flash
4. Have recovery plan ready
5. Only then consider flashing

---

## Status

Comparison Status: Analyzed (candidate analyzed, no physical OEM dump available for direct comparison)

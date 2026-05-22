# COMP-003 - Comparison: hame-mpr-a1-v22-uboot128.bin (JiapengLi) vs OEM Dump

## Summary

This document compares CAND-003 (hame-mpr-a1-v22-uboot128.bin from JiapengLi/OpenWrt-RT5350) against the known A5-V11 OEM dump structure.

---

## Files Compared

| Item | Value |
|---|---|
| Candidate | hame-mpr-a1-v22-uboot128.bin |
| Candidate Source | JiapengLi/OpenWrt-RT5350 |
| Candidate SHA256 | 20688d081821ed9fe2dc0500f8cadd690bd0a2798fc9c416d6f334128d1bed53 |
| OEM Dump | Not available in this repo (board-specific) |
| Comparison Type | Candidate analysis vs known OEM structure |

---

## File Size Comparison

| File | Size |
|---|---|
| hame-mpr-a1-v22-uboot128.bin | 131072 bytes (128 KB) |
| Stock A5-V11 U-Boot partition | 128 KB (131072 bytes) typical |
| Fit in stock U-Boot partition? | Exactly 128 KB - fills the partition completely |

This file is exactly 128 KB, which exactly fills the standard U-Boot partition.

---

## File Type Comparison

| Property | hame-mpr-a1-v22-uboot128.bin | Typical OEM A5-V11 U-Boot |
|---|---|---|
| Format | U-Boot legacy uImage | U-Boot legacy uImage |
| Architecture | MIPS | MIPS |
| SoC | Ralink RT5350 (assumed) | Ralink RT5350 |
| Load address | 0x80200000 | 0x80200000 (typical) |
| Entry point | 0x80200000 | 0x80200000 (typical) |
| Image type | Standalone Program | Standalone Program |

---

## Strings Analysis

Key strings found in hame-mpr-a1-v22-uboot128.bin:

| String | Significance |
|---|---|
| `U-Boot 1.1.7 (Dec 13 2011 - 13:49:42)` | Older U-Boot build (2011 vs 2013 for CAND-001/002) |
| `RAMDisk Image` | Supports ramdisk boot |
| `MX25L12805D`, `MX25L25635E`, `S25FL128P` | Supported flash chips |
| `DRAM_SIZE: %d Mbits` | DRAM detection |

---

## Comparison With uboot128.img (CAND-001)

| Property | hame-mpr-a1-v22-uboot128.bin | uboot128.img (CAND-001) |
|---|---|---|
| File size | 131072 bytes | 105472 bytes |
| U-Boot version | 1.1.7 | 1.1.3 |
| Build date | Dec 13 2011 | Jul 31 2013 |
| Target hardware | Hame MPR-A1 | Generic RT5350 (A5-V11 compatible) |
| USB boot | Not confirmed | Not confirmed |
| Load address | 0x80200000 | 0x80200000 |

---

## Target Hardware Assessment

| Property | Assessment |
|---|---|
| Named target | Hame MPR-A1 v22 |
| A5-V11 compatibility | UNKNOWN - not confirmed |
| SoC match | RT5350F (same SoC family) |
| PCB match | Different PCB from A5-V11 |
| Factory partition format | May differ from A5-V11 |

The Hame MPR-A1 and A5-V11 use the same RT5350F SoC but are different PCB designs.

The bootloader for one may not be directly compatible with the other.

This file is documented for reference only.

---

## RAM Configuration Assessment

The `uboot128` in the filename indicates this is for **128 Mbit (16 MB) DRAM**.

This file is only relevant for boards with 16 MB RAM.

---

## Overall Assessment

| Property | Result |
|---|---|
| Format compatibility | Structurally valid RT5350 U-Boot image |
| Partition fit | Yes (exact 128 KB) |
| Target hardware match | NO - for Hame MPR-A1, not A5-V11 |
| RAM compatibility | 16 MB RAM only |
| Source trust level | Medium (GitHub, old 2011 build) |
| Ready to flash on A5-V11 | NO - wrong target hardware |

---

## Recommendation

Do not use this bootloader on an A5-V11.

It is for the Hame MPR-A1 v22 hardware.

Use CAND-001 (uboot128.img) for 16 MB RAM A5-V11 boards instead.

---

## Status

Comparison Status: Analyzed (candidate analyzed, not recommended for A5-V11 use)

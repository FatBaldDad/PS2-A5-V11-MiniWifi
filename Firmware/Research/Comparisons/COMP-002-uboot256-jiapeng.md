# COMP-002 - Comparison: uboot256.img (JiapengLi) vs OEM Dump

## Summary

This document compares CAND-002 (uboot256.img from JiapengLi/OpenWrt-RT5350) against the known A5-V11 OEM dump structure.

---

## Files Compared

| Item | Value |
|---|---|
| Candidate | uboot256.img |
| Candidate Source | JiapengLi/OpenWrt-RT5350 |
| Candidate SHA256 | 6af9bfcf3326df3a9da1355338198af8b8e8709ab7f96e9171ae8766b8830d81 |
| OEM Dump | Not available in this repo (board-specific) |
| Comparison Type | Candidate analysis vs known OEM structure |

---

## File Size Comparison

| File | Size |
|---|---|
| uboot256.img | 105504 bytes (103 KB) |
| Stock A5-V11 U-Boot partition | 128 KB (131072 bytes) typical |
| Fit in stock U-Boot partition? | Yes - 105504 < 131072 |

---

## File Type Comparison

| Property | uboot256.img | Typical OEM A5-V11 U-Boot |
|---|---|---|
| Format | U-Boot legacy uImage | U-Boot legacy uImage |
| Architecture | MIPS | MIPS |
| SoC | Ralink RT5350 | Ralink RT5350 |
| Load address | 0x80200000 | 0x80200000 (typical) |
| Entry point | 0x80200000 | 0x80200000 (typical) |
| Image type | Standalone Program | Standalone Program |
| Magic bytes (offset 0) | 27 05 19 56 | 27 05 19 56 (uImage magic) |

---

## Strings Analysis

Key strings found in uboot256.img:

| String | Significance |
|---|---|
| `U-Boot 1.1.3 (Apr 11 2013 - 00:10:51)` | OpenWrt-era U-Boot build for RT5350 |
| `Ralink UBoot Version` | Confirms Ralink/MediaTek origin |
| `Board: Ralink APSoC` | Ralink APSoC confirmation |
| `RT5350 #` | U-Boot prompt, confirms RT5350 |
| `MX25L12805D`, `MX25L25635E`, `S25FL128P` | Supported flash chips (4 MB options) |
| `kernel_addr=BFC40000` | Kernel load address |
| `DRAM_SIZE: %d Mbits` | DRAM size detection |

---

## Comparison With uboot128.img (CAND-001)

| Property | uboot128.img (CAND-001) | uboot256.img (CAND-002) |
|---|---|---|
| File size | 105472 bytes | 105504 bytes |
| Size difference | — | +32 bytes |
| Build date | Jul 31 2013 | Apr 10 2013 |
| uboot256 built earlier | — | Yes (earlier by ~4 months) |
| Differing bytes | 85393 (of 105472 compared) | — |
| Load address | 0x80200000 | 0x80200000 |
| Entry point | 0x80200000 | 0x80200000 |
| Flash chip support | Same | Same |
| U-Boot prompt | RT5350 # | RT5350 # |

The two files differ in 85393 bytes of the common 105472 bytes that can be compared.
This is expected: DRAM timing registers, configuration constants, CRC values, and build timestamp strings all differ.

---

## Partition Layout Comparison

| Property | uboot256.img | Typical OEM A5-V11 |
|---|---|---|
| U-Boot partition offset | 0x00000 | 0x00000 |
| U-Boot size | 105504 bytes | ~105-128 KB typical |
| Kernel address | 0xBFC40000 | 0xBFC40000 (typical) |
| RAM layout | 0x80200000 | 0x80200000 (typical) |

---

## RAM Configuration Assessment

The `256` in the filename indicates this bootloader is configured for **256 Mbit (32 MB) DRAM**.

Stock A5-V11 boards most commonly ship with 32 MB RAM (256 Mbit).

**This is the correct bootloader variant for most stock A5-V11 boards.**

---

## Overall Assessment

| Property | Result |
|---|---|
| Format compatibility | Compatible (valid RT5350 U-Boot image) |
| Partition fit | Yes (fits in 128 KB U-Boot partition) |
| Kernel address compatible | Yes |
| RAM compatibility | 32 MB RAM (most common A5-V11 config) |
| Source trust level | Medium-High (GitHub, referenced in many OpenWrt guides) |
| Most appropriate for standard board | Yes |
| Ready to flash | NO - must verify RAM via UART boot log first |

---

## Required Steps Before Use

1. Confirm board RAM is 32 MB (256 Mbit DRAM) via UART boot log
2. Confirm board is an A5-V11 RT5350F
3. Backup original flash
4. Have recovery plan ready
5. Only then consider flashing

---

## Status

Comparison Status: Analyzed (candidate analyzed, no physical OEM dump available for direct comparison)

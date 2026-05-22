# COMP-004 - Comparison: uboot256.img (WErt/4PDA) vs OEM Dump

## Summary

This document compares CAND-004 (uboot256.img from WErt/4PDA, mirrored at ozayturay/OpenWrt-A5-V11) against the known A5-V11 OEM dump structure.

---

## Files Compared

| Item | Value |
|---|---|
| Candidate | uboot256.img (WErt/4PDA build) |
| Candidate Source | wertwert4pda/rt5350f-uboot (now 404) via ozayturay/OpenWrt-A5-V11 |
| Candidate SHA256 | 1008f4144a3e7343f8612dbd43396b0fa7d66dfff32bd102a5f47c10b22fa9b9 |
| OEM Dump | Not available in this repo (board-specific) |
| Comparison Type | Candidate analysis vs known OEM structure and CAND-002 |

---

## File Size Comparison

| File | Size |
|---|---|
| uboot256.img (WErt/4PDA) | 138396 bytes (135 KB) |
| uboot256.img (JiapengLi, CAND-002) | 105504 bytes (103 KB) |
| Stock A5-V11 U-Boot partition | 128 KB (131072 bytes) typical |
| Fit in standard 128 KB U-Boot partition? | NO - 138396 > 131072 |

**Important:** This file is 138396 bytes, which is LARGER than the standard 128 KB U-Boot partition.

If the stock A5-V11 has a 128 KB bootloader partition, this file WILL NOT fit.

This file was likely designed for a board with a larger bootloader partition, or it uses a non-standard partition layout.

The GorGylka UDPBD project uses a related file (`uboot_usb_256_03.img`) and explicitly instructs flashing it with `mtd_write write /media/sda1/uboot_usb_256_03.img Bootloader`, which suggests it has been tested and works in practice. However, the exact partition sizes on the specific tested board must be confirmed.

---

## File Type Comparison

| Property | uboot256.img (WErt/4PDA) | Typical OEM A5-V11 U-Boot |
|---|---|---|
| Format | U-Boot legacy uImage | U-Boot legacy uImage |
| Architecture | MIPS | MIPS |
| SoC | Ralink RT5350 | Ralink RT5350 |
| Load address | 0x80200000 | 0x80200000 (typical) |
| Entry point | 0x80200000 | 0x80200000 (typical) |
| Image type | Standalone Program | Standalone Program |

---

## Strings Analysis

Key strings found in uboot256.img (WErt/4PDA):

| String | Significance |
|---|---|
| `U-Boot 1.1.3 Rev 0.3 by WErt(WErt) 4PDA (May 19 2016 - 14:41:04)` | Community-modified U-Boot, 2016 build |
| `USB Storage` | USB storage support added |
| `Upgrade FW from USB storage` | USB firmware upgrade capability |
| `Upgrade U-Boot from USB storage` | USB bootloader upgrade capability |
| `usbboot` | USB boot command |
| `DRAM_SIZE: %d Mbits` | DRAM detection |
| `DRAM_CONF_FROM: EEPROM` | DRAM config source |

---

## Comparison With uboot256.img (CAND-002 - JiapengLi)

| Property | CAND-002 (JiapengLi) | CAND-004 (WErt/4PDA) |
|---|---|---|
| File size | 105504 bytes | 138396 bytes |
| Size difference | — | +32892 bytes larger |
| Build date | Apr 10 2013 | May 19 2016 |
| U-Boot version | 1.1.3 | 1.1.3 Rev 0.3 |
| Builder | Ralink/community | WErt, 4PDA community |
| USB boot support | Not confirmed | Yes - explicitly present |
| Fits 128 KB partition? | Yes | No - too large |
| Source available? | GitHub (active) | Original source 404 |

---

## USB Boot Feature Assessment

The WErt/4PDA bootloader adds USB boot capability.

This allows:
- Booting firmware from a USB drive
- Upgrading firmware from a USB drive
- Upgrading the bootloader itself from a USB drive

This is the key feature used in the GorGylka UDPBD software installation method.

---

## Partition Size Warning

The WErt/4PDA U-Boot (138396 bytes) is approximately 35% larger than the JiapengLi U-Boot (105504 bytes).

Standard A5-V11 U-Boot partition is reported as 128 KB in most documentation.

**138396 bytes exceeds 128 KB (131072 bytes) by 7324 bytes.**

One of the following must be true:
1. The stock U-Boot partition is larger than commonly documented (e.g., 192 KB or 256 KB)
2. The WErt/4PDA build requires a non-standard partition layout
3. The GorGylka install instructions modify the partition layout as part of the process

This needs further investigation before use.

The GorGylka project has apparently used this bootloader successfully, so it is likely that either the partition is larger or the install process accounts for the size difference.

---

## Overall Assessment

| Property | Result |
|---|---|
| Format compatibility | Compatible (valid RT5350 U-Boot image) |
| Partition fit | UNCERTAIN - file exceeds standard 128 KB partition |
| Kernel address compatible | Likely yes (load address matches) |
| RAM compatibility | 32 MB RAM (256 Mbit) |
| Source trust level | Medium (community build, original source gone) |
| USB boot | Yes - confirmed from strings |
| Ready to flash | NO - partition size concern must be resolved first |

---

## Required Steps Before Use

1. Confirm board RAM is 32 MB (256 Mbit DRAM) via UART boot log
2. Determine actual bootloader partition size via OEM dump analysis
3. Confirm the file fits within the available bootloader space
4. Backup original flash
5. Have recovery plan ready
6. Reference GorGylka UDPBD documentation for tested install procedure

---

## Status

Comparison Status: Analyzed (candidate analyzed, partition size concern documented)

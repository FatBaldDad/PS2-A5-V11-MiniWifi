# CAND-003 - hame-mpr-a1-v22-uboot128.bin (JiapengLi)

## Basic Info

| Item | Value |
|---|---|
| Candidate ID | CAND-003 |
| Original Filename | hame-mpr-a1-v22-uboot128.bin |
| Source Repository | JiapengLi/OpenWrt-RT5350 |
| Source URL | https://github.com/JiapengLi/OpenWrt-RT5350/raw/007b3569e1684c8771c09405c420c8adfd2267e7/u-boot/hame-mpr-a1-v22-uboot128.bin |
| Source HTML | https://github.com/JiapengLi/OpenWrt-RT5350/blob/master/u-boot/hame-mpr-a1-v22-uboot128.bin |
| Source Type | GitHub repository |
| File Type | U-Boot legacy uImage, SPI Flash Image |
| File Size | 131072 bytes |
| SHA256 | 20688d081821ed9fe2dc0500f8cadd690bd0a2798fc9c416d6f334128d1bed53 |
| Git Blob SHA | 8a36829e5b7153ccd625693eb60920f3a6182fe8 |
| Status | Analyzed |
| Research Date | 2026-05-22 |

---

## Firmware Details

| Item | Value |
|---|---|
| U-Boot Version | 1.1.7 |
| Build Date | Tue Dec 13 2011 13:49:42 |
| SoC | Ralink RT5350 (assumed - same family) |
| Load Address | 0x80200000 |
| Entry Point | 0x80200000 |
| Architecture | MIPS |
| Image Type | Standalone Program (Not compressed) |
| Data Size | 108428 bytes (after 64-byte uImage header) |
| Header CRC | 0x0FDEC3AA |
| Data CRC | 0x02540165 |

---

## RAM Compatibility

| Item | Value |
|---|---|
| Target RAM | 128 Mbit = 16 MB |
| DRAM Type | SDRAM |
| DRAM Config Source | EEPROM |

The filename includes `uboot128` which indicates this is for **16 MB RAM (128 Mbit DRAM)** boards.

---

## Target Hardware

| Item | Value |
|---|---|
| Named target | Hame MPR-A1 (v22) |
| Related hardware | Hame MPR-A1 uses the same Ralink RT5350F SoC |
| A5-V11 compatibility | Unknown - NOT confirmed for A5-V11 |

This bootloader is labeled for the Hame MPR-A1 v22, not the A5-V11.

The Hame MPR-A1 is a related RT5350F device but is NOT the same PCB.

Do not assume this bootloader works on an A5-V11 without additional verification.

---

## Flash Chip Strings

The following flash chip names were found in the image:

- MX25L12805D
- MX25L25635E
- S25FL128P

---

## Source Notes

This file is in the same repo as CAND-001 and CAND-002.

It is an older U-Boot 1.1.7 build from 2011 compared to the 2013 builds in CAND-001/002.

It is documented here as a reference for comparison purposes.

It is NOT recommended for use on an A5-V11 without further research.

---

## Risk Warning

This is not a confirmed A5-V11 bootloader.

Flashing this on an A5-V11 could cause a brick.

Document only - do not use without additional research.

---

## Comparison

See: `Firmware/Research/Comparisons/COMP-003-hame-mpr-a1-v22-uboot128.md`

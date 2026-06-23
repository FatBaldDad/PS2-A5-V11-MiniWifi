# CAND-001 - uboot128.img (JiapengLi)

## Basic Info

| Item | Value |
|---|---|
| Candidate ID | CAND-001 |
| Original Filename | uboot128.img |
| Source Repository | JiapengLi/OpenWrt-RT5350 |
| Source URL | https://github.com/JiapengLi/OpenWrt-RT5350/raw/007b3569e1684c8771c09405c420c8adfd2267e7/u-boot/uboot128.img |
| Source HTML | https://github.com/JiapengLi/OpenWrt-RT5350/blob/master/u-boot/uboot128.img |
| Source Type | GitHub repository |
| File Type | U-Boot legacy uImage, SPI Flash Image |
| File Size | 105472 bytes |
| SHA256 | de7d3c5842defd10cc0cc1457bc7e634aaf13e543905c06b11084eaf96f7d1a1 |
| Git Blob SHA | 9113af9cacf000fad8b9eb33ee37a8216687b047 |
| Status | Analyzed |
| Research Date | 2026-05-22 |

---

## Firmware Details

| Item | Value |
|---|---|
| U-Boot Version | 1.1.3 |
| Build Date | Wed Jul 31 2013 23:35:04 |
| SoC | Ralink RT5350 |
| Load Address | 0x80200000 |
| Entry Point | 0x80200000 |
| Architecture | MIPS |
| Image Type | Standalone Program (Not compressed) |
| Data Size | 105408 bytes (after 64-byte uImage header) |
| Header CRC | 0x6E6701F3 |
| Data CRC | 0x50CA4CE2 |

---

## RAM Compatibility

| Item | Value |
|---|---|
| Target RAM | 128 Mbit = 16 MB |
| DRAM Type | SDRAM |
| DRAM Config Source | EEPROM |

This bootloader is for boards with **16 MB RAM (128 Mbit DRAM)**.

Do not use on boards with 32 MB RAM unless verified.

---

## Flash Chip Strings

The following flash chip names were found in the image:

- MX25L12805D
- MX25L25635E
- S25FL128P
- AT25DF321
- AT26DF161
- FL016AIF

This suggests the bootloader supports common SPI flash chips.

---

## Partition Behavior

| Item | Value |
|---|---|
| kernel_addr | BFC40000 |
| TFTP boot | Supported |

The bootloader uses `BFC40000` as the kernel address.

---

## Source Notes

This is one of the two canonical A5-V11 bootloader files frequently referenced in OpenWrt guides for the RT5350.

The `uboot128.img` and `uboot256.img` pair from this repo is the most widely cited A5-V11 bootloader source.

This repository also contains recovery scripts and OpenWrt notes for the Hame MPR-A1 and HLK-RM04, which share the RT5350F SoC.

---

## Risk Warning

Flashing the wrong bootloader can hard-brick the router.

Do not flash this on a 32 MB RAM board.

Do not flash without a recovery plan and a backup of the original flash.

---

## Comparison

See: `Firmware/Research/Comparisons/COMP-001-uboot128-jiapeng.md`

# CAND-002 - uboot256.img (JiapengLi)

## Basic Info

| Item | Value |
|---|---|
| Candidate ID | CAND-002 |
| Original Filename | uboot256.img |
| Source Repository | JiapengLi/OpenWrt-RT5350 |
| Source URL | https://github.com/JiapengLi/OpenWrt-RT5350/raw/007b3569e1684c8771c09405c420c8adfd2267e7/u-boot/uboot256.img |
| Source HTML | https://github.com/JiapengLi/OpenWrt-RT5350/blob/master/u-boot/uboot256.img |
| Source Type | GitHub repository |
| File Type | U-Boot legacy uImage, SPI Flash Image |
| File Size | 105504 bytes |
| SHA256 | 6af9bfcf3326df3a9da1355338198af8b8e8709ab7f96e9171ae8766b8830d81 |
| Git Blob SHA | 0b59221eb41acf0b8ba470d3f02ff726b840b9d1 |
| Status | Analyzed |
| Research Date | 2026-05-22 |

---

## Firmware Details

| Item | Value |
|---|---|
| U-Boot Version | 1.1.3 |
| Build Date | Wed Apr 10 2013 16:10:55 |
| SoC | Ralink RT5350 |
| Load Address | 0x80200000 |
| Entry Point | 0x80200000 |
| Architecture | MIPS |
| Image Type | Standalone Program (Not compressed) |
| Data Size | 105440 bytes (after 64-byte uImage header) |
| Header CRC | 0x4E07BB56 |
| Data CRC | 0x705C7FF5 |

---

## RAM Compatibility

| Item | Value |
|---|---|
| Target RAM | 256 Mbit = 32 MB |
| DRAM Type | SDRAM |
| DRAM Config Source | EEPROM |

This bootloader is for boards with **32 MB RAM (256 Mbit DRAM)**.

Do not use on boards with 16 MB RAM unless verified.

---

## Flash Chip Strings

The following flash chip names were found in the image:

- MX25L12805D
- MX25L25635E
- S25FL128P
- AT25DF321
- AT26DF161
- FL016AIF

---

## Partition Behavior

| Item | Value |
|---|---|
| kernel_addr | BFC40000 |
| TFTP boot | Supported |

---

## Relationship To CAND-001

CAND-001 (uboot128.img) and CAND-002 (uboot256.img) differ only in RAM configuration.

Key differences found via binary comparison:

| Property | uboot128.img | uboot256.img |
|---|---|---|
| File size | 105472 bytes | 105504 bytes |
| Build date | Jul 31 2013 | Apr 10 2013 |
| uboot256 built earlier | No | Yes |
| Total differing bytes | 85393 of 105472 | — |

The files differ in 85393 of the 105472 bytes where they can be compared.
This is expected: the RAM configuration registers, DRAM timing, CRC values, and date constants all differ.

---

## Source Notes

This is the 32 MB RAM counterpart to `uboot128.img`.

The standard A5-V11 as sold commonly uses 32 MB RAM (256 Mbit).

Most OpenWrt guides for the A5-V11 recommend `uboot256.img` for standard boards.

The GorGylka UDPBD project also requires this bootloader variant for standard A5-V11 hardware (32 MB RAM).

---

## Risk Warning

Flashing the wrong bootloader can hard-brick the router.

Do not flash this on a 16 MB RAM board.

Do not flash without a recovery plan and a backup of the original flash.

---

## Comparison

See: `Firmware/Research/Comparisons/COMP-002-uboot256-jiapeng.md`

# CAND-004 - uboot256.img (WErt/4PDA via ozayturay)

## Basic Info

| Item | Value |
|---|---|
| Candidate ID | CAND-004 |
| Original Filename | uboot256.img |
| Source Repository | wertwert4pda/rt5350f-uboot (now 404) mirrored at ozayturay/OpenWrt-A5-V11 |
| Source URL | https://github.com/ozayturay/OpenWrt-A5-V11/raw/c75a30c5bf1612bafd40181143f830504a731161/uboot256.img |
| Source HTML | https://github.com/ozayturay/OpenWrt-A5-V11/blob/master/uboot256.img |
| Original Source URL | https://github.com/wertwert4pda/rt5350f-uboot (404 - repository deleted or removed) |
| Source Type | GitHub repository (mirror) |
| File Type | U-Boot legacy uImage, SPI Flash Image |
| File Size | 138396 bytes |
| SHA256 | 1008f4144a3e7343f8612dbd43396b0fa7d66dfff32bd102a5f47c10b22fa9b9 |
| Git Blob SHA | 8b08472c6c0454a4ea6bbe929b72e7c81d48395d |
| Status | Analyzed |
| Research Date | 2026-05-22 |

---

## Firmware Details

| Item | Value |
|---|---|
| U-Boot Version | 1.1.3 Rev 0.3 by WErt(WErt) 4PDA |
| Build Date | Thu May 19 2016 14:41:04 |
| SoC | Ralink RT5350 |
| Load Address | 0x80200000 |
| Entry Point | 0x80200000 |
| Architecture | MIPS |
| Image Type | Standalone Program (Not compressed) |
| Data Size | 138332 bytes (after 64-byte uImage header) |
| Header CRC | 0x99FA73D4 |
| Data CRC | 0x1D0A49F0 |

---

## RAM Compatibility

| Item | Value |
|---|---|
| Target RAM | 256 Mbit = 32 MB |
| DRAM Type | SDRAM |
| DRAM Config Source | EEPROM |

This bootloader is for boards with **32 MB RAM (256 Mbit DRAM)**.

---

## Key Feature: USB Boot

This is a community-modified U-Boot that adds USB boot support.

USB-related features found in strings:

- USB storage detection
- USB firmware upgrade (`Upgrade FW from USB storage`)
- USB bootloader upgrade (`Upgrade U-Boot from USB storage`)
- `usbboot` command

This is the bootloader referenced in the GorGylka UDPBD guide for the software install method.

The GorGylka guide calls a similar file `uboot_usb_256_03.img`.

---

## Relationship To CAND-002

CAND-004 is a different file from CAND-002 (JiapengLi uboot256.img).

| Property | CAND-002 (JiapengLi) | CAND-004 (WErt/4PDA) |
|---|---|---|
| File size | 105504 bytes | 138396 bytes |
| Build date | Apr 10 2013 | May 19 2016 |
| Builder | Ralink / unknown | WErt, 4PDA community |
| USB boot support | Not confirmed | Yes |
| Original source | JiapengLi GitHub | wertwert4pda GitHub (now 404) |

They are different bootloaders for the same RAM configuration.

---

## Source Provenance Concern

The original `wertwert4pda/rt5350f-uboot` GitHub repository that produced this file returned 404 at time of research (2026-05-22).

The file exists as a copy in `ozayturay/OpenWrt-A5-V11`.

The original source is no longer verifiable directly.

The binary was analyzed locally and confirmed to be a valid U-Boot image for RT5350.

The community attribution `WErt(WErt) 4PDA` is embedded in the binary strings.

Use with awareness that the primary source is no longer active.

---

## Risk Warning

Flashing the wrong bootloader can hard-brick the router.

Do not flash this on a 16 MB RAM board.

Do not flash without a recovery plan and a backup of the original flash.

The original source repository is no longer accessible, which reduces provenance confidence.

---

## Comparison

See: `Firmware/Research/Comparisons/COMP-004-uboot256-wert-4pda.md`

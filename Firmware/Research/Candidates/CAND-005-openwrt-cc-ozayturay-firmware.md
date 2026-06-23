# CAND-005 - firmware.bin Chaos Calmer (ozayturay)

## Basic Info

| Item | Value |
|---|---|
| Candidate ID | CAND-005 |
| Original Filename | firmware.bin |
| Source Repository | ozayturay/OpenWrt-A5-V11 |
| Source URL | https://github.com/ozayturay/OpenWrt-A5-V11/raw/c75a30c5bf1612bafd40181143f830504a731161/firmware.bin |
| Source HTML | https://github.com/ozayturay/OpenWrt-A5-V11/blob/master/firmware.bin |
| Source Type | GitHub repository |
| File Type | U-Boot legacy uImage, MIPS OpenWrt Linux, OS Kernel Image (lzma) |
| File Size | 3670020 bytes (approx 3.5 MB) |
| SHA256 | c34516fbc3a0406a189f8e57e6ea6660a9ad4a3f5098b873291c8a45511d779b |
| Git Blob SHA | f29aad351df3a4ad24ccaadd684a875192ee7bec |
| Status | Analyzed |
| Research Date | 2026-05-22 |

---

## Firmware Details

| Item | Value |
|---|---|
| OpenWrt Release | Chaos Calmer era (approx) |
| Linux Kernel Version | 3.18.23 |
| Build Date | Tue Aug 30 2016 19:17:00 |
| Architecture | MIPS |
| Load Address | 0x80000000 |
| Entry Point | 0x80000000 |
| Header CRC | 0xCA3DA5DF |
| Data CRC | 0x4A17BCC5 |
| Compression | lzma |
| Image Name | MIPS OpenWrt Linux-3.18.23 |

---

## Target Hardware

| Item | Value |
|---|---|
| Named target | A5-V11 (per repo name and README) |
| SoC | Ralink RT5350F |
| Flash size needed | 4 MB |
| RAM needed | Unknown RAM (32 MB assumed based on common A5-V11 configuration) |

---

## Build Configuration

Per the source README, this image was built with:

```
make image PROFILE="A5-V11" PACKAGES="-luci nano blkid block-mount kmod-nls-cp437 kmod-nls-iso8859-1 kmod-nls-utf8 kmod-fs-vfat kmod-fs-ext4 kmod-usb-storage-extras"
```

Notable points:

- LuCI web UI removed (`-luci`)
- USB storage support added
- ext4 and vfat filesystem support included
- OpenWrt Chaos Calmer era, kernel 3.18

---

## File Size Notes

File size is 3670020 bytes (approx 3.5 MB).

This is unusually large for a 4 MB flash target.

Standard A5-V11 has 4 MB flash.

The kernel image alone at 3.5 MB leaves very little space for rootfs on a 4 MB flash chip.

This may be a combined kernel+rootfs image or it may require careful flash partition sizing.

**This needs further analysis before any flash attempt.**

---

## Source Notes

This is a historical pre-built image.

The source repo (ozayturay/OpenWrt-A5-V11) has no documented checksums for this file.

The build date is 2016, which is consistent with OpenWrt Chaos Calmer (2015-2016 era).

Linux 3.18.23 is typical of the Chaos Calmer era for MIPS targets.

The repo README says this image was for testing USB storage and extroot on the A5-V11.

---

## Risk Warning

- This is an old 2016 firmware image.
- The file is 3.5 MB which is very large for a 4 MB flash target.
- Do not flash without careful partition analysis.
- No LuCI - web access not available after flash.
- LuCI must be installed separately via opkg if needed.
- This firmware is not PS2-focused.

---

## Comparison

See: `Firmware/Research/Comparisons/COMP-005-openwrt-cc-ozayturay-firmware.md`

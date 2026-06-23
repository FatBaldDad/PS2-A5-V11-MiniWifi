# COMP-005 - Comparison: firmware.bin Chaos Calmer (ozayturay) vs OEM Dump

## Summary

This document compares CAND-005 (firmware.bin from ozayturay/OpenWrt-A5-V11) against the known A5-V11 OEM dump structure.

---

## Files Compared

| Item | Value |
|---|---|
| Candidate | firmware.bin (Chaos Calmer era, kernel 3.18.23) |
| Candidate Source | ozayturay/OpenWrt-A5-V11 |
| Candidate SHA256 | c34516fbc3a0406a189f8e57e6ea6660a9ad4a3f5098b873291c8a45511d779b |
| OEM Dump | Not available in this repo (board-specific) |
| Comparison Type | Candidate analysis vs known OEM structure |

---

## File Size Comparison

| File | Size |
|---|---|
| firmware.bin (ozayturay) | 3670020 bytes (approx 3.5 MB) |
| Stock kernel + rootfs space on 4 MB A5-V11 | approx 3.75 MB (after U-Boot + env + factory partitions) |
| OEM kernel partition (typical) | 1152 KB (0x120000) |
| OEM rootfs partition (typical) | 2624 KB (0x290000) |
| Combined kernel + rootfs (typical) | 3776 KB |
| Firmware.bin fits? | Yes - 3670020 < 3866624 (3776 KB) |

The firmware image at 3.5 MB is large but should fit in the combined kernel+rootfs space of a 4 MB flash layout.

---

## File Type Comparison

| Property | firmware.bin | Typical OEM A5-V11 Firmware |
|---|---|---|
| Format | U-Boot legacy uImage (kernel) | U-Boot legacy uImage (kernel) |
| Architecture | MIPS | MIPS |
| Linux kernel version | 3.18.23 | Varies (stock uses older 2.6.x in some versions) |
| Compression | lzma | lzma (typical) |
| Load address | 0x80000000 | 0x80000000 (typical) |
| Entry point | 0x80000000 | 0x80000000 (typical) |
| Image type | OS Kernel Image | OS Kernel Image |

---

## Strings Analysis

Key strings found in firmware.bin:

| String | Significance |
|---|---|
| `MIPS OpenWrt Linux-3.18.23` | OpenWrt Chaos Calmer era kernel |
| Linux kernel 3.18.23 | Chaos Calmer used 3.18.x for RT5350 |

---

## Comparison With OEM Firmware

| Property | firmware.bin (ozayturay) | OEM A5-V11 Stock |
|---|---|---|
| OS | OpenWrt (Chaos Calmer era) | Vendor firmware (BusyBox based) |
| Kernel version | Linux 3.18.23 | Older (2.6.x or similar, vendor patched) |
| Web UI | None (LuCI removed) | Yes (vendor web UI) |
| Telnet | Available by default (OpenWrt) | Available by default (vendor) |
| USB storage | Supported | Limited support (vendor) |
| Wi-Fi calibration | Loaded from factory partition | Loaded from factory partition |
| Build date | Aug 30 2016 | Unknown |

---

## Build Configuration

Per the source README, this image was built with:

```
make image PROFILE="A5-V11" PACKAGES="-luci nano blkid block-mount kmod-nls-cp437 kmod-nls-iso8859-1 kmod-nls-utf8 kmod-fs-vfat kmod-fs-ext4 kmod-usb-storage-extras"
```

This is a minimal OpenWrt image with USB storage support but no LuCI.

---

## Flash Layout Compatibility

Standard A5-V11 flash layout (4 MB):

| Partition | Offset | Size |
|---|---|---|
| u-boot | 0x00000 | 0x20000 (128 KB) |
| u-boot-env | 0x20000 | 0x10000 (64 KB) |
| factory | 0x30000 | 0x10000 (64 KB) |
| kernel | 0x40000 | 0x120000 (1152 KB) |
| rootfs | 0x160000 | 0x290000 (2624 KB) |
| rootfs_data | 0x3F0000 | small |

The firmware.bin at 3670020 bytes maps to:
- Standard kernel + rootfs combined = 3776 KB available
- firmware.bin = 3580 KB used
- Remaining = ~196 KB for rootfs_data overlay

This is tight but may work depending on the exact OpenWrt squashfs structure.

---

## Overall Assessment

| Property | Result |
|---|---|
| Format compatibility | Compatible (valid MIPS Linux kernel image) |
| Flash size fit | Tight but likely fits in 4 MB flash |
| Web UI | None (LuCI removed) |
| USB storage | Supported |
| Age | 2016 (Chaos Calmer era) |
| PS2 suitability | Not specifically designed for PS2 use |
| Source trust level | Medium (GitHub, 2016 build, no LuCI) |
| Ready to flash | NO - needs further analysis, old firmware |

---

## Recommendation

This firmware is not recommended for PS2 use.

It was designed for generic A5-V11 USB storage and extroot testing.

For PS2 UDPBD use, the GorGylka UDPBD firmware (CAND-006/CAND-007) is more appropriate.

For general OpenWrt testing on A5-V11, use a more recent OpenWrt 17.01.7 or 19.07 image.

---

## Status

Comparison Status: Analyzed (candidate analyzed, not recommended for PS2 use)

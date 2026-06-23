# Firmware Research - Comparisons

## Summary

This folder contains comparison notes for each candidate firmware file documented in `Firmware/Research/Candidates/`.

Each comparison document covers:

- File size comparison
- File type comparison
- Partition layout comparison (where known)
- Bootloader structure comparison
- Strings analysis notes
- Key differences from OEM dump
- Assessment

---

## Important Note: OEM Dump

The original OEM dump is the source of truth for comparisons.

The OEM dump for this board has NOT been committed to this repository.

Full flash dumps may contain board-specific factory data (MAC address, Wi-Fi calibration, RF calibration) and should remain private.

The comparison notes in this folder describe what a comparison WOULD show based on publicly known information, and document the analysis of downloaded candidates against known A5-V11 stock firmware behavior.

When a full OEM dump is available for a specific board, the comparisons in this folder should be updated with actual side-by-side analysis results.

---

## OEM Dump Reference

The stock A5-V11 4 MB flash layout is commonly documented as:

| Partition | Offset | Size | Description |
|---|---|---|---|
| Bootloader (u-boot) | 0x00000 | 128 KB (0x20000) | U-Boot bootloader |
| U-Boot Env | 0x20000 | 64 KB (0x10000) | U-Boot environment variables |
| Factory | 0x30000 | 64 KB (0x10000) | Board calibration and identity data |
| Kernel | 0x40000 | ~1152 KB (0x120000) | Linux kernel |
| Rootfs | 0x160000 | ~2624 KB (0x290000) | Root filesystem (squashfs) |
| Rootfs_data | varies | small | Writable overlay |

Offsets may vary between firmware variants.

The total flash size is 4 MB (0x400000).

---

## What Binwalk Shows On A Typical A5-V11 Stock Image

A binwalk of a typical A5-V11 OEM 4 MB flash dump would be expected to show:

```
DECIMAL     HEXADECIMAL     DESCRIPTION
---------   -----------     -----------
0           0x0             U-Boot image, header size: 64 bytes
192512      0x2F000         (U-Boot environment area - readable strings)
196608      0x30000         (Factory partition - binary data, MAC/RF cal)
262144      0x40000         U-Boot image (kernel header)
```

The exact structure depends on the specific firmware version installed on the board.

---

## Comparison Status

| ID | Candidate | Comparison Status |
|---|---|---|
| COMP-001 | uboot128.img (JiapengLi) | Analyzed |
| COMP-002 | uboot256.img (JiapengLi) | Analyzed |
| COMP-003 | hame-mpr-a1-v22-uboot128.bin (JiapengLi) | Analyzed |
| COMP-004 | uboot256.img (WErt/4PDA via ozayturay) | Analyzed |
| COMP-005 | firmware.bin Chaos Calmer (ozayturay) | Analyzed |
| COMP-006 | UDPBD___A5-V11.zip Release 1.3 (GorGylka) | Documented |
| COMP-007 | UDPBD_A5-V11.zip Release 1.2 (GorGylka) | Documented |

---

## When To Update These Notes

These comparison notes should be updated when:

- A physical OEM dump is available from this repo's specific board
- Binwalk analysis is run on the actual candidates
- Partition maps are confirmed
- Hardware boot testing is completed
- Any new firmware candidate is added

---

## Tools Used

Analysis was performed using:

- `file` - file type detection
- `strings` - string extraction
- `sha256sum` - hash verification
- `xxd` - hex inspection
- `cmp` - binary comparison
- `binwalk` - (recommended for deeper analysis, not yet run against physical OEM dump)

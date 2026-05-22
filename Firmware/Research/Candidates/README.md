# Firmware Research - Candidates

## Summary

This folder contains one metadata file per candidate firmware image or bootloader found during research.

No binary files are stored here.

Binary files should not be committed to this repo without a clear source, license, target hardware, and risk warning.

See `Firmware/Binary-Policy.md` for full rules.

---

## What Is A Candidate

A candidate is a publicly available firmware image or bootloader that:

- Is intended for or compatible with the A5-V11, RT5350F, or similar hardware
- Was found in a verified public source
- Has been documented with sufficient metadata to identify, verify, and evaluate it
- Has NOT been flashed or tested on this repo's hardware yet

---

## Candidate Status Labels

| Status | Meaning |
|---|---|
| Documented | Metadata recorded, file not yet analyzed |
| Analyzed | File has been downloaded and analyzed locally (not committed) |
| Compared | Comparison against OEM dump is complete |
| Compatible - Pending Test | Believed compatible but not yet tested on hardware |
| Tested | Has been tested on hardware |
| Incompatible | Known to not work on this board configuration |
| Unknown RAM | RAM compatibility not yet confirmed |
| Requires 16MB RAM | For 128 Mbit / 16 MB RAM boards only |
| Requires 32MB RAM | For 256 Mbit / 32 MB RAM boards only |

---

## Candidate Index

| ID | Filename | Source | Type | RAM | Status |
|---|---|---|---|---|---|
| CAND-001 | uboot128.img | JiapengLi/OpenWrt-RT5350 | Bootloader | 16 MB (128 Mbit) | Analyzed |
| CAND-002 | uboot256.img | JiapengLi/OpenWrt-RT5350 | Bootloader | 32 MB (256 Mbit) | Analyzed |
| CAND-003 | hame-mpr-a1-v22-uboot128.bin | JiapengLi/OpenWrt-RT5350 | Bootloader | 16 MB (128 Mbit) | Analyzed |
| CAND-004 | uboot256.img (WErt/4PDA) | wertwert4pda via ozayturay | Bootloader | 32 MB (256 Mbit) | Analyzed |
| CAND-005 | firmware.bin (Chaos Calmer) | ozayturay/OpenWrt-A5-V11 | OpenWrt Firmware | Unknown RAM | Analyzed |
| CAND-006 | UDPBD___A5-V11.zip (Release 1.3) | GorGylka/UDPBD-A5-V11 | OpenWrt + PS2 Bundle | 32 MB (256 Mbit) | Documented |
| CAND-007 | UDPBD_A5-V11.zip (Release 1.2) | GorGylka/UDPBD-A5-V11 | OpenWrt + PS2 Bundle | 32 MB (256 Mbit) | Documented |

---

## Notes

- CAND-001 and CAND-002 are the canonical uboot128/uboot256 pair most commonly referenced in A5-V11 OpenWrt guides.
- CAND-003 is an older bootloader for the Hame MPR-A1 device, which shares the RT5350F SoC. It is not the same as the A5-V11 but has been documented for reference.
- CAND-004 is a community-modified U-Boot with USB boot support, from the WErt/4PDA community.
- CAND-005 is a pre-built OpenWrt Chaos Calmer era image from the ozayturay repo. It uses kernel 3.18.23.
- CAND-006 and CAND-007 are UDPBD-focused PS2 firmware bundles from GorGylka. They include a 4MB hardware flash dump in release 1.2.

---

## Warning

These candidates are documented for research purposes only.

Do not flash any candidate without:

1. Verifying the board RAM size
2. Verifying the board flash size
3. Confirming the candidate matches your hardware
4. Having a recovery plan
5. Having a backup of the original flash dump

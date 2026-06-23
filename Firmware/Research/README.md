# Firmware Research

## Summary

This folder contains firmware research notes for the A5-V11 mini router.

The goal is to document, catalog, and compare candidate firmware images and bootloaders found in public sources.

This folder does not contain flashing instructions.

This folder does not replace the OEM dump.

---

## Structure

```
Firmware/Research/
├── README.md                  (this file)
├── Candidates/                (one file per candidate firmware or bootloader)
│   ├── README.md
│   ├── CAND-001-uboot128-jiapeng.md
│   ├── CAND-002-uboot256-jiapeng.md
│   ├── CAND-003-hame-mpr-a1-v22-uboot128.md
│   ├── CAND-004-uboot256-wert-4pda.md
│   ├── CAND-005-openwrt-cc-ozayturay-firmware.md
│   ├── CAND-006-gorgylka-udpbd-release-1.3.md
│   └── CAND-007-gorgylka-udpbd-release-1.2.md
└── Comparisons/               (comparison notes per candidate vs OEM dump)
    ├── README.md
    ├── COMP-001-uboot128-jiapeng.md
    ├── COMP-002-uboot256-jiapeng.md
    ├── COMP-003-hame-mpr-a1-v22-uboot128.md
    ├── COMP-004-uboot256-wert-4pda.md
    ├── COMP-005-openwrt-cc-ozayturay-firmware.md
    ├── COMP-006-gorgylka-udpbd-release-1.3.md
    └── COMP-007-gorgylka-udpbd-release-1.2.md
```

---

## Rules

- Do not flash firmware based only on these notes.
- Do not overwrite or modify the original OEM dump.
- Do not trust unverified binaries.
- Do not download from suspicious hosts.
- Do not modify bootloaders automatically.
- Always confirm RAM size and flash size before using any candidate.
- Always confirm the bootloader matches the board's RAM configuration.

---

## Research Sources

| Source | Type | URL |
|---|---|---|
| OpenWrt Wiki A5-V11 | Wiki | https://openwrt.org/toh/unbranded/a5-v11 |
| JiapengLi/OpenWrt-RT5350 | GitHub | https://github.com/JiapengLi/OpenWrt-RT5350 |
| wertwert4pda/rt5350f-uboot | GitHub (now 404) | https://github.com/wertwert4pda/rt5350f-uboot |
| ozayturay/OpenWrt-A5-V11 | GitHub | https://github.com/ozayturay/OpenWrt-A5-V11 |
| GorGylka/UDPBD-A5-V11 | GitHub | https://github.com/GorGylka/UDPBD-A5-V11 |
| sternlabs/RT5350F-cheap-router | GitHub | https://github.com/sternlabs/RT5350F-cheap-router |

---

## Research Date

Research conducted: 2026-05-22

All findings should be reverified before use.

---

## Important Warning

A5-V11 hardware variants exist.

Some boards use 16 MB RAM (128 Mbit DRAM).

Some boards use 32 MB RAM (256 Mbit DRAM).

The bootloader must match the board's actual RAM configuration.

Using the wrong bootloader can prevent boot or cause instability.

Using the wrong firmware image can cause a brick.

Always verify board hardware before selecting any candidate from this folder.

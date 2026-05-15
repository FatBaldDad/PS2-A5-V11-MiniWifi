# Source Links

## Summary

This document is the source-link index for the A5-V11 mini router project.

The goal is to keep all important links in one clean place so the repo can properly credit community work, track research sources, and avoid losing useful references.

This repo is heavily based on public community research, older A5-V11 tutorials, OpenWrt notes, PS2 homebrew projects, and personal testing.

Use this file to track:

- A5-V11 documentation
- OpenWrt references
- Community tutorials
- GitHub repositories
- PS2 software projects
- Recovery tools
- Datasheets
- Forum posts
- Blog posts
- Build notes
- Historical sources
- Dead links
- Archive links
- Sources that still need verification

---

## Main Rule

The main rule is:

```text
Credit sources clearly and verify risky information before using it.
```

The second rule is:

```text
A link is not proof that a method works on every A5-V11 board.
```

A5-V11 boards, bootloaders, flash chips, RAM chips, and firmware behavior can vary.

---

## Source Status Labels

Use these labels in the tables below.

| Status | Meaning |
|---|---|
| Active | Link currently works and is useful |
| Historical | Useful old source, but may be outdated |
| Needs Review | Link exists but needs to be reviewed |
| Needs Archive | Important source that should be archived |
| Broken | Link appears dead |
| Unverified | Link or content has not been checked |
| Risky | Contains instructions that can brick hardware |
| Do Not Mirror | Link may contain binaries or private/sensitive files that should not be rehosted |
| Preferred | Currently preferred source for that topic |

---

## Risk Labels

Use these risk labels when tracking sources.

| Risk | Meaning |
|---|---|
| Low | Safe documentation, reference, or normal software use |
| Medium | Config changes that can cause lockout or confusion |
| High | Firmware flashing, recovery, or partition writes |
| Critical | U-Boot, factory partition, full flash, or hardware modification |

---

## Source Link Entry Template

Use this template when adding a new source.

```text
# Source Link Entry

## Basic Info

Source ID:
Title:
Author / Maintainer:
URL:
Archive URL:
Source type:
Status:
Risk level:
Date accessed:

## What It Covers

Topics:
Hardware:
Firmware:
Flash size:
RAM size:
PS2 relevance:
Recovery relevance:

## Notes

Summary:
Important warnings:
Files mentioned:
Commands mentioned:
License notes:
Redistribution notes:

## Verification

Tested by repo:
Test board ID:
Test result:
Needs retest:
Notes:
```

---

## Quick Source Table

| Source ID | Title | Type | Status | Risk | Main Topic |
|---|---|---|---|---|---|
| SRC-001 | OpenWrt A5-V11 Wiki | Wiki | Active / Access may be protected | High | Hardware, OpenWrt, recovery |
| SRC-002 | Legacy OpenWrt A5-V11 Wiki | Wiki | Historical | High | Older OpenWrt notes |
| SRC-003 | Gorgylka UDPBD-A5-V11 | GitHub | Active | High | UDPBD firmware and PS2 setup |
| SRC-004 | Gorgylka UDPBD-A5-V11 Releases | GitHub Releases | Active | High | Firmware and PS2-side files |
| SRC-005 | Scargill A5 V11 Router Blog | Blog | Historical | High | Early A5-V11 testing |
| SRC-006 | Hackaday RTL-SDR on A5-V11 | Hackaday | Historical | High | OpenWrt and A5-V11 experiments |
| SRC-007 | 4PDA Buildroot Thread | Forum | Historical / Translation needed | High | OpenWrt build notes |
| SRC-008 | wertwert4pda rt5350f-uboot | GitHub | Historical | Critical | U-Boot files |
| SRC-009 | Ozay Turay OpenWrt-A5-V11 | GitHub | Historical | High | OpenWrt A5-V11 firmware notes |
| SRC-010 | JiapengLi OpenWrt-RT5350 | GitHub | Historical | Critical | RT5350 recovery / bootloader notes |
| SRC-011 | sternlabs RT5350F-cheap-router | GitHub | Historical | High | Related RT5350 firmware |
| SRC-012 | OpenWrt Forum Antenna Note | Forum | Historical | Medium | Disconnected antenna warning |
| SRC-013 | Networking At Home MPR-L8 Recovery | Blog | Historical | Critical | TFTP recovery pattern |
| SRC-014 | board.nwrk.biz A5-V11 Thread | Forum | Historical / May be broken | High | A5-V11 related thread |
| SRC-015 | YouTube A5-V11 Video | Video | Historical | Medium | A5-V11 demonstration |
| SRC-016 | Albert David A5-V11 XMPP Notes | Blog | Historical | Medium | A5-V11 IoT usage |
| SRC-017 | OpenWrt Chaos Calmer Download | Firmware download | Historical | High | Old OpenWrt image |
| SRC-018 | Open PS2 Loader | GitHub | Active | Low | PS2 SMB / loader testing |
| SRC-019 | wLaunchELF | GitHub | Active | Low | PS2 FTP testing |
| SRC-020 | Neutrino | GitHub | Active | Low / Medium | UDPBD / UDPFS PS2 testing |
| SRC-021 | PS2SDK | GitHub | Active | Low | PS2 development base |
| SRC-022 | hdl-dump | GitHub | Active | Low | PS2 HDD tooling |
| SRC-023 | PuTTY | Tool | Active | Low | Telnet / SSH / serial terminal |
| SRC-024 | Tftpd64 | Tool | Active | High when flashing | TFTP recovery |
| SRC-025 | GParted Live | Tool | Active | Low | USB formatting |
| SRC-026 | Rufus | Tool | Active | Low | USB formatting / boot media |
| SRC-027 | flashrom | Tool | Active | Critical when writing | SPI flash programming |

---

# A5-V11 And OpenWrt Sources

## SRC-001: OpenWrt A5-V11 Wiki

| Item | Value |
|---|---|
| Title | OpenWrt Wiki: A5-V11 3G/4G Router |
| URL | https://openwrt.org/toh/unbranded/a5-v11 |
| Source type | Wiki |
| Status | Active, but may be protected by anti-bot access |
| Risk level | High |
| Date accessed | 2026-05-14 |

### Covers

- A5-V11 hardware overview
- RT5350F notes
- 4 MB flash / 32 MB RAM warning
- UART pinout
- OpenWrt install notes
- U-Boot notes
- TFTP recovery notes
- GPIO notes
- Ethernet interface caveats
- Known issues

### Repo Notes

This is one of the most important A5-V11 references.

Do not blindly copy commands from the wiki.

Verify:

- Board revision
- flash size
- RAM size
- U-Boot behavior
- firmware image type
- partition layout
- recovery method

---

## SRC-002: Legacy OpenWrt Wiki A5-V11 Page

| Item | Value |
|---|---|
| Title | Legacy OpenWrt Wiki: A5-V11 |
| URL | https://wiki.openwrt.org/toh/unbranded/a5-v11 |
| Source type | Legacy wiki |
| Status | Historical |
| Risk level | High |

### Notes

Older links and instructions may be outdated.

Use only as historical reference unless tested.

---

## SRC-003: Gorgylka UDPBD-A5-V11

| Item | Value |
|---|---|
| Title | OpenWRT UDPBD for A5-V11 3G/4G Mini Router |
| Author / Maintainer | GorGylka |
| URL | https://github.com/GorGylka/UDPBD-A5-V11 |
| Source type | GitHub repository |
| Status | Active |
| Risk level | High |

### Covers

- A5-V11 UDPBD firmware
- OpenWrt 17.01.7 build notes
- exFAT support
- USB storage requirements
- PS2 OPL UDPBD setup
- boot delay notes
- hard reboot / supervisor IC note
- heatsink recommendation
- 4 MB flash / 32 MB RAM requirement

### Important Warnings

This source includes firmware flashing and U-Boot flashing instructions.

Treat as high risk.

Do not run bootloader write commands without backups and recovery tools.

---

## SRC-004: Gorgylka UDPBD-A5-V11 Releases

| Item | Value |
|---|---|
| Title | GorGylka UDPBD-A5-V11 Releases |
| URL | https://github.com/GorGylka/UDPBD-A5-V11/releases/ |
| Source type | GitHub releases |
| Status | Active |
| Risk level | High |

### Covers

- Release files
- PS2-side files
- UDPBD-related downloads

### Repo Notes

Record checksums before using any binary.

Do not mirror binaries unless license and redistribution status are clear.

---

## SRC-005: Scargill A5 V11 Router Blog

| Item | Value |
|---|---|
| Title | A5 V11 Router |
| Author | Peter Scargill |
| URL | https://tech.scargill.net/a5-v11-router/ |
| Source type | Blog |
| Status | Historical |
| Risk level | High |

### Covers

- Early A5-V11 testing
- stock firmware behavior
- default IP behavior
- 32 MB RAM observation
- OpenWrt install struggles
- missing SSH problem
- no-space-left problem
- UART at 57600
- brick symptoms
- heat and dim LED symptoms
- bootloader limitations
- community comments with recovery links

### Repo Notes

Very useful historical source.

Treat old commands and links as historical until retested.

---

## SRC-006: Hackaday RTL-SDR On A5-V11

| Item | Value |
|---|---|
| Title | Running RTL-SDR on A5-V11 3G/4G Router |
| URL | https://hackaday.io/project/11037-running-rtl-sdr-on-a5-v11-3g4g-router |
| Source type | Hackaday project |
| Status | Historical |
| Risk level | High |

### Covers

- A5-V11 OpenWrt experiments
- firmware loading workflow
- use of small router for SDR experiments
- related bootloader / firmware notes

### Repo Notes

Use as historical reference.

Verify all filenames and commands before use.

---

## SRC-007: 4PDA Buildroot Thread

| Item | Value |
|---|---|
| Title | 4PDA OpenWrt Buildroot Thread |
| URL | https://4pda.to/forum/index.php?showtopic=821686 |
| Source type | Forum |
| Status | Historical / Translation needed |
| Risk level | High |

### Covers

- OpenWrt buildroot method
- older RT5350 / A5-V11-related build notes
- non-English community build instructions

### Repo Notes

Translation may be required.

Do not use commands blindly.

---

## SRC-008: wertwert4pda RT5350F U-Boot

| Item | Value |
|---|---|
| Title | rt5350f-uboot |
| URL | https://github.com/wertwert4pda/rt5350f-uboot |
| Source type | GitHub repository |
| Status | Historical |
| Risk level | Critical |

### Covers

- RT5350F U-Boot files or references

### Important Warning

U-Boot flashing is critical risk.

Do not use files from this source unless:

- board compatibility is confirmed
- RAM size is confirmed
- flash size is confirmed
- original U-Boot is backed up
- CH341A recovery is available
- UART is connected

---

## SRC-009: Ozay Turay OpenWrt-A5-V11

| Item | Value |
|---|---|
| Title | OpenWrt-A5-V11 |
| Author | Ozay Turay |
| URL | https://github.com/ozayturay/OpenWrt-A5-V11 |
| Source type | GitHub repository |
| Status | Historical |
| Risk level | High |

### Covers

- A5-V11 OpenWrt firmware notes
- stripped build concepts
- extroot-related notes
- old community work

### Repo Notes

Historical reference only until tested.

---

## SRC-010: JiapengLi OpenWrt-RT5350

| Item | Value |
|---|---|
| Title | OpenWrt-RT5350 |
| Author | JiapengLi |
| URL | https://github.com/JiapengLi/OpenWrt-RT5350 |
| Source type | GitHub repository |
| Status | Historical |
| Risk level | Critical |

### Covers

- RT5350 OpenWrt notes
- U-Boot / recovery references
- TFTP / Wireshark-related recovery notes

### Repo Notes

Critical-risk source because it may involve bootloader or flash recovery work.

---

## SRC-011: sternlabs RT5350F Cheap Router

| Item | Value |
|---|---|
| Title | RT5350F-cheap-router |
| URL | https://github.com/sternlabs/RT5350F-cheap-router |
| Source type | GitHub repository |
| Status | Historical |
| Risk level | High |

### Covers

- Related RT5350F cheap-router work
- firmware experiments

### Repo Notes

Scargill notes mention a brick after trying an image related to this project.

Do not use blindly.

---

## SRC-012: OpenWrt Forum Antenna Note

| Item | Value |
|---|---|
| Title | OpenWrt Forum A5-V11 Antenna Note |
| URL | https://forum.openwrt.org/viewtopic.php?pid=279151#p279151 |
| Source type | Forum post |
| Status | Historical |
| Risk level | Medium |

### Covers

- possible disconnected Wi-Fi antenna issue
- poor range or missing Wi-Fi on some boards

### Repo Notes

Useful for antenna troubleshooting.

Verify against real board photos and continuity.

---

## SRC-013: Networking At Home MPR-L8 Recovery Note

| Item | Value |
|---|---|
| Title | Custom firmware on MPR-L8 cheap wireless router |
| URL | http://networkingathome.blogspot.com.tr/2015/01/custom-firware-on-mpr-l8-cheap-wireless.html |
| Source type | Blog / comment reference |
| Status | Historical / Needs archive |
| Risk level | Critical |

### Covers

- TFTP recovery pattern
- router IP `192.168.1.2`
- TFTP server IP `192.168.1.55`
- MAC-address-based filename concept

### Repo Notes

This appears to be related hardware, not guaranteed A5-V11 behavior.

Use UART and Wireshark before relying on it.

---

## SRC-014: board.nwrk.biz A5-V11 Thread

| Item | Value |
|---|---|
| Title | A5-V11 / RT5350 related forum thread |
| URL | http://board.nwrk.biz/viewtopic.php?pid=342 |
| Source type | Forum |
| Status | Historical / May be broken |
| Risk level | High |

### Repo Notes

Preserve as a historical reference.

Find archive if possible.

---

## SRC-015: A5-V11 YouTube Video

| Item | Value |
|---|---|
| Title | A5-V11 related YouTube video |
| URL | https://www.youtube.com/watch?v=pZLU15zx1EU |
| Source type | Video |
| Status | Historical |
| Risk level | Medium |

### Repo Notes

Useful if it shows physical setup, serial access, or firmware workflow.

Needs review.

---

## SRC-016: Albert David A5-V11 XMPP Notes

| Item | Value |
|---|---|
| Title | Access Your Home Network Using Smart A5-V11 |
| URL | http://albert-david.blogspot.de/2017/12/access-your-home-network-using-smart.html |
| Source type | Blog |
| Status | Historical |
| Risk level | Medium |

### Covers

- stripped OpenWrt image
- XMPP / IoT use
- small-service firmware concept

### Repo Notes

Useful as an example of purpose-built firmware on limited hardware.

---

## SRC-017: OpenWrt Chaos Calmer A5-V11 Factory Image

| Item | Value |
|---|---|
| Title | OpenWrt 15.05 A5-V11 factory image |
| URL | http://downloads.openwrt.org/chaos_calmer/15.05/ramips/rt305x/openwrt-15.05-ramips-rt305x-a5-v11-squashfs-factory.bin |
| Source type | Firmware download |
| Status | Historical |
| Risk level | High |

### Important Warning

This is an old firmware image.

Do not use blindly.

Record checksum and confirm image type before testing.

---

# PS2 Software Sources

## SRC-018: Open PS2 Loader

| Item | Value |
|---|---|
| Title | Open PS2 Loader |
| Short name | OPL |
| URL | https://github.com/ps2homebrew/Open-PS2-Loader |
| Source type | GitHub repository |
| Status | Active |
| Risk level | Low |

### Covers

- PS2 game and app loading
- SMBv1 support
- USB loading
- MX4SIO support
- HDD support
- PS2 network-loading tests

### Repo Notes

Always record exact OPL version and build.

UDPBD support may require a special build.

---

## SRC-019: wLaunchELF

| Item | Value |
|---|---|
| Title | wLaunchELF |
| URL | https://github.com/ps2homebrew/wLaunchELF |
| Source type | GitHub repository |
| Status | Active |
| Risk level | Low |

### Covers

- PS2 file manager
- ELF launcher
- FTP testing
- basic network testing

### Repo Notes

Good first PS2-side network test with A5-V11 bridge mode.

---

## SRC-020: Neutrino

| Item | Value |
|---|---|
| Title | Neutrino |
| URL | https://github.com/rickgaiser/neutrino |
| Source type | GitHub repository |
| Status | Active |
| Risk level | Low / Medium |

### Covers

- PS2 device emulation
- UDPBD backend
- UDPFS backend
- modular PS2 loading workflow

### Repo Notes

Useful for newer UDPBD / UDPFS research.

Always record exact version.

---

## SRC-021: PS2SDK

| Item | Value |
|---|---|
| Title | PS2SDK |
| URL | https://github.com/ps2dev/ps2sdk |
| Source type | GitHub repository |
| Status | Active |
| Risk level | Low |

### Covers

- PS2 homebrew development SDK
- libraries and tooling for PS2 homebrew

### Repo Notes

Useful background source for PS2-side development.

---

## SRC-022: hdl-dump

| Item | Value |
|---|---|
| Title | hdl-dump |
| URL | https://github.com/ps2homebrew/hdl-dump |
| Source type | GitHub repository |
| Status | Active |
| Risk level | Low |

### Covers

- PS2 HDD image management
- HDLoader-format support

### Repo Notes

Not directly required for A5-V11 testing, but useful in the wider PS2 storage ecosystem.

---

# Recovery And Programming Tool Sources

## SRC-023: PuTTY

| Item | Value |
|---|---|
| Title | PuTTY |
| URL | https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html |
| Source type | Tool |
| Status | Active |
| Risk level | Low |

### Uses

- Telnet
- SSH
- serial console testing
- stock firmware access
- UART logging

---

## SRC-024: Tftpd64 / Tftpd32

| Item | Value |
|---|---|
| Title | Tftpd64 |
| URL | https://pjo2.github.io/tftpd64/ |
| Source type | Tool |
| Status | Active |
| Risk level | High when flashing |

### Uses

- TFTP server
- TFTP client
- U-Boot recovery
- firmware transfer testing

### Warning

TFTP transfer may write flash depending on bootloader mode.

Use UART whenever possible.

---

## SRC-025: GParted Live

| Item | Value |
|---|---|
| Title | GParted Live |
| URL | https://gparted.org/liveusb.php |
| Source type | Tool |
| Status | Active |
| Risk level | Low |

### Uses

- USB drive partitioning
- GPT / MBR setup
- FAT32 / exFAT / ext4 preparation
- test media setup

---

## SRC-026: Rufus

| Item | Value |
|---|---|
| Title | Rufus |
| URL | https://rufus.ie |
| Source type | Tool |
| Status | Active |
| Risk level | Low |

### Uses

- USB formatting
- bootable USB creation
- test media preparation

---

## SRC-027: flashrom

| Item | Value |
|---|---|
| Title | flashrom |
| URL | https://flashrom.org/ |
| Source type | Tool |
| Status | Active |
| Risk level | Critical when writing |

### Uses

- CH341A SPI flash reading
- SPI flash writing
- verifying flash contents
- recovering from hard bricks
- programming 16 MB flash chips

### Warning

Writing SPI flash is critical risk.

Always read twice and compare before writing.

---

## SRC-028: AsProgrammer

| Item | Value |
|---|---|
| Title | AsProgrammer |
| URL | https://github.com/nofeletru/UsbAsp-flash |
| Source type | Tool |
| Status | Needs Review |
| Risk level | Critical when writing |

### Uses

- Windows CH341A flash programming
- read / erase / write / verify SPI flash

### Repo Notes

Verify current maintained fork before recommending.

---

## SRC-029: NeoProgrammer

| Item | Value |
|---|---|
| Title | NeoProgrammer |
| URL |  |
| Source type | Tool |
| Status | Needs Link |
| Risk level | Critical when writing |

### Uses

- Windows CH341A flash programming

### Repo Notes

Add trusted source link before recommending.

---

## SRC-030: Wireshark

| Item | Value |
|---|---|
| Title | Wireshark |
| URL | https://www.wireshark.org/ |
| Source type | Tool |
| Status | Active |
| Risk level | Low |

### Uses

- TFTP recovery debugging
- ARP/TFTP capture
- identifying bootloader IP behavior
- checking network traffic
- debugging PS2/A5-V11 network paths

---

# OpenWrt Build And Download Sources

## SRC-031: OpenWrt Downloads

| Item | Value |
|---|---|
| Title | OpenWrt Downloads |
| URL | https://downloads.openwrt.org/ |
| Source type | Official download archive |
| Status | Active |
| Risk level | High when flashing |

### Uses

- historical firmware downloads
- image builder archives
- package archives
- toolchain references

---

## SRC-032: OpenWrt GitHub

| Item | Value |
|---|---|
| Title | OpenWrt Source Repository |
| URL | https://github.com/openwrt/openwrt |
| Source type | GitHub repository |
| Status | Active |
| Risk level | High when flashing built images |

### Uses

- firmware source
- device tree work
- image building
- package configuration
- patch tracking

---

## SRC-033: OpenWrt Documentation

| Item | Value |
|---|---|
| Title | OpenWrt Documentation |
| URL | https://openwrt.org/docs/start |
| Source type | Documentation |
| Status | Active |
| Risk level | Medium |

### Uses

- build system notes
- image builder notes
- network config
- failsafe
- package management
- UCI config

---

# Datasheet And Component Sources

## SRC-034: MediaTek / Ralink RT5350F

| Item | Value |
|---|---|
| Title | RT5350F Datasheet / Technical Reference |
| URL |  |
| Source type | Datasheet |
| Status | Needs Link |
| Risk level | Low |

### Repo Notes

Add manufacturer or reliable archived datasheet link.

Do not rely on seller pages for SoC pinout or electrical limits.

---

## SRC-035: Winbond SPI Flash

| Item | Value |
|---|---|
| Title | Winbond Serial NOR Flash Datasheets |
| URL | https://www.winbond.com/hq/product/code-storage-flash-memory/serial-nor-flash/ |
| Source type | Manufacturer product page |
| Status | Active |
| Risk level | Low |

### Uses

- W25Q32
- W25Q64
- W25Q128
- JEDEC ID checking
- package checking
- voltage checking
- programming support

---

## SRC-036: GigaDevice SPI Flash

| Item | Value |
|---|---|
| Title | GigaDevice SPI NOR Flash |
| URL | https://www.gigadevice.com/product/flash/spi-nor-flash/ |
| Source type | Manufacturer product page |
| Status | Active |
| Risk level | Low |

### Uses

- GD25Q32
- GD25Q64
- GD25Q128
- alternate flash chips

---

## SRC-037: Analog Devices / Maxim MAX809

| Item | Value |
|---|---|
| Title | MAX809 Reset Supervisor |
| URL | https://www.analog.com/en/products/max809.html |
| Source type | Manufacturer product page |
| Status | Active |
| Risk level | Low |

### Uses

- reset supervisor mod
- Flipp'n Caps PCB/Flex
- hard reboot reliability experiments

---

## SRC-038: Analog Devices ADM809

| Item | Value |
|---|---|
| Title | ADM809 Reset Supervisor |
| URL | https://www.analog.com/en/products/adm809.html |
| Source type | Manufacturer product page |
| Status | Active |
| Risk level | Low |

### Uses

- MAX809-style alternate supervisor
- reset reliability testing

---

## SRC-039: Texas Instruments TPS54331

| Item | Value |
|---|---|
| Title | TPS54331 Buck Converter |
| URL | https://www.ti.com/product/TPS54331 |
| Source type | Manufacturer product page |
| Status | Active |
| Risk level | Medium |

### Uses

- PS2 internal power design
- dedicated 5 V regulator concepts
- PowerOR-related work

---

# Project And Private Source Links

## Private Google Docs

Do not publish private Google Docs links in the public repo unless the document is intentionally public.

Track them privately instead.

| Document | Public Repo Policy | Notes |
|---|---|---|
| A5-V11 WiFi Tutorial Google Doc | Do not publish unless made public | Use as private project source |
| Sudonull A5-V11 WiFi Tutorial Google Doc | Do not publish unless made public | Use as private project source |
| Internal project notes | Do not publish raw private links | Summarize and credit if public |

Use this placeholder format if needed:

```text
Private source:
<private Google Doc link>

Public repo note:
Do not publish this link unless permissions are confirmed.
```

---

# Links To Archive

Important sources that should be archived or mirrored as notes if allowed:

| Source ID | Source | Archive Needed | Notes |
|---|---|---|---|
| SRC-005 | Scargill A5 V11 Router Blog | Yes | Historical source with many useful comments |
| SRC-006 | Hackaday RTL-SDR on A5-V11 | Yes | Historical A5-V11 project |
| SRC-007 | 4PDA Buildroot Thread | Yes | Non-English build reference |
| SRC-013 | Networking At Home MPR-L8 Recovery | Yes | TFTP recovery pattern |
| SRC-014 | board.nwrk.biz Thread | Yes | May already be dead |
| SRC-017 | OpenWrt 15.05 A5-V11 image | Yes | Historical firmware source |

---

# Dead Or Risky Link Tracking

Use this table for links that need checking.

| Source ID | URL | Problem | Next Step |
|---|---|---|---|
| SRC-014 | http://board.nwrk.biz/viewtopic.php?pid=342 | May be dead | Check archive |
| SRC-013 | http://networkingathome.blogspot.com.tr/2015/01/custom-firware-on-mpr-l8-cheap-wireless.html | Old link / typo in URL may exist | Check archive and corrected spelling |
| SRC-017 | http://downloads.openwrt.org/chaos_calmer/15.05/ramips/rt305x/openwrt-15.05-ramips-rt305x-a5-v11-squashfs-factory.bin | Old firmware link | Verify checksum if used |
| SRC-029 | NeoProgrammer link missing | No trusted link recorded | Find trusted source |

---

# Source Review Checklist

Before using a source for instructions:

| Check | Done |
|---|---|
| Source URL saved |  |
| Author or maintainer recorded |  |
| Date accessed recorded |  |
| Source type recorded |  |
| Risk level assigned |  |
| Board variant identified |  |
| Flash size identified |  |
| RAM size identified |  |
| Firmware version identified |  |
| Image type identified |  |
| Commands reviewed |  |
| Dangerous commands marked |  |
| License / redistribution checked |  |
| Archive link saved if important |  |
| Tested before marking verified |  |

---

# Dangerous Source Warning

Some links contain commands that can overwrite bootloader, firmware, or factory data.

Dangerous command examples:

```text
mtd_write write <file> Bootloader
mtd_write write <file> Kernel
mtd write <file> factory
flashrom -p ch341a_spi -w <file>
```

Before running dangerous commands:

- back up full flash
- back up factory partition
- back up U-Boot
- confirm RAM size
- confirm flash size
- confirm image type
- connect UART
- have CH341A recovery ready
- verify file checksum

---

# Public Repo Safety

Do not commit:

- private full flash dumps
- factory partitions
- MAC addresses
- Wi-Fi passwords
- private Google Doc links
- customer information
- PS2 BIOS files
- game ISOs
- unknown firmware binaries
- random U-Boot images
- private Discord logs without permission

Safe to commit:

- source links
- summaries
- source IDs
- archive links
- warnings
- tested notes
- checksums for public files
- public build instructions
- redacted logs
- your own photos
- your own diagrams

---

# Link Entry Format

Use this format for adding links.

```text
- Source ID:
  - Title:
  - Author:
  - URL:
  - Archive:
  - Source type:
  - Status:
  - Risk:
  - Date accessed:
  - Notes:
```

---

# Example Link Entry

```text
- Source ID: SRC-003
  - Title: OpenWRT UDPBD for A5-V11 3G/4G Mini Router
  - Author: GorGylka
  - URL: https://github.com/GorGylka/UDPBD-A5-V11
  - Archive:
  - Source type: GitHub repository
  - Status: Active
  - Risk: High
  - Date accessed: 2026-05-14
  - Notes: Important PS2 UDPBD firmware source. Contains risky bootloader and firmware flashing instructions.
```

---

# Recommended Maintenance

Review this file periodically.

Maintenance tasks:

- Check active links
- Add archive links
- Mark broken links
- Add checksums for public binaries
- Remove unsafe mirrors
- Update source status
- Add new source IDs
- Connect sources to test results
- Record which claims were verified
- Mark outdated instructions clearly
- Keep public repo safe

---

# Do Not Do This

Avoid these mistakes:

- Do not publish private flash backups.
- Do not publish factory partitions.
- Do not mirror unknown firmware files.
- Do not mirror U-Boot files without license clarity.
- Do not copy full guides without permission.
- Do not remove author credits.
- Do not use old firmware links blindly.
- Do not treat old forum comments as universal truth.
- Do not run commands from links without reviewing them.
- Do not mix 4 MB, 8 MB, and 16 MB instructions.
- Do not mix UDPBD, UDPFS, and SMB notes without labels.

---

## Short Version

This file is the repo’s link index.

Use it to track:

- A5-V11 sources
- OpenWrt references
- PS2 software links
- recovery tools
- datasheets
- old tutorials
- risky files
- dead links
- archive links
- source credits

The safest workflow is:

```text
Save the source.
Credit the author.
Mark the risk.
Archive important links.
Verify before using.
Document test results.
Do not rehost private or risky binaries.
```

The goal is not to collect random links.

The goal is to build a trustworthy, credited, testable source map for A5-V11 and PS2 integration work.

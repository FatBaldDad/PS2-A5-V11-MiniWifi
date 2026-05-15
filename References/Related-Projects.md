# Related Projects

## Summary

This document tracks related projects, tools, firmware, software, hardware mods, and community work connected to the A5-V11 mini router project.

The A5-V11 PS2 project does not exist in a vacuum.

It depends on, learns from, or connects to work from:

- OpenWrt
- LEDE
- U-Boot
- PS2 homebrew projects
- OPL
- wLaunchELF
- UDPBD
- UDPFS
- Neutrino
- NHDDL
- SMB/Samba
- CH341A programmer tools
- Community A5-V11 tutorials
- Router hacking projects
- PS2 internal modding projects

The goal of this file is to keep track of related work, give credit, and make it easier to find the original sources.

---

## Purpose

This document is used to track:

- Projects related to the A5-V11
- Projects used by the PS2 integration work
- Firmware projects
- Recovery tools
- Flash programming tools
- PS2 network-loading tools
- PS2 file-transfer tools
- OpenWrt build references
- Hardware mod references
- Community research sources
- Projects that inspired this repo

This file should help explain what this repo builds on and where users can learn more.

---

## Main Rule

The main rule is:

```text
Credit related projects clearly and do not claim their work as original to this repo.
```

This repo should organize, document, test, and extend A5-V11 knowledge for PS2 use.

It should not strip credit from the projects and people that made the work possible.

---

## Related Project Status Labels

Use these labels.

| Status | Meaning |
|---|---|
| Active Reference | Still important to this project |
| Historical Reference | Useful but older or possibly outdated |
| Dependency | Directly used by this project |
| Optional Tool | Helpful but not required |
| Research Source | Used for background or testing |
| Experimental | Related but not fully tested |
| Deprecated | No longer recommended |
| Unknown | Needs more research |
| Do Not Use Blindly | Useful but risky or poorly verified |

---

## Risk Labels

Use these labels for related projects or files.

| Risk | Meaning |
|---|---|
| Low | Safe documentation, normal software use, or reference only |
| Medium | Can lock out access or cause setup confusion |
| High | Firmware flashing, recovery, or partition-level changes |
| Critical | U-Boot, factory partition, full flash, or hardware modification |

---

## Project Entry Template

Use this template for each related project.

```text
# Related Project Entry

## Basic Info

Project name:
Author / maintainer:
Project type:
URL:
License:
Status:
Risk level:

## What It Does

Summary:
Main features:
Project relevance:

## A5-V11 Relevance

Used by this repo:
Useful for stock A5-V11:
Useful for 16 MB flash upgrade:
Useful for PS2 integration:
Useful for recovery:

## Notes

Known issues:
Version notes:
Compatibility notes:
Testing status:
Credit notes:
```

---

## Major Related Projects

| Project | Type | Relevance | Status |
|---|---|---|---|
| OpenWrt | Embedded Linux firmware | Main firmware base for A5-V11 experiments | Active Reference |
| LEDE | Historical OpenWrt fork | Older builds and legacy RT5350 support | Historical Reference |
| U-Boot | Bootloader | Boot, TFTP recovery, flash layout, recovery | Dependency |
| Linux MTD | Flash partition tools | Flash backup, partition handling, recovery | Dependency |
| Samba | SMB server | Router-hosted SMB and OPL SMB testing | Optional Tool |
| OPL | PS2 loader | SMB and UDPBD PS2-side testing | Dependency for PS2 loading |
| wLaunchELF | PS2 file manager | FTP testing and PS2 network file transfer | Dependency for FTP testing |
| UDPBD | PS2 network block-device workflow | A5-V11 USB-backed game loading experiments | Experimental |
| UDPFS | UDP file-serving workflow | Neutrino/NHDDL-related experiments | Experimental |
| Neutrino | PS2 loader workflow | Newer PS2 loading research | Experimental |
| NHDDL | PS2 loading workflow | Newer PS2 loading research | Experimental |
| CH341A tools | SPI programmer tools | Flash backup and hard recovery | Dependency for recovery |
| flashrom | SPI flash programming | Linux-based CH341A workflow | Optional Tool |
| AsProgrammer | SPI flash programming | Windows CH341A workflow | Optional Tool |
| NeoProgrammer | SPI flash programming | Windows CH341A workflow | Optional Tool |

---

# OpenWrt

## Basic Info

| Item | Value |
|---|---|
| Project name | OpenWrt |
| Type | Embedded Linux firmware |
| Project relevance | Main firmware base for A5-V11 development |
| Status | Active Reference |
| Risk level | High when flashing firmware |

## Project Relevance

OpenWrt is the main firmware platform used for A5-V11 experiments.

It matters for:

- Building custom firmware
- Ethernet configuration
- Wi-Fi bridge mode
- USB storage support
- SMB/Samba support
- UDPBD server support
- UDPFS server support
- UART logging
- Failsafe recovery
- Flash partition layout
- Device tree changes
- 4 MB, 8 MB, and 16 MB flash support

## A5-V11 Notes

The A5-V11 is an older RT5350F-based device.

The stock 4 MB flash and 32 MB RAM are very limited.

For this project:

- Stock 4 MB builds should stay minimal.
- 16 MB flash is preferred for serious PS2-focused firmware.
- RAM is still limited even after flash upgrade.
- Full LuCI is not always practical.
- One service mode at a time may be best.
- UART and recovery access are mandatory during testing.

## Repo Use

This repo may include:

- OpenWrt build notes
- Device tree notes
- Package selection notes
- PS2-focused configs
- Flash layout notes
- Recovery notes
- Build logs
- Tested configuration files

This repo should avoid hosting unclear firmware binaries unless licensing and source are clear.

---

# LEDE

## Basic Info

| Item | Value |
|---|---|
| Project name | LEDE |
| Type | Historical OpenWrt fork |
| Project relevance | Older RT5350 / A5-V11 support references |
| Status | Historical Reference |
| Risk level | High when flashing firmware |

## Project Relevance

LEDE and older OpenWrt branches are important because the A5-V11 belongs to a class of older low-resource routers.

Some guides, tutorials, and firmware images were created during the LEDE or older OpenWrt era.

## Notes

Treat LEDE-based notes as historical unless tested.

Before using old instructions, verify:

- Target
- Subtarget
- Device profile
- Image type
- Flash size
- RAM size
- Package set
- Recovery method

Do not assume old image builder commands work unchanged on newer OpenWrt.

---

# U-Boot

## Basic Info

| Item | Value |
|---|---|
| Project name | U-Boot |
| Type | Bootloader |
| Project relevance | A5-V11 boot and recovery |
| Status | Dependency |
| Risk level | Critical |

## Project Relevance

U-Boot is the bootloader used on the A5-V11.

It matters for:

- Booting firmware
- Detecting RAM
- Detecting SPI flash
- Loading kernel
- TFTP recovery
- Boot menu options
- Firmware recovery
- Bootloader replacement
- Flash upgrade behavior

## Important Warning

U-Boot work is critical risk.

Do not flash U-Boot unless:

- The original U-Boot is backed up
- RAM size is confirmed
- Flash size is confirmed
- Replacement source is trusted
- CH341A recovery is available
- UART is connected
- The risk is accepted

For normal firmware problems, recover the firmware partition first.

Do not replace U-Boot just because OpenWrt config is broken.

---

# Linux MTD Tools

## Basic Info

| Item | Value |
|---|---|
| Project name | Linux MTD |
| Type | Flash partition tools |
| Project relevance | Flash partition reading and writing |
| Status | Dependency |
| Risk level | High to Critical |

## Project Relevance

MTD tools and `/proc/mtd` are important for understanding the A5-V11 flash layout.

Useful for:

- Listing partitions
- Backing up factory partition
- Backing up U-Boot
- Writing firmware partitions
- Checking flash layout
- Understanding OpenWrt partition names

## Important Warning

MTD writes can permanently damage firmware, U-Boot, or factory data.

Before using `mtd write` or `mtd_write`:

- Confirm the partition name
- Confirm the file type
- Confirm the file size
- Confirm the board ID
- Confirm a backup exists
- Confirm recovery method

Do not assume `mtd2` is always factory.

Always check:

```text
cat /proc/mtd
```

---

# Samba

## Basic Info

| Item | Value |
|---|---|
| Project name | Samba |
| Type | SMB/CIFS server |
| Project relevance | Router-hosted SMB for OPL |
| Status | Optional Tool |
| Risk level | Medium to High on A5-V11 |

## Project Relevance

Samba may be used if the A5-V11 hosts a USB drive as an SMB share for OPL.

Possible use:

```text
USB storage -> A5-V11 Samba server -> PS2 OPL SMB
```

## A5-V11 Notes

Samba can be heavy for this hardware.

Concerns:

- 4 MB flash is likely too small for comfortable use.
- 32 MB RAM is limited.
- SMB1/NT1 may be needed for PS2 OPL compatibility.
- USB storage must mount before Samba starts.
- Boot timing must be tested.
- Router-hosted SMB may be less efficient than UDPBD or UDPFS.

## Repo Use

This repo may include:

- Minimal Samba config examples
- SMB1/NT1 notes
- RAM usage notes
- OPL compatibility tests
- Router-hosted SMB testing results

---

# OPL

## Basic Info

| Item | Value |
|---|---|
| Project name | Open PS2 Loader |
| Short name | OPL |
| Type | PlayStation 2 game loader |
| Project relevance | PS2-side SMB and UDPBD testing |
| Status | Dependency for PS2 loading |
| Risk level | Low to Medium |

## Project Relevance

OPL is important for testing PS2 network loading.

A5-V11-related OPL use cases include:

- SMB loading from external PC or NAS through A5-V11 bridge
- SMB loading from A5-V11 router-hosted USB storage
- UDPBD loading from A5-V11 USB storage when using compatible OPL builds
- Network timing and compatibility testing

## Important Version Rule

Always record the exact OPL version.

Do not write:

```text
OPL works.
```

Write:

```text
OPL version:
Build:
Network mode:
A5-V11 firmware:
PS2 model:
Result:
```

UDPBD support may require a special OPL build.

---

# wLaunchELF

## Basic Info

| Item | Value |
|---|---|
| Project name | wLaunchELF |
| Type | PS2 file manager and launcher |
| Project relevance | FTP helper testing and PS2 file transfers |
| Status | Dependency for FTP testing |
| Risk level | Low |

## Project Relevance

wLaunchELF is useful for testing basic PS2 network connectivity.

A5-V11 use cases:

- PC reaches PS2 FTP through A5-V11
- Testing Wi-Fi bridge mode
- Testing PS2 static IP settings
- Copying homebrew files
- Checking Ethernet wiring before game-loading tests

## Test Use

A good first PS2 network test is:

```text
PC -> A5-V11 -> PS2 wLaunchELF FTP
```

If FTP works reliably, Ethernet wiring and basic network path are probably working.

---

# UDPBD

## Basic Info

| Item | Value |
|---|---|
| Project name | UDPBD |
| Type | PS2 network block-device style loading workflow |
| Project relevance | A5-V11 USB-backed game loading experiments |
| Status | Experimental |
| Risk level | Medium to High |

## Project Relevance

UDPBD is one of the most interesting PS2-focused use cases for the A5-V11.

Basic concept:

```text
USB storage -> A5-V11 UDPBD server -> PS2 Ethernet -> UDPBD-capable OPL
```

## Notes

UDPBD testing is version-sensitive.

Always record:

- UDPBD server version
- Server architecture
- A5-V11 firmware
- OPL UDPBD build
- PS2 model
- USB drive model
- Filesystem
- Boot delay
- Network mode
- Result

## A5-V11 Concerns

UDPBD depends on:

- USB storage mount timing
- Correct server binary
- Correct network interface
- Correct PS2-side loader
- Stable Ethernet
- Stable power
- Good boot timing
- Adequate cooling

Do not mix UDPBD notes with normal SMB notes.

---

# UDPFS

## Basic Info

| Item | Value |
|---|---|
| Project name | UDPFS |
| Type | UDP-based file-serving workflow |
| Project relevance | Neutrino/NHDDL-related PS2 loading experiments |
| Status | Experimental |
| Risk level | Medium to High |

## Project Relevance

UDPFS may be useful for newer PS2 network-loading workflows.

Basic concept:

```text
Storage path -> A5-V11 UDPFS server -> PS2 Ethernet -> compatible PS2 loader
```

## Notes

UDPFS should be documented separately from UDPBD.

Always record:

- UDPFS server version
- PS2-side loader
- Loader version
- A5-V11 firmware
- Storage path
- Network mode
- Filesystem
- Result

Do not assume UDPFS and UDPBD behave the same.

---

# Neutrino

## Basic Info

| Item | Value |
|---|---|
| Project name | Neutrino |
| Type | PS2 loading workflow |
| Project relevance | Newer PS2 network-loading experiments |
| Status | Experimental |
| Risk level | Low to Medium |

## Project Relevance

Neutrino-related workflows may be useful with UDPFS or other network-serving methods.

For A5-V11 use, the main questions are:

- Can the router run the needed server software?
- Can the PS2 loader connect reliably?
- Is the A5-V11 fast enough?
- Is the network mode correct?
- Does the storage path work?
- Does the loader need a specific server version?

Always record exact versions.

---

# NHDDL

## Basic Info

| Item | Value |
|---|---|
| Project name | NHDDL |
| Type | PS2 loading workflow |
| Project relevance | Newer PS2 network and storage experiments |
| Status | Experimental |
| Risk level | Low to Medium |

## Project Relevance

NHDDL may be useful for testing newer PS2 loading paths with the A5-V11.

For this repo, NHDDL-related testing should record:

- NHDDL version
- Server type
- A5-V11 firmware
- Network mode
- PS2 model
- Storage source
- Result
- Known issues

---

# PS2BBL

## Basic Info

| Item | Value |
|---|---|
| Project name | PS2BBL |
| Type | PS2 bootloader / launcher workflow |
| Project relevance | PS2 launch environment and boot timing |
| Status | Optional Tool |
| Risk level | Low to Medium |

## Project Relevance

PS2BBL may be useful as part of the PS2-side launch workflow.

For A5-V11 integration, it may matter because boot timing affects whether the router is ready before the PS2 loader starts.

Track:

- PS2BBL version
- Launch timing
- Loader launched
- A5-V11 service-ready time
- Result

---

# FMCB / FHDB / OpenTuna

## Basic Info

| Item | Value |
|---|---|
| Project names | FMCB, FHDB, OpenTuna |
| Type | PS2 boot and exploit environments |
| Project relevance | Launching PS2-side network tools |
| Status | Optional Tool |
| Risk level | Low to Medium |

## Project Relevance

These projects can be used to launch:

- wLaunchELF
- OPL
- PS2BBL
- Neutrino
- Other PS2 homebrew

For A5-V11 testing, record which boot method was used.

Example:

```text
Boot method:
Loader:
Loader version:
Delay before launch:
A5-V11 service-ready time:
Result:
```

---

# CH341A Programmer Tools

## Basic Info

| Item | Value |
|---|---|
| Project/tool family | CH341A SPI flash programming |
| Type | Hardware and software recovery tools |
| Project relevance | A5-V11 flash backup and hard recovery |
| Status | Dependency for recovery |
| Risk level | Critical when writing flash |

## Project Relevance

CH341A tools are needed for:

- Backing up stock flash
- Extracting factory partition
- Restoring firmware
- Restoring U-Boot
- Programming 16 MB flash
- Recovering from hard bricks
- Verifying flash images

## Related Tools

| Tool | Platform | Use |
|---|---|---|
| flashrom | Linux/macOS/Windows builds | Read/write SPI flash |
| AsProgrammer | Windows | Read/write SPI flash |
| NeoProgrammer | Windows | Read/write SPI flash |
| IMSProg | Linux/Windows | Read/write SPI flash |
| Colibri | Windows | Read/write SPI flash |

## Warning

Do not write flash until:

- Two original reads match
- Factory partition is extracted
- U-Boot is backed up
- Image type is confirmed
- Chip size is confirmed
- Write verify passes

---

# flashrom

## Basic Info

| Item | Value |
|---|---|
| Project name | flashrom |
| Type | Flash programming utility |
| Project relevance | CH341A programming workflow |
| Status | Optional Tool |
| Risk level | Critical when writing |

## Project Relevance

flashrom can be used to read, write, and verify SPI flash chips.

Example read workflow:

```text
flashrom -p ch341a_spi -r read1.bin
flashrom -p ch341a_spi -r read2.bin
cmp read1.bin read2.bin
sha256sum read1.bin read2.bin
```

Example write workflow:

```text
flashrom -p ch341a_spi -w fullflash.bin
flashrom -p ch341a_spi -v fullflash.bin
```

Always verify after writing.

---

# AsProgrammer

## Basic Info

| Item | Value |
|---|---|
| Project name | AsProgrammer |
| Type | Windows SPI flash programmer software |
| Project relevance | CH341A programming workflow |
| Status | Optional Tool |
| Risk level | Critical when writing |

## Project Relevance

AsProgrammer is commonly used with CH341A programmers on Windows.

Use it for:

- Reading SPI flash
- Saving full dumps
- Erasing chips
- Writing images
- Verifying writes

## Notes

Do not trust one successful read.

Recommended workflow:

```text
Read.
Save as read1.
Read again.
Save as read2.
Compare hashes.
Only then write.
```

---

# NeoProgrammer

## Basic Info

| Item | Value |
|---|---|
| Project name | NeoProgrammer |
| Type | Windows SPI flash programmer software |
| Project relevance | CH341A programming workflow |
| Status | Optional Tool |
| Risk level | Critical when writing |

## Project Relevance

NeoProgrammer is another Windows option for CH341A programming.

Use the same safety rules:

- Confirm chip ID
- Confirm voltage
- Read twice
- Compare
- Save backups
- Verify after write

---

# Tftpd64 / Tftpd32

## Basic Info

| Item | Value |
|---|---|
| Project name | Tftpd64 / Tftpd32 |
| Type | Windows TFTP server/client |
| Project relevance | U-Boot TFTP recovery |
| Status | Optional Tool |
| Risk level | High when flashing firmware |

## Project Relevance

Tftpd64 can be used for:

- U-Boot TFTP recovery
- Firmware transfer
- Observing TFTP requests
- Serving `firmware.bin` during bootloader recovery

## Notes

When using TFTP recovery:

- Use a known-good firmware image.
- Use binary mode if using a TFTP client.
- Select the correct network adapter.
- Disable firewall temporarily if needed.
- Watch UART if possible.
- Do not interrupt flash writing.

---

# dnsmasq TFTP

## Basic Info

| Item | Value |
|---|---|
| Project/tool | dnsmasq TFTP mode |
| Type | Linux TFTP server option |
| Project relevance | U-Boot TFTP recovery |
| Status | Optional Tool |
| Risk level | High when flashing firmware |

## Project Relevance

dnsmasq can be used as a simple TFTP server during recovery.

Example concept:

```text
sudo dnsmasq --port=0 --enable-tftp --tftp-root=$HOME/a5v11-tftp --interface=eth0 --bind-interfaces
```

Confirm the correct Ethernet interface before use.

---

# Wireshark

## Basic Info

| Item | Value |
|---|---|
| Project name | Wireshark |
| Type | Network packet analyzer |
| Project relevance | TFTP recovery and network debugging |
| Status | Optional Tool |
| Risk level | Low |

## Project Relevance

Wireshark is useful when TFTP recovery behavior is unknown.

It can show:

- Router recovery IP
- Host IP expected
- ARP requests
- TFTP filename requested
- Transfer errors
- Whether any packets are sent at all

Useful display filter:

```text
tftp or arp or bootp
```

---

# Community A5-V11 Tutorials

## Basic Info

| Item | Value |
|---|---|
| Project/source type | Community tutorials |
| Type | Blog posts, wiki pages, forum posts, GitHub notes |
| Project relevance | A5-V11 hardware and firmware research |
| Status | Research Source |
| Risk level | Varies |

## Project Relevance

Community A5-V11 tutorials are useful for:

- Stock firmware access
- UART pinout
- OpenWrt installation
- U-Boot replacement
- TFTP recovery
- Flash layout
- USB storage behavior
- Known issues
- Board variant warnings

## Warning

Old tutorials may be correct for one board and wrong for another.

Always verify:

- Board revision
- RAM size
- Flash size
- Bootloader
- Image type
- Offsets
- Recovery method

---

# Gorgylka A5-V11 Work

## Basic Info

| Item | Value |
|---|---|
| Project/source | Gorgylka A5-V11 notes and firmware work |
| Type | Community research / PS2-related A5-V11 work |
| Project relevance | UDPBD and A5-V11 firmware reference |
| Status | Research Source |
| Risk level | High when flashing firmware |

## Project Relevance

This work is especially relevant because it connects the A5-V11 to PS2 network-loading experiments.

Useful topics may include:

- UDPBD server setup
- A5-V11 firmware behavior
- USB storage timing
- PS2 OPL UDPBD builds
- Known limitations
- Boot timing notes
- Hard reboot or freeze behavior

## Repo Use

This repo should credit this work when documenting PS2-specific A5-V11 firmware behavior.

Do not rehost binaries unless license and redistribution status are clear.

Record:

- File names
- Checksums
- Firmware image type
- Flash size target
- Test board
- Test result

---

# Scargill A5-V11 Notes

## Basic Info

| Item | Value |
|---|---|
| Source | Scargill's A5-V11 blog notes |
| Type | Blog research |
| Project relevance | Historical A5-V11 testing and warnings |
| Status | Research Source |
| Risk level | Varies |

## Project Relevance

Blog notes may be useful for:

- General A5-V11 behavior
- OpenWrt experiments
- Brick symptoms
- Firmware update behavior
- Recovery observations
- Heat and stability notes

## Repo Use

Treat as historical practical research.

Cross-check before using any command or binary.

---

# Sudonull A5-V11 Tutorial

## Basic Info

| Item | Value |
|---|---|
| Source | Sudonull A5-V11 tutorial |
| Type | Community tutorial |
| Project relevance | A5-V11 OpenWrt and hardware research |
| Status | Research Source |
| Risk level | Varies |

## Project Relevance

This tutorial may be useful for:

- Stock firmware notes
- OpenWrt install process
- UART notes
- Recovery notes
- Hardware modifications
- Board variant notes

## Repo Use

Use as a research source with attribution.

If translated, mark translation uncertainty.

---

# Flipp'n Caps PCB/Flex

## Basic Info

| Item | Value |
|---|---|
| Project name | Flipp'n Caps PCB/Flex |
| Type | A5-V11 fitment helper board |
| Project relevance | Internal PS2 mounting and capacitor relocation |
| Status | Experimental |
| Risk level | Medium to High |

## Project Relevance

Flipp'n Caps is a helper PCB/Flex concept for the A5-V11.

Possible goals:

- Lay tall capacitors flat
- Relocate capacitors cleanly
- Add reset supervisor footprint
- Improve internal PS2 fitment
- Help use RF shield as thermal path
- Make A5-V11 installs more repeatable

## Notes

This is project-specific and experimental.

Before treating it as recommended:

- Test capacitor polarity
- Test boot reliability
- Test USB storage
- Test Wi-Fi
- Test closed-shell fitment
- Test heat
- Test long-run stability

---

# Button Butler

## Basic Info

| Item | Value |
|---|---|
| Project name | Button Butler |
| Type | PS2 control and service interface concept |
| Project relevance | Future power sequencing and mode control |
| Status | Experimental / Future |
| Risk level | Medium to High |

## Project Relevance

Button Butler may eventually control or monitor A5-V11 behavior.

Possible A5-V11 connections:

- Router power sequencing
- Router ready signal
- UART mode switching
- Wi-Fi/UDPBD/SMB mode selection
- PS2 boot delay coordination
- Service menu access
- Recovery controls

## Notes

This is future-facing.

The A5-V11 should work standalone before adding controller-managed behavior.

---

# PowerOR / USB-C Power Projects

## Basic Info

| Item | Value |
|---|---|
| Project name | PowerOR / USB-C power support |
| Type | PS2 power board concept |
| Project relevance | Stable power source for A5-V11 and PS2 mods |
| Status | Related Internal Project |
| Risk level | High |

## Project Relevance

A stable 5 V source is important for the A5-V11, especially when USB storage is connected.

PowerOR-style work may help with:

- Dedicated regulator power
- USB-C PD power input
- Power OR-ing
- Controlled internal power
- Reduced brownout behavior
- Always-on or pre-boot router mode

## Notes

Power changes can affect PS2 reliability.

Always test:

- Voltage
- Current
- Heat
- Backfeed
- Closed-shell behavior
- Router boot timing

---

# PS2 Ethernet And SMB Related Work

## Basic Info

| Item | Value |
|---|---|
| Project area | PS2 Ethernet and SMB |
| Type | PS2 network loading ecosystem |
| Project relevance | OPL SMB and FTP bridge use |
| Status | Active Reference |
| Risk level | Low to Medium |

## Project Relevance

The A5-V11 can act as a network helper for existing PS2 Ethernet workflows.

Important related topics:

- OPL SMB setup
- SMB1/NT1 compatibility
- Windows SMB behavior
- NAS SMB behavior
- PS2 IP configuration
- wLaunchELF FTP
- Network adapter behavior
- Slim built-in Ethernet behavior

## Notes

The A5-V11 should not be blamed automatically for PS2 network issues.

Always test:

- PS2 IP settings
- Loader settings
- External Ethernet cable
- Known-good SMB server
- Known-good FTP path
- A5-V11 network mode

---

# Project Relationship Map

```text
A5-V11 PS2 Project
│
├── OpenWrt / LEDE
│   ├── Custom firmware
│   ├── Network configuration
│   ├── USB storage support
│   ├── SMB/Samba support
│   └── Recovery/failsafe
│
├── U-Boot
│   ├── Bootloader
│   ├── TFTP recovery
│   ├── Flash detection
│   └── Firmware loading
│
├── Recovery Tools
│   ├── CH341A
│   ├── flashrom
│   ├── AsProgrammer
│   ├── NeoProgrammer
│   ├── Tftpd64
│   └── Wireshark
│
├── PS2 Software
│   ├── wLaunchELF
│   ├── OPL
│   ├── PS2BBL
│   ├── Neutrino
│   ├── NHDDL
│   ├── FMCB
│   ├── FHDB
│   └── OpenTuna
│
├── PS2 Network Services
│   ├── FTP
│   ├── SMB
│   ├── UDPBD
│   └── UDPFS
│
└── Hardware Mods
    ├── Flipp'n Caps
    ├── Antenna mod
    ├── Supervisor IC
    ├── Flash upgrade
    ├── Internal mounting
    ├── PowerOR
    └── Button Butler
```

---

## Related Project Tracking Table

Use this table for quick tracking.

| Project | URL | Status | Repo Use | Notes |
|---|---|---|---|---|
| OpenWrt |  | Active Reference | Firmware base |  |
| LEDE |  | Historical Reference | Legacy build notes |  |
| U-Boot |  | Dependency | Bootloader and recovery |  |
| OPL |  | Dependency | PS2 loader testing |  |
| wLaunchELF |  | Dependency | FTP testing |  |
| UDPBD |  | Experimental | PS2 network storage |  |
| UDPFS |  | Experimental | PS2 network file serving |  |
| Neutrino |  | Experimental | PS2 loading workflow |  |
| NHDDL |  | Experimental | PS2 loading workflow |  |
| PS2BBL |  | Optional Tool | Launch workflow |  |
| flashrom |  | Optional Tool | SPI flash programming |  |
| AsProgrammer |  | Optional Tool | SPI flash programming |  |
| NeoProgrammer |  | Optional Tool | SPI flash programming |  |
| Tftpd64 |  | Optional Tool | TFTP recovery |  |
| Wireshark |  | Optional Tool | Network debugging |  |
| Gorgylka A5-V11 work |  | Research Source | UDPBD/A5-V11 notes |  |
| Scargill A5-V11 notes |  | Research Source | Historical testing |  |
| Sudonull A5-V11 tutorial |  | Research Source | OpenWrt/tutorial notes |  |
| Flipp'n Caps |  | Experimental | Fitment helper |  |
| Button Butler |  | Future | Control/service integration |  |
| PowerOR |  | Related Internal Project | Power support |  |

---

## Adding New Related Projects

When adding a new project, record:

- Project name
- Author or maintainer
- URL
- License
- What it does
- Why it matters to A5-V11
- Why it matters to PS2 integration
- Whether it is tested
- Whether it is safe to use
- Whether it includes binaries
- Whether those binaries can be redistributed
- Any warnings

---

## Public Repo Safety

Do not include:

- Unknown firmware binaries
- Random U-Boot images
- Personal flash dumps
- Factory partitions
- MAC addresses
- Wi-Fi passwords
- PS2 BIOS files
- Game files
- Commercial software
- Private chat logs without permission

This file should link, credit, summarize, and track related work.

It should not become a dumping ground for risky files.

---

## Credit Policy

When using related project work, include credit.

Example:

```text
Credit:
This section references work from <project name> by <author/maintainer>.
Original source: <URL>
```

For combined research:

```text
Credit:
This repo combines public OpenWrt documentation, A5-V11 community tutorials, PS2 homebrew project notes, and personal bench testing to document A5-V11 use with the PlayStation 2.
```

---

## Do Not Do This

Avoid these mistakes:

- Do not strip credits from related projects.
- Do not rehost binaries without license clarity.
- Do not claim community work as original.
- Do not flash U-Boot from a related project without checking RAM size.
- Do not use old OpenWrt instructions without checking target and image type.
- Do not mix UDPBD and UDPFS notes.
- Do not assume OPL builds all support the same network modes.
- Do not assume one A5-V11 board matches another.
- Do not publish private factory data.
- Do not include PS2 game or BIOS files.

---

## Condensed Summary

This repo is related to many other projects.

The most important related projects are:

- OpenWrt for firmware
- U-Boot for boot and recovery
- CH341A tools for hard recovery
- OPL for PS2 network loading
- wLaunchELF for FTP testing
- UDPBD and UDPFS for PS2 network storage experiments
- Community A5-V11 guides for historical research
- Flipp'n Caps for internal PS2 fitment experiments

The goal is to organize and test this information for A5-V11 and PS2 use while giving proper credit to the people and projects that made the work possible.

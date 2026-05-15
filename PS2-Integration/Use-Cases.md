# PS2 Use Cases

## Summary

This document describes practical PlayStation 2 use cases for the A5-V11 mini router.

The A5-V11 can be used as a small internal or external network helper for the PS2. Depending on firmware, wiring, storage, and power setup, it can support several different roles.

The primary goal is not to make the A5-V11 a modern full-featured router.

The goal is to make it a small PS2-focused network appliance.

---

## Main PS2 Use Cases

Possible A5-V11 PS2 use cases include:

- Wi-Fi bridge for PS2 Ethernet
- wLaunchELF FTP helper
- OPL SMB bridge
- Router-hosted SMB server
- UDPBD server
- UDPFS server
- Internal USB storage host
- External test router
- Firmware development platform
- Recovery and service network
- Future PS2-specific simple web setup device

Each use case has different firmware, wiring, power, storage, and boot timing requirements.

---

## Use Case Overview

| Use Case | Main Purpose | Difficulty | Best Flash Size |
|---|---|---:|---:|
| Wi-Fi bridge | Connect PS2 Ethernet to home Wi-Fi | Medium | 4 MB or 16 MB |
| FTP helper | Reach PS2 wLaunchELF FTP over Wi-Fi | Medium | 4 MB or 16 MB |
| OPL SMB bridge | Bridge PS2 to external SMB server | Medium | 4 MB or 16 MB |
| Router-hosted SMB | A5-V11 hosts USB storage over SMB | High | 16 MB |
| UDPBD server | A5-V11 serves USB storage to PS2 over UDPBD | High | 4 MB or 16 MB |
| UDPFS server | A5-V11 serves files through UDPFS workflow | High | 16 MB |
| Internal storage appliance | A5-V11 plus USB storage inside PS2 | High | 16 MB |
| Service/recovery router | Debug, configure, recover, and test | Medium | 4 MB or 16 MB |
| Custom PS2 web setup | Simple user-facing PS2 network setup UI | High | 16 MB |

---

## Use Case 1: Wi-Fi Bridge For PS2 Ethernet

## Purpose

Use the A5-V11 to connect the PS2 Ethernet port to a home Wi-Fi network.

Basic idea:

```text
PS2 Ethernet -> A5-V11 Ethernet -> A5-V11 Wi-Fi -> Home network
```

This allows the PS2 to access the network without running a long Ethernet cable.

---

## Useful For

Wi-Fi bridge mode can help with:

- wLaunchELF FTP
- OPL SMB access to a PC or NAS
- PS2 network setup testing
- Homebrew network tools
- File transfers
- Network access in rooms without Ethernet
- Internal PS2 Wi-Fi-style builds

---

## Hardware Requirements

Minimum hardware:

- A5-V11 router
- PS2 with Ethernet
- 5 V power source
- Ethernet connection between PS2 and A5-V11
- Working A5-V11 Wi-Fi antenna

Optional hardware:

- Internal PS2 mounting
- External antenna mod
- UART service connector
- Supervisor IC
- 16 MB flash upgrade
- Custom web setup UI

---

## Firmware Requirements

Firmware should support:

- Ethernet interface
- Wi-Fi client mode
- Bridge or routed network configuration
- Static IP or DHCP configuration
- Simple recovery access
- UART console
- Optional web setup page

For a very small firmware, full LuCI is not required.

A tiny custom setup page would be better.

---

## Network Questions

Wi-Fi bridge mode must answer:

- Is the A5-V11 acting as a true bridge?
- Is the A5-V11 routing/NATing the PS2?
- Does the home router see the PS2?
- Does the PS2 need a static IP?
- Does the A5-V11 need a static IP?
- Can a PC reach the PS2 FTP server?
- Does Wi-Fi client isolation block access?
- Does DHCP pass through correctly?

These must be tested.

---

## Advantages

- No long Ethernet cable
- Useful for FTP and SMB
- Can be internal or external
- Does not require USB storage on the A5-V11
- Lower power than storage-heavy modes
- Good first PS2 use case

---

## Disadvantages

- Wi-Fi signal depends on antenna placement
- Bridge mode can be tricky
- NAT/routing can block inbound FTP
- PS2 network settings must be correct
- Boot timing still matters
- Stock firmware may not be reliable enough
- Internal PS2 RF shield can reduce Wi-Fi signal

---

## Wi-Fi Bridge Test Checklist

| Test | Result |
|---|---|
| A5-V11 boots |  |
| Ethernet link to PS2 works |  |
| Wi-Fi connects to home network |  |
| Router IP known |  |
| PS2 IP known |  |
| PC can ping router |  |
| PC can ping PS2, if expected |  |
| PS2 can reach SMB server, if used |  |
| wLaunchELF FTP works, if used |  |
| Signal works with shell closed |  |
| Reboot test passed |  |

---

## Use Case 2: wLaunchELF FTP Helper

## Purpose

Use the A5-V11 to make it easier to access the PS2 through wLaunchELF FTP.

Basic idea:

```text
PC -> Wi-Fi/home network -> A5-V11 -> PS2 Ethernet -> wLaunchELF FTP
```

The A5-V11 acts as the network path between the PC and PS2.

---

## Useful For

FTP helper mode can help with:

- Copying files to PS2 memory card
- Copying files to PS2 USB storage
- Copying files to internal HDD on Fat PS2
- Copying homebrew files
- Testing PS2 network settings
- Avoiding a direct Ethernet cable from PC to PS2

---

## Hardware Requirements

Minimum hardware:

- A5-V11
- PS2 Ethernet connection
- PC on same network or reachable network
- 5 V power source
- Working Wi-Fi if wireless is used

---

## Firmware Requirements

Firmware should support:

- Ethernet link to PS2
- Wi-Fi client connection or routed access
- Correct firewall behavior
- Clear IP configuration
- Optional static IP setup
- Optional simple web setup page

The A5-V11 does not need to host USB storage for this use case.

---

## PS2 Requirements

The PS2 needs:

- wLaunchELF
- Network configured correctly
- FTP server started in wLaunchELF
- Correct PS2 IP address
- Correct subnet/gateway if needed

---

## Advantages

- Simple PS2 network test
- Good first functional test
- Does not need USB storage on A5-V11
- Lower power use
- Useful even if game loading is not the goal
- Good proof that Ethernet wiring works

---

## Disadvantages

- FTP depends on network direction
- NAT can make inbound FTP difficult
- Wi-Fi client isolation may block access
- PS2 static IP setup may be needed
- Not a game-loading use case by itself

---

## FTP Helper Test Checklist

| Test | Result |
|---|---|
| Router boots |  |
| Ethernet link works |  |
| Wi-Fi connects, if used |  |
| PS2 IP configured |  |
| PC can ping PS2 |  |
| wLaunchELF FTP starts |  |
| FTP client connects |  |
| Directory listing works |  |
| Small file transfer works |  |
| Large file transfer works |  |
| Reconnect works |  |

---

## Use Case 3: OPL SMB Bridge To External Server

## Purpose

Use the A5-V11 as a bridge between the PS2 and an external SMB server.

Basic idea:

```text
PS2 Ethernet -> A5-V11 -> Wi-Fi/home network -> PC or NAS SMB share
```

In this setup, the A5-V11 does not host the games.

It only connects the PS2 to the device that hosts the SMB share.

---

## Useful For

SMB bridge mode can help with:

- Loading PS2 games from a PC
- Loading PS2 games from a NAS
- Testing OPL SMB without a long Ethernet cable
- Keeping game storage outside the PS2
- Avoiding USB storage on the A5-V11

---

## Hardware Requirements

Minimum hardware:

- A5-V11
- PS2 Ethernet connection
- PC or NAS SMB server
- Home Wi-Fi or wired network
- 5 V power source

---

## Firmware Requirements

Firmware should support:

- Stable Ethernet
- Stable Wi-Fi client mode
- Bridge or routed mode
- Correct firewall behavior
- Static or DHCP IP plan
- Recovery access

The A5-V11 does not need Samba installed for this mode because the SMB server is external.

---

## External SMB Server Requirements

The external server must support the PS2/OPL SMB requirements.

Record:

| Item | Value |
|---|---|
| Server type | PC, NAS, Linux, Windows, other |
| Server IP |  |
| Share name |  |
| SMB protocol |  |
| Username |  |
| Guest access | Yes or no |
| Folder layout |  |
| OPL version |  |

---

## Advantages

- Less load on the A5-V11
- No USB storage required on the router
- Better storage capacity from PC or NAS
- Easier to manage game files
- Good use for Wi-Fi bridge firmware

---

## Disadvantages

- Requires external PC or NAS
- SMB1/NT1 support may be hard on modern systems
- Wi-Fi performance may limit loading
- Network topology can get confusing
- OPL SMB settings must be correct

---

## SMB Bridge Test Checklist

| Test | Result |
|---|---|
| Router boots |  |
| Ethernet link to PS2 works |  |
| Wi-Fi bridge works |  |
| External SMB server reachable |  |
| OPL network settings correct |  |
| OPL sees games list |  |
| Game boots |  |
| FMV behavior acceptable |  |
| Repeated launch works |  |
| Closed-shell Wi-Fi works, if internal |  |

---

## Use Case 4: Router-Hosted SMB Server

## Purpose

Use the A5-V11 itself as the SMB server for OPL.

Basic idea:

```text
USB storage -> A5-V11 SMB server -> PS2 Ethernet -> OPL
```

In this mode, the A5-V11 hosts the game storage.

---

## Useful For

Router-hosted SMB can help with:

- A self-contained PS2 network storage setup
- Internal PS2 storage appliance
- No external PC or NAS required
- OPL SMB loading from USB attached to A5-V11

---

## Hardware Requirements

Minimum hardware:

- A5-V11
- USB storage connected to A5-V11
- PS2 Ethernet connection
- Stable 5 V power
- Adequate cooling

Recommended hardware:

- 16 MB flash upgrade
- Low-power USB flash drive or SSD
- Supervisor IC
- Heatsink
- UART access
- Strong 5 V regulator

---

## Firmware Requirements

Firmware should support:

- USB storage
- Filesystem support
- Mount scripts
- Samba or SMB server
- SMB1/NT1 compatibility
- Stable Ethernet
- Sufficient free RAM
- Sufficient flash space
- Service startup after USB mount

---

## Advantages

- Self-contained
- No external SMB server needed
- Can work with Ethernet-only PS2 link
- Useful for internal no-cable builds
- Can keep game storage inside the console

---

## Disadvantages

- Samba can be heavy
- 4 MB flash is likely too small
- 32 MB RAM is still tight
- USB storage draws power
- Boot timing matters
- USB mount timing matters
- Heat matters
- More complex than bridge mode

---

## Router-Hosted SMB Test Checklist

| Test | Result |
|---|---|
| Router boots |  |
| USB storage detected |  |
| USB storage mounted |  |
| SMB service starts |  |
| SMB1/NT1 configured |  |
| OPL connects |  |
| Games list appears |  |
| Game boots |  |
| RAM usage acceptable |  |
| Reboot test passed |  |
| Closed-shell test passed |  |

---

## Use Case 5: UDPBD Server

## Purpose

Use the A5-V11 as a UDPBD server for the PS2.

Basic idea:

```text
USB storage -> A5-V11 UDPBD server -> PS2 Ethernet -> UDPBD-capable OPL
```

This is one of the most interesting PS2-specific uses for the A5-V11.

---

## Useful For

UDPBD mode can help with:

- PS2 game loading from USB storage connected to A5-V11
- Ethernet-only PS2 loading
- Compact internal network storage
- Avoiding SMB overhead
- Testing PS2 network block-device workflows

---

## Hardware Requirements

Minimum hardware:

- A5-V11
- USB storage connected to A5-V11
- Ethernet link to PS2
- Stable 5 V power
- UART access for testing

Recommended hardware:

- Heatsink
- Supervisor IC
- 16 MB flash for development
- Low-power USB storage
- Good internal mounting
- Service-ready LED or delay plan

---

## Firmware Requirements

Firmware should support:

- USB storage
- Required filesystem
- UDPBD server binary
- Startup script
- Correct network interface
- Ethernet link to PS2
- Optional disabled Wi-Fi if not needed
- Optional disabled unused PHYs
- Clear boot timing behavior

---

## PS2 Requirements

The PS2 needs:

- UDPBD-capable OPL build or compatible loader
- Correct network settings
- Correct launch timing
- Correct game folder layout
- Loader launched after router service-ready

---

## Important UDPBD Notes

UDPBD is version-sensitive.

Always record:

- Router firmware version
- UDPBD server version
- OPL UDPBD build
- USB drive model
- Filesystem
- Boot delay
- PS2 model
- Network mode

Some UDPBD workflows may require the USB drive to be connected before the A5-V11 powers on.

Some firmware builds may not support USB hotplug.

---

## Advantages

- Very PS2-focused
- Avoids full SMB server overhead
- Can be compact
- Can be Ethernet-only
- Good candidate for internal builds
- Interesting use of cheap A5-V11 hardware

---

## Disadvantages

- Requires specific PS2-side loader support
- USB mount timing matters
- Boot timing matters
- May not support hotplug
- Firmware setup is more specialized
- Debugging can be harder than FTP
- Requires careful compatibility testing

---

## UDPBD Test Checklist

| Test | Result |
|---|---|
| Router boots |  |
| USB drive inserted before power-on |  |
| USB storage detected |  |
| USB storage mounted |  |
| UDPBD server starts |  |
| Ethernet link works |  |
| Correct OPL UDPBD build used |  |
| Loader launched after delay |  |
| Games list appears |  |
| Game boots |  |
| Repeated launch works |  |
| Closed-shell test passed |  |

---

## Use Case 6: UDPFS Server

## Purpose

Use the A5-V11 as a UDPFS server or similar UDP-based file server for newer PS2 loading workflows.

Basic idea:

```text
Storage path -> A5-V11 UDPFS server -> PS2 Ethernet -> compatible PS2 loader
```

UDPFS should be documented separately from UDPBD because the tools, assumptions, and compatibility may differ.

---

## Useful For

UDPFS mode can help with:

- Newer PS2 network-loading experiments
- NHDDL or Neutrino-related workflows
- Lightweight network serving
- Comparing UDPFS against UDPBD and SMB
- Future PS2-focused firmware development

---

## Hardware Requirements

Minimum hardware:

- A5-V11
- Ethernet link to PS2
- Storage path, if needed
- Stable power
- UART access

Recommended hardware:

- 16 MB flash upgrade
- Low-power USB storage
- Heatsink
- Supervisor IC
- Reliable power source

---

## Firmware Requirements

Firmware should support:

- UDPFS server binary or script
- Required storage path
- Required filesystem support
- Correct network mode
- Startup script
- Service-ready detection
- Recovery access

---

## PS2 Requirements

The PS2 needs:

- Compatible loader
- Correct loader version
- Correct network settings
- Correct timing
- Correct file layout

---

## Advantages

- Good for newer PS2 loader testing
- Potentially lighter than SMB
- Useful research path
- Good comparison point against UDPBD

---

## Disadvantages

- More experimental
- Loader and server versions matter
- Less documented than SMB
- Requires careful testing
- May need newer PS2-side software

---

## UDPFS Test Checklist

| Test | Result |
|---|---|
| Router boots |  |
| Storage path ready |  |
| UDPFS server starts |  |
| Ethernet link works |  |
| PS2 loader version recorded |  |
| Loader connects |  |
| Game or test content appears |  |
| Content boots |  |
| Repeated launch works |  |
| Stability test passed |  |

---

## Use Case 7: Internal USB Storage Host

## Purpose

Use the A5-V11 as a host for USB storage inside the PS2.

This can support SMB, UDPBD, UDPFS, or other file-serving methods.

Basic idea:

```text
Internal USB storage -> A5-V11 -> PS2 network loader
```

---

## Useful For

Internal USB storage hosting can help with:

- Self-contained PS2 builds
- No external drive hanging out
- Internal game storage experiments
- Internal homebrew storage
- Network-served storage from inside console
- PC access over Wi-Fi if router remains powered

---

## Hardware Requirements

Minimum hardware:

- A5-V11
- USB storage device
- Stable 5 V power
- Internal mounting space
- USB wiring or connector
- Ethernet wiring to PS2

Recommended hardware:

- Low-power USB flash drive or SSD
- Dedicated 5 V regulator
- 16 MB flash
- Heatsink
- Supervisor IC
- Service connector
- Removable storage access plan

---

## Firmware Requirements

Firmware depends on service mode.

Possible required support:

- USB storage
- FAT32, exFAT, or ext4
- block-mount
- SMB
- UDPBD
- UDPFS
- custom mount scripts
- hotplug or boot-time mount
- service start after mount

---

## Key Questions

Before choosing internal USB storage, answer:

- Does the drive need to be removable?
- Can files be updated over network instead?
- Does the drive need to be inserted before boot?
- Does hotplug work?
- How much current does the drive draw?
- Does the drive get hot?
- What filesystem is required?
- Can the PS2 loader see the files?
- Can the router stay powered while PS2 is off?
- Is there a recovery path if the storage fails?

---

## Advantages

- Clean internal build
- No external drive required
- Can be self-contained
- Good for Ultra Slim builds
- Can pair with Wi-Fi access for file management

---

## Disadvantages

- More heat
- More power draw
- Storage access can be difficult
- USB hotplug may not work
- Firmware mount scripts must be reliable
- Internal replacement may require disassembly

---

## Internal USB Storage Test Checklist

| Test | Result |
|---|---|
| USB drive physically fits |  |
| USB drive powered safely |  |
| USB drive detected |  |
| USB drive mounted |  |
| Filesystem supported |  |
| Service starts after mount |  |
| PS2 loader sees content |  |
| File update method works |  |
| Drive temperature acceptable |  |
| Closed-shell test passed |  |

---

## Use Case 8: External A5-V11 Test Router

## Purpose

Use the A5-V11 externally before committing to internal PS2 installation.

Basic idea:

```text
PS2 Ethernet -> Ethernet cable -> A5-V11 outside console
```

This is the best way to test firmware, network mode, storage, and boot timing before internal work.

---

## Useful For

External testing can help with:

- Firmware development
- OpenWrt testing
- UDPBD testing
- UDPFS testing
- SMB testing
- FTP bridge testing
- Power measurement
- Thermal testing
- Recovery testing
- UART testing
- Comparing USB drives
- Confirming PS2-side settings

---

## Advantages

- Easy access to UART
- Easy access to reset button
- Easy access to USB storage
- Easy to power externally
- Easier to recover from bad firmware
- No PS2 disassembly required
- Best first test method

---

## Disadvantages

- Not as clean
- Does not prove internal fitment
- Does not test closed-shell Wi-Fi
- Does not test internal heat
- Does not test final power wiring
- Does not test internal Ethernet wiring

---

## External Test Checklist

| Test | Result |
|---|---|
| Router boots externally |  |
| UART accessible |  |
| Ethernet to PS2 works |  |
| Wi-Fi works, if used |  |
| USB storage works, if used |  |
| Target service starts |  |
| PS2 loader works |  |
| Boot timing measured |  |
| Power draw measured |  |
| Heat measured |  |

---

## Use Case 9: Service And Recovery Network

## Purpose

Use the A5-V11 as a service and recovery device for PS2 network testing.

This can include:

- Static test network
- Known-good bridge
- Known-good FTP route
- Firmware recovery access
- Debugging PS2 IP settings
- Testing loaders without changing the main home network

---

## Useful For

Service mode can help with:

- Testing PS2 network configs
- Testing wLaunchELF FTP
- Testing OPL SMB settings
- Testing A5-V11 firmware changes
- Testing router recovery
- Isolating network problems
- Creating a repeatable bench setup

---

## Firmware Requirements

Service firmware should support:

- Known default IP
- Ethernet access
- UART access
- SSH or telnet for isolated bench testing
- Simple web page if possible
- Clear reset behavior
- Easy recovery method

---

## Advantages

- Good development tool
- Reduces confusion
- Repeatable test environment
- Useful even if final internal build changes
- Good for comparing firmware builds

---

## Disadvantages

- Not final user-facing mode
- May include tools not needed in final build
- May be too large for 4 MB if not trimmed
- Must be kept separate from release firmware

---

## Use Case 10: Simple PS2-Focused Web Setup

## Purpose

Create a simple web interface for PS2-specific setup.

The goal is not to expose all OpenWrt settings.

The goal is to provide only what is needed for PS2 use.

---

## Possible Web UI Features

A PS2-focused web UI could include:

- Join home Wi-Fi
- Set router IP
- Set PS2 IP suggestion
- Set subnet mask
- Set gateway
- Set DNS
- Choose mode
- Show Ethernet status
- Show Wi-Fi status
- Show USB mount status
- Show active service
- Restart service
- Reboot router
- Reset settings

---

## Possible Modes

The web UI could select between:

| Mode | Purpose |
|---|---|
| Setup | Configure Wi-Fi and IP |
| Bridge | PS2 Ethernet to Wi-Fi |
| FTP Helper | PC-to-PS2 FTP path |
| SMB Bridge | PS2 to external SMB server |
| SMB Server | A5-V11 hosts USB SMB |
| UDPBD | A5-V11 hosts UDPBD |
| UDPFS | A5-V11 hosts UDPFS |
| Recovery | Known static IP and safe access |

---

## Advantages

- Easier for users
- Cleaner than LuCI
- Smaller than full LuCI
- PS2-specific
- Reduces setup mistakes
- Can hide advanced OpenWrt clutter

---

## Disadvantages

- Requires custom firmware work
- Must be secure enough for local use
- Must not break recovery access
- Must handle bad Wi-Fi settings
- Must be tested heavily
- More complicated than static config files

---

## Web UI Design Rule

The web UI should be simple.

Good:

```text
Set Wi-Fi
Set IP
Choose PS2 mode
Save
Reboot
Show status
```

Bad:

```text
Expose every OpenWrt setting and confuse the user.
```

---

## Use Case Comparison Table

| Use Case | Needs USB Storage | Needs Wi-Fi | Needs SMB | Needs Special PS2 Loader | Internal Friendly |
|---|---|---|---|---|---|
| Wi-Fi bridge | No | Yes | No | No | Yes |
| FTP helper | No | Usually | No | No | Yes |
| External SMB bridge | No | Usually | External only | No | Yes |
| Router-hosted SMB | Yes | Optional | Yes | No | Maybe |
| UDPBD server | Yes | No or optional | No | Yes | Yes |
| UDPFS server | Maybe | No or optional | No | Yes | Yes |
| Internal USB storage host | Yes | Optional | Depends | Depends | Yes |
| Service/recovery router | Optional | Optional | No | No | External preferred |
| Simple web setup | No | Optional | No | No | Yes |

---

## Recommended Development Order

Recommended use case development order:

1. External A5-V11 test router
2. Basic Ethernet link to PS2
3. wLaunchELF FTP helper
4. Wi-Fi bridge
5. OPL SMB bridge to external server
6. USB storage detection
7. UDPBD server
8. UDPFS server
9. Router-hosted SMB server
10. Internal PS2 mounting
11. Simple PS2-focused web UI
12. Advanced controller-managed power or ready signal

Start simple.

Add only one new feature at a time.

---

## Best First Use Case

The best first use case is:

```text
A5-V11 as an external Wi-Fi bridge or FTP helper.
```

Why:

- No internal mounting required
- No USB storage required
- Easier to recover
- Easier to debug
- Proves Ethernet and Wi-Fi
- Proves PS2 network settings
- Good baseline before UDPBD or SMB work

---

## Best Internal Use Case

The best internal use case depends on the build goal.

For a simple internal network upgrade:

```text
Wi-Fi bridge
```

For a PS2 storage-focused build:

```text
UDPBD server with internal USB storage
```

For a user-friendly future build:

```text
Simple web setup plus mode selection
```

For development:

```text
External test router with UART and recovery access
```

---

## Use Case Documentation Template

Use this template for each tested use case.

```text
# Use Case Test

## Use Case

Name:
Purpose:
Status:

## Hardware

A5-V11 board ID:
Flash size:
RAM size:
PS2 model:
Power source:
Storage device:
Antenna:
Heatsink:
Supervisor IC:

## Firmware

Firmware name:
OpenWrt version:
Service mode:
Default IP:
Network mode:
USB support:
Filesystem support:
Special scripts:

## PS2 Software

Boot method:
Loader:
Loader version:
Settings:

## Test

Ethernet:
Wi-Fi:
USB:
Service:
Boot timing:
PS2 result:
Closed-shell:
Thermal:
Power:

## Result

Pass/fail:
Compatibility level:
Known issues:
Notes:
```

---

## Use Case Status Labels

Use these labels:

| Label | Meaning |
|---|---|
| Idea | Not started |
| Planned | Intended for future testing |
| Bench Testing | Being tested externally |
| PS2 Bench Tested | Tested with PS2 externally |
| Internal Testing | Installed and being tested inside PS2 |
| Working | Works under documented conditions |
| Stable | Repeated tests pass |
| Recommended | Preferred current method |
| Experimental | Works partly or needs more testing |
| Blocked | Cannot continue due to issue |
| Deprecated | Kept for history only |

---

## Safety And Legal Notes

This repo should document hardware, firmware, networking, and testing.

This repo should not host:

- Game ISOs
- PS2 BIOS files
- Commercial software
- Copyrighted game assets
- Piracy-focused instructions

Testing should use legally owned backups or homebrew test files.

---

## Short Version

The A5-V11 can support several PS2 use cases:

- Wi-Fi bridge
- wLaunchELF FTP helper
- OPL SMB bridge
- Router-hosted SMB server
- UDPBD server
- UDPFS server
- Internal USB storage appliance
- Service/recovery router
- Simple PS2-focused web setup

The best starting point is external testing with FTP or Wi-Fi bridge mode.

The most interesting PS2-specific direction is UDPBD or UDPFS with USB storage connected to the A5-V11.

The best long-term direction is a small PS2-focused firmware with clear mode selection, reliable boot timing, recovery access, and simple setup.

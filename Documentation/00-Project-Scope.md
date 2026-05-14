# 00 - Project Scope

## Project Name

A5-V11 Field Manual

## Short Description

A complete research, documentation, firmware, hardware-modification, and PlayStation 2 integration reference for the A5-V11 mini Wi-Fi router.

## Purpose

The purpose of this project is to create a one-stop reference for the A5-V11 mini router.

The A5-V11 is small, cheap, common, and useful, but the available information is scattered across old wiki pages, blogs, forum posts, GitHub repos, videos, personal notes, and community experiments. This repo is intended to collect, organize, verify, and expand that information in one place.

The primary focus is using the A5-V11 as a small internal or external network device for the PlayStation 2, but the repo should also be useful for anyone interested in the A5-V11 as a low-cost embedded Linux router platform.

## Main Goal

The main goal is to document everything useful about the A5-V11 in a clear, organized, and practical way.

This includes:

- Stock board features
- Stock firmware behavior
- OpenWrt support and limitations
- UART access
- Flash backup and recovery
- 4 MB, 8 MB, and 16 MB flash upgrade experiments
- Hardware improvements
- Reliability improvements
- Thermal improvements
- Antenna improvements
- Capacitor relocation and replacement
- Supervisor IC modifications
- PS2 internal mounting
- PS2 network use cases
- UDPBD, UDPFS, SMB1, and FTP use cases
- Test results
- Datasheets
- Community references
- Videos and tutorials
- Future simplified Wi-Fi-only PCB ideas

## What This Project Is

This project is a field manual and research notebook.

It is meant to document what is known, what has been tested, what still needs to be tested, and what is risky.

It is also meant to preserve useful community knowledge before links, forum posts, images, and downloads disappear.

This repo should become a practical reference for:

- Identifying A5-V11 boards
- Understanding board variations
- Backing up original flash contents
- Recovering bricked boards
- Building or testing firmware
- Performing hardware modifications
- Installing the board into a PS2
- Using the board as a PS2 Wi-Fi bridge or network storage helper
- Designing small helper PCBs or flex boards for fitment and reliability

## What This Project Is Not

This project is not an official OpenWrt project.

This project is not an official A5-V11 manufacturer project.

This project is not a commercial firmware release.

This project is not currently a product, kit, or sales page.

This project is not intended to market or sell modified A5-V11 routers.

This project is not intended to claim ownership of other people's work.

This project is heavily based on community research, OpenWrt documentation, old A5-V11 notes, firmware experiments, and PS2 loader work from other developers and hobbyists.

All outside work should be credited clearly.

## Commercial Boundary

This repo is currently for documentation and research only.

The only possible future exception may be small support hardware such as the Flipp'n Caps PCB/Flex, but that is not currently a finished product or kit.

Until something is clearly marked as tested, released, and ready, all PCB and flex designs should be treated as experimental.

No one should assume that any design in this repo is safe for sale, installation, or customer use unless it has a specific release note saying so.

## Primary Application

The primary application is PlayStation 2 integration.

The A5-V11 is being explored as a compact network device for PS2 projects because it has:

- Small physical size
- Low power requirements
- 2.4 GHz Wi-Fi
- 10/100 Ethernet
- USB host support
- OpenWrt compatibility on older builds
- Potential use with PS2 network loaders and file-transfer tools

Possible PS2 uses include:

- Wi-Fi bridge for the PS2 Ethernet port
- FTP access using wLaunchELF
- SMB1 access for OPL
- UDPBD or UDPFS support for newer PS2 loading methods
- Internal PS2 network module
- Internal PS2 game-storage helper
- Compact network bridge for Slim and Ultra Slim style builds
- Test platform for custom PS2 network firmware concepts

## Secondary Applications

Although PS2 use is the main focus, the repo may also document other A5-V11 uses.

Examples:

- General OpenWrt experimentation
- Embedded Linux learning
- Tiny router projects
- Serial console practice
- Flash programming practice
- USB storage experiments
- Low-cost network bridge experiments
- Hardware reverse engineering

These secondary uses are allowed, but they should not distract from the main PS2-focused direction of the repo.

## Hardware Scope

This repo covers the A5-V11 mini router and close variants.

The main target board is the unbranded A5-V11 RT5350F-based mini router.

Typical known hardware features include:

- Ralink or MediaTek RT5350F SoC
- MIPS CPU at 360 MHz
- 32 MB SDRAM on most useful units
- 4 MB SPI flash on stock units
- 1x 10/100 Ethernet port
- 1x USB 2.0 host port
- 1x micro-USB power input
- 2.4 GHz Wi-Fi
- Internal UART pads
- Red and blue LEDs
- Reset button or pinhole switch

Board variants should be documented carefully because these routers were sold under many names and may have different firmware, bootloaders, flash chips, RAM chips, antenna quality, and component choices.

## Firmware Scope

This repo may document firmware work, but it should be careful about how firmware files are handled.

Allowed firmware documentation:

- OpenWrt build notes
- OpenWrt ImageBuilder notes
- OpenWrt Buildroot notes
- Device tree notes
- Flash layout notes
- Package selection notes
- Configuration files
- PS2-specific network configuration
- UART recovery notes
- TFTP recovery notes
- U-Boot notes
- Known working and known broken build paths
- Links to upstream firmware projects
- Notes about third-party firmware builds

Firmware areas of interest:

- Stock firmware behavior
- OpenWrt 15.05-era notes
- OpenWrt 17.01.7 notes
- OpenWrt 18.06 notes
- OpenWrt 19.07 last official 4/32-era support notes
- Gorgylka-style UDPBD builds
- Minimal Wi-Fi bridge builds
- Minimal PS2 utility builds
- 16 MB flash builds
- Custom web GUI concepts
- Mode-switching scripts
- Single-purpose PS2 firmware images

## Firmware Binary Policy

This repo should not casually redistribute firmware binaries unless the license, source, and redistribution rights are understood.

Preferred approach:

- Store source notes
- Store build configs
- Store patches
- Store scripts
- Store file overlays
- Store instructions
- Link to original upstream releases when possible

Avoid uploading:

- Random full flash dumps
- Unknown vendor firmware files
- Personal factory partitions
- Files containing unique MAC addresses
- Files containing RF calibration data from a specific board
- Third-party binaries without clear permission

If binaries are included later, they should go in a clearly marked area and include source, license, version, date, target flash size, and known risks.

## Factory Partition Policy

The factory partition is important.

It may contain board-specific data such as:

- MAC address
- Wi-Fi calibration data
- RF data
- Hardware-specific configuration

The repo should teach people how to preserve and migrate this data.

The repo should not encourage people to overwrite their board with someone else's factory data unless they understand the consequences.

The safest rule is:

Always back up the original flash before making changes.

## Hardware Mod Scope

This repo may document both practical and experimental hardware modifications.

Planned hardware mod sections include:

- Wi-Fi antenna repair or upgrade
- Capacitor replacement
- Capacitor relocation
- Flipp'n Caps PCB/Flex
- MAX809TTR supervisor IC mod
- ADM809 supervisor IC mod
- Flash chip replacement
- 8 MB flash upgrade
- 16 MB flash upgrade
- Heatsink installation
- RF shield heatsink mounting
- Power-input modifications
- USB port modifications
- UART header installation
- PS2 internal Ethernet wiring
- PS2 internal power wiring
- Mounting brackets
- Copper heat spreaders
- Internal PS2 fitment modifications

Each hardware mod should clearly state:

- Purpose
- Difficulty
- Required tools
- Required parts
- Risk level
- Board revision tested
- Whether it was bench tested
- Whether it was PS2 tested
- Photos or diagrams needed
- Known problems
- Reversibility

## PS2 Integration Scope

The PS2 integration section should document how the A5-V11 can be used with PlayStation 2 consoles.

Areas to document:

- External PS2 use
- Internal PS2 use
- PS2 Slim fitment
- PS2 Ultra Slim fitment
- Mounting locations
- RF shield heat-sink ideas
- Ethernet wiring
- Power wiring
- USB storage behavior
- Boot timing
- Router startup delay
- PS2 IP address settings
- Router IP address settings
- Wi-Fi bridge behavior
- FTP using wLaunchELF
- SMB1 using OPL
- UDPBD using supported OPL builds
- UDPFS using supported loaders
- NHDDL and Neutrino-related testing
- Compatibility notes
- Known issues with powered-off console behavior
- Known issues with boot order
- Known issues with USB drive detection

## Future Minimal Wi-Fi PCB Scope

A long-term experimental goal is to study whether a simplified board can be made using only what is needed for a PS2 Wi-Fi bridge.

This idea is not a finished design.

Possible research topics:

- What parts of the A5-V11 are actually required for PS2 Wi-Fi bridge use
- Whether the design can be reduced to only Ethernet, Wi-Fi, power, flash, RAM, and support components
- Whether an RT5350F-based design is practical to reproduce
- Whether a different module or SoC would be better
- Whether the A5-V11 should remain the base platform instead of making a new board
- Whether a custom PCB would be worth the effort
- Whether an off-the-shelf module is a better path

This section should remain clearly marked as future research until real hardware is designed and tested.

## Documentation Style

Documentation should be written in a practical builder style.

The tone should be:

- Clear
- Honest
- Technical but approachable
- Direct
- Cautious where needed
- Credit-focused
- Test-focused
- Not sales-focused

The repo should separate confirmed information from guesses.

Use plain labels such as:

- Confirmed
- Bench Tested
- PS2 Tested
- Experimental
- Untested
- Risky
- Reference Only
- Needs Verification

## Testing Status Labels

Use these labels throughout the repo.

### Confirmed

Information verified by reliable documentation, repeated community testing, or direct testing.

### Bench Tested

Tested outside a PS2 on the bench.

### PS2 Tested

Tested directly with a PlayStation 2.

### Experimental

A promising idea that has not been fully proven.

### Untested

Documented as an idea only.

### Risky

Could brick the router, corrupt flash, damage hardware, or cause unreliable operation.

### Reference Only

Included for documentation or historical value, but not currently recommended.

### Needs Verification

Information that appears useful but needs another source or direct testing.

## Credit Policy

This project depends on other people's work.

Credit must be preserved.

Credit should be given for:

- OpenWrt documentation
- A5-V11 wiki information
- Blog posts
- Forum research
- GitHub projects
- Firmware builds
- PS2 loader work
- UDPBD work
- UDPFS work
- Board photos
- Hardware discoveries
- Videos
- Community testing
- Datasheets and manufacturer documentation

Do not remove upstream credits.

Do not rename someone else's work as original work.

Do not upload someone else's files without permission or a clear license.

If a source is unclear, link to it and mark it as reference material.

## Risk Scope

This project includes risky work.

Risks include:

- Bricking the A5-V11
- Corrupting flash contents
- Losing factory calibration data
- Losing MAC address data
- Damaging the flash chip
- Damaging solder pads
- Damaging the PS2
- Causing unstable boot behavior
- Causing network instability
- Causing overheating
- Causing unreliable game loading
- Creating unsafe wiring inside a console

Every guide should warn the reader when a step is risky.

## Safety Notes

The A5-V11 is normally a low-voltage device, but mistakes can still damage hardware.

Basic safety rules:

- Back up the original flash before modifying firmware
- Do not overwrite the factory partition without understanding it
- Use 3.3 V UART only
- Do not connect 5 V serial adapters to the UART pins
- Verify polarity before powering the board
- Check for shorts before applying power
- Use current-limited bench power when possible
- Do not assume every A5-V11 board is identical
- Do not assume every firmware image works on every board
- Do not install experimental hardware in a PS2 until it has been bench tested

## Out-of-Scope Items

The following items are not the focus of this repo:

- Selling pre-modded routers
- Selling firmware
- Selling PS2 network kits
- Supporting unrelated routers
- Supporting modern secure router use
- Replacing official OpenWrt documentation
- Hosting random firmware dumps
- Hosting game files
- Hosting copyrighted PS2 software
- Hosting BIOS files
- Hosting commercial software
- Providing piracy-focused instructions

## Repository Success Criteria

This repo is successful if it becomes a useful one-stop reference for the A5-V11.

A good finished version should include:

- Clear board overview
- Board identification guide
- Stock firmware notes
- OpenWrt notes
- UART guide
- Flash backup guide
- Recovery guide
- Flash upgrade guide
- Hardware mod guides
- PS2 integration guide
- Photos and diagrams
- Datasheet references
- Known issue list
- Testing notes
- Credit list
- Source links
- Clear warnings
- Clear status labels

## Long-Term Vision

The long-term vision is to push the A5-V11 as far as reasonably possible while documenting the process.

That includes:

- Making the stock board more reliable
- Making it easier to recover from bad flashes
- Making it easier to fit inside PS2 consoles
- Making PS2 network use simpler
- Creating clean helper PCBs or flexes
- Building minimal firmware for specific PS2 use cases
- Exploring whether a simplified Wi-Fi-only PCB is realistic
- Preserving community knowledge around this tiny router

## Current Project Status

This project is in the documentation and research phase.

Some information is known from existing sources.

Some information is based on direct testing.

Some information is still experimental.

Nothing should be treated as a finished product unless it is specifically marked as released and tested.

## Short Version

This repo is a complete A5-V11 field manual with a PS2 focus.

It documents the board, firmware, mods, recovery methods, PS2 use cases, and future hardware ideas.

It is research-first, credit-focused, and not currently a commercial kit or product.

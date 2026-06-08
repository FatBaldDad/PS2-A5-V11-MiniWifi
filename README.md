# A5-V11 Field Manual

A complete research, repair, firmware, and modding reference for the A5-V11 mini Wi-Fi router.

This project focuses on documenting the A5-V11 as thoroughly as possible, especially for PlayStation 2 use. The goal is to collect hardware notes, firmware information, recovery methods, board modifications, PS2 integration ideas, and experimental improvements in one place.

This is not intended to be a commercial kit project. It is a documentation and research project built on top of existing community work.

## Project Goals

- Document the standard A5-V11 board features
- Preserve stock firmware and hardware information
- Document OpenWrt support and limitations
- Document safe flash backup and recovery methods
- Explore 4 MB, 8 MB, and 16 MB flash configurations
- Document useful hardware improvements
- Improve boot reliability with supervisor IC mods
- Improve thermals with heatsinks and PS2 RF shield mounting
- Improve wireless range with antenna modifications
- Relocate or replace capacitors for internal PS2 fitment
- Document PS2-specific use cases:
  - FTP access using wLaunchELF
  - SMB1 use with OPL
  - UDPBD / UDPFS use with newer PS2 loaders
  - Internal PS2 mounting
  - Power and boot-timing behavior
- Explore a future minimal Wi-Fi-only PCB using only what is needed

## What This Project Is

This repo is a field manual and lab notebook for the A5-V11 mini router.

It is meant to help people understand, repair, recover, modify, and repurpose these boards.

The primary application is PlayStation 2 integration, but the information may also be useful for general OpenWrt, embedded Linux, and low-cost router experimentation.

## What This Project Is Not

This is not an official OpenWrt project.

This is not a commercial firmware product.

This is not currently a kit, product, or finished hardware design.

Some experimental boards, such as the Flipp'n Caps PCB/Flex, may eventually become useful prefab parts, but nothing in this repo should be treated as a finished consumer product unless clearly marked as tested and released.

## A5-V11 Hardware Summary

The A5-V11 is a small RT5350F-based mini router commonly sold as a 3G/4G router or M1 SkyShare-style device.

Typical hardware:

- SoC: Ralink / MediaTek RT5350F
- CPU: MIPS 24KEc at 360 MHz
- RAM: 32 MB SDRAM
- Flash: commonly 4 MB SPI flash
- Ethernet: 1x 10/100 Mbps RJ45
- Wireless: 2.4 GHz 802.11b/g/n
- USB: 1x USB 2.0 host port
- Power: 5 V through micro-USB
- Serial console: available through internal pads

Important note: the original 4 MB flash / 32 MB RAM configuration is extremely limited. Current OpenWrt support for 4/32 devices has ended, so this project treats the A5-V11 as a legacy embedded device, not a modern secure router.

## Major Research Areas

### 1. Stock Hardware

Documentation of the original board, components, pinouts, test points, UART pads, LEDs, USB behavior, Ethernet behavior, and power input.

### 2. Stock Firmware

Notes on the original vendor firmware, web interface, telnet access, default IP behavior, BusyBox shell behavior, and firmware backup.

### 3. OpenWrt Firmware

Notes for building and flashing OpenWrt-based firmware for the A5-V11, including older versions that still fit the hardware.

Topics include:

- OpenWrt 17.01.7
- OpenWrt 18.06
- OpenWrt 19.07.10 as the last official 4/32-era release
- ImageBuilder notes
- Buildroot notes
- Device tree changes
- 16 MB flash layout experiments
- Minimal PS2-focused builds

### 4. Flash Upgrades

The stock 4 MB flash is one of the biggest limitations of the A5-V11.

This project documents:

- Original 4 MB layout
- Factory partition preservation
- RF calibration data
- MAC address preservation
- 8 MB flash experiments
- 16 MB flash experiments
- CH341A programming
- UART recovery
- U-Boot behavior
- TFTP recovery

### 5. Hardware Mods

Documented and experimental modifications include:

- External Wi-Fi antenna
- Capacitor relocation
- Ceramic capacitor replacement experiments
- Flipp'n Caps PCB/Flex
- MAX809TTR / ADM809 supervisor IC mod
- Heatsink installation
- RF shield heatsink mounting for PS2 installs
- USB power behavior
- Direct Ethernet wiring
- Flash replacement

### 6. PS2 Integration

The primary practical use case for this project is installing or adapting the A5-V11 for PlayStation 2 network access.

Planned PS2 use cases:

- Wi-Fi bridge for the PS2 Ethernet port
- FTP access through wLaunchELF
- SMB1 access for OPL
- UDPBD / UDPFS support for newer PS2 loaders
- Internal PS2 mounting
- Powering from the console
- Boot delay and timing behavior
- PS2-side network configuration
- Clean internal wiring
- Thermal management inside Slim consoles

### 7. Future Minimal Wi-Fi PCB

A long-term experimental goal is to study whether a simplified board can be created using only the parts needed for a Wi-Fi-only PS2 bridge.

This is a future research area only.

## Documentation Status Labels

Each guide or mod should use one of the following labels:

- `Documented` - copied from known references or confirmed source material
- `Bench Tested` - tested outside a PS2
- `PS2 Tested` - tested inside or directly with a PS2
- `Experimental` - promising but not fully validated
- `Risky` - possible brick/damage risk
- `Reference Only` - included for documentation, not recommended

## References

### GorGylka A5-V11 UDPBD Firmware

GorGylka’s A5-V11 UDPBD project is used as an external reference for this project.

Original GitHub repo:  
https://github.com/GorGylka/UDPBD-A5-V11

This repo is not copied, forked, or included here. It is only linked as a reference for research and comparison.

## Credit and Source Policy

This project is built on community work.

Credit must be preserved for:

- OpenWrt documentation and contributors
- A5-V11 community researchers
- Gorgylka's A5-V11 UDPBD work
- Scargill's A5-V11 testing notes
- Forum posts, blogs, videos, and GitHub repos used as references

Do not remove upstream credits.

Do not claim other people's firmware, scripts, research, photos, or board work as original.

## Binary and Firmware Policy

This repo should avoid casually redistributing firmware binaries unless the license and source are clear.

Recommended policy:

- Store build configs, patches, scripts, and notes
- Link to upstream firmware releases when possible
- Do not publish personal factory partitions containing unique MAC/RF calibration data
- Do not publish full flash dumps from unknown devices without reviewing them first
- Keep third-party binaries in a clearly marked reference section only if redistribution is allowed

## Disclaimer

This project involves soldering, flash programming, router firmware modification, and internal PlayStation 2 modifications.

Mistakes can brick the router, corrupt flash data, damage the PS2, or cause unreliable behavior.

Use this information at your own risk.

## AI Assistance and Attribution Disclaimer

This project uses AI tools to help with writing, organization, documentation, research, code examples, and design planning. While I review and edit the information, some details may still be incorrect, incomplete, or outdated.

Not all ideas, code, research, methods, or technical information in this project should be credited only to me. This project may reference, build on, or be inspired by community knowledge, open-source projects, datasheets, forum posts, Discord discussions, manufacturer documentation, and the work of other developers and modders.

Credit will be given whenever a source is known. If something is missing credit or needs correction, please let me know so I can update the documentation.

# Firmware

## Summary

This folder contains firmware notes, build references, configuration files, patches, scripts, and experimental firmware work for the A5-V11 mini router.

The A5-V11 is a legacy RT5350F-based mini router. It can run older OpenWrt builds, but the stock 4 MB flash and 32 MB RAM configuration is very limited.

The goal of this firmware section is not to turn the A5-V11 into a modern general-purpose router.

The goal is to document and build small, focused firmware images for research, recovery, and PlayStation 2 network use.

## Main Firmware Goals

The firmware work in this repo focuses on:

- Preserving stock firmware information
- Documenting OpenWrt support
- Building minimal OpenWrt images
- Supporting 4 MB stock boards where possible
- Supporting 8 MB and 16 MB flash upgrade experiments
- Creating PS2-focused firmware configurations
- Testing Wi-Fi bridge behavior
- Testing FTP access for wLaunchELF
- Testing SMB1/NT1 access for OPL
- Testing UDPBD support
- Testing UDPFS support
- Improving boot reliability
- Improving power and thermal behavior
- Creating a simple future web setup interface

## Important Warning

Do not flash firmware to an A5-V11 until the original flash has been backed up.

Before flashing anything:

1. Identify the board.
2. Confirm RAM size.
3. Confirm flash size.
4. Capture UART boot log.
5. Dump the full original flash.
6. Verify the flash dump.
7. Extract and save the factory partition.
8. Save the original U-Boot partition.
9. Save the original U-Boot environment.
10. Confirm a recovery method.

The factory partition may contain board-specific Wi-Fi calibration, RF data, and MAC address information.

Do not overwrite it casually.

## Firmware Philosophy

The A5-V11 is tiny and limited.

Good firmware for this board should be:

- Small
- Focused
- Reproducible
- Recoverable
- Well documented
- Clear about flash size
- Clear about RAM requirements
- Clear about install method
- Clear about known risks
- Designed for one job at a time

Bad firmware for this board tries to do everything at once.

Avoid building one bloated image that tries to be:

- Full router
- Full LuCI admin system
- SMB server
- UDPBD server
- UDPFS server
- FTP server
- USB NAS
- VPN endpoint
- Debug system
- PS2 appliance

Instead, create role-specific firmware images.

## Supported Hardware Target

Primary target:

| Item | Value |
|---|---|
| Board | A5-V11 mini router |
| SoC | Ralink / MediaTek RT5350F |
| CPU | MIPS 24KEc |
| CPU speed | 360 MHz |
| RAM | 32 MB preferred |
| Stock flash | 4 MB SPI flash |
| Upgrade flash | 8 MB or 16 MB experimental |
| Ethernet | 1x 10/100 Mbps |
| Wi-Fi | 2.4 GHz 802.11b/g/n |
| USB | 1x USB 2.0 host |
| Power | 5 V input |

Boards with 16 MB RAM, unknown bootloaders, unknown flash layouts, or non-A5-V11 PCB markings should be treated as variants until tested.

## OpenWrt Version Targets

This repo may document several OpenWrt branches.

| Version | Purpose |
|---|---|
| OpenWrt 15.05 | Historical reference and old guide compatibility |
| OpenWrt 17.01.7 | Important PS2/UDPBD reference branch |
| OpenWrt 18.06 | Legacy reference and compatibility testing |
| OpenWrt 19.07.10 | Last official 4/32-era reference point |
| Newer OpenWrt | Research only, not recommended for stock 4 MB boards |

The most practical PS2-focused branch is likely OpenWrt 17.01.7 or a closely related legacy branch, especially for reproducing known UDPBD work.

## Why Modern OpenWrt Is Not The Main Target

The stock A5-V11 is commonly a 4 MB flash / 32 MB RAM device.

That is too small for modern full OpenWrt use.

Problems include:

- Kernel size
- Package size
- Little or no overlay space
- LuCI usually too large
- USB storage support may not fit
- exFAT support may not fit
- SMB support may not fit
- SSH may be missing in some minimal builds
- Settings may fail to save
- Modern security expectations exceed the hardware

For this project, modern OpenWrt is not the goal.

Legacy, purpose-built firmware is the goal.

## Folder Layout

Suggested firmware folder structure:

```text
Firmware/
├── README.md
├── Binary-Policy.md
├── Build-Environment.md
├── Common-Notes.md
├── OpenWrt-15.05/
│   ├── README.md
│   ├── configs/
│   ├── files/
│   ├── patches/
│   └── notes/
├── OpenWrt-17.01.7/
│   ├── README.md
│   ├── configs/
│   ├── files/
│   ├── patches/
│   └── notes/
├── OpenWrt-18.06/
│   ├── README.md
│   ├── configs/
│   ├── files/
│   ├── patches/
│   └── notes/
├── OpenWrt-19.07.10/
│   ├── README.md
│   ├── configs/
│   ├── files/
│   ├── patches/
│   └── notes/
├── Experimental-16MB/
│   ├── README.md
│   ├── configs/
│   ├── files/
│   ├── patches/
│   └── notes/
├── PS2-Focused/
│   ├── Bridge-Only/
│   ├── FTP-Helper/
│   ├── SMB1-OPL/
│   ├── UDPBD/
│   ├── UDPFS/
│   └── Simple-Web-UI/
├── Recovery/
│   ├── README.md
│   ├── U-Boot/
│   ├── TFTP/
│   ├── UART/
│   └── CH341A/
└── Scripts/
    ├── backup/
    ├── build/
    ├── network/
    ├── usb/
    └── ps2/
```

## What Goes In This Folder

This firmware folder may contain:

- Build notes
- `.config` files
- OpenWrt ImageBuilder commands
- OpenWrt Buildroot commands
- Device tree notes
- Flash layout notes
- Patches
- Files overlays
- Network configuration examples
- USB mount scripts
- Service startup scripts
- PS2-specific scripts
- Recovery scripts
- Checksums for known public files
- Links to upstream releases
- Redacted boot logs
- Firmware testing notes

## What Should Not Go In This Folder

Avoid committing:

- Random full flash dumps
- Board-specific factory partitions
- Personal MAC address data
- Unknown vendor firmware binaries
- Unknown U-Boot binaries
- Third-party firmware without license clarity
- Copyrighted PS2 software
- BIOS files
- Game files
- Private Wi-Fi credentials
- Private network configuration
- Unredacted logs with private data

## Binary Policy

Preferred approach:

- Store build instructions
- Store configs
- Store patches
- Store files overlays
- Store scripts
- Link to upstream releases
- Document checksums
- Document exact source
- Document exact build environment

Avoid storing binaries unless there is a clear reason.

If a binary is included later, it must include:

- Source or upstream origin
- License notes
- Build date
- OpenWrt branch
- Target board
- Target flash size
- Target RAM size
- Install method
- Recovery method
- SHA256 checksum
- Tested board IDs
- Known risks

## Full Flash Dump Policy

A full flash dump is useful for recovery, but it should usually remain private.

Full flash dumps may contain:

- U-Boot
- U-Boot environment
- Factory partition
- MAC address
- Wi-Fi calibration data
- RF data
- Vendor firmware

Do not upload full flash dumps casually.

Recommended public approach:

- Explain how to dump the flash.
- Explain how to verify the dump.
- Explain how to extract partitions.
- Use placeholder filenames.
- Keep actual board-specific dumps private.

## Factory Partition Policy

The factory partition is board-specific.

It may contain:

- Wi-Fi calibration
- RF calibration
- MAC address
- Board-specific settings

The repo should teach people to preserve it.

The repo should not encourage people to overwrite their board with someone else's factory data.

Rule:

```text
Always back up your own factory partition before firmware work.
```

## Firmware Roles

Firmware should be organized by role.

## Bridge-Only Firmware

Purpose:

Use the A5-V11 as a simple Ethernet-to-Wi-Fi bridge for PS2 network access.

Possible use cases:

- wLaunchELF FTP access
- PS2 on home network without a long Ethernet cable
- General PS2 network access

Important tests:

- PS2 can get or use correct IP
- PC can reach PS2 FTP
- Bridge or routing behavior is clear
- Wi-Fi remains stable
- Boot time is acceptable
- Power draw is acceptable

## FTP Helper Firmware

Purpose:

Support PS2 file transfer using wLaunchELF FTP.

Possible behaviors:

- Wi-Fi bridge
- Static IP setup
- Simple web setup page
- Clear PS2 network instructions

Important tests:

- PC can ping PS2
- FTP connects
- File transfers complete
- Router does not block inbound FTP
- Network topology is documented

## SMB1 / OPL Firmware

Purpose:

Provide or support SMB1/NT1 file sharing for OPL.

Possible use cases:

- Router hosts USB storage over SMB1
- Router bridges PS2 to an external SMB server
- Router acts as a small PS2 network appliance

Important tests:

- OPL connects
- Games list appears
- Game boots
- SMB protocol is compatible
- Memory use is acceptable
- USB storage mounts reliably
- Performance is acceptable

Warning:

SMB can be heavy for this board.

This role is likely more practical with 16 MB flash, but RAM is still limited.

## UDPBD Firmware

Purpose:

Use the A5-V11 as a UDPBD server with USB storage.

Possible use cases:

- PS2 game loading from USB storage connected to the router
- Ethernet-only PS2 loading
- Low-power PS2 network storage appliance

Important tests:

- Correct PS2-side OPL build
- Correct router-side UDPBD binary
- USB drive detected at boot
- USB filesystem supported
- Game list appears
- Game boots
- Speed is measured
- Boot timing is documented
- USB hotplug behavior is documented

Known notes:

- Some UDPBD workflows require a specific OPL build.
- Some builds expect the USB drive to be connected before router power-on.
- Some builds do not support plug-and-play USB behavior.
- Router boot timing matters.

## UDPFS Firmware

Purpose:

Test UDPFS or newer UDP-based PS2 file serving/loading methods.

Important tests:

- Correct loader
- Correct server binary
- Network mode
- USB mount path
- CPU load
- RAM use
- Game compatibility
- Transfer speed
- Stability

UDPFS should be documented separately from UDPBD.

## Simple Web UI Firmware

Purpose:

Replace full LuCI with a small PS2-focused setup interface.

Possible features:

- Join Wi-Fi network
- Set router IP address
- Set PS2 IP suggestion
- Set subnet mask
- Set gateway
- Set DNS
- Select mode
- Show Ethernet status
- Show Wi-Fi status
- Show USB mount status
- Reboot router
- Reset settings

The web UI should be small and appliance-like.

It should not try to expose all OpenWrt settings.

## Recovery Firmware

Purpose:

Provide a known-good minimal image for recovery and testing.

Useful features:

- Ethernet access
- SSH or telnet for isolated bench use
- UART console
- Basic USB detection
- Clear default IP
- Simple known password policy
- Minimal packages
- Low risk
- Easy sysupgrade path

Recovery firmware should be tested before relying on it.

## Flash Size Targets

## 4 MB Stock Flash

Use for:

- Minimal tests
- Bridge-only firmware
- UDPBD-only experiments
- Recovery experiments
- Stock behavior comparison

Avoid:

- Full LuCI
- Samba unless heavily stripped
- Multiple services
- Large web UI
- Extra packages
- Unneeded filesystem drivers

## 8 MB Flash

Use for:

- Slightly more comfortable builds
- SSH and basic scripts
- Small web UI
- USB storage support
- Better overlay space
- Transitional experiments

Still avoid bloated all-in-one firmware.

## 16 MB Flash

Use for:

- Serious development
- PS2-focused firmware
- Custom web UI
- USB storage support
- exFAT support
- SMB experiments
- UDPBD and UDPFS experiments
- Recovery tools
- Better logging
- More overlay space

16 MB flash gives room, but it does not increase RAM.

The firmware must still be lightweight.

## Common Default IPs

Known or proposed IP behavior:

| Firmware State | Possible IP |
|---|---|
| Stock firmware | 192.168.100.1 or DHCP-assigned |
| OpenWrt default | 192.168.1.1 |
| PS2-focused setup idea | 192.168.1.222 |

Each firmware build must document its default IP.

## Common Login Notes

Stock firmware often uses:

```text
admin / admin
```

OpenWrt behavior depends on branch and configuration.

Possible OpenWrt states:

- Telnet open with no password
- Password must be set before SSH
- SSH available through Dropbear
- SSH missing in tiny builds
- UART console only

Each firmware build must document:

- Default login
- Password behavior
- SSH availability
- Telnet availability
- UART behavior

## Build Methods

## ImageBuilder

ImageBuilder is useful for:

- Faster builds
- Package selection testing
- Minimal image experiments
- Older branch image generation

Good for:

- Stock 4 MB tests
- Quick package trimming
- Reproducible simple images

## Full Source Build

Full source build is useful for:

- Device tree changes
- 16 MB flash layout
- Kernel config changes
- Custom board definitions
- Custom packages
- Custom web UI
- Deeper OpenWrt changes

This is the preferred path for serious 16 MB firmware work.

## Build Environment Notes

Old OpenWrt branches may not build cleanly on modern Linux systems.

Possible build environments:

- Ubuntu 16.04
- Older Debian
- Docker container
- VM with older dependencies
- Dedicated Linux build machine

Every build folder should document:

- Host OS
- Required packages
- OpenWrt branch
- Commit or release tag
- Build command
- Config file
- Files overlay
- Patches
- Resulting image
- Tested board ID

## Common Firmware Files

Possible firmware-related files:

| File | Purpose |
|---|---|
| `.config` | OpenWrt build configuration |
| `files/` | Files overlay copied into firmware |
| `patches/` | Source patches |
| `network` | OpenWrt network config |
| `wireless` | OpenWrt Wi-Fi config |
| `fstab` | Mount configuration |
| `rc.local` | Startup commands |
| `firewall` | Firewall configuration |
| `smb.conf` | Samba configuration |
| `uhttpd` | Web server configuration |
| `dropbear` | SSH server configuration |
| `sysupgrade.bin` | OpenWrt upgrade image |
| `factory.bin` | First-install image |
| `full-flash.bin` | External programmer image only |

## Image Type Warning

Use the correct image type.

| Image Type | Typical Use |
|---|---|
| factory.bin | First install from stock firmware or vendor web UI |
| sysupgrade.bin | Upgrade from existing OpenWrt |
| raw firmware partition | Direct partition write only when layout is known |
| full flash image | External SPI programmer only |

Do not confuse these.

Using the wrong image type can brick the router.

## U-Boot Warning

U-Boot files are dangerous.

Some files are specific to RAM size.

Common clue:

| File Name Pattern | Often Associated With |
|---|---|
| 128 | 16 MB RAM |
| 256 | 32 MB RAM |

Do not flash U-Boot unless:

- RAM size is confirmed
- Flash size is confirmed
- Original U-Boot is backed up
- Replacement U-Boot is known good for the board
- A hardware programmer is available
- UART is connected
- The risk is acceptable

## Install Methods

Possible install methods:

| Method | Notes |
|---|---|
| Stock web UI | Works on some units, silently fails or rejects images on others |
| Stock telnet and mtd_write | Useful but risky |
| OpenWrt sysupgrade | Normal path once OpenWrt is installed |
| U-Boot TFTP | Useful with UART and compatible bootloader |
| TFTP recovery without serial | Only works on some modified bootloaders |
| CH341A programming | Best hard recovery and flash upgrade method |

Each firmware build should say which install method it supports.

## Testing Requirements

A firmware build is not considered useful until tested.

Minimum test list:

| Test | Required |
|---|---|
| Boots | Yes |
| UART log captured | Yes |
| Ethernet works | Yes |
| Wi-Fi works if included | Yes |
| USB works if included | Yes |
| Overlay space checked | Yes |
| RAM usage checked | Yes |
| Reboot tested | Yes |
| Recovery method documented | Yes |
| Flash size documented | Yes |
| Board ID documented | Yes |

For PS2 builds, also test:

| Test | Required |
|---|---|
| PS2 connected by Ethernet | Yes |
| PS2 IP plan works | Yes |
| Loader sees service | Yes |
| Game list appears if applicable | Yes |
| Game boots if applicable | Yes |
| Boot timing recorded | Yes |
| Power draw recorded | Yes |
| Thermal behavior recorded | Yes |

## Firmware Status Labels

Use these labels for firmware folders and notes.

| Label | Meaning |
|---|---|
| Reference Only | Documented from outside source |
| Builds | Source/config builds successfully |
| Boots | Image boots on A5-V11 |
| Ethernet Works | Wired Ethernet tested |
| Wi-Fi Works | Wireless tested |
| USB Works | USB storage tested |
| PS2 Bench Tested | Tested with PS2 externally |
| PS2 Internal Tested | Tested inside PS2 |
| Broken | Known not to work |
| Risky | Can brick or has major uncertainty |
| Deprecated | Kept for history only |
| Recommended | Preferred current build path |

## Firmware Release Note Template

Each tested firmware should include a release note.

```text
Firmware name:
Status:
Purpose:
OpenWrt version:
Source:
Commit or release:
Build method:
Build host OS:
Target:
Subtarget:
Device/profile:
Flash size:
RAM size:
Image type:
Image file:
SHA256:
Default IP:
Default login:
SSH included:
Telnet included:
UART console:
Wi-Fi included:
USB included:
Filesystem support:
Included packages:
Removed packages:
Files overlay:
Patches:
Factory partition handling:
U-Boot requirement:
Install method:
Recovery method:
Tested board IDs:
Ethernet tested:
Wi-Fi tested:
USB tested:
PS2 tested:
Known issues:
Risk level:
Notes:
```

## PS2 Firmware Release Note Template

For PS2-focused builds:

```text
Firmware name:
PS2 role:
Supported loader:
Loader version:
Router-side service:
Service version:
USB filesystem:
USB hotplug supported:
USB must be inserted before boot:
Default router IP:
Suggested PS2 IP:
Suggested PC IP:
Network mode:
Bridge or routed:
SMB protocol, if used:
UDPBD version, if used:
UDPFS version, if used:
Boot-to-ready time:
Recommended PS2 boot delay:
Power source tested:
Current draw:
Thermal result:
Known issues:
Notes:
```

## Package Selection Notes

Avoid unused packages.

On 4 MB builds, every package matters.

Possible packages by role:

| Role | Possible Packages |
|---|---|
| Bridge-only | Minimal network and Wi-Fi packages |
| USB storage | kmod-usb-core, kmod-usb2, kmod-usb-storage, block-mount |
| FAT32 | kmod-fs-vfat, codepage/NLS packages |
| exFAT | exFAT support package for the selected branch |
| SSH | dropbear |
| Web UI | uhttpd or tiny custom web server |
| SMB | Samba package appropriate to branch |
| UDPBD | UDPBD server binary and scripts |
| UDPFS | UDPFS server binary and scripts |

Exact package names vary by OpenWrt branch.

## Packages To Avoid Unless Needed

Avoid on tiny builds:

- Full LuCI
- IPv6 packages
- PPP packages
- PPPoE packages
- 3G/4G modem packages
- VPN packages
- Multiple filesystem drivers
- Multiple USB serial drivers
- Heavy web servers
- Heavy logging
- Unused debugging tools
- Multiple PS2 services running together

## Network Configuration Notes

Every firmware build should document:

- LAN interface
- Wi-Fi interface
- Bridge interface
- VLAN interface
- Default IP
- DHCP server behavior
- DHCP client behavior
- Gateway behavior
- Firewall behavior
- DNS behavior
- PS2-side IP expectations

A5-V11 Ethernet may use:

```text
eth0
```

or:

```text
eth0.1
```

depending on the OpenWrt branch and configuration.

Do not assume.

## USB Storage Notes

Every USB-capable firmware should document:

- USB driver support
- Filesystem support
- Mount path
- Hotplug behavior
- Drive format
- Partition table type
- Whether USB must be inserted before boot
- Whether large drives work
- Whether USB HDD parking prevention is used
- Whether a keepalive file is created

## Power And Thermal Notes

Firmware can affect power and heat.

Possible firmware power optimizations:

- Disable unused Ethernet PHYs
- Disable Wi-Fi when not needed
- Disable unused services
- Avoid constant logging
- Run one service mode at a time
- Avoid heavy Samba builds when not required

Thermal testing should be documented for all PS2 internal firmware roles.

## Known Useful Startup Concepts

Possible startup logic:

- Wait for USB drive
- Mount USB drive
- Verify required folders
- Start selected service
- Create keepalive file if needed
- Disable unused PHYs
- Configure LED status
- Mark service ready
- Log startup result

## Service-Ready State

For PS2 use, firmware should clearly define when it is ready.

Service-ready may mean:

- Ethernet is up
- Wi-Fi is connected, if used
- USB storage is mounted, if used
- SMB is running, if used
- UDPBD is running, if used
- UDPFS is running, if used
- FTP helper network path is reachable, if used

Boot timing should be measured from power-on to service-ready.

## Recovery Requirements

Every firmware build should document how to recover from:

- Bad IP settings
- Bad Wi-Fi settings
- Missing SSH
- Missing web UI
- Bad USB mount script
- Service startup failure
- Soft brick
- Failed boot
- Bad sysupgrade

Minimum recovery plan:

- UART access
- Known default IP
- Known failsafe behavior
- Known sysupgrade path
- External programmer backup

## Security Notes

The A5-V11 is a legacy device.

Do not treat stock 4 MB A5-V11 firmware as a secure modern router.

Security concerns:

- Old OpenWrt branches
- Old kernels
- Old packages
- Limited update path
- Telnet on stock firmware
- Default credentials
- Unknown vendor firmware
- Tiny flash prevents modern package sets

Use this project for focused, controlled, local-network PS2 use.

Do not expose it directly to the internet.

## Public Repo Notes

This firmware section should be clear and honest.

Each firmware folder should say:

- What works
- What does not work
- What is untested
- What can brick the router
- What flash size it targets
- What board was tested
- What source it is based on
- Who deserves credit

Do not present experimental firmware as finished.

## Credits

Firmware work in this repo may reference or build on:

- OpenWrt
- LEDE/OpenWrt legacy branches
- A5-V11 OpenWrt wiki notes
- Gorgylka UDPBD A5-V11 work
- PS2 loader developers
- UDPBD developers
- UDPFS developers
- Forum posts and community research
- Scargill's A5-V11 testing notes
- Other A5-V11 firmware experiments

Do not remove upstream credits.

Do not rename other people's firmware as original work.

## Current Recommended Direction

The recommended firmware development path for this project is:

1. Preserve stock firmware and factory data.
2. Build or reproduce a known-good legacy OpenWrt image.
3. Confirm UART, Ethernet, Wi-Fi, and USB behavior.
4. Reproduce known UDPBD-style behavior as a reference.
5. Build a minimal bridge-only PS2 firmware.
6. Upgrade a test board to 16 MB flash.
7. Create a 16 MB PS2-focused development firmware.
8. Add simple service mode scripts.
9. Add a tiny PS2-focused web UI.
10. Test inside a PS2 only after bench testing passes.

## Short Version

This folder is for A5-V11 firmware research and PS2-focused OpenWrt development.

The main rules are:

- Back up the original flash first.
- Preserve the factory partition.
- Document the exact board and flash size.
- Use UART for development.
- Keep firmware small and role-specific.
- Prefer reproducible configs and patches over random binaries.
- Treat 4 MB builds as extremely limited.
- Use 16 MB flash for serious development.
- Do not treat this as modern secure router firmware.

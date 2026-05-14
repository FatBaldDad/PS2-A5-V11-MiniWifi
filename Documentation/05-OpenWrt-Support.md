# 05 - OpenWrt Support

## Summary

This document covers OpenWrt support for the A5-V11 mini router.

The A5-V11 has a long OpenWrt history, but it should be treated as a legacy device.

The standard A5-V11 hardware is useful for experiments, recovery practice, PS2 network projects, and special-purpose firmware builds, but it is not a good target for modern full OpenWrt use in its stock form.

The stock board commonly has:

- 4 MB SPI flash
- 32 MB RAM
- Ralink / MediaTek RT5350F SoC
- ramips / rt305x OpenWrt target history

The 4 MB flash and 32 MB RAM combination is the main limitation.

## Important Warning

The stock 4 MB / 32 MB A5-V11 should not be treated as a modern secure OpenWrt router.

It is best treated as:

- Legacy OpenWrt research hardware
- Embedded Linux learning hardware
- A PS2-focused network helper
- A small single-purpose appliance
- A flash-upgrade experiment platform
- A firmware recovery practice board

Do not use stock 4 MB A5-V11 hardware as an internet-facing secure router.

## OpenWrt Support Status

The A5-V11 is supported only in older OpenWrt branches.

The stock 4 MB flash version is too limited for current full-featured OpenWrt use.

Important points:

- The A5-V11 belongs to the ramips / rt305x target family.
- The SoC is Ralink / MediaTek RT5350F.
- Older OpenWrt builds supported this board.
- 4 MB flash is extremely restrictive.
- 32 MB RAM is also restrictive.
- Modern OpenWrt builds are not realistic for stock 4 MB hardware.
- OpenWrt 19.07.10 is commonly referenced as the last official 4/32-era release.
- Newer OpenWrt versions should be treated as out-of-scope for stock 4 MB boards unless someone is doing advanced custom work.

## Why OpenWrt Still Matters For This Project

Even though modern OpenWrt support is limited, OpenWrt is still important for this repo.

OpenWrt gives the A5-V11:

- Linux-based configuration
- Network bridge options
- Wi-Fi client mode
- Ethernet configuration
- USB storage support
- Package-based firmware customization
- Scripting
- UART console access
- Boot logs
- Recovery options
- Filesystem control
- PS2-specific service possibilities

For PS2 use, the goal is not a general-purpose router.

The goal is a trimmed, purpose-built firmware that does only what the PS2 project needs.

## Primary OpenWrt Goal For This Repo

The primary OpenWrt goal is to document and build minimal PS2-focused firmware for the A5-V11.

Possible PS2-focused firmware roles:

- Wi-Fi bridge only
- FTP helper network bridge
- SMB1 / NT1 server for OPL
- UDPBD storage appliance
- UDPFS storage appliance
- USB-storage network helper
- Simple setup web page
- Recovery-friendly development image
- 16 MB flash enhanced image

## Supported Hardware Target

The main hardware target is:

| Item | Value |
|---|---|
| Board | A5-V11 mini router |
| SoC | Ralink / MediaTek RT5350F |
| OpenWrt target family | ramips |
| OpenWrt subtarget | rt305x |
| CPU | MIPS 24KEc |
| CPU speed | 360 MHz |
| RAM | 32 MB preferred |
| Stock flash | 4 MB SPI flash |
| Upgrade flash | 8 MB or 16 MB experimental |
| Ethernet | 1x 10/100 |
| Wi-Fi | 2.4 GHz |
| USB | 1x USB 2.0 host |

## Hardware That Needs Extra Caution

Proceed carefully with boards that have:

- 16 MB RAM
- Unknown RAM chip
- Unknown flash size
- Unknown bootloader
- No UART access
- No original flash dump
- No saved factory partition
- Damaged flash chip
- Damaged UART pads
- No Ethernet link
- No Wi-Fi activity
- Previous failed firmware attempts

A firmware build that works on a 32 MB RAM board may not work on a 16 MB RAM board.

A firmware build for 4 MB flash will not use the full space of a 16 MB flash upgrade unless the layout is changed.

A firmware build for 16 MB flash can brick or fail on a 4 MB board.

## Version Notes

This section lists OpenWrt versions that are relevant to A5-V11 research.

## OpenWrt 15.05 Chaos Calmer

OpenWrt 15.05 is important historically because many older A5-V11 guides reference it.

Possible uses:

- Historical reference
- Stock-to-OpenWrt flashing research
- Older ImageBuilder examples
- Smaller firmware experiments
- Comparison against later builds

Limitations:

- Very old
- Not secure for modern router use
- Old kernel
- Old packages
- Not ideal for long-term project firmware unless needed for a specific test

## LEDE / OpenWrt 17.01.7

OpenWrt 17.01.7 is especially important for this project.

Known PS2-focused A5-V11 work has used OpenWrt 17.01.7 as a base.

Possible uses:

- UDPBD builds
- exFAT support experiments
- USB storage support
- PS2-specific appliance firmware
- 4 MB flash experiments
- Known community reference point

This is likely one of the most important branches for reproducing existing PS2-focused A5-V11 work.

## OpenWrt 18.06

OpenWrt 18.06 is another relevant legacy branch.

Possible uses:

- Historical reference
- Last-era official images for some A5-V11 references
- Comparison testing
- Firmware size testing
- Recovery experiments

Limitations:

- Still old
- Still constrained by 4 MB flash
- Not modern secure router firmware
- May be too large depending on packages

## OpenWrt 19.07.10

OpenWrt 19.07.10 is commonly referenced as the last official build era for 4 MB flash / 32 MB RAM devices.

For this repo, 19.07.10 should be treated as:

- A final official reference point for 4/32-class OpenWrt support
- A compatibility boundary
- A research target, not necessarily the best PS2 target

It may still be too tight for useful A5-V11 PS2 appliance work on stock 4 MB flash.

## Newer OpenWrt Versions

Newer OpenWrt versions are not recommended for the stock 4 MB / 32 MB A5-V11.

Reasons:

- Kernel is larger
- Packages are larger
- 4 MB flash is too small
- 32 MB RAM is too limited
- Overlay space may be unusable
- LuCI may not fit
- USB storage support may not fit
- SMB support may not fit
- Custom scripts may not fit
- Modern security expectations exceed the hardware

Newer branches may only be worth studying if:

- The flash is upgraded
- The image is extremely stripped down
- The goal is research only
- Someone is willing to maintain custom patches
- The resulting firmware is not treated as a secure router

## Stock 4 MB Flash Strategy

For stock 4 MB boards, the firmware must be extremely minimal.

Recommended strategy:

- Avoid LuCI unless absolutely required.
- Avoid IPv6 packages if not needed.
- Avoid PPP packages if not needed.
- Avoid modem packages if not needed.
- Avoid multiple services.
- Use only the packages required for the specific PS2 role.
- Keep Dropbear only if SSH is needed and fits.
- Prefer UART access during development.
- Prefer one service mode at a time.
- Keep the image reproducible from source/config.

Possible stock 4 MB roles:

- Wi-Fi bridge only
- UDPBD-only appliance
- FTP bridge helper
- Extremely minimal USB-storage image
- Recovery test image

Stock 4 MB is not a good target for a full all-in-one PS2 firmware.

## 8 MB Flash Strategy

An 8 MB flash upgrade gives more room but is still limited.

Possible 8 MB goals:

- More comfortable OpenWrt base
- Dropbear SSH
- Basic web setup page
- USB storage support
- Basic PS2 helper scripts
- Better overlay space
- Easier debugging

8 MB may be enough for a useful PS2 appliance image, but it is still not generous.

## 16 MB Flash Strategy

A 16 MB flash upgrade is the preferred long-term path for serious A5-V11 development.

Possible 16 MB goals:

- Custom PS2-focused web UI
- Dropbear SSH
- USB storage support
- exFAT support
- FAT32 support
- SMB1 support
- UDPBD support
- UDPFS support
- Mode-switching scripts
- Better recovery tooling
- Better logs
- More overlay space
- Cleaner development workflow

A 16 MB flash upgrade does not remove the 32 MB RAM limitation.

Even with 16 MB flash, the firmware should still avoid running too much at once.

## Factory Partition Warning

Flash upgrades must preserve the factory partition.

The factory partition may contain:

- Wi-Fi calibration data
- RF calibration data
- MAC address
- Board-specific settings

Do not overwrite it casually.

For 8 MB and 16 MB flash upgrades:

1. Dump the original 4 MB flash.
2. Verify the dump.
3. Save the full dump.
4. Extract the factory partition.
5. Preserve U-Boot and U-Boot environment.
6. Build a new flash layout.
7. Expand only the firmware area.
8. Keep factory data at the expected offset unless the firmware is specifically changed to match a new layout.
9. Test with UART connected.

## Common Stock Flash Layout

A common stock A5-V11 flash layout is:

| Offset | Size | Partition |
|---:|---:|---|
| 0x000000 | 0x030000 | u-boot |
| 0x030000 | 0x010000 | u-boot-env |
| 0x040000 | 0x010000 | factory |
| 0x050000 | Remaining flash | firmware |

For stock 4 MB flash:

| Partition | Typical Range |
|---|---|
| u-boot | 0x000000 to 0x030000 |
| u-boot-env | 0x030000 to 0x040000 |
| factory | 0x040000 to 0x050000 |
| firmware | 0x050000 to 0x400000 |

For 16 MB flash, the firmware area can potentially extend to:

```text
0x1000000
```

but only if the bootloader, firmware definition, and OpenWrt layout are correct.

## Image Types

OpenWrt images commonly come in two types.

| Image Type | Use |
|---|---|
| factory.bin | First flash from stock firmware or vendor updater |
| sysupgrade.bin | Upgrade from an existing OpenWrt install |

Use the correct image type.

Do not flash a sysupgrade image through a stock firmware web UI unless a guide specifically says that stock firmware expects that format.

Do not flash a factory image through sysupgrade unless specifically supported.

## First Install Methods

Possible first install paths:

| Method | Notes |
|---|---|
| Stock web UI firmware update | Works on some units, fails or silently does nothing on others |
| Stock telnet with mtd_write | Works on some units with USB access and required commands |
| U-Boot over serial | Useful when UART works and U-Boot menu is available |
| TFTP recovery | Depends on bootloader behavior |
| CH341A flash programming | Safest for full backup and hard recovery |
| Direct replacement flash chip | Useful for 8 MB or 16 MB migration |

The safest development approach is:

- Dump first
- Preserve factory partition
- Use UART
- Have a CH341A or similar programmer available
- Test with expendable boards

## Web UI Flashing From Stock Firmware

Some stock firmware web interfaces can flash an OpenWrt factory image.

Possible outcomes:

- Flash succeeds and OpenWrt boots.
- Image is rejected.
- Upload completes but firmware does not change.
- Router reboots to stock firmware.
- Router becomes unreachable.
- Router bricks.

After web flashing, verify with:

- UART boot log
- OpenWrt banner
- New IP behavior
- Telnet or SSH behavior
- Web interface change
- Partition output

Do not trust the success message alone.

## Stock Telnet mtd_write Method

Some stock firmware versions allow flashing through telnet.

A common pattern is:

```text
mount /dev/sda1 /mnt
ls /mnt
mtd_write write /mnt/uboot_usb_256_03.img Bootloader
mtd_write write /mnt/firmware.bin Kernel
reboot
```

Warning:

This is risky.

Before using mtd_write, confirm:

- Correct board
- Correct RAM size
- Correct flash size
- Correct U-Boot file
- Correct firmware file
- Correct partition names
- USB drive is mounted correctly
- Files are visible
- Power is stable
- Full flash dump exists
- UART is available if possible

Do not interrupt power during mtd_write.

## U-Boot Warning

Some old A5-V11 guides use U-Boot images with names that indicate RAM size.

Common naming clue:

| File Name Pattern | Often Associated With |
|---|---|
| 128 | 16 MB RAM |
| 256 | 32 MB RAM |

Do not guess.

Flashing the wrong U-Boot can hard-brick the router.

Only replace U-Boot if:

- The current U-Boot is backed up.
- The board RAM size is confirmed.
- The replacement U-Boot is known good for the board.
- A hardware programmer is available.
- UART is connected.
- The risk is acceptable.

## Serial / U-Boot Install

U-Boot can be used to load firmware over TFTP when serial access is available.

General concept:

1. Connect UART.
2. Start a TFTP server on the PC.
3. Put the OpenWrt image in the TFTP root.
4. Boot the router.
5. Interrupt U-Boot.
6. Select the correct U-Boot option.
7. Enter router IP, server IP, and file name.
8. Load image.
9. Write image if intended.
10. Reboot and verify.

Example TFTP server command from older notes:

```text
dnsmasq --port=0 --enable-tftp eth0 --tftp-root=/your/folder
```

Actual commands depend on host OS and network interface.

## TFTP Without Serial

Some modified bootloaders may allow TFTP recovery without serial.

A common pattern from older notes:

1. Rename known working sysupgrade image to `firmware.bin`.
2. Hold reset while powering the router.
3. Wait for blue LED flashing.
4. Set PC IP to `192.168.1.2`.
5. TFTP the image to `192.168.1.1`.
6. Wait for automatic reboot.

Example:

```text
tftp 192.168.1.1
mode binary
put firmware.bin
```

Warning:

This behavior may require a modified bootloader.

It may not work on stock U-Boot.

Test and document per board.

## CH341A / External Programmer Method

For serious A5-V11 work, an external SPI programmer is strongly recommended.

Benefits:

- Full flash backup
- Factory partition preservation
- U-Boot recovery
- Recovery from bad firmware
- 8 MB and 16 MB flash preparation
- Offline verification
- Easier experimentation

Recommended actions:

- Read the chip multiple times.
- Compare dumps.
- Save verified backups.
- Label backups by board ID.
- Never overwrite the only known-good dump.
- Verify programmed flash before soldering.
- Keep factory data safe.

## Build Methods

There are two main OpenWrt build approaches for this project.

| Method | Use |
|---|---|
| ImageBuilder | Faster, simpler, uses prebuilt packages |
| Buildroot / full source build | More flexible, needed for deeper changes |

## ImageBuilder

ImageBuilder is useful for:

- Quickly creating custom images
- Adding or removing packages
- Testing minimal package sets
- Reproducing older image layouts
- Making small changes without compiling the full toolchain

Example older ImageBuilder flow:

```text
wget http://downloads.openwrt.org/chaos_calmer/15.05/ramips/rt305x/OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64.tar.bz2
tar xfj OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64.tar.bz2
cd OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64
make image PROFILE="A5-V11"
```

This is an old example.

For the repo, keep version-specific commands in version-specific folders.

## Buildroot / Full Source Build

A full OpenWrt source build is useful for:

- Device tree changes
- Flash layout changes
- 16 MB flash support
- Kernel config changes
- Custom packages
- Custom files overlay
- Custom scripts
- Custom web interface
- Reproducible PS2 firmware
- Deeper debugging

Full source builds take more time and need a working Linux build environment.

## Build Environment Notes

Old OpenWrt branches may not build cleanly on modern Linux distributions.

For older branches, it may be easier to use:

- Ubuntu 16.04 VM
- Older Debian VM
- Docker container with older build dependencies
- Dedicated Linux build machine
- Known-good build environment documented in the repo

For this project, each firmware branch should document:

- Host OS
- Package dependencies
- Toolchain version
- OpenWrt commit or release tag
- Config file
- Files overlay
- Patches
- Build command
- Output image names
- Tested board
- Tested flash size

## Recommended Repo Firmware Folder Layout

Suggested structure:

```text
Firmware/
├── README.md
├── Binary-Policy.md
├── Build-Notes/
│   ├── OpenWrt-15.05.md
│   ├── OpenWrt-17.01.7.md
│   ├── OpenWrt-18.06.md
│   ├── OpenWrt-19.07.10.md
│   └── Build-Environment.md
├── OpenWrt-17.01.7/
│   ├── configs/
│   ├── files/
│   ├── patches/
│   └── notes.md
├── OpenWrt-18.06/
│   ├── configs/
│   ├── files/
│   ├── patches/
│   └── notes.md
├── OpenWrt-19.07.10/
│   ├── configs/
│   ├── files/
│   ├── patches/
│   └── notes.md
└── Experimental-16MB/
    ├── configs/
    ├── files/
    ├── patches/
    └── notes.md
```

## Package Selection Philosophy

The A5-V11 cannot run everything comfortably.

Choose packages based on the firmware role.

Do not make one bloated image that tries to be:

- Router
- NAS
- SMB server
- UDPBD server
- UDPFS server
- FTP server
- LuCI router
- VPN endpoint
- Debug workstation

A better strategy is to create role-specific images.

Example roles:

| Image Role | Main Purpose |
|---|---|
| bridge-only | Wi-Fi bridge for PS2 Ethernet |
| udpbd-only | USB storage over UDPBD |
| smb1-only | OPL SMB1 storage |
| ftp-helper | Simple PS2 file-transfer network helper |
| recovery | SSH/UART-friendly recovery image |
| dev | Bigger 16 MB development image |

## Packages To Avoid Unless Needed

Avoid these on stock 4 MB builds unless required:

- LuCI
- IPv6 packages
- PPP packages
- PPPoE packages
- 3G/4G modem packages
- VPN packages
- Samba4, unless the firmware is specifically SMB-focused and has enough space
- Multiple filesystem drivers
- Multiple USB serial drivers
- Heavy web servers
- Large debugging packages
- Unused wireless tools

## Packages Commonly Needed

Depending on the role, useful packages may include:

| Package Area | Possible Packages |
|---|---|
| USB storage | kmod-usb-core, kmod-usb2, kmod-usb-storage |
| Filesystems | kmod-fs-vfat, kmod-fs-ext4, exfat support where available |
| Mounting | block-mount |
| SSH | dropbear |
| Wi-Fi | wireless tools already included by target image |
| SMB | samba or samba4 depending on branch and space |
| PS2 UDPBD | udpbd or udpfs-related binary/script depending on project |
| Web setup | uhttpd or very small custom web approach |

Exact package names vary by OpenWrt branch.

## LuCI Notes

LuCI is useful but heavy for this board.

On stock 4 MB flash, LuCI often consumes too much space.

Possible approaches:

- No LuCI for 4 MB images
- Minimal LuCI only on 8 MB or 16 MB images
- Replace LuCI with a tiny custom PS2 setup page
- Use SSH/UART for development
- Use a static config file for appliance builds

For PS2 use, a tiny custom web UI may be better than LuCI.

## Custom Web UI Goal

A PS2-focused custom web UI should be simple.

Possible features:

- Join Wi-Fi network
- Set router IP
- Set PS2 IP suggestion
- Set subnet mask
- Set gateway
- Set DNS
- Select service mode
- Show Wi-Fi status
- Show Ethernet status
- Show USB mount status
- Reboot router
- Reset to default settings

The UI should not try to expose every OpenWrt feature.

The goal is appliance-style setup.

## Network Interface Notes

A5-V11 Ethernet configuration can be confusing.

Some OpenWrt references use:

```text
eth0.1
```

for the LAN interface instead of plain:

```text
eth0
```

Incorrect interface configuration can make the board unreachable.

For every firmware build, document:

- LAN interface name
- bridge interface name
- Wi-Fi interface name
- default IP
- DHCP behavior
- firewall behavior
- DNS behavior
- PS2-side IP expectations
- recovery IP

## Default IP Ideas

Common IP references:

| Firmware State | Possible IP |
|---|---|
| Stock firmware | 192.168.100.1 |
| OpenWrt default | 192.168.1.1 |
| PS2-focused default idea | 192.168.1.222 |

For this project, a PS2-focused firmware may eventually use:

```text
192.168.1.222
```

as a setup IP.

This is only a design idea and should be clearly documented in the firmware release notes.

## Wi-Fi Bridge Mode

A basic PS2 Wi-Fi bridge mode would connect:

```text
PS2 Ethernet -> A5-V11 Ethernet -> A5-V11 Wi-Fi -> Home network
```

Important bridge questions:

- Is this true layer-2 bridging or routed client mode?
- Does the home router see the PS2 MAC?
- Does the PS2 need a static IP?
- Does the A5-V11 need a static IP?
- Does DHCP pass through correctly?
- Is NAT used?
- Can wLaunchELF FTP be reached from the PC?
- Can OPL reach SMB shares?
- Does UDPBD or UDPFS work through the chosen mode?

These need testing and should not be assumed.

## SMB1 / OPL Notes

OPL SMB use commonly depends on SMB1 / NT1 behavior.

A PS2 SMB-focused firmware should document:

- SMB server version
- SMB protocol level
- Share path
- Guest access
- Username/password
- Filesystem format
- USB mount path
- OPL settings
- Game folder layout
- Performance
- Compatibility
- RAM usage
- Boot timing

SMB can be heavy for the A5-V11.

A 16 MB flash upgrade may help with space, but RAM remains limited.

## UDPBD Notes

UDPBD is important for PS2-focused A5-V11 work.

Known community A5-V11 UDPBD work uses a specific OpenWrt build and specific PS2-side loader setup.

For this repo, document:

- Firmware base
- UDPBD binary source
- UDPBD version
- USB filesystem support
- USB drive format
- Router boot time
- PS2 boot delay
- OPL version required
- Whether Wi-Fi is enabled or disabled
- Whether unused Ethernet PHYs are disabled
- Power draw
- Speed results
- Compatibility results
- Known failure modes

## UDPFS Notes

UDPFS should be documented separately from UDPBD.

For UDPFS testing, record:

- Loader used
- Server binary used
- Firmware branch
- CPU usage
- RAM usage
- Network mode
- USB filesystem
- Game compatibility
- Speed
- Stability
- Whether Wi-Fi is usable
- Whether Ethernet-only is required

## USB Storage Notes

USB storage support depends on firmware packages.

Important areas:

- USB core support
- USB 2.0 support
- USB storage driver
- Filesystem driver
- Mount script
- Hotplug behavior
- Drive format
- Power draw
- Startup timing
- Whether the drive must be inserted before boot
- Whether large drives work
- Whether exFAT works
- Whether FAT32 works
- Whether ext4 works

Some PS2-focused builds may require the USB drive to be connected before router power-on.

## exFAT Notes

exFAT can be useful for large PS2 game storage.

Important notes:

- exFAT support depends on OpenWrt branch and packages.
- exFAT support may not fit easily in 4 MB builds.
- exFAT may be more practical in a custom 4 MB image if heavily stripped.
- exFAT is more comfortable on 8 MB or 16 MB flash.
- Drive formatting method matters.
- Cluster size should be tested.

Record exact formatting settings used during testing.

## extroot Notes

Extroot can expand available storage by using a USB drive as root filesystem overlay.

Benefits:

- More package space
- Easier package installation
- LuCI possible after external storage setup
- Useful for experiments

Drawbacks:

- Adds complexity
- Depends on USB drive
- Can fail if drive is missing
- Adds boot timing issues
- May not be ideal for PS2 appliance use
- Not as clean as a 16 MB flash upgrade

For this project, extroot is useful for research but may not be ideal for final PS2 internal builds.

## OverlayFS Note

OpenWrt squashfs images use a read-only root filesystem with a writable overlay.

Deleting files from the overlay does not necessarily recover space from the read-only firmware image.

This matters on 4 MB boards.

If the image is too big or has too little free space, the correct fix is usually:

- Rebuild the image smaller
- Remove packages before building
- Use extroot
- Upgrade flash size

Do not expect to recover much space by deleting built-in packages after flashing.

## Failsafe Mode

OpenWrt failsafe can help recover from bad network configuration.

Failsafe behavior depends on firmware and bootloader.

Typical uses:

- Reset forgotten password
- Fix network config
- Disable broken startup scripts
- Restore default settings
- Recover from unreachable IP settings

Document for each firmware build:

- How to enter failsafe
- LED behavior
- IP address
- Whether telnet works
- Whether SSH works
- Whether reset button works
- What commands are needed to recover

## SSH / Dropbear Notes

Dropbear SSH is useful but may not always fit or be enabled in tiny builds.

On first boot, OpenWrt may allow telnet until a password is set, depending on version.

Some old builds or custom images may lack SSH entirely.

For each build, document:

- Telnet availability
- SSH availability
- Default password behavior
- Whether password change works
- Whether Dropbear is included
- Whether SCP works
- Whether SFTP works
- Recovery method if SSH is unavailable

## UART Development Recommendation

UART should be considered mandatory for serious development.

UART allows:

- Watching boot logs
- Interrupting U-Boot
- Recovering from bad network settings
- Confirming image boot
- Reading kernel messages
- Debugging USB detection
- Debugging Wi-Fi startup
- Debugging scripts
- Testing without relying on web/SSH access

Recommended UART settings:

```text
57600 baud
8 data bits
No parity
1 stop bit
No flow control
```

Use only 3.3 V serial levels.

## Power And Boot Timing

OpenWrt boot time matters for PS2 integration.

Record:

- Time to first U-Boot output
- Time to kernel start
- Time to Ethernet link
- Time to Wi-Fi association
- Time to USB mount
- Time to service ready
- Time to web UI ready
- Time to UDPBD ready
- Time to SMB ready
- Time to FTP reachable

For PS2 use, the router may need to boot before OPL or another loader starts.

Some setups may need a delay before launching the PS2-side loader.

## Heat And Power Tuning

OpenWrt can help reduce heat and power draw.

Possible tuning:

- Disable unused switch ports.
- Disable Wi-Fi if not needed.
- Disable unused services.
- Avoid constant logging.
- Avoid unneeded daemons.
- Use only one PS2 service mode at a time.
- Add heatsink.
- Use stable 5 V power.

Known switch-port disable concept:

```text
swconfig dev switch0 port 1 set disable 1
swconfig dev switch0 port 2 set disable 1
swconfig dev switch0 port 3 set disable 1
swconfig dev switch0 port 4 set disable 1
swconfig dev switch0 set apply
```

If used permanently, add tested commands to startup scripts.

Do not add blindly without testing that Ethernet still works.

## Firmware Build Status Labels

Use these labels for firmware builds in this repo.

| Label | Meaning |
|---|---|
| Reference Only | Documented from an outside source |
| Builds | Source/config builds successfully |
| Boots | Image boots on hardware |
| Ethernet Works | Wired Ethernet confirmed |
| Wi-Fi Works | Wi-Fi confirmed |
| USB Works | USB storage confirmed |
| PS2 Bench Tested | Tested externally with PS2 |
| PS2 Internal Tested | Tested inside PS2 |
| Broken | Known issue prevents normal use |
| Risky | Can brick or behaves unpredictably |
| Deprecated | Kept for history only |

## Firmware Release Notes Template

Each firmware build should have a release note.

Template:

```text
Firmware name:
OpenWrt version:
Source branch:
Commit:
Build host OS:
Target:
Subtarget:
Device/profile:
Flash size:
RAM size:
Image type:
Image file:
Default IP:
Default login:
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

## Binary Policy

This repo should avoid casually distributing firmware binaries.

Preferred:

- Build instructions
- Config files
- Patches
- Files overlay
- Scripts
- Links to upstream releases
- Checksums for known images
- Notes explaining how to reproduce the build

If binaries are included, they must include:

- Source reference
- License notes
- Build config
- Target flash size
- Target RAM size
- Install method
- Recovery method
- Risk warning
- Checksum
- Tested board ID

Do not upload random full flash dumps publicly.

Do not upload personal factory partitions publicly.

## Known Good Documentation Targets

The OpenWrt section of the repo should eventually include:

- OpenWrt support overview
- Build environment guide
- ImageBuilder guide
- Buildroot guide
- 4 MB stock build guide
- 16 MB flash build guide
- Device tree notes
- Partition layout notes
- Package list examples
- PS2 bridge config
- PS2 SMB config
- UDPBD config
- UDPFS config
- Recovery guide
- TFTP guide
- UART guide
- CH341A flash guide
- Known working images list
- Known broken images list

## Known Problems To Document

Known or likely problems:

- Stock firmware may reject OpenWrt images.
- Stock firmware may appear to flash but not change.
- Wrong U-Boot can brick the board.
- Wrong RAM-size U-Boot can brick the board.
- Wrong flash-size layout can fail.
- 4 MB flash leaves almost no overlay space.
- LuCI may not fit.
- SSH may not be included in some images.
- USB storage packages may not fit.
- exFAT may not fit without stripping.
- SMB may be too heavy for some builds.
- Wi-Fi range may be poor because of antenna issues.
- Router may hang after hard reboot without supervisor mod.
- USB drive may need to be inserted before boot.
- Boot timing may be too slow for PS2 auto-launch without delay.

## Recommended OpenWrt Development Flow

For a new board:

1. Identify the board.
2. Photograph the board.
3. Confirm RAM and flash chip.
4. Connect UART.
5. Capture stock boot log.
6. Dump full stock flash.
7. Save factory partition.
8. Verify recovery method.
9. Test known-good firmware on stock 4 MB flash.
10. Build a minimal image.
11. Test Ethernet.
12. Test Wi-Fi.
13. Test USB.
14. Test PS2 use case externally.
15. Add thermal testing.
16. Add power testing.
17. Only then consider internal PS2 installation.

For a 16 MB upgrade:

1. Dump original 4 MB flash.
2. Save factory partition.
3. Program 16 MB flash with preserved early partitions.
4. Expand firmware area.
5. Build 16 MB firmware image.
6. Test with UART.
7. Confirm partition layout.
8. Confirm overlay space.
9. Test packages.
10. Test PS2 use case.

## PS2-Focused Firmware Priorities

The best PS2-focused firmware should prioritize:

- Reliable boot
- Simple setup
- Stable Ethernet
- Stable Wi-Fi
- Stable USB storage
- Low heat
- Low RAM use
- Minimal services
- Clear status
- Easy recovery
- Predictable IP behavior
- One purpose at a time

It should avoid:

- General-purpose router clutter
- Unused packages
- Heavy web interfaces
- Multiple storage services running together
- Hidden default behavior
- Unclear IP settings
- Hard-to-recover configs

## Short Version

The A5-V11 can run older OpenWrt builds, but the stock 4 MB flash and 32 MB RAM make it a legacy, highly constrained device.

For this repo, OpenWrt should be treated as a tool for building small PS2-focused appliance firmware, not as a modern general-purpose router firmware.

The most useful direction is:

- Preserve stock flash and factory data.
- Use UART and a programmer for recovery.
- Build minimal firmware for one job at a time.
- Use 17.01.7 and other older branches as reference points.
- Explore 16 MB flash upgrades for serious development.
- Keep every build reproducible and clearly documented.

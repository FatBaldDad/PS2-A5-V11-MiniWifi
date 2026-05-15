# 10 - Glossary

## Summary

This glossary defines common terms used throughout the A5-V11 Field Manual.

The A5-V11 project crosses several areas:

- Embedded Linux
- OpenWrt
- SPI flash programming
- UART recovery
- Wi-Fi networking
- USB storage
- PlayStation 2 networking
- PS2 homebrew loaders
- Hardware modification
- PCB and flex design
- Thermal and power testing

This file is meant to keep the wording consistent across the repo.

## A5-V11

The small RT5350F-based mini Wi-Fi router documented in this repo.

It is commonly sold as a generic 3G/4G router, travel router, or M1 SkyShare-style device.

For this project, the A5-V11 is mainly being studied as a small network helper for PlayStation 2 projects.

## A5-V11 Field Manual

The name of this documentation project.

The goal is to create a one-stop reference for the A5-V11, including stock hardware, stock firmware, OpenWrt support, recovery, hardware mods, PS2 integration, and future custom hardware ideas.

## 3G/4G Router

The common marketing label printed on many A5-V11 shells.

This does not mean the A5-V11 has a built-in cellular modem.

The original idea was that the router could share an external USB 3G/4G modem connected to the USB host port.

## 150M

A common marking on the router shell.

It usually refers to 150 Mbps-class 2.4 GHz 802.11n Wi-Fi marketing.

This does not mean the board can actually move 150 Mbps of real application data.

## RT5350F

The main Ralink / MediaTek SoC used on the A5-V11.

It includes the CPU, Wi-Fi, Ethernet, USB controller support, GPIO, and UART features used by the board.

## SoC

System on Chip.

A chip that combines multiple major functions into one package.

On the A5-V11, the RT5350F SoC contains the processor and major networking functions.

## Ralink

The original vendor family associated with the RT5350F platform.

Ralink later became part of MediaTek.

## MediaTek

The company family now associated with many former Ralink networking chips.

The A5-V11 may be described as using a Ralink or MediaTek RT5350F.

## MIPS

The CPU architecture used by the RT5350F.

The A5-V11 is not ARM-based.

## MIPS 24KEc

The specific MIPS CPU core family used by the RT5350F.

## CPU

Central Processing Unit.

The part of the SoC that runs firmware, Linux, OpenWrt, services, and scripts.

## 360 MHz

The typical CPU clock speed of the RT5350F on the A5-V11.

## RAM

Random Access Memory.

Temporary working memory used while the router is running.

The useful/common A5-V11 boards usually have 32 MB RAM.

## SDRAM

Synchronous Dynamic Random Access Memory.

The type of RAM commonly used on the A5-V11.

## W9825G6EH-75

A Winbond SDRAM chip found on some A5-V11 boards.

It is commonly associated with 32 MB RAM configurations.

## EM63A165TS-6G

An EtronTech SDRAM chip found on some A5-V11 boards.

It is commonly associated with 32 MB RAM configurations.

## Flash

Non-volatile memory used to store bootloader, firmware, factory data, and configuration.

The stock A5-V11 commonly has 4 MB SPI flash.

## SPI Flash

Serial Peripheral Interface flash memory.

The A5-V11 normally uses an 8-pin SPI NOR flash chip.

## SPI NOR Flash

A type of flash memory commonly used for embedded firmware storage.

The A5-V11 flash chip is normally SPI NOR, not NAND.

## 4 MB Flash

The common stock flash size on the A5-V11.

4 MB is very limiting for OpenWrt and is one of the main reasons this repo explores 8 MB and 16 MB upgrades.

## 8 MB Flash

An experimental or upgraded flash size.

It gives more room than stock, but is still limited.

## 16 MB Flash

A preferred upgrade target for serious A5-V11 development.

16 MB gives much more room for custom OpenWrt firmware, PS2-focused scripts, exFAT support, SMB experiments, and a simple web UI.

## Mbit Versus MB

Flash chips are often described in megabits, while file sizes are usually described in megabytes.

Important conversions:

| Megabits | Megabytes |
|---:|---:|
| 32 Mbit | 4 MB |
| 64 Mbit | 8 MB |
| 128 Mbit | 16 MB |

## Pm25LQ032

A 32 Mbit, or 4 MB, SPI flash chip commonly found on stock A5-V11 boards.

## MX25L3205

A 32 Mbit, or 4 MB, SPI flash chip or similar part that may appear in A5-V11-related work.

## W25Q128

A 128 Mbit, or 16 MB, SPI flash chip family often discussed as a flash upgrade candidate.

Exact part number and voltage must be checked before use.

## Bootloader

The first program that runs when the router powers on.

It initializes hardware and loads the firmware.

Many A5-V11 boards use U-Boot.

## U-Boot

A common embedded bootloader.

On the A5-V11, U-Boot may provide serial console output, boot menus, TFTP flashing options, and firmware boot control.

## U-Boot Environment

A small flash area that stores U-Boot settings.

This can include boot commands, network settings, and other bootloader variables.

## Factory Partition

A flash partition that contains board-specific data.

It may include Wi-Fi calibration, RF data, MAC address, and hardware-specific settings.

This partition must be backed up before modifying firmware.

## RF Calibration

Radio-frequency calibration data used by the Wi-Fi hardware.

If this data is missing or wrong, Wi-Fi may not work correctly.

## MAC Address

Media Access Control address.

A unique network hardware address assigned to the Ethernet or Wi-Fi interface.

Do not clone another board's MAC address into a public or production device.

## Partition

A defined region of flash memory used for a specific purpose.

Common A5-V11 partitions include:

- u-boot
- u-boot-env
- factory
- firmware
- kernel
- rootfs
- rootfs_data

## MTD

Memory Technology Device.

A Linux subsystem used to expose flash partitions.

OpenWrt uses MTD devices for flash partitions.

## `/proc/mtd`

A Linux file that lists MTD flash partitions.

Useful command:

```text
cat /proc/mtd
```

## Kernel

The core of the Linux operating system.

OpenWrt uses a Linux kernel.

## Root Filesystem

The main filesystem used by Linux after boot.

In OpenWrt, the root filesystem is often a compressed read-only SquashFS image plus a writable overlay.

## Rootfs

Short for root filesystem.

## Rootfs Data

The writable overlay area used by OpenWrt to store changes, settings, installed files, and scripts.

## SquashFS

A compressed read-only filesystem commonly used by OpenWrt.

It saves flash space but cannot be directly modified.

## JFFS2

A flash-friendly writable filesystem often used by OpenWrt for the writable overlay area.

## OverlayFS

A Linux filesystem layer that combines a read-only base with writable changes.

In OpenWrt, deleting built-in files does not truly free space from the read-only firmware image.

## Overlay

The writable part of an OpenWrt system where configuration changes and added files are stored.

On a 4 MB A5-V11, overlay space can be extremely limited.

## OpenWrt

An open-source Linux-based firmware for routers and embedded network devices.

The A5-V11 is supported by older OpenWrt branches, but stock 4 MB / 32 MB hardware is too limited for modern secure OpenWrt use.

## LEDE

A former fork of OpenWrt.

LEDE later merged back into OpenWrt.

OpenWrt 17.01.x is often called LEDE-era firmware.

## Chaos Calmer

The codename for OpenWrt 15.05.

Many old A5-V11 guides reference Chaos Calmer.

## OpenWrt 17.01.7

An older LEDE/OpenWrt release that is important for A5-V11 PS2/UDPBD-related work.

## OpenWrt 18.06

An older OpenWrt release relevant to A5-V11 history and testing.

## OpenWrt 19.07.10

A commonly referenced last official release era for 4 MB flash / 32 MB RAM devices.

It is still old and should not be treated as modern secure router firmware.

## 4/32 Device

A router with 4 MB flash and 32 MB RAM.

The A5-V11 stock hardware commonly falls into this category.

Modern OpenWrt support for 4/32 devices has ended.

## ramips

The OpenWrt target family used for many Ralink / MediaTek MIPS router SoCs.

The A5-V11 belongs to the ramips family.

## rt305x

The OpenWrt subtarget family relevant to the A5-V11 and RT5350F platform.

## ImageBuilder

An OpenWrt tool for building custom firmware images from prebuilt packages.

Useful for quickly creating trimmed images.

## Buildroot

In OpenWrt context, this usually means building OpenWrt from full source.

This is needed for deeper changes such as custom device definitions, partition layouts, and patches.

## Toolchain

The compiler and tools used to build firmware for the target CPU.

For the A5-V11, the toolchain builds MIPS firmware.

## `.config`

The OpenWrt build configuration file.

It defines the target, packages, kernel options, and build settings.

## Files Overlay

A folder of files copied into the firmware image during build.

Used to add default configs, scripts, web files, and startup behavior.

## Patch

A file that modifies source code or configuration.

Patches are used to change OpenWrt behavior, add device support, or modify partition layouts.

## Factory Image

An OpenWrt firmware image intended for first-time flashing from stock firmware or a vendor update interface.

Usually named with `factory`.

## Sysupgrade Image

An OpenWrt firmware image intended for upgrading an existing OpenWrt installation.

Usually named with `sysupgrade`.

## Full Flash Dump

A complete readout of the entire SPI flash chip.

It includes bootloader, factory data, firmware, and all partitions.

A full flash dump is essential for recovery.

## Raw Firmware Partition

Only the firmware portion of the flash.

This is not the same as a full flash dump.

## CH341A

A common low-cost USB SPI flash programmer.

Used for reading, writing, and recovering SPI flash chips.

## AsProgrammer

A Windows program often used with CH341A-style programmers.

## NeoProgrammer

A Windows program often used with CH341A-style programmers.

## flashrom

An open-source tool used to read and write flash chips.

Often used on Linux with CH341A programmers.

## SOIC Clip

A clip used to connect to an 8-pin flash chip without removing it from the board.

It can be useful, but in-circuit programming is not always reliable.

## In-Circuit Programming

Reading or writing a flash chip while it remains soldered to the board.

This can work, but other parts of the circuit may interfere.

## Out-of-Circuit Programming

Removing the flash chip from the board and programming it separately.

This is usually more reliable but requires soldering skill.

## UART

Universal Asynchronous Receiver/Transmitter.

A serial console interface used for boot logs, shell access, debugging, and recovery.

## Serial Console

A text console accessed through UART.

On the A5-V11, it is one of the most important recovery and development tools.

## TTL Serial

Low-voltage logic-level serial signaling.

The A5-V11 uses 3.3 V TTL serial.

## RS-232

A different serial signaling standard that can use much higher positive and negative voltages.

Do not connect true RS-232 directly to the A5-V11 UART.

## 3.3 V UART

The correct logic voltage for the A5-V11 serial console.

Use a 3.3 V USB-to-TTL adapter.

## 5 V UART

A logic voltage that may damage the A5-V11.

Do not use 5 V UART signals on the router.

## Baud Rate

The speed of serial communication.

The A5-V11 UART commonly uses 57600 baud.

## 57600 8N1

A common serial setting.

It means:

- 57600 baud
- 8 data bits
- No parity
- 1 stop bit

## TX

Transmit signal.

Router TX connects to adapter RX.

## RX

Receive signal.

Router RX connects to adapter TX, preferably through a 470 ohm to 1 k ohm resistor.

## GND

Ground.

The router and UART adapter must share ground.

## VCC

Voltage supply.

The A5-V11 UART header may include a 3.3 V VCC pad, but it should normally be left disconnected during serial-console use.

## TFTP

Trivial File Transfer Protocol.

Often used by bootloaders to load firmware images over Ethernet.

## TFTP Recovery

A recovery method where U-Boot loads firmware from a TFTP server.

Behavior varies by bootloader.

## dnsmasq

A lightweight DHCP, DNS, and TFTP server often used on Linux.

It can be used to provide a TFTP server for recovery.

## Failsafe Mode

A recovery mode in OpenWrt.

It can allow access when normal network settings are broken.

## Firstboot

An OpenWrt command that resets the writable overlay to defaults.

This can recover from bad configuration, but it can also delete custom settings.

## Sysupgrade

The OpenWrt upgrade process.

It writes a new firmware image to the firmware partition.

## LuCI

The standard OpenWrt web interface.

It is useful but often too large for the stock 4 MB A5-V11.

## uhttpd

A small web server commonly used by OpenWrt.

It may be used for LuCI or a custom web interface.

## Dropbear

A lightweight SSH server used by OpenWrt.

Useful for remote shell access.

## SSH

Secure Shell.

A command-line login method used to manage OpenWrt remotely.

## Telnet

An older unencrypted command-line login method.

Stock A5-V11 firmware often exposes telnet.

Telnet should not be used on untrusted networks.

## BusyBox

A compact collection of Unix command-line tools used in embedded Linux systems.

Stock A5-V11 firmware often uses BusyBox.

## `runshellcmd`

A command found in some stock A5-V11 firmware versions that may enable a fuller shell.

Not every stock firmware supports it.

## `mtd_write`

A command found in some firmware builds that writes data directly to flash partitions.

It is powerful and dangerous.

Using the wrong file or partition can brick the router.

## `sysupgrade`

The OpenWrt command used to upgrade firmware.

Example:

```text
sysupgrade -v -n firmware.bin
```

## `swconfig`

An OpenWrt utility used to configure switch ports on older switch drivers.

It can be used on some A5-V11 builds to disable unused internal switch ports.

## Ethernet

The wired network connection.

The A5-V11 has one physical 10/100 Mbps Ethernet port.

## 10/100 Ethernet

Ethernet that supports 10 Mbps and 100 Mbps speeds.

The A5-V11 and PS2 Ethernet are both in this speed class.

## RJ45

The standard Ethernet connector.

The A5-V11 stock board has an RJ45 jack.

## Magnetics

Ethernet isolation transformers.

Ethernet ports normally use magnetics for signal isolation and proper Ethernet operation.

## PHY

Physical layer interface.

In Ethernet, the PHY handles low-level electrical signaling.

The RT5350F has internal Ethernet PHY/switch functions.

## Switch Port

A port on an Ethernet switch.

The RT5350F has more internal switch capability than the A5-V11 physically exposes.

Unused internal ports may waste power unless disabled.

## VLAN

Virtual LAN.

OpenWrt may use VLAN-style interfaces such as `eth0.1`.

## `eth0`

A common Linux name for the first Ethernet interface.

## `eth0.1`

A VLAN interface on `eth0`.

Some A5-V11 OpenWrt configs use `eth0.1` for LAN.

## br-lan

A common OpenWrt bridge interface.

It may combine Ethernet and Wi-Fi interfaces depending on configuration.

## Wi-Fi

Wireless network connection.

The A5-V11 supports 2.4 GHz Wi-Fi.

## 2.4 GHz

The Wi-Fi band supported by the A5-V11.

The A5-V11 does not support 5 GHz Wi-Fi.

## 802.11b/g/n

Wi-Fi standards supported by the RT5350F platform.

## STA Mode

Station mode.

A Wi-Fi mode where the A5-V11 connects to another access point as a client.

This is important for PS2 Wi-Fi bridge use.

## AP Mode

Access Point mode.

A Wi-Fi mode where the A5-V11 creates its own Wi-Fi network.

## WISP Mode

Wireless Internet Service Provider mode.

A router mode where the device connects to Wi-Fi as a client and routes traffic for wired devices.

Behavior depends on firmware.

## Bridge Mode

A network mode where devices appear to be on the same network segment.

For PS2 use, bridge mode may allow the PS2 to appear on the home LAN.

## Routed Mode

A network mode where the A5-V11 routes traffic between two networks.

The PS2 may be on a different subnet than the home network.

## NAT

Network Address Translation.

A routed mode where devices behind the router share another network connection.

NAT can make inbound access to the PS2 more complicated.

## DHCP

Dynamic Host Configuration Protocol.

Used to automatically assign IP addresses.

## Static IP

A manually assigned IP address.

Often useful for PS2 network setups.

## Gateway

The network device that routes traffic to other networks.

Usually the home router.

## Subnet Mask

Defines the size of a local IP network.

Common home network mask:

```text
255.255.255.0
```

## DNS

Domain Name System.

Converts names into IP addresses.

For many PS2 use cases, DNS may not matter if everything uses direct IP addresses.

## 192.168.100.1

A common stock firmware IP address reported for some A5-V11 units.

## 192.168.1.1

A common OpenWrt default IP address.

## 192.168.1.222

A proposed PS2-focused default setup IP for a custom A5-V11 firmware.

This is a project idea, not a stock behavior.

## USB Host

A USB port that controls connected USB devices.

The A5-V11 Type-A port is a USB host port.

## USB Device

A USB port or device that connects to a host.

The A5-V11 micro-USB port is normally for power, not USB device data.

## USB 2.0

The USB standard supported by the A5-V11 host port.

## micro-USB

The stock power input connector on the A5-V11.

It normally provides 5 V power only.

## USB Type-A

The full-size USB host connector on the A5-V11.

Used for USB storage or original USB modem use.

## USB Storage

A USB flash drive, SSD, hard drive, or card reader connected to the A5-V11.

Used for firmware flashing, file sharing, UDPBD, UDPFS, SMB, or extroot experiments.

## USB Hotplug

The ability to detect and mount a USB device after boot.

Some minimal A5-V11 builds may not support full hotplug behavior.

## FAT32

A widely supported filesystem.

Often used for simple USB storage compatibility.

## exFAT

A filesystem useful for large storage devices and large files.

It may require extra OpenWrt packages and may not fit easily on stock 4 MB flash.

## ext4

A Linux filesystem.

Useful for OpenWrt extroot and Linux-native storage, but less convenient for Windows users.

## NTFS

A Windows filesystem.

Support on small OpenWrt builds can be limited or heavy.

## GPT

GUID Partition Table.

A modern partition table format.

Some USB storage workflows may use GPT.

## MBR

Master Boot Record.

An older partition table format.

Some embedded systems work better with simple MBR layouts.

## Cluster Size

Filesystem allocation unit size.

Cluster size can affect performance and compatibility.

## Mount

Attaching a filesystem to a directory in Linux.

Example:

```text
mount /dev/sda1 /mnt/usb
```

## `/dev/sda1`

A common Linux device name for the first partition on the first USB storage device.

## block-mount

An OpenWrt package used for mounting block devices such as USB drives.

## extroot

An OpenWrt method for using external storage as the writable root overlay.

Useful for experiments but not always ideal for a final PS2 internal build.

## SMB

Server Message Block.

A network file sharing protocol.

OPL can use SMB shares for PS2 game loading.

## SMB1

The older SMB protocol version often required by PS2 OPL setups.

Also called NT1 in Samba configuration.

## NT1

The Samba protocol name for SMB1.

## Samba

A Linux SMB server package.

Can be heavy for the A5-V11, especially on 4 MB flash and 32 MB RAM.

## Samba4

A newer Samba package family.

It can be too heavy for small devices unless carefully configured.

## OPL

Open PS2 Loader.

A PlayStation 2 homebrew loader used to load games from USB, HDD, SMB, MX4SIO, UDPBD, and other sources depending on build and support.

## wLaunchELF

A PlayStation 2 file manager and homebrew tool.

It can run FTP and is useful for file transfer and setup.

## uLaunchELF

Older or alternate name associated with LaunchELF.

Often abbreviated as uLE.

## FMCB

Free McBoot.

A common PS2 memory card exploit/launcher environment.

## FHDB

Free Hard Drive Boot.

A PS2 boot method using the internal hard drive on compatible fat PS2 models.

## OpenTuna

A PS2 exploit/launcher option often used on some consoles where FMCB compatibility differs.

## PS2BBL

PlayStation 2 Bare-Bones Loader.

A PS2 bootloader project used in some modern homebrew setups.

## PS2

PlayStation 2.

The primary target platform for this A5-V11 project.

## PS2 Slim

The smaller PlayStation 2 console family.

This repo is especially interested in Slim and Ultra Slim internal A5-V11 mounting.

## PS2 Ultra Slim

A custom modified PS2 Slim style build where the console is made thinner or internally rearranged.

## MX4SIO

A PS2 storage method using the memory card interface to access microSD storage.

Mentioned for context because many PS2 networking/storage projects are compared against it.

## SD2PSX

A PlayStation memory card emulator project using SD storage.

Mentioned for context in PS2 storage and MMCE discussions.

## MMCE

Multi-Purpose Memory Card Emulation.

In this repo's PS2 context, MMCE refers to memory-card-based storage/emulation systems such as SD2PSX-style devices.

## UDPBD

A PS2 network block device loading method.

On the A5-V11, UDPBD is important because community builds have used the router as a small USB-storage-backed UDPBD server.

## UDPFS

A UDP-based file serving/loading approach connected to newer PS2 network loading experiments.

Should be documented separately from UDPBD.

## NHDDL

A PS2 loader related to newer network and HDD loading workflows.

Mentioned because the A5-V11 may be tested with NHDDL/Neutrino-style setups.

## Neutrino

A modern PS2 loader project often discussed with newer network-loading methods.

## FTP

File Transfer Protocol.

Used with wLaunchELF for transferring files to or from the PS2.

## Passive FTP

An FTP connection mode that can matter when routing or NAT is involved.

## Active FTP

Another FTP connection mode that can matter when routing or NAT is involved.

## Game List

The list of games shown by OPL or another PS2 loader.

If the game list is empty, the storage or network service may not be ready.

## FMV

Full Motion Video.

In PS2 testing, FMV stutter is a common way to notice slow or unstable storage performance.

## ISO

A disc image file format often used for PS2 game backups.

This repo should not host copyrighted game files.

## CD Folder

A folder often used by OPL for CD-based PS2 images.

## DVD Folder

A folder often used by OPL for DVD-based PS2 images.

## ART Folder

A folder often used by OPL for game artwork.

## VMC

Virtual Memory Card.

A file-based memory card used by OPL and other PS2 tools.

## Homebrew

Unofficial software made by the community.

This repo focuses on legal documentation, configuration, and hardware work, not copyrighted game distribution.

## Firmware

Software stored in flash that runs the router.

On the A5-V11, firmware may be stock firmware, OpenWrt, or a custom build.

## Stock Firmware

The original firmware that came on the A5-V11.

It varies between units and may include a web UI, telnet, storage sharing, and firmware update page.

## Custom Firmware

Firmware modified or built for a specific purpose.

For this repo, custom firmware usually means PS2-focused OpenWrt builds.

## Minimal Firmware

A firmware image with only the packages and files required for a specific role.

Important for the stock 4 MB A5-V11.

## Role-Specific Firmware

A firmware image designed for one job.

Examples:

- Wi-Fi bridge only
- UDPBD only
- SMB1 only
- FTP helper
- Recovery image
- Development image

## Appliance Firmware

Firmware designed to make the router act like a simple dedicated device instead of a general-purpose router.

This is the ideal direction for PS2-focused A5-V11 builds.

## Web UI

Web User Interface.

A browser-based configuration page.

The stock A5-V11 may have one, and a future custom PS2-focused firmware may have a very simple one.

## Custom Web GUI

A custom web interface made specifically for PS2-focused settings.

Possible options:

- Join Wi-Fi
- Set IP
- Select mode
- Show USB status
- Reboot
- Reset to defaults

## Mode Switching

Changing the router between firmware service modes.

Possible modes:

- Bridge
- SMB
- UDPBD
- UDPFS
- FTP helper
- Setup
- Recovery

## GPIO

General-Purpose Input/Output.

Pins on the SoC that can be used for signals such as LEDs, buttons, or control lines.

## GPIO Current Limit

The A5-V11 GPIOs should be treated as low-current logic signals.

Known notes warn around 4 mA maximum.

Use transistors or buffers for external loads.

## LED

Light Emitting Diode.

The A5-V11 normally has red and blue LEDs.

## Red LED

Commonly used as a power or system LED.

OpenWrt notes associate it with GPIO17.

## Blue LED

Commonly used as a system or Wi-Fi LED.

OpenWrt notes associate it with GPIO20.

It may need manual OpenWrt configuration.

## Reset Button

A small button or pinhole switch on the A5-V11.

Depending on firmware and bootloader, it may reset settings, enter failsafe, or trigger recovery.

## Supervisor IC

An integrated circuit that monitors voltage and holds reset until power is stable.

A supervisor can improve boot reliability.

## MAX809TTR

A reset supervisor IC discussed for A5-V11 reliability mods.

May help with hard reboot or power-cycle issues.

## ADM809

Another reset supervisor IC family discussed for A5-V11 reliability mods.

## Brownout

A low-voltage condition where the system may behave unpredictably or reset.

## Power Ramp

How quickly and cleanly voltage rises when power is applied.

Poor power ramp can cause unreliable boot.

## Warm Reboot

Restarting without fully removing power.

Example:

```text
reboot
```

## Cold Boot

Starting the board from fully powered off.

## Rapid Power Cycle

Turning power off and back on quickly.

This can expose reset and capacitor discharge problems.

## Heatsink

A piece of metal attached to a hot chip to help remove heat.

The RT5350F may benefit from a heatsink.

## Thermal Pad

A soft thermally conductive pad used to transfer heat between parts.

May be used to couple the A5-V11 SoC or heat spreader to the PS2 RF shield.

## Heat Spreader

A metal piece that spreads heat over a larger area.

Copper plates or the PS2 RF shield may be used as heat spreaders.

## RF Shield

The metal shield inside the PS2.

It may help as a heat spreader, but it can also block or weaken Wi-Fi if the antenna is placed poorly.

## Antenna

The part of the router that sends and receives Wi-Fi signals.

The A5-V11 antenna implementation may vary and should be inspected.

## Antenna Mod

A hardware modification to improve Wi-Fi range by repairing or adding an antenna.

## STA Range

The Wi-Fi range when the A5-V11 is connected to another access point as a client.

This matters for PS2 Wi-Fi bridge use.

## Capacitor

An electronic component used for filtering, decoupling, and energy storage.

The A5-V11 has stock capacitors that may be too tall for PS2 internal mounting.

## Electrolytic Capacitor

A polarized capacitor type commonly used for bulk capacitance.

Often physically tall.

## Tantalum Capacitor

A capacitor type that may appear on some A5-V11 variants.

Usually polarized and smaller than many electrolytics.

## Ceramic Capacitor

A non-polarized capacitor type often used for decoupling.

Large ceramic banks may be tested as replacements, but bulk behavior must be verified.

## Decoupling

Using capacitors near circuits to smooth voltage and handle fast current changes.

## Bulk Capacitance

Larger capacitance used to support power rails during load changes.

Important for USB, Wi-Fi, and boot reliability.

## ESR

Equivalent Series Resistance.

A capacitor property that affects filtering and transient behavior.

## Flipp'n Caps

A proposed helper PCB or flex board for relocating or laying down A5-V11 capacitors.

The goal is better PS2 internal fitment and cleaner installation.

## PCB

Printed Circuit Board.

The physical board that holds electronic components.

## Flex PCB

A flexible printed circuit board.

Useful for tight spaces and capacitor relocation.

## Helper PCB

A small board designed to make a modification cleaner, repeatable, or easier to install.

## Castellated Pads

Half-hole edge pads that allow a small PCB to be soldered onto another board.

## KiCad

An open-source PCB design tool.

Used for designing helper boards, flexes, and PS2 integration hardware.

## OSH Park

A PCB fabrication service often used for prototype boards.

## JLCPCB

A PCB fabrication service often used for prototype and production boards.

## 0.8 mm PCB

A thinner PCB option that may help with PS2 internal fitment.

## BOM

Bill of Materials.

A list of parts needed for a build or modification.

## MPN

Manufacturer Part Number.

The exact part number from the component manufacturer.

## DigiKey

A component supplier often used for sourcing exact electronic parts.

## Bench Test

Testing a board outside the PS2 on a workbench.

## PS2 Bench Test

Testing the A5-V11 with a PS2 while the router is still external or accessible.

## PS2 Internal Test

Testing the A5-V11 installed inside the PS2 shell.

## Long-Run Test

A stability test run for a long period, such as 4 hours or 24 hours.

## Boot Reliability Test

A test where the router is power-cycled or rebooted repeatedly to see if it starts every time.

## Thermal Test

A test where temperatures are measured during idle, load, and closed-shell operation.

## Power Test

A test where current draw, voltage stability, and power behavior are measured.

## Current Draw

The amount of electrical current used by the board.

Usually measured in mA.

## Power

Voltage multiplied by current.

Usually measured in watts.

## Voltage Sag

A temporary drop in voltage during load changes.

Can cause resets or unstable behavior.

## RSSI

Received Signal Strength Indicator.

A measure of Wi-Fi signal strength, usually in dBm.

## dBm

A logarithmic unit used for RF signal strength.

For Wi-Fi, less negative values usually mean stronger signal.

Example:

```text
-45 dBm is stronger than -75 dBm
```

## Packet Loss

Network packets that fail to reach their destination.

Packet loss can cause FTP, SMB, UDPBD, UDPFS, or PS2 loader problems.

## Throughput

Actual data transfer speed.

Usually measured in MB/s or Mbps.

## MB/s

Megabytes per second.

Used for file transfer speeds.

## Mbps

Megabits per second.

Used for network link or data rates.

## Conversion Between MB/s And Mbps

Use:

```text
1 MB/s = 8 Mbps
```

Example:

```text
4.2 MB/s = 33.6 Mbps
```

## Latency

Delay between sending a packet and receiving a response.

Often measured with ping.

## Ping

A basic network test command.

Used to check whether one device can reach another.

## iperf

A network throughput test tool.

May be too large for some minimal A5-V11 builds.

## dd

A Linux command that can read or write raw data.

Used for storage speed tests and flash partition extraction.

Dangerous if used with the wrong output target.

## sha256sum

A command that generates a checksum.

Useful for verifying flash dumps and firmware images.

## cmp

A command used to compare two files.

Useful for confirming two flash reads are identical.

## Hex Editor

A program used to inspect binary files.

Useful for checking flash dumps and partition offsets.

## Offset

A position inside a binary file or flash chip.

Example:

```text
0x040000
```

## 0x040000

A hex offset commonly associated with the factory partition location on the stock A5-V11 flash layout.

## 0x050000

A hex offset commonly associated with the beginning of the firmware partition on the stock A5-V11 flash layout.

## 0x400000

The total size of a 4 MB flash chip in hexadecimal.

## 0x800000

The total size of an 8 MB flash chip in hexadecimal.

## 0x1000000

The total size of a 16 MB flash chip in hexadecimal.

## Brick

A device state where the router no longer boots or works normally.

Some bricks are recoverable.

## Soft Brick

A failure where the device does not work normally but the bootloader, UART, failsafe, or recovery mode still works.

## Hard Brick

A failure where the device does not boot far enough for normal recovery.

May require external SPI programming or flash replacement.

## Recovery

The process of restoring a board to a bootable or usable state.

## Known-Good Image

A firmware or flash image that has been tested and verified on a specific board or configuration.

## Board ID

A unique identifier assigned to each physical A5-V11 board during testing.

Example:

```text
board-001
```

## Board Log

A document recording the hardware, firmware, tests, mods, and status of one specific board.

## Reference Only

A documentation status label meaning the information is included for history or reference but is not currently recommended.

## Confirmed

A status label meaning the information has been verified by testing or reliable documentation.

## Bench Tested

A status label meaning the item was tested outside a PS2.

## PS2 Tested

A status label meaning the item was tested directly with a PlayStation 2.

## Experimental

A status label meaning the idea or method is promising but not fully proven.

## Risky

A status label meaning the method could brick hardware, corrupt flash, damage parts, or cause unreliable behavior.

## Untested

A status label meaning the item has not been tested yet.

## Needs Verification

A status label meaning the information appears useful but needs another source or direct test.

## Workaround

A temporary or partial solution to a known problem.

## Regression

A new problem introduced by a change that previously worked.

## Compatibility Table

A table showing which hardware, firmware, loaders, USB drives, filesystems, or PS2 models work together.

## PS2-Focused Firmware

A firmware build designed specifically for PlayStation 2 use cases.

It should be simple, lightweight, and role-specific.

## Wi-Fi Bridge

A setup where the PS2 connects by Ethernet to the A5-V11, and the A5-V11 connects by Wi-Fi to the home network.

## Network Appliance

A small dedicated device that performs one or a few specific network tasks.

The A5-V11 is best treated as a tiny network appliance, not a modern all-purpose router.

## Service Mode

A selected operating mode for the router.

Examples:

- Bridge mode
- SMB mode
- UDPBD mode
- UDPFS mode
- FTP helper mode
- Recovery mode
- Setup mode

## Setup Mode

A firmware mode intended for initial configuration, such as joining Wi-Fi or setting IP addresses.

## Recovery Mode

A firmware or bootloader state intended to help restore access after a failure.

## Service-Ready

A state where the router has fully booted, mounted storage, connected networking, and started the required service.

For PS2 use, the loader should not start before the router is service-ready.

## Boot Delay

A delay added before launching PS2 software so the router has time to become service-ready.

## Keepalive

A small file or repeated action used to prevent USB drives from sleeping or parking.

Some PS2-focused A5-V11 workflows may create a keepalive file on the USB drive.

## USB Parking

A drive power-saving behavior where a USB HDD may park heads or sleep.

This can cause delays or stutter.

## Game Storage

Storage used to hold PS2 game files.

This repo should not host copyrighted games.

## Legal Backup

A backup made from software the user owns and is legally allowed to back up.

This repo should focus on hardware, firmware, and configuration, not piracy.

## Copyrighted Content

Games, BIOS files, commercial software, and other content protected by copyright.

This repo should not host copyrighted PS2 software.

## Datasheet

A manufacturer document describing a component.

Datasheets are important for verifying flash chips, supervisors, regulators, capacitors, and other parts.

## Source Link

A link to original documentation, firmware source, forum post, blog, datasheet, or project.

## Third-Party Credit

Credit given to original authors, projects, and community researchers.

This repo depends heavily on outside work and should preserve credits clearly.

## License

The legal terms under which files or code may be used, modified, or redistributed.

Do not upload third-party firmware or files without checking license and source.

## Binary

A compiled file such as firmware, bootloader, or executable.

Binaries should be handled carefully in this repo.

## Binary Policy

The repo policy for whether and how compiled firmware files are included.

Preferred approach:

- Store build instructions
- Store configs
- Store patches
- Link to upstream releases
- Avoid random full flash dumps
- Avoid personal factory partitions

## Short Version

The A5-V11 project uses terms from embedded Linux, OpenWrt, networking, SPI flash recovery, PS2 loaders, and hardware modding.

The most important terms to understand first are:

- A5-V11
- RT5350F
- OpenWrt
- 4 MB flash
- 32 MB RAM
- SPI flash
- U-Boot
- factory partition
- UART
- CH341A
- sysupgrade
- TFTP
- Ethernet bridge
- USB storage
- SMB1
- UDPBD
- UDPFS
- PS2 integration

Understanding these terms makes the rest of the repo much easier to follow.

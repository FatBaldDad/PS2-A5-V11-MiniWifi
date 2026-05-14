# 01 - A5-V11 Overview

## Summary

The A5-V11 is a very small, low-cost, RT5350F-based mini Wi-Fi router.

It was commonly sold as a generic 3G/4G router, travel router, or M1 SkyShare-style device. Despite the 3G/4G marketing, the board itself is not a cellular modem. The 3G/4G function came from using an external USB cellular dongle.

The A5-V11 is interesting because it is tiny, cheap, hackable, and capable of running older OpenWrt builds. It includes Wi-Fi, Ethernet, USB host, UART access, LEDs, flash storage, and enough RAM to run a very small embedded Linux system.

For this repo, the A5-V11 is being studied mainly as a PlayStation 2 network helper.

Possible PS2 uses include:

- Wi-Fi bridge for the PS2 Ethernet port
- FTP access using wLaunchELF
- SMB1 network share access for OPL
- UDPBD or UDPFS support for newer PS2 loaders
- USB storage hosted by the router
- Internal network module for PS2 Slim and Ultra Slim builds
- Experimental platform for PS2-focused OpenWrt builds

## Why This Board Matters

The A5-V11 is not powerful by modern standards, but it is useful because it packs several features into a very small board.

It has:

- 2.4 GHz Wi-Fi
- 10/100 Ethernet
- USB 2.0 host
- UART console access
- SPI flash
- 32 MB RAM on most useful units
- Low 5 V power requirement
- OpenWrt history
- Very small physical size

That makes it a good candidate for embedded projects where space matters.

For PS2 projects, the board is especially interesting because the PlayStation 2 already uses 100 Mbps Ethernet, and many PS2 network loading methods do not require modern high-speed networking. The A5-V11 is not a modern router, but it may be enough for PS2-specific network tasks.

## Important Warning

The A5-V11 is a legacy device.

The common stock version has only:

- 4 MB flash
- 32 MB RAM

This is extremely limited for modern OpenWrt.

The A5-V11 should not be treated as a modern secure router. It is best viewed as a legacy embedded Linux board, research platform, or special-purpose network helper.

For this project, the goal is not to make the A5-V11 a general-purpose modern router.

The goal is to document it, preserve useful information, improve it where possible, and adapt it for focused PS2 use cases.

## Typical Hardware Specifications

The most common useful A5-V11 boards have the following hardware.

| Feature | Typical Value |
|---|---|
| SoC | Ralink / MediaTek RT5350F |
| CPU | MIPS 24KEc |
| CPU Speed | 360 MHz |
| RAM | 32 MB SDRAM |
| Stock Flash | 4 MB SPI flash |
| Wi-Fi | 2.4 GHz 802.11b/g/n |
| Ethernet | 1x 10/100 Mbps RJ45 |
| USB Host | 1x USB 2.0 Type-A |
| Power Input | 5 V through micro-USB |
| UART | Internal serial pads |
| LEDs | Red power LED and blue system/Wi-Fi LED |
| Button | Reset button or pinhole switch |
| Bootloader | U-Boot on many units |

## Physical Size

The A5-V11 is very small.

Typical case dimensions are approximately:

| Dimension | Approximate Size |
|---|---|
| Length | 61 mm to 62 mm |
| Width | 23 mm to 24 mm |
| Height | 14 mm to 15 mm |

The bare PCB is smaller than the plastic shell, which makes it possible to consider internal mounting inside other devices.

For PS2 Slim integration, the small size is one of the biggest advantages of this board.

## Common Board Markings

Known or reported board markings include:

- A5-V11
- MIFI
- Similar unbranded markings

The A5-V11 marking is commonly found near the Ethernet connector area on the PCB.

Because many of these devices were sold unbranded, the outside shell is not enough to identify the board. The PCB should be inspected directly.

## Common Shell Styles

These routers were sold in several small plastic shells.

Common shell styles include:

- Black 3G/4G Router shell
- White 3G/4G Router shell
- Small travel-router style shell
- M1 SkyShare-style shell
- Other unbranded variants

The shell may say 3G/4G Router, 150M, Wi-Fi Router, or similar text.

Do not assume that two units are identical just because the outside shell looks the same.

## Why Board Variation Matters

A major issue with the A5-V11 is variation.

Different units may have:

- Different stock firmware
- Different web interfaces
- Different bootloader behavior
- Different flash chips
- Different RAM chips
- Different antenna condition
- Different solder quality
- Different component substitutions
- Different recovery behavior
- Different default IP behavior
- Different ability to accept OpenWrt images

This repo should document each tested board as carefully as possible.

A guide that works on one A5-V11 may not work on another A5-V11 without changes.

## Known RAM Configurations

The most useful A5-V11 units usually have 32 MB RAM.

Known RAM chips include:

- Winbond W9825G6EH-75
- EtronTech EM63A165TS-6G
- Other compatible SDRAM chips may exist

Some similar routers may have less RAM.

A board with only 16 MB RAM is much less useful and may require different bootloader or firmware choices.

## Known Flash Configurations

The stock A5-V11 commonly uses 4 MB SPI flash.

Common stock flash examples include:

- Pm25LQ032 or similar 32 Mbit SPI flash

This repo is interested in documenting:

- Stock 4 MB flash layouts
- 8 MB flash upgrades
- 16 MB flash upgrades
- Factory partition preservation
- U-Boot behavior with larger flash
- OpenWrt image size limits
- Recovery methods after bad flashes

## Why Flash Size Is a Big Limitation

The 4 MB stock flash is one of the biggest problems with the A5-V11.

With only 4 MB flash, there is very little room for:

- Kernel
- Root filesystem
- OpenWrt packages
- Web interface
- USB storage support
- SMB support
- exFAT support
- Dropbear SSH
- Custom scripts
- PS2-specific tools

Even simple changes can run into space limitations.

This is why larger flash experiments are important.

A 16 MB flash upgrade can turn the board from a barely usable legacy router into a much more useful embedded project board.

## Factory Partition Warning

The factory partition is important.

It may contain board-specific information such as:

- Wi-Fi calibration data
- RF calibration data
- MAC address
- Device-specific factory data

Do not erase or overwrite the factory partition without a backup.

Do not assume one board's factory partition should be copied to another board.

Before firmware experiments, the full original flash should be dumped and saved.

Recommended backup rule:

Always dump the original flash before modifying firmware or replacing the flash chip.

## Stock Firmware Overview

The stock firmware varies between units.

Some units may have:

- Web interface
- Telnet access
- Limited BusyBox shell
- More complete BusyBox shell
- Chinese interface
- English interface
- Qualcomm-branded interface even though the SoC is Ralink / MediaTek
- DHCP behavior that depends on the mode or firmware version
- Firmware update page that may or may not accept OpenWrt images

Common stock login information reported in old references:

| Service | Typical Value |
|---|---|
| Web login | admin |
| Web password | admin |
| Telnet login | admin |
| Telnet password | admin |
| Possible stock IP | 192.168.100.1 |
| Possible OpenWrt IP after flash | 192.168.1.1 |

These values are not guaranteed.

## OpenWrt Overview

The A5-V11 has a long OpenWrt history, but it is now a legacy device.

Important OpenWrt points:

- Older OpenWrt builds supported the A5-V11.
- The board is part of the ramips / rt305x family.
- The RT5350F is a Ralink / MediaTek SoC.
- The stock 4 MB flash is very limiting.
- Modern OpenWrt is not practical for the stock 4 MB version.
- OpenWrt support for 4 MB flash / 32 MB RAM devices has ended.
- 19.07.10 was the last official OpenWrt build era for 4/32 devices.
- Older versions such as 15.05, 17.01.7, and 18.06 are important for research.
- Custom builds are usually required for useful functionality.

This repo should treat OpenWrt on the A5-V11 as legacy firmware work.

## Why Older OpenWrt Builds Matter

Older OpenWrt builds matter because they are small enough to fit the device and still support the hardware.

For A5-V11 research, the most relevant OpenWrt versions are likely:

- OpenWrt 15.05 Chaos Calmer
- LEDE / OpenWrt 17.01.7
- OpenWrt 18.06
- OpenWrt 19.07.10 as the last official 4/32-era release reference

For PS2-focused work, 17.01.7 is especially interesting because known community PS2/UDPBD builds have used it successfully.

## Ethernet Overview

The A5-V11 has one physical 10/100 Ethernet port.

The RT5350F SoC has an internal Ethernet switch, but only one physical Ethernet port is exposed on the A5-V11.

Important notes:

- The board uses 100 Mbps Ethernet, which is enough for many PS2 use cases.
- Some OpenWrt configurations may use eth0.1 instead of eth0 for LAN.
- Incorrect network interface configuration can make the board unreachable.
- Unused internal switch ports may still consume power unless disabled in software.
- Disabling unused switch ports may reduce power draw and heat.

For PS2 use, the Ethernet port is one of the most important features.

## Wi-Fi Overview

The A5-V11 has 2.4 GHz Wi-Fi integrated through the RT5350F platform.

Typical Wi-Fi support:

- 802.11b
- 802.11g
- 802.11n
- 2.4 GHz only

There is no 5 GHz Wi-Fi.

Some units may have poor Wi-Fi range because of antenna issues.

Antenna-related documentation should include:

- Stock antenna path
- Possible disconnected antenna issue
- Antenna repair
- External antenna mod
- Internal PS2 antenna placement
- RF shield interaction
- Signal strength testing

## USB Overview

The A5-V11 includes one USB 2.0 host port.

This is important because the router can use USB storage.

Possible uses:

- Firmware flashing from USB on some stock firmware versions
- USB game storage for PS2-related experiments
- exFAT or FAT32 storage
- OpenWrt extroot experiments
- File sharing over network
- UDPBD or UDPFS storage backend
- General embedded Linux USB testing

Important limitation:

USB plug-and-play behavior may be limited depending on the firmware. Some PS2-focused builds expect the USB drive to be connected before the router boots.

## Micro-USB Power Overview

The micro-USB port is normally used for 5 V power input.

Important notes:

- The micro-USB port is generally treated as power input.
- It is not normally used as a USB data connection to a computer.
- The Type-A USB port is the USB host port.
- The board can often be powered by a simple 5 V USB source.
- Internal PS2 power integration should be tested carefully.
- Power quality matters because the board can freeze or boot unreliably.

## UART Overview

The A5-V11 has internal UART pads.

UART is important for:

- Boot logs
- OpenWrt console
- U-Boot access
- Debugging failed flashes
- Recovery work
- Network configuration repair
- Firmware development

Typical UART notes:

- Use a 3.3 V USB-to-serial adapter.
- Do not connect 5 V UART signals.
- Do not connect the VCC pad unless there is a specific reason.
- TX from the router goes to RX on the adapter.
- RX on the router goes to TX on the adapter.
- GND must be connected.
- A resistor between adapter TX and router RX may help avoid boot problems.
- Serial speed is commonly 57600 baud on known units.

UART access should be documented in its own guide.

## LEDs

The A5-V11 usually has two LEDs:

- Red LED
- Blue LED

Common LED uses:

- Power indication
- System activity
- Wi-Fi activity
- Boot status
- Failure symptoms

OpenWrt may not configure both LEDs by default.

The blue LED can be useful as a Wi-Fi or network activity indicator if configured correctly.

LED behavior should be documented for:

- Stock firmware
- OpenWrt firmware
- Failed boot
- U-Boot recovery
- PS2 internal install status

## Button

The board usually has a small reset button or pinhole switch.

Depending on firmware and bootloader, the button may be used for:

- Factory reset
- OpenWrt failsafe
- TFTP recovery
- Bootloader recovery
- User input GPIO
- Mode switching in custom firmware

Button behavior may vary between bootloaders.

Do not assume the reset button works the same way on every A5-V11.

## Thermal Behavior

The A5-V11 can run warm or hot.

Heat is a known issue because:

- The board is very small.
- The plastic case traps heat.
- The RT5350F can get warm under load.
- Internal switch ports may waste power.
- USB storage adds load.
- PS2 internal mounting may reduce airflow.

Thermal improvements to document:

- Removing the plastic shell
- Adding a heatsink to the RT5350F
- Using the PS2 RF shield as a heat spreader
- Copper plate heat spreaders
- Thermal pad testing
- Disabling unused switch ports
- Reducing unnecessary services
- Running only one major service at a time

## Power Behavior

The A5-V11 normally runs from 5 V.

Power behavior is important for PS2 integration.

Things to test and document:

- Current draw at idle
- Current draw with Wi-Fi enabled
- Current draw with Wi-Fi disabled
- Current draw with USB storage attached
- Current draw with UDPBD or SMB running
- Boot current
- Power draw after unused switch ports are disabled
- Behavior when powered from PS2 USB
- Behavior when powered from an internal 5 V regulator
- Behavior when the PS2 is off
- Whether Ethernet behavior remains stable when the console is powered down

## Boot Reliability

Some A5-V11 boards can fail to boot cleanly after a hard reset or rapid power cycle.

Known or suspected causes include:

- Weak reset timing
- Poor power ramp behavior
- Capacitor behavior
- Regulator behavior
- Flash behavior
- USB drive initialization timing
- Firmware boot timing
- Heat
- Board variation

A supervisor IC mod, such as MAX809TTR or ADM809, may help improve boot reliability by holding reset until power is stable.

This is one of the important hardware modifications for PS2 internal use.

## Capacitor Concerns

The stock board usually has several electrolytic capacitors.

For PS2 internal mounting, these capacitors may be too tall or poorly located.

Possible capacitor-related work:

- Replace tall electrolytic capacitors
- Relocate capacitors
- Lay capacitors flat
- Use a small helper PCB
- Use a flex PCB
- Use ceramic capacitor banks where appropriate
- Keep enough bulk capacitance for stable operation
- Compare boot reliability before and after changes

The Flipp'n Caps PCB/Flex idea belongs in this area.

## Flipp'n Caps PCB/Flex Concept

The Flipp'n Caps PCB/Flex is a possible helper board or flex board for improving A5-V11 fitment.

The concept is to make capacitor relocation cleaner and more repeatable.

Possible goals:

- Invert or lay down the stock capacitors
- Relocate tall parts away from the height limit
- Provide a clean footprint for a supervisor IC
- Improve PS2 Slim internal fitment
- Make the mod more repeatable
- Reduce hand-wiring
- Allow the board to sit closer to a mounting plate or RF shield

This is not currently a finished kit.

It should be documented as experimental until fully tested.

## Flash Upgrade Overview

Flash upgrades are one of the most important A5-V11 enhancement areas.

The stock 4 MB flash severely limits firmware choices.

Upgrade goals:

- Preserve original factory data
- Replace 4 MB flash with 8 MB or 16 MB flash
- Expand firmware partition
- Build larger OpenWrt images
- Add PS2-focused packages
- Add a simpler web interface
- Improve recovery options
- Avoid extroot if possible
- Keep the board compact

Flash upgrade documentation should include:

- Required tools
- Compatible flash chips
- CH341A wiring
- Full flash dump process
- Factory partition extraction
- Factory partition restoration
- U-Boot compatibility
- OpenWrt partition layout
- Device tree changes
- Known good images
- Known bad images
- Recovery notes

## PS2 Relevance

The PlayStation 2 is the main target application for this repo.

The A5-V11 may be useful because it can sit between the PS2 Ethernet port and the user's home Wi-Fi network.

Possible PS2 network workflows:

- PS2 to A5-V11 by Ethernet
- A5-V11 to home network by Wi-Fi
- PC to PS2 by FTP through the A5-V11
- OPL to SMB share through the A5-V11
- PS2 loader to USB drive hosted by the A5-V11
- UDPBD or UDPFS from router-attached storage
- Internal PS2 Wi-Fi module using the existing PS2 Ethernet signals

## PS2 Network Use Cases

### FTP

wLaunchELF can run an FTP server on the PS2.

A Wi-Fi bridge inside or near the PS2 could make it easier to access the PS2 without running a long Ethernet cable.

### SMB1

OPL can use SMB network shares, but PS2 compatibility often depends on older SMB1/NT1 behavior.

A custom A5-V11 firmware could potentially provide a simple PS2-focused SMB1 environment.

### UDPBD

UDPBD is a network block-device style loading method used with specific PS2 loader builds.

Gorgylka's A5-V11 work is an important reference for this direction.

### UDPFS

UDPFS is another PS2 network-loading direction connected to newer loader experiments.

The A5-V11 may be limited, but it is worth documenting whether it can be useful in this role.

### Wi-Fi Bridge

The simplest PS2 use case is a Wi-Fi bridge.

In this mode, the PS2 talks to the A5-V11 through Ethernet, and the A5-V11 connects to the user's home network over Wi-Fi.

This would make the PS2 network-capable without an external Ethernet cable running across the room.

## PS2 Internal Mounting

The A5-V11 is small enough to consider internal mounting inside PS2 Slim and Ultra Slim builds.

Internal mounting topics:

- Best location inside each PS2 Slim model
- RF shield clearance
- Fan clearance
- Controller port clearance
- Ethernet wiring
- Power wiring
- USB drive access
- Thermal path
- Antenna placement
- Serviceability
- Boot timing
- Whether the router remains powered when the PS2 is off
- Whether the PS2 Ethernet port can remain directly wired to the router

The repo should document each tested mounting location with photos and measurements.

## Why a Custom Web GUI Might Help

A normal OpenWrt web interface is too broad for a PS2-focused router.

A PS2-focused interface could be much simpler.

Possible settings:

- Join Wi-Fi network
- Router IP address
- PS2 IP address suggestion
- Subnet mask
- Gateway
- DNS
- Mode selection
- FTP helper mode
- SMB mode
- UDPBD mode
- UDPFS mode
- Reboot button
- Reset to default button
- Status page
- USB drive status
- Wi-Fi signal status

The goal should be a simple appliance-like interface, not a full router admin panel.

## Possible Default PS2-Focused Behavior

A PS2-focused firmware could eventually boot into a simple default setup.

Possible default assumptions:

- Device IP: 192.168.1.222
- Subnet: 255.255.255.0
- Gateway: 192.168.1.1
- Web setup page enabled
- Wi-Fi setup prompt available
- Ethernet side ready for PS2
- USB storage checked at boot
- Only one major service enabled at a time
- Simple status LEDs

These are design ideas, not final firmware decisions.

## Service Mode Philosophy

The A5-V11 is limited.

A good PS2-focused firmware should avoid running everything at once.

Possible service modes:

- Wi-Fi bridge only
- FTP helper mode
- SMB1 mode
- UDPBD mode
- UDPFS mode
- Recovery mode
- Setup mode

The firmware should be designed around the board's limits instead of fighting them.

## Known Strengths

The A5-V11 has several strengths.

- Very small size
- Cheap and easy to find
- 5 V power input
- 2.4 GHz Wi-Fi
- 100 Mbps Ethernet
- USB 2.0 host
- UART access
- OpenWrt history
- PS2 network speed compatibility
- Good candidate for internal PS2 mounting
- Good learning platform for OpenWrt and embedded Linux

## Known Weaknesses

The A5-V11 also has serious weaknesses.

- Very limited stock flash
- Limited RAM
- Old OpenWrt support
- Board variation
- Firmware variation
- Bootloader variation
- Poor documentation spread across many sources
- Possible antenna issues
- Possible heat issues
- Possible boot reliability issues
- No modern security support on stock 4 MB devices
- Easy to brick with wrong firmware
- Requires soldering for serious recovery work
- Requires factory partition preservation during flash upgrades

## Known Risks

Working with the A5-V11 can be risky.

Risks include:

- Bricking the router
- Losing original factory data
- Losing Wi-Fi calibration
- Losing MAC address data
- Flashing the wrong U-Boot
- Flashing an image for the wrong RAM size
- Flashing an image for the wrong flash size
- Damaging pads during flash replacement
- Damaging UART pads
- Overheating the board
- Creating unstable PS2 network behavior
- Creating an internal PS2 short or power issue

Every hardware and firmware guide should warn about the specific risks involved.

## Recommended First Steps With Any A5-V11

Before modifying an A5-V11, the recommended process is:

1. Photograph both sides of the board.
2. Record all visible chip markings.
3. Record the stock firmware behavior.
4. Record default IP behavior.
5. Test web login.
6. Test telnet login.
7. Connect UART if possible.
8. Capture a boot log.
9. Dump the original flash.
10. Save multiple copies of the flash dump.
11. Identify the factory partition.
12. Only then begin firmware or hardware experiments.

## Documentation Priorities

The most important things to document first are:

- Board identification
- UART pinout
- Stock firmware behavior
- Full flash backup process
- Factory partition preservation
- Known good recovery process
- Flash chip upgrade process
- PS2 wiring approach
- Power behavior
- Heat behavior
- Boot reliability
- Known working firmware builds

## Repo Direction

This repo should be practical.

Each document should answer one simple question:

What does someone need to know to understand, modify, recover, or use this board?

The repo should avoid hype and avoid treating the A5-V11 like a modern product.

The board is old, limited, weird, and inconsistent.

That is exactly why it needs a field manual.

## Short Version

The A5-V11 is a tiny RT5350F-based 2.4 GHz Wi-Fi router with Ethernet, USB, UART, SPI flash, and older OpenWrt support.

It is too limited to be a modern secure router, but it is still a very useful embedded project board.

For this repo, the main goal is to document the A5-V11 as completely as possible and push it toward reliable PlayStation 2 network use.

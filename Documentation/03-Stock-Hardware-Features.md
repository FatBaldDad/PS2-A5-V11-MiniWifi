# 03 - Stock Hardware Features

## Summary

This document describes the stock hardware features of the A5-V11 mini router.

The goal is to document what the board normally includes before any modifications are made.

This file is focused on the standard board hardware only.

Hardware modifications such as antenna upgrades, capacitor relocation, flash upgrades, supervisor IC additions, heatsinks, and PS2 internal mounting are documented in separate mod-specific files.

## Important Note About Variants

The A5-V11 is not a tightly controlled commercial platform.

It was sold as an unbranded or lightly branded low-cost mini router, and many units were built with whatever parts were available.

Because of this, two boards that look similar may have different:

- Flash chips
- RAM chips
- Capacitors
- Antenna connections
- Bootloaders
- Stock firmware
- Web interfaces
- UART behavior
- Button behavior
- Recovery behavior
- Default IP behavior

This document describes the common stock hardware features, not a guarantee for every board.

Always inspect and document the exact board before making firmware or hardware changes.

## Typical Stock Hardware Summary

| Feature | Typical Stock Value |
|---|---|
| Board family | A5-V11 mini router |
| Common shell text | 3G/4G Router, 150M |
| SoC | Ralink / MediaTek RT5350F |
| CPU architecture | MIPS 24KEc |
| CPU speed | 360 MHz |
| RAM | 32 MB SDRAM on useful/common units |
| Stock flash | 4 MB SPI flash |
| Wi-Fi | 2.4 GHz 802.11b/g/n |
| Ethernet | 1x 10/100 Mbps RJ45 |
| USB host | 1x USB 2.0 Type-A |
| Power input | 5 V through micro-USB |
| UART | Internal 4-pad serial console |
| LEDs | Red LED and blue LED |
| Button | Reset button or pinhole switch |
| Bootloader | U-Boot on many units |
| Case size | About 62 mm x 24 mm x 14.5 mm |
| Modem | No built-in cellular modem |

## What The 3G/4G Label Means

The A5-V11 was often sold as a 3G/4G router.

This does not mean the board has a built-in cellular modem.

The 3G/4G function usually means the router firmware can use an external USB cellular modem plugged into the USB Type-A host port.

For PS2 use, the cellular feature is normally irrelevant.

The useful features for PS2 projects are:

- Ethernet
- Wi-Fi
- USB host
- OpenWrt compatibility
- Small size
- Low-voltage power input
- UART access

## Main SoC

The main processor is normally the Ralink / MediaTek RT5350F.

| Item | Value |
|---|---|
| SoC | RT5350F |
| Vendor family | Ralink / MediaTek |
| CPU core | MIPS 24KEc |
| CPU speed | 360 MHz |
| Integrated Wi-Fi | Yes |
| Integrated Ethernet | Yes |
| Integrated USB host support | Yes |
| Integrated GPIO | Yes |
| Integrated UART | Yes |

The RT5350F is the heart of the board.

It provides the CPU, Wi-Fi support, Ethernet support, USB controller support, GPIO, and serial console features used by the A5-V11.

## CPU

The CPU is a MIPS 24KEc-class processor running at about 360 MHz.

This is enough for simple embedded networking tasks, but it is not powerful by modern router standards.

The CPU is suitable for:

- Basic routing
- Wi-Fi bridge use
- Lightweight OpenWrt builds
- Simple web configuration pages
- FTP helper use
- SMB1 experiments
- UDPBD or UDPFS experiments
- USB storage serving with careful firmware choices

The CPU is not suitable for:

- Heavy modern routing
- Modern security-heavy OpenWrt use
- Multiple major services running at once
- High-performance NAS use
- VPN-heavy workloads
- Modern full-featured router replacement use

For PS2 projects, this CPU is still interesting because the PS2 itself uses 100 Mbps Ethernet and many PS2 network-loading workflows are not modern high-bandwidth use cases.

## RAM

Most useful A5-V11 boards have 32 MB SDRAM.

Known RAM chips include:

| RAM Chip | Typical Meaning |
|---|---|
| W9825G6EH-75 | 32 MB SDRAM |
| EM63A165TS-6G | 32 MB SDRAM |
| Other SDRAM chips | Needs verification |

RAM is one of the major limitations of the board.

32 MB is enough for carefully built older OpenWrt images and single-purpose tasks, but it is very limited.

A board with 16 MB RAM should be treated as a different and more limited variant.

## RAM Size Warning

Some bootloaders and firmware files are tied to RAM size.

A file intended for a 16 MB RAM unit may not be safe on a 32 MB RAM board.

A file intended for a 32 MB RAM unit may not be safe on a 16 MB RAM board.

Before flashing U-Boot or firmware, confirm the RAM size.

Ways to confirm RAM size:

- Read the RAM chip marking
- Check stock firmware system information
- Check OpenWrt boot logs
- Check U-Boot boot logs
- Read memory size from Linux if the board boots

## Stock Flash

The stock board commonly uses a 4 MB SPI flash chip.

Common stock flash example:

| Flash Chip | Size | Notes |
|---|---:|---|
| Pm25LQ032 | 4 MB | Common stock SPI flash |
| MX25L3205 or similar | 4 MB | Possible similar stock flash |
| Other 25-series SPI flash | Varies | Must be identified before programming |

The stock flash is one of the biggest limitations of the A5-V11.

4 MB is barely enough for older OpenWrt builds and leaves very little room for packages, configuration, web UI, storage support, and custom scripts.

## Flash Type Note

The A5-V11 stock flash is normally an 8-pin SPI NOR flash device.

Some old writeups may casually call it NAND or ROM, but when documenting the hardware for this repo, use:

SPI flash

or more specifically:

SPI NOR flash

## Why 4 MB Flash Is A Problem

The 4 MB stock flash limits what the board can do.

The stock flash has to contain:

- Bootloader
- Bootloader environment
- Factory data
- Kernel
- Root filesystem
- Writable overlay area

This leaves very little room for:

- LuCI
- USB storage support
- exFAT support
- SMB support
- UDPBD tools
- UDPFS tools
- Dropbear SSH
- Custom web GUI
- PS2-specific scripts
- Recovery tools

This is why 8 MB and 16 MB flash upgrades are important research areas for this project.

## Factory Data

The stock flash normally contains a factory area.

This factory data may include:

- MAC address
- Wi-Fi calibration data
- RF calibration data
- Board-specific settings

This data is important.

Do not erase it.

Do not overwrite it with another board's factory partition unless you fully understand the risk.

Before modifying the board:

1. Dump the entire stock flash.
2. Verify the dump.
3. Save multiple copies.
4. Extract and save the factory partition.
5. Record the board's MAC address.

## Typical Stock Flash Layout

A common A5-V11 flash layout is:

| Offset | Size | Partition |
|---:|---:|---|
| 0x000000 | 0x030000 | u-boot |
| 0x030000 | 0x010000 | u-boot-env |
| 0x040000 | 0x010000 | factory |
| 0x050000 | remaining flash | firmware |

For a stock 4 MB flash, the firmware partition commonly begins at:

0x050000

and extends to the end of the 4 MB flash.

For 8 MB or 16 MB flash upgrades, the firmware partition must be expanded carefully while preserving the early bootloader, environment, and factory areas.

## Bootloader

Many A5-V11 units use U-Boot.

The bootloader may support:

- Normal boot from flash
- TFTP firmware loading
- TFTP firmware flashing
- Serial loading
- Boot command line access
- Recovery modes

However, bootloader behavior varies between units.

Some stock bootloaders may:

- Accept standard OpenWrt images
- Reject standard OpenWrt images
- Only accept vendor-modified images
- Pretend to flash from the web UI but keep the stock firmware
- Have broken reset-button behavior
- Have different TFTP behavior
- Require a specific file name or IP setup
- Be unsafe to replace without matching RAM and flash size

Do not replace U-Boot casually.

## Wi-Fi

The A5-V11 uses 2.4 GHz Wi-Fi through the RT5350F platform.

Typical Wi-Fi features:

| Feature | Value |
|---|---|
| Band | 2.4 GHz only |
| Standards | 802.11b/g/n |
| 5 GHz support | No |
| Integrated radio | Yes |
| External cellular modem | No, USB dongle only if supported by firmware |

For PS2 use, the most important Wi-Fi mode is usually client or bridge-style operation.

The A5-V11 can potentially connect the PS2 Ethernet port to a home Wi-Fi network.

## Wi-Fi Limitations

The Wi-Fi hardware is old and limited.

Expected limitations:

- 2.4 GHz only
- No 5 GHz support
- No Wi-Fi 6
- No modern high-speed performance
- Limited antenna quality
- Possible disconnected antenna issue on some boards
- Signal quality may be affected by PS2 internal mounting
- RF shield placement may affect range
- Heat may affect stability

For PS2 use, the goal is not modern router performance.

The goal is stable enough Wi-Fi for PS2 network tools.

## Antenna

The stock antenna implementation may vary.

Some boards may use:

- PCB antenna trace
- Internal antenna wire
- Soldered antenna connection
- Very small built-in antenna structure
- Poor or incomplete antenna connection

Some A5-V11 units are known to have poor wireless range because the antenna path may be disconnected or poorly implemented.

Antenna inspection should be part of every board log.

Document:

- Antenna style
- Antenna solder point
- Antenna trace
- Any missing connection
- Wi-Fi signal before modification
- Wi-Fi signal after modification
- Internal PS2 antenna placement
- RF shield interaction

## Ethernet

The A5-V11 has one physical 10/100 Mbps Ethernet port.

| Feature | Value |
|---|---|
| Physical Ethernet ports | 1 |
| Speed | 10/100 Mbps |
| Connector | RJ45 |
| Gigabit support | No |
| Integrated switch | RT5350F has internal switch features |
| Main PS2 use | PS2-to-router wired link |

The Ethernet port is critical for PS2 use because the PlayStation 2 network adapter and Slim Ethernet port are also 10/100 Mbps.

## Ethernet Interface Notes

Depending on firmware, the wired Ethernet interface may appear as:

- eth0
- eth0.1
- br-lan
- another configured LAN interface

Some OpenWrt notes mention that the A5-V11 may use eth0.1 for the LAN interface.

Incorrect Ethernet interface configuration can make the board unreachable after flashing.

For PS2-focused firmware, Ethernet configuration must be documented clearly.

## Internal Switch And Unused PHYs

The RT5350F platform includes more Ethernet switch capability than the A5-V11 physically exposes.

Even though the A5-V11 only has one physical Ethernet port, unused internal PHYs may still consume power depending on firmware state.

Disabling unused switch ports can reduce power draw and heat.

This matters for:

- Internal PS2 installs
- Thermal stability
- Power consumption
- Long-term reliability
- Small enclosed builds

This belongs in firmware tuning and thermal documentation, but it is worth noting as a stock hardware characteristic.

## USB Host Port

The A5-V11 includes one USB 2.0 Type-A host port.

| Feature | Value |
|---|---|
| USB type | USB 2.0 host |
| Connector | Type-A |
| Main original use | 3G/4G USB modem |
| Useful project use | USB storage |
| PS2 use | Storage backend for UDPBD, UDPFS, SMB, or file serving |

The USB host port is one of the most useful features for PS2 experiments.

Possible uses:

- USB flash drive
- USB SSD
- USB hard drive with proper power
- Firmware flashing on some stock firmware versions
- USB storage for UDPBD
- USB storage for UDPFS
- SMB file share storage
- FTP-accessible storage
- extroot experiments

## USB Power Notes

The USB Type-A port can power connected USB devices, but the available current should be treated carefully.

Important considerations:

- Small flash drives may work directly.
- External SSDs may need more current.
- Mechanical hard drives may need separate power.
- USB drive startup current can affect router boot.
- Some PS2-focused firmware expects the USB drive to be connected before boot.
- Hotplug behavior may be limited depending on firmware.
- Large USB storage support depends on filesystem packages and kernel modules.

For PS2 internal use, USB device power should be tested separately from router logic power.

## Micro-USB Power Input

The micro-USB connector is normally used for 5 V power input.

| Feature | Value |
|---|---|
| Power input | 5 V |
| Connector | micro-USB |
| Data use | Normally not used as USB device data |
| Typical project use | Power only |

For stock use, power is normally supplied through a USB power adapter or computer USB port.

For PS2 internal use, the micro-USB connector may be removed or bypassed, with 5 V wired directly to the board.

## Power Consumption

Reported power draw varies depending on firmware, Wi-Fi state, Ethernet state, and USB load.

Things that affect power draw:

- Wi-Fi enabled or disabled
- Ethernet link active
- Internal switch ports enabled or disabled
- USB storage attached
- CPU load
- Services running
- Heat
- Firmware version
- Board variation

Power consumption must be tested on the exact board and firmware being used.

For PS2 use, measure:

- Idle current
- Boot current
- Wi-Fi client mode current
- Ethernet active current
- USB drive connected current
- UDPBD active current
- SMB active current
- FTP active current
- Current after disabling unused switch ports

## Voltage Rails

The board is powered from 5 V input.

The onboard circuitry generates the lower voltages required by:

- RT5350F SoC
- SDRAM
- SPI flash
- Wi-Fi section
- Ethernet section
- USB section

Important PS2 integration note:

Do not assume the board can be powered directly from 3.3 V unless the power circuit has been reverse engineered and tested.

The normal stock input is 5 V.

## Capacitors

Stock A5-V11 boards commonly have several electrolytic or tantalum capacitors.

Capacitor population may vary between units.

Common capacitor concerns:

- Height may interfere with PS2 internal mounting.
- Electrolytic capacitors may need relocation.
- Some boards may use tantalum capacitors.
- Replacement or relocation may affect boot reliability.
- Removing bulk capacitance may cause instability.
- USB storage may increase power demands.
- Wi-Fi transmit current may create short current spikes.

Document all capacitor values before changing them.

## Capacitor Information To Record

For each board, record:

| Item | Value |
|---|---|
| Cap reference, if known |  |
| Capacitance |  |
| Voltage rating |  |
| Type | Electrolytic, tantalum, ceramic, unknown |
| Polarity | Yes or no |
| Height |  |
| Diameter or footprint |  |
| Location |  |
| Function guess | Input bulk, local decoupling, USB power, etc. |
| Interferes with PS2 fitment | Yes or no |
| Removed or relocated | Yes or no |
| Replacement part |  |

## LEDs

The A5-V11 normally has a red LED and a blue LED.

Known OpenWrt GPIO notes:

| GPIO | Function |
|---:|---|
| GPIO17 | Red power LED |
| GPIO20 | Blue system LED |

LED behavior depends on firmware.

Possible LED meanings:

- Power present
- Booting
- System ready
- Wi-Fi activity
- Ethernet activity
- Recovery mode
- Failed boot
- USB activity, if configured

The blue LED may need firmware configuration before it behaves as a Wi-Fi activity LED.

## LED Documentation

Record LED behavior during:

- Power applied
- Stock firmware boot
- OpenWrt boot
- Failsafe mode
- TFTP recovery mode
- USB drive attached
- Wi-Fi connected
- Ethernet connected
- Failed boot
- PS2 power-on
- PS2 power-off
- Warm reboot
- Cold boot

LED behavior is useful for debugging internal PS2 installs where the router may not be easy to access.

## Reset Button

The board normally has a small reset button or pinhole switch.

Possible functions:

- Stock factory reset
- OpenWrt failsafe
- U-Boot recovery mode
- TFTP trigger
- Custom firmware input
- Mode switching

Button behavior depends on firmware and bootloader.

The reset button should be tested carefully and documented for each board.

## GPIO

The A5-V11 exposes or internally uses several GPIOs.

Known GPIO notes from OpenWrt references include:

| GPIO | Function |
|---:|---|
| GPIO1 | I2C_SD, appears not connected on some boards |
| GPIO2 | I2C_SCLK, appears not connected on some boards |
| GPIO7 | USB power |
| GPIO8 | UARTF TXD, CPU side of resistor |
| GPIO9 | UARTF CTS_N, appears not connected |
| GPIO10 | UARTF RXD, appears not connected |
| GPIO11 | UARTF DTR_N, appears not connected |
| GPIO12 | USB root hub power |
| GPIO13 | UARTF DSR_N, appears not connected |
| GPIO14 | UARTF RIN, appears not connected |
| GPIO17 | Red power LED |
| GPIO18 | JTAG_TDI, appears not connected |
| GPIO19 | JTAG_TMS, appears not connected |
| GPIO20 | Blue system LED |
| GPIO21 | JTAG_TRST_N, goes to via |
| GPIO22 | EPHY_LED0_N |
| GPIO23 | EPHY_LED1_N |
| GPIO24 | EPHY_LED2_N |
| GPIO25 | EPHY_LED3_N |
| GPIO26 | EPHY_LED4_N |

At least some GPIOs can be controlled in software.

Known controllable GPIOs include:

- GPIO8
- GPIO22
- GPIO23
- GPIO24
- GPIO25
- GPIO26

## GPIO Current Warning

Known OpenWrt notes warn that GPIOs can handle only about 4 mA maximum.

Do not directly drive heavy loads from GPIO pins.

For external circuits, use proper buffers, transistors, MOSFETs, or logic ICs.

For PS2 integration, GPIO should be treated as signal-level only unless a proper driver circuit is added.

## UART Serial Console

The A5-V11 has internal UART pads.

This is one of the most important hardware features.

UART is useful for:

- Stock firmware access
- Boot logs
- U-Boot menu access
- OpenWrt console
- Recovery
- Debugging bad network configuration
- Debugging failed firmware flashes
- Watching kernel messages
- Confirming RAM and flash size
- Confirming partition layout

## UART Pad Order

Using the common orientation:

- USB Type-A host port on the left
- Ethernet RJ45 jack on the right
- UART pads in the lower-right area

The four pads are commonly listed left to right as:

| Pad | Function | Connection |
|---:|---|---|
| 1 | VCC 3.3 V | Do not connect for normal serial console use |
| 2 | TX | Connect to RX on 3.3 V USB-serial adapter |
| 3 | RX | Connect to TX on 3.3 V USB-serial adapter |
| 4 | GND | Connect to adapter ground |

Use a 3.3 V serial adapter only.

Do not use 5 V serial levels.

Do not connect VCC during normal UART use.

## UART Speed

Common UART settings:

| Setting | Value |
|---|---|
| Baud rate | 57600 |
| Data bits | 8 |
| Parity | None |
| Stop bits | 1 |
| Flow control | None |

If the output is unreadable, verify the baud rate and wiring.

## UART RX Resistor Note

Some boards may hang during boot if the USB-serial adapter TX line is connected directly to the router RX pad before power-up.

A common workaround is to place a resistor between the adapter TX and router RX.

Recommended resistor range:

- 470 ohm to 1 k ohm

Suggested UART wiring:

| Router Pad | Adapter Connection |
|---|---|
| TX | Adapter RX |
| RX | Adapter TX through 470 ohm to 1 k ohm resistor |
| GND | Adapter GND |
| VCC | Leave disconnected |

If the router hangs with UART connected, power the router first and connect the RX line after boot, then add the resistor for future work.

## I2C Notes

OpenWrt notes list possible I2C-related GPIOs:

| GPIO | Function |
|---:|---|
| GPIO1 | I2C_SD |
| GPIO2 | I2C_SCLK |

These appear to be not connected on some boards.

This repo should treat I2C as unverified unless tested on a specific board.

## JTAG Notes

Some GPIOs are associated with JTAG-style functions.

Known notes include:

| GPIO | Function |
|---:|---|
| GPIO18 | JTAG_TDI |
| GPIO19 | JTAG_TMS |
| GPIO21 | JTAG_TRST_N |

These appear to be not connected or only available through vias on some boards.

JTAG is not a primary recovery path for this repo unless someone verifies it.

UART and SPI flash programming are the primary practical recovery paths.

## USB-Related GPIO Notes

Known USB-related GPIO notes:

| GPIO | Function |
|---:|---|
| GPIO7 | USB power |
| GPIO12 | USB root hub power |

These may matter for:

- USB storage detection
- USB power control
- Firmware scripts
- Low-power mode
- PS2 storage boot timing
- Router startup behavior

More testing is needed before relying on these GPIOs for custom control.

## Ethernet PHY LED GPIO Notes

Known Ethernet PHY LED GPIO notes:

| GPIO | Function |
|---:|---|
| GPIO22 | EPHY_LED0_N |
| GPIO23 | EPHY_LED1_N |
| GPIO24 | EPHY_LED2_N |
| GPIO25 | EPHY_LED3_N |
| GPIO26 | EPHY_LED4_N |

These may be useful for hardware experiments or status indication, but their stock behavior should be documented before repurposing them.

## Ethernet Magnetics

The stock board includes the hardware needed for its RJ45 Ethernet port.

This normally includes:

- RJ45 connector
- Ethernet magnetics or integrated magnetics
- Ethernet signal routing to the RT5350F
- Link/activity LED behavior depending on connector and firmware

For PS2 integration, the Ethernet hardware is important because the board may be wired internally to the PS2 Ethernet path.

Any internal PS2 wiring must preserve proper Ethernet signal integrity.

## Case

The stock case is small and usually plastic.

Common case features:

- Small rectangular shell
- Full-size USB Type-A opening
- micro-USB power opening
- RJ45 Ethernet opening
- LED holes or light pipes
- Reset pinhole
- 3G/4G Router or 150M marking

The stock case is normally removed for internal PS2 installs.

## Approximate Stock Case Dimensions

Typical dimensions:

| Dimension | Approximate Size |
|---|---:|
| Length | 61 mm to 62 mm |
| Width | 23 mm to 24 mm |
| Height | 14 mm to 15 mm |

The bare PCB will be smaller than the complete case.

For PS2 internal fitment, measure the bare board and maximum component height directly.

## Stock Board Height Concerns

The tallest stock parts are usually:

- Electrolytic capacitors
- RJ45 connector
- USB Type-A connector
- micro-USB connector
- Possible antenna or wire
- Button
- LED parts depending on board

For PS2 internal use, the large parts may need to be removed, replaced, relocated, or avoided through mounting position.

## Thermal Behavior

The A5-V11 can run warm or hot.

Heat is affected by:

- Plastic case
- Wi-Fi activity
- Ethernet activity
- USB storage load
- CPU load
- Internal switch ports
- Poor airflow
- Internal PS2 mounting
- Ambient temperature

Some references recommend adding a heatsink to the RT5350F.

For PS2 use, thermal testing is required.

## Thermal Areas To Inspect

Inspect these areas during operation:

- RT5350F SoC
- Voltage regulator area
- Flash chip
- RAM chip
- USB power area
- Ethernet area
- Any capacitor that becomes warm
- PS2 RF shield contact area, if used as a heat spreader

Use thermal tape, a small heatsink, copper spreader, or the PS2 RF shield only after checking for shorts and clearance.

## Stock Antenna And PS2 RF Shield Interaction

If the board is installed inside a PS2, the PS2 metal RF shield may affect Wi-Fi range.

Possible issues:

- Shield blocks signal
- Antenna is too close to metal
- Antenna is pointed into shield
- External antenna may be needed
- Plastic shell area may be better for antenna placement
- BlueRetro or other wireless boards may share the same space

Antenna placement should be tested before final mounting.

## Stock Button And PS2 Access

The stock reset button may become inaccessible after internal installation.

For internal PS2 builds, decide whether to:

- Leave the button unused
- Relocate the button
- Add external access
- Use a hidden service hole
- Wire the button to another controller board
- Use firmware-only reset/recovery
- Keep UART access available instead

Recovery access should be planned before closing the console.

## Stock LEDs And PS2 Access

The stock red and blue LEDs may not be visible after internal installation.

Options:

- Leave them internal
- Use them only for bench testing
- Pipe light to the shell
- Replace with wires to panel LEDs
- Ignore stock LEDs and use PS2 UI status instead
- Use Button Butler or another controller board for status

LED relocation should not overload GPIO pins.

Use proper resistors and drivers as needed.

## Stock USB Port And PS2 Use

For PS2 integration, the stock USB Type-A port may be:

- Left in place
- Removed for clearance
- Replaced with wires
- Connected to an internal USB drive
- Extended to an external-access slot
- Used only for development
- Not used in Wi-Fi bridge-only builds

If USB storage is used, consider:

- Access to remove the drive
- Power draw
- Heat
- Boot timing
- Filesystem support
- Drive detection reliability
- Whether plug-and-play is supported
- Whether the drive must be present at boot

## Stock Ethernet Port And PS2 Use

For internal PS2 integration, the stock RJ45 jack may be:

- Left in place for external Ethernet use
- Removed for clearance
- Wired directly to the PS2 Ethernet path
- Connected through a short internal Ethernet cable
- Connected through magnetics depending on the PS2-side design
- Replaced with board-to-board wiring

Do not treat Ethernet as simple low-speed wiring.

Ethernet signal integrity matters.

Twist pairs where appropriate, keep wiring short, and avoid running Ethernet lines next to noisy power wiring.

## Stock Power Input And PS2 Use

The stock board expects 5 V input through micro-USB.

For internal PS2 use, possible power options include:

- PS2 USB 5 V
- Internal 5 V regulator
- Dedicated buck regulator
- Always-on auxiliary 5 V source
- Switched 5 V source
- Separate power from console power

Important questions:

- Should the router stay powered when the PS2 is off?
- Should the router boot before the PS2?
- Should the router boot at the same time as the PS2?
- Does the USB drive need time to initialize?
- Does the PS2 need a boot delay before launching OPL?
- Is the 5 V source stable under Wi-Fi and USB load?
- Is the PS2 USB port current enough for the router plus storage?

## Stock Hardware Strengths

The stock A5-V11 has several useful hardware strengths.

- Very small size
- Low cost
- 5 V power input
- 2.4 GHz Wi-Fi
- 10/100 Ethernet
- USB 2.0 host
- UART console
- SPI flash that can be replaced
- 32 MB RAM on useful units
- OpenWrt history
- Enough hardware for PS2 network experiments
- Small enough for PS2 Slim internal mounting experiments

## Stock Hardware Weaknesses

The stock A5-V11 also has important weaknesses.

- Only 4 MB stock flash
- Limited 32 MB RAM
- Old RT5350F platform
- No 5 GHz Wi-Fi
- No Gigabit Ethernet
- No modern OpenWrt headroom
- Board variation
- Bootloader variation
- Stock firmware variation
- Possible poor antenna connection
- Possible heat issues
- Possible unreliable warm reboot
- Tall capacitors
- Large stock connectors for internal installs
- Limited GPIO current
- Easy to brick with wrong firmware

## Good Stock Board Candidate

A good stock board for this project should have:

- RT5350F SoC
- 32 MB RAM
- 4 MB readable SPI flash
- Working Ethernet
- Working Wi-Fi
- Working USB host
- Working UART
- Recoverable bootloader
- Stable 5 V operation
- No visible corrosion
- No missing parts
- No lifted pads
- Good antenna path
- Reasonable thermal behavior
- Full flash dump saved
- Factory partition saved

## Poor Stock Board Candidate

A poor candidate may have:

- Unknown SoC
- 16 MB RAM
- Dead Wi-Fi
- Dead Ethernet
- Dead USB
- No UART output
- Corroded board
- Missing antenna connection
- Overheating immediately
- Flash chip unreadable
- Unknown previous firmware damage
- Red and blue LEDs stuck dim with no serial output
- Damaged pads
- Missing components
- No recoverable factory data

A poor candidate may still be useful as a parts board or soldering practice board.

## Stock Hardware Documentation Checklist

For each board, record the following.

| Item | Result |
|---|---|
| Board ID |  |
| Shell marking |  |
| PCB marking |  |
| SoC marking |  |
| RAM chip marking |  |
| RAM size |  |
| Flash chip marking |  |
| Flash size |  |
| Bootloader observed |  |
| Stock firmware observed |  |
| Stock IP behavior |  |
| Web UI works |  |
| Telnet works |  |
| UART works |  |
| UART baud rate |  |
| Ethernet works |  |
| Wi-Fi works |  |
| USB host works |  |
| Red LED behavior |  |
| Blue LED behavior |  |
| Reset button behavior |  |
| Antenna condition |  |
| Capacitor types |  |
| Max component height |  |
| Current draw idle |  |
| Current draw with Wi-Fi |  |
| Current draw with Ethernet |  |
| Current draw with USB storage |  |
| Heat behavior |  |
| Full flash dumped |  |
| Factory partition saved |  |
| Notes |  |

## Stock Feature Test Plan

A simple stock board test plan:

1. Photograph the board.
2. Record chip markings.
3. Power the board from a known good 5 V source.
4. Check LED behavior.
5. Check for excessive heat.
6. Connect Ethernet.
7. Look for DHCP activity.
8. Try the stock web interface.
9. Try stock telnet.
10. Connect UART.
11. Capture a boot log.
12. Test Wi-Fi scan or connection.
13. Test USB storage detection if supported.
14. Measure idle current.
15. Measure current with Wi-Fi active.
16. Measure current with Ethernet active.
17. Measure current with USB storage attached.
18. Dump the full flash.
19. Save the factory partition.
20. Label the board.

## PS2-Relevant Stock Features

For PlayStation 2 work, the most important stock features are:

| Feature | Why It Matters |
|---|---|
| 10/100 Ethernet | Matches PS2 network speed class |
| 2.4 GHz Wi-Fi | Allows wireless bridge concepts |
| USB host | Can host storage for PS2 network loading |
| 5 V input | Easier to power from internal console sources |
| UART | Important for recovery and development |
| SPI flash | Can be upgraded to 8 MB or 16 MB |
| Small PCB | Possible internal PS2 Slim mounting |
| LEDs | Useful for boot and status debugging |
| Reset button | Useful for recovery or custom mode selection |
| GPIO | Possible future control/status uses |

## Features That Need Modification For Best PS2 Use

Stock hardware is useful, but PS2 integration may require changes.

Likely modifications:

- Add heatsink
- Improve antenna
- Relocate capacitors
- Add supervisor IC
- Upgrade flash to 16 MB
- Remove or bypass micro-USB connector
- Remove or bypass USB Type-A connector
- Remove or bypass RJ45 connector
- Add internal wiring pads
- Add PS2 mounting plate
- Add RF shield thermal coupling
- Add custom firmware
- Add simple web GUI
- Add startup delay handling

These are not stock features, but they are important follow-up areas.

## Stock Hardware Short Version

The stock A5-V11 is a tiny RT5350F-based 2.4 GHz Wi-Fi router with 32 MB RAM, 4 MB SPI flash, 10/100 Ethernet, USB 2.0 host, 5 V micro-USB power, internal UART pads, red and blue LEDs, and a reset button.

Its strengths are size, cost, Ethernet, Wi-Fi, USB, UART, and OpenWrt history.

Its weaknesses are limited flash, limited RAM, old OpenWrt support, board variation, possible heat issues, possible antenna issues, and difficult recovery if the flash is corrupted.

For PS2 use, the stock hardware is promising but needs careful testing, firmware tuning, and likely hardware modifications.

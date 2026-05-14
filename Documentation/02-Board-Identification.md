# 02 - Board Identification

## Summary

This document is for identifying A5-V11 mini router boards and close variants before modifying firmware, replacing flash, adding hardware mods, or installing the board inside a PlayStation 2.

Do not assume every small 3G/4G Wi-Fi router is an A5-V11.

Do not assume every A5-V11-looking board has the same hardware.

These routers were sold under many names, with many shells, firmware versions, bootloaders, flash chips, RAM chips, antennas, and component substitutions.

Before doing any firmware or hardware work, identify and document the board.

## Why Board Identification Matters

Board identification matters because the A5-V11 family is inconsistent.

Two routers that look the same from the outside may have:

- Different stock firmware
- Different web interface
- Different bootloader
- Different flash chip
- Different RAM chip
- Different RAM size
- Different flash size
- Different antenna connection
- Different capacitor style
- Different reset behavior
- Different default IP address
- Different recovery behavior
- Different OpenWrt compatibility

A firmware image or U-Boot file that works on one board may brick another board.

The safest rule is:

Identify first. Back up second. Modify third.

## Primary Target Board

The main target for this repo is the unbranded A5-V11 RT5350F-based mini router.

Typical target board features:

| Feature | Expected Value |
|---|---|
| Board family | A5-V11 style mini router |
| SoC | Ralink / MediaTek RT5350F |
| CPU | MIPS 24KEc |
| CPU speed | 360 MHz |
| RAM | 32 MB SDRAM |
| Stock flash | 4 MB SPI flash |
| Ethernet | 1x 10/100 Mbps RJ45 |
| Wi-Fi | 2.4 GHz 802.11b/g/n |
| USB | 1x USB 2.0 host port |
| Power | 5 V through micro-USB |
| UART | Internal serial pads |
| LEDs | Red and blue LEDs |
| Bootloader | Usually U-Boot, but behavior varies |

## Common External Shells

The A5-V11 is often found in a tiny plastic shell.

Common shell markings include:

- 3G/4G Router
- 3G/4G Router 150M
- Mini 3G/4G Router
- Wi-Fi Router
- M1 SkyShare-style labeling
- Generic unbranded labeling

Common shell colors include:

- Black
- White
- Orange or other odd variants may exist

The shell alone is not enough to confirm the board.

A shell labeled 3G/4G Router does not mean the board has a built-in cellular modem. The 3G/4G function usually means the router can use an external USB cellular dongle.

## Common PCB Markings

Open the shell and inspect the PCB.

Known markings include:

- A5-V11
- MIFI

The A5-V11 marking is commonly located near the Ethernet connector area.

If the board does not have an A5-V11 or MIFI marking, it may still be similar, but it should be treated as a variant until proven.

## Opening the Shell

The shell is usually clipped together.

Basic opening method:

1. Disconnect all power and cables.
2. Remove any USB drive.
3. Use a plastic pry tool if possible.
4. Start near a seam.
5. Work slowly around the shell.
6. Avoid twisting the PCB.
7. Avoid prying against small parts.
8. Photograph the board before removing or modifying anything.

Do not use metal tools near the board unless necessary.

## First Photo Set

Before modifying anything, take clear photos.

Minimum photo set:

- Front of shell
- Back of shell
- Label or sticker
- PCB top side
- PCB bottom side
- Close-up of SoC
- Close-up of RAM chip
- Close-up of flash chip
- Close-up of UART pads
- Close-up of antenna area
- Close-up of Ethernet area
- Close-up of USB port area
- Close-up of capacitors
- Close-up of any board markings

These photos are useful for recovery, documentation, and comparison with other boards.

## Board Orientation

For documentation, use a consistent board orientation.

Recommended orientation:

- USB Type-A host port on the left
- RJ45 Ethernet jack on the right
- UART pads at the lower-right area
- Ralink / MediaTek SoC on the opposite side from the UART pads

Use this orientation when documenting:

- UART pads
- GPIO notes
- antenna location
- capacitor location
- flash location
- heatsink placement
- PS2 fitment photos

## Main Chip Identification

The main SoC should be marked as some form of RT5350F.

Common markings may include:

- Ralink RT5350F
- MediaTek / Ralink RT5350F
- RT5350F

This is the main processor and includes the Wi-Fi and Ethernet hardware used by the board.

If the main chip is not RT5350F or a very close compatible part, do not assume the board is supported by the A5-V11 notes in this repo.

## RAM Identification

Most useful A5-V11 units have 32 MB SDRAM.

Known RAM chips include:

| RAM Chip Marking | Notes |
|---|---|
| W9825G6EH-75 | Common 32 MB SDRAM chip |
| EM63A165TS-6G | Known 32 MB SDRAM chip |
| Other SDRAM chips | Possible, needs verification |

RAM size matters because some bootloader files are specific to RAM size.

A file meant for a 16 MB RAM unit may be wrong for a 32 MB RAM unit.

A file meant for a 32 MB RAM unit may be wrong for a 16 MB RAM unit.

Do not flash a bootloader until the RAM size is confirmed.

## Flash Identification

The stock A5-V11 commonly uses a 4 MB SPI flash chip.

Known stock flash examples include:

| Flash Chip | Size | Notes |
|---|---:|---|
| Pm25LQ032 | 4 MB | Common stock SPI flash |
| MX25L3205 or similar | 4 MB | Possible compatible stock flash |
| Other 25-series SPI flash | Varies | Must be identified before programming |

The flash chip is usually an 8-pin SOIC/SOP package.

Record the exact chip marking before removing or programming it.

## Flash Size Identification

Flash size can be identified by:

- Reading the chip marking
- Reading the flash with a programmer
- Checking OpenWrt boot logs
- Checking stock firmware information
- Checking MTD partition output from Linux
- Comparing the chip part number to a datasheet

Common sizes of interest:

| Flash Size | Capacity Name | Notes |
|---:|---|---|
| 4 MB | 32 Mbit | Common stock size |
| 8 MB | 64 Mbit | Upgrade target |
| 16 MB | 128 Mbit | Preferred upgrade target for more firmware room |

The repo should clearly separate information for 4 MB, 8 MB, and 16 MB boards.

## Factory Partition Warning

The factory partition may contain board-specific data.

This can include:

- MAC address
- Wi-Fi calibration data
- RF calibration data
- Board-specific factory settings

Do not erase it.

Do not overwrite it with another board's data unless you fully understand the risk.

Before any flash replacement or firmware experiment:

1. Dump the full original flash.
2. Verify the dump.
3. Save at least two copies.
4. Extract and save the factory partition.
5. Record the MAC address.
6. Only then continue.

## MAC Address Notes

Some A5-V11 references report Ethernet MAC addresses beginning with:

- 2C:67:FB

This is not guaranteed.

Record the MAC address from:

- Device label, if present
- Stock web interface, if available
- Telnet output, if available
- OpenWrt output, if available
- Factory partition analysis, if known

Do not assume a MAC address from another board belongs to your board.

## Stock Firmware Identification

The stock firmware varies heavily.

Known stock firmware traits may include:

- Web interface
- Telnet access
- Limited BusyBox shell
- More complete BusyBox shell
- Chinese interface
- English interface
- Qualcomm-branded interface on a Ralink / MediaTek device
- Default admin/admin login
- Default IP behavior that changes by mode or firmware version

Common reported login:

| Service | Username | Password |
|---|---|---|
| Web UI | admin | admin |
| Telnet | admin | admin |

These are common values, not guaranteed values.

## Default IP Behavior

Possible default IP behavior includes:

| Situation | Possible IP |
|---|---|
| Stock firmware router mode | 192.168.100.1 |
| Stock firmware DHCP client mode | DHCP-assigned IP |
| OpenWrt default after flash | 192.168.1.1 |
| Custom PS2-focused firmware idea | 192.168.1.222 |

Do not assume the IP.

Check the router using:

- DHCP client list on your main router
- Network scanner
- Static PC address on 192.168.100.x
- Static PC address on 192.168.1.x
- UART console
- Boot log

## Stock Telnet Identification

Some stock firmware versions allow telnet.

Typical test:

- Connect Ethernet
- Power the router
- Find the IP address
- Telnet to the router
- Try admin/admin

If a limited shell appears, record the prompt and available commands.

Useful stock commands may include:

| Command | Purpose |
|---|---|
| help | Show available commands |
| show system revision | Show firmware and hardware revision |
| runshellcmd | May enable fuller shell on some firmware |
| cat /proc/cmdline | Confirm kernel command line if shell allows it |

Do not rely on every stock firmware supporting the same commands.

## Stock Web Interface Identification

Record the stock web interface before flashing.

Things to record:

- Login page appearance
- Branding
- Language options
- Firmware version
- Hardware version
- Product model
- Default LAN IP
- DHCP settings
- Wireless settings
- Storage settings
- Firmware update page behavior
- Whether it accepts standard OpenWrt factory images
- Whether it pretends to flash but does nothing

Some stock firmware update pages may reject non-vendor images.

Some may appear to flash successfully but leave the original firmware installed.

## Bootloader Identification

Many A5-V11 units use U-Boot, but bootloader behavior varies.

Possible cases:

- U-Boot accepts standard OpenWrt images
- U-Boot only accepts vendor-modified images
- U-Boot supports TFTP recovery
- U-Boot does not support expected TFTP recovery
- Reset button behavior is wrong due to GPIO mismatch
- Bootloader is damaged or locked down

Do not replace U-Boot unless you understand:

- RAM size
- Flash size
- Board target
- Recovery method
- Correct U-Boot file
- Risk of total brick

## U-Boot RAM Size Warning

Some old A5-V11 instructions reference U-Boot files with names that imply RAM size.

Common warning:

| File Name Pattern | Meaning |
|---|---|
| 128 | Often associated with 16 MB RAM |
| 256 | Often associated with 32 MB RAM |

Do not blindly flash a U-Boot file from an old guide.

A wrong U-Boot can brick the router.

## UART Pad Identification

The A5-V11 has four internal UART pads.

Using the common orientation:

- USB host port on the left
- Ethernet jack on the right
- UART pads in the lower-right area

The pads are commonly listed from left to right as:

| Pad | Function | Notes |
|---:|---|---|
| 1 | VCC 3.3 V | Do not connect for normal serial console use |
| 2 | TX | Router TX to USB-serial RX |
| 3 | RX | Router RX to USB-serial TX |
| 4 | GND | Ground |

Use only a 3.3 V UART adapter.

Do not use 5 V UART signals.

Do not connect the VCC pad unless there is a specific reason.

## UART Resistor Note

Some A5-V11 references warn that connecting the UART adapter TX line directly to the router RX line can cause boot issues.

Recommended practice:

- Router TX to adapter RX directly
- Adapter TX to router RX through 470 ohm to 1 k ohm resistor
- Ground to ground
- Leave VCC disconnected

If the board hangs during boot with RX connected:

1. Disconnect adapter TX from router RX.
2. Power the router first.
3. Connect RX after boot.
4. Add the series resistor if not already installed.

## UART Speed

A common UART speed for the A5-V11 is:

- 57600 baud
- 8 data bits
- no parity
- 1 stop bit

Common setting:

| Setting | Value |
|---|---|
| Baud | 57600 |
| Data bits | 8 |
| Parity | None |
| Stop bits | 1 |
| Flow control | None |

Always verify with boot output.

## LED Identification

The board usually has two LEDs.

Common LED mapping:

| LED | Possible Function |
|---|---|
| Red LED | Power or system status |
| Blue LED | System, Wi-Fi, or activity status |

Known GPIO notes from OpenWrt references:

| GPIO | Function |
|---:|---|
| GPIO17 | Red power LED |
| GPIO20 | Blue system LED |

LED behavior depends on firmware.

Document LED behavior during:

- Stock boot
- OpenWrt boot
- Failed boot
- Reset button hold
- TFTP recovery attempt
- PS2 internal install
- USB storage detection

## Button Identification

The board usually has a reset button or pinhole switch.

Possible uses:

- Stock factory reset
- OpenWrt failsafe
- U-Boot recovery
- TFTP recovery trigger
- Custom firmware input
- Mode switching

Button behavior is not guaranteed across bootloaders.

Record what the button does on each tested board.

## USB Host Port Identification

The full-size USB Type-A port is the USB host port.

Possible uses:

- USB storage
- Firmware flashing on some stock firmware methods
- UDPBD storage
- UDPFS storage
- SMB storage
- extroot experiments
- USB serial adapter experiments

Known GPIO notes from OpenWrt references:

| GPIO | Function |
|---:|---|
| GPIO7 | USB power |
| GPIO12 | USB root hub power |

USB behavior can depend heavily on firmware and included kernel modules.

## Micro-USB Port Identification

The micro-USB port is normally for 5 V power input.

Do not assume the micro-USB port provides a useful USB data connection to a computer.

For normal use:

- Micro-USB = 5 V power input
- USB Type-A = USB host port

For PS2 internal installs, the micro-USB connector may be removed, bypassed, or replaced by direct 5 V wiring.

## Ethernet Identification

The A5-V11 has one physical 10/100 Ethernet port.

The RT5350F platform has an internal Ethernet switch, but the A5-V11 exposes only one wired port.

Record:

- RJ45 connector type
- Ethernet magnetics location
- Link LED behavior, if any
- Whether the board gets a DHCP address
- Whether OpenWrt uses eth0 or eth0.1
- Whether the port works after flashing

For PS2 integration, Ethernet is the key connection between the PS2 and the router.

## Antenna Identification

Some A5-V11 boards may have poor Wi-Fi range due to antenna issues.

Inspect and document:

- Antenna trace
- Soldered antenna wire, if present
- PCB antenna area, if present
- Missing or disconnected antenna connection
- Any solder blob or jumper used for antenna path
- RF shield interaction if mounted inside a PS2
- Signal strength before and after antenna repair

If Wi-Fi range is poor, do not assume firmware is the problem.

Inspect the antenna path first.

## Capacitor Identification

A5-V11 boards may use different capacitor styles.

Known variations may include:

- Aluminum electrolytic capacitors
- Tantalum capacitors
- Different values
- Different heights
- Different placement
- Different manufacturers

For PS2 internal fitment, capacitor height is important.

Record:

- Capacitance
- Voltage rating
- Package style
- Height
- Diameter or footprint
- Polarity marking
- Location on board
- Whether it interferes with PS2 mounting
- Whether it can be laid flat or relocated

## Common Visual Differences Between Units

Look for these differences:

- Different shell label
- Different PCB marking
- Different RAM chip
- Different flash chip
- Different capacitor style
- Different capacitor height
- Different antenna connection
- Different UART pad exposure
- Different button style
- Different LED color behavior
- Different USB connector style
- Different Ethernet jack style
- Different stock firmware branding
- Different bootloader behavior

Document each difference.

## Confirming It Is a Good Candidate

A good A5-V11 candidate for this repo should ideally have:

- RT5350F SoC
- 32 MB RAM
- Working UART
- Working Ethernet
- Working Wi-Fi
- Working USB host
- Readable flash chip
- Recoverable bootloader
- Dumped original flash
- Preserved factory partition
- No major board damage

For PS2 use, the best candidate should also have:

- Stable 5 V operation
- Reliable cold boot
- Reliable warm boot
- Good Wi-Fi signal
- Reasonable thermal behavior
- Physical fitment potential
- Good Ethernet stability

## Red Flags

Be careful with boards that have:

- Unknown SoC
- 16 MB RAM
- No visible board marking
- Damaged flash chip
- Missing or damaged UART pads
- No serial output
- No Ethernet link
- No Wi-Fi signal
- Burn marks
- Corroded parts
- Missing antenna connection
- Wrong bootloader
- Always-on dim LEDs with no boot
- Excessive heat immediately after power-on
- Stock firmware that cannot be accessed
- Failed previous flash attempts

A red flag does not always mean the board is useless, but it should be documented before continuing.

## Brick Symptom Notes

Possible brick symptoms include:

- Red and blue LEDs stuck on
- Dim LEDs only
- No Ethernet link
- No DHCP activity
- No serial output
- Serial output stops early
- Boot loop
- U-Boot menu appears but firmware will not boot
- TFTP recovery does not start
- Router heats quickly
- Flash chip cannot be read by programmer

Record the exact symptoms before trying recovery.

## Board Identification Checklist

Use this checklist for each board.

| Item | Result |
|---|---|
| Shell marking |  |
| PCB marking |  |
| SoC marking |  |
| RAM chip marking |  |
| RAM size |  |
| Flash chip marking |  |
| Flash size |  |
| MAC address |  |
| Stock IP behavior |  |
| Stock web UI works |  |
| Stock telnet works |  |
| Stock login |  |
| UART pads found |  |
| UART speed confirmed |  |
| Boot log captured |  |
| U-Boot present |  |
| USB host works |  |
| Ethernet works |  |
| Wi-Fi works |  |
| Antenna inspected |  |
| Capacitors documented |  |
| Full flash dumped |  |
| Factory partition saved |  |
| Board photos saved |  |
| Notes file created |  |

## Suggested Board Log Template

Create one log file per board.

Suggested file name format:

- board-001.md
- board-002.md
- board-003.md

Suggested contents:

| Field | Value |
|---|---|
| Board ID |  |
| Date received |  |
| Seller |  |
| Shell type |  |
| Shell label |  |
| PCB marking |  |
| SoC |  |
| RAM chip |  |
| RAM size |  |
| Flash chip |  |
| Flash size |  |
| MAC address |  |
| Stock firmware version |  |
| Stock web UI branding |  |
| Stock IP |  |
| Telnet login works |  |
| UART works |  |
| Bootloader |  |
| Ethernet works |  |
| Wi-Fi works |  |
| USB works |  |
| Antenna condition |  |
| Capacitor style |  |
| Heat behavior |  |
| Flash dump file name |  |
| Factory partition file name |  |
| Current status |  |
| Notes |  |

## Example Board Status Labels

Use simple labels.

| Label | Meaning |
|---|---|
| Unknown | Not inspected yet |
| Identified | Board has been visually identified |
| UART Confirmed | Serial console works |
| Flash Dumped | Full flash backup exists |
| Factory Saved | Factory partition has been saved |
| Stock Working | Stock firmware still works |
| OpenWrt Working | OpenWrt boots and network works |
| PS2 Bench Test | Tested with PS2 externally |
| PS2 Internal Test | Tested inside PS2 |
| Bricked | Does not boot normally |
| Recovery Candidate | May be recoverable |
| Parts Board | Useful for parts only |

## Minimum Documentation Before Flashing

Before flashing anything, the board should have:

- Clear photos of both sides
- SoC identified
- RAM chip identified
- Flash chip identified
- UART pads identified
- Stock firmware behavior recorded
- Full flash dump saved
- Factory partition saved
- Recovery method planned

Do not flash first and document later.

## Minimum Documentation Before PS2 Installation

Before installing inside a PS2, the board should have:

- Known working firmware
- Reliable cold boot
- Reliable warm boot
- Stable 5 V operation
- Working Ethernet
- Working Wi-Fi
- Tested USB behavior, if used
- Heat test completed
- Antenna plan
- Mounting plan
- Insulation plan
- Power wiring plan
- Ethernet wiring plan
- Recovery access plan

Internal installation should not be the first test.

## PS2 Fitment Identification Notes

When identifying a board for PS2 use, also record:

- Total board length
- Total board width
- Maximum component height
- Capacitor height
- USB port height
- Ethernet jack height
- Micro-USB height
- Heatsink clearance
- Possible RF shield contact area
- Possible antenna location
- Possible mounting points
- Whether ports will be removed
- Whether capacitors need relocation
- Whether Flipp'n Caps PCB/Flex is needed

## Photo Naming Convention

Recommended photo names:

- board-001-shell-front.jpg
- board-001-shell-back.jpg
- board-001-pcb-top.jpg
- board-001-pcb-bottom.jpg
- board-001-soc.jpg
- board-001-ram.jpg
- board-001-flash.jpg
- board-001-uart.jpg
- board-001-antenna.jpg
- board-001-caps.jpg
- board-001-ethernet.jpg
- board-001-usb.jpg

Consistent photo names make the repo easier to search.

## Known Identification Problems

Common problems:

- The shell says 3G/4G, but the board has no cellular modem.
- The web interface may say Qualcomm even though the SoC is Ralink / MediaTek.
- Two boards from the same seller may not be the same.
- A web firmware update may appear successful but not actually flash OpenWrt.
- A U-Boot file from an old guide may be for the wrong RAM size.
- Some firmware assumes 4 MB flash.
- Some firmware assumes a specific partition layout.
- Some boards may have poor Wi-Fi because of antenna issues.
- Some boards may run hot.
- Some boards may need a supervisor IC mod for reliable booting.

## Identification Decision Tree

Use this rough decision tree.

1. Does the board have an RT5350F SoC?
   - If yes, continue.
   - If no, treat as a different router.

2. Does the PCB say A5-V11 or MIFI?
   - If yes, likely target board.
   - If no, treat as variant.

3. Does it have 32 MB RAM?
   - If yes, good candidate.
   - If no, proceed with caution.

4. Does it have 4 MB stock flash?
   - If yes, standard stock layout likely.
   - If no, document carefully.

5. Does UART work?
   - If yes, recovery and testing are much safer.
   - If no, fix UART access before risky firmware work.

6. Has the original flash been dumped?
   - If yes, continue.
   - If no, dump before modifying.

7. Is the factory partition saved?
   - If yes, continue.
   - If no, save it before modifying.

8. Is the board stable on stock firmware or known firmware?
   - If yes, good test candidate.
   - If no, treat as recovery or parts board.

## Short Version

To identify an A5-V11, open the shell and inspect the PCB.

Look for:

- A5-V11 or MIFI board marking
- RT5350F main chip
- 32 MB RAM chip such as W9825G6EH-75 or EM63A165TS-6G
- 4 MB SPI flash such as Pm25LQ032
- Internal UART pads
- Working Ethernet
- Working Wi-Fi
- Working USB host
- Stock firmware or UART access

Before modifying anything, photograph the board and dump the original flash.

The A5-V11 family has too many variants to trust the shell, seller listing, or old flashing guide by itself.

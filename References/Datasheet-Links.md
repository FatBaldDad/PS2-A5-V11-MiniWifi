# Datasheet Links

## Summary

This document tracks datasheets, product pages, technical references, and component-level documentation related to the A5-V11 mini router project.

The goal is to keep all useful hardware references in one place.

This includes datasheets for:

- A5-V11 main SoC
- RAM chips
- SPI flash chips
- Voltage supervisors
- USB power parts
- Ethernet magnetics
- Capacitors
- Connectors
- Programming tools
- PS2 integration support parts
- Future helper boards such as Flipp'n Caps PCB/Flex

---

## Purpose

This file is used to track:

- Component part numbers
- Manufacturer names
- Datasheet links
- Product page links
- Package information
- Voltage ratings
- Pinout references
- Alternate parts
- Notes about where the part appears in the project
- Whether the datasheet has been verified

This is not meant to replace the actual datasheets.

Always read the manufacturer datasheet before designing a board, modifying hardware, or choosing a replacement part.

---

## Main Rule

The main rule is:

```text
Use manufacturer datasheets whenever possible.
```

Secondary sources can be useful, but the manufacturer datasheet should be treated as the primary reference.

---

## Important Warning

Do not rely only on seller listings.

Seller pages can have:

- Wrong part numbers
- Wrong photos
- Wrong package names
- Wrong voltage ratings
- Wrong pinouts
- Wrong dimensions
- Copied specs from another part
- Bad translations
- Missing package drawings
- Missing derating information

For board design, always verify with the datasheet.

---

## Source Priority

Use references in this order when possible:

1. Manufacturer datasheet
2. Manufacturer product page
3. Authorized distributor page
4. OpenWrt hardware documentation
5. Board photos and measurements
6. Community research
7. Seller listing
8. Unknown mirror

For critical parts, avoid relying on unknown mirrors.

---

## Datasheet Status Labels

Use these labels.

| Label | Meaning |
|---|---|
| Needed | Datasheet still needs to be found |
| Found | Link found but not fully reviewed |
| Reviewed | Datasheet has been reviewed |
| Verified | Specs confirmed against board or design |
| Alternate | Useful alternate part |
| Obsolete | Part may be old or discontinued |
| Unverified | Source or part match is not confirmed |
| Do Not Use Blindly | Risky or unclear part |
| Preferred | Currently preferred part for project use |

---

## Link Status Labels

Use these labels.

| Label | Meaning |
|---|---|
| Active | Link currently works |
| Archived | Original may be dead, archive link saved |
| Dead | Link no longer works |
| Needs Archive | Important link should be archived |
| Distributor Only | Datasheet found through distributor |
| Mirror Only | Only mirror source found |
| Unknown | Link status not checked |

---

## Datasheet Entry Template

Use this template for each part.

```text
# Datasheet Entry

## Basic Info

Part number:
Manufacturer:
Description:
Package:
Project use:
Status:

## Links

Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
Alternate datasheet source:

## Key Specs To Check

Supply voltage:
Logic voltage:
Current rating:
Package dimensions:
Pinout:
Thermal information:
Absolute maximum ratings:
Recommended operating conditions:

## Project Notes

Used on A5-V11:
Used on PS2 integration board:
Used on Flipp'n Caps:
Used for flash upgrade:
Used for recovery:
Notes:

## Verification

Checked against real board:
Checked against schematic:
Checked against footprint:
Date reviewed:
Reviewer:
```

---

## Main A5-V11 Components

| Part | Manufacturer | Description | Project Relevance | Status |
|---|---|---|---|---|
| RT5350F | Ralink / MediaTek | MIPS Wi-Fi router SoC | Main A5-V11 processor, Ethernet, Wi-Fi, USB | Needed |
| W9825G6EH-75 | Winbond | SDRAM | Common 32 MB RAM chip on A5-V11 boards | Needed |
| EM63A165TS-6G | EtronTech | SDRAM | Alternate 32 MB RAM chip seen on some boards | Needed |
| W25Q32 | Winbond | 32 Mbit SPI flash | 4 MB flash class | Needed |
| W25Q64 | Winbond | 64 Mbit SPI flash | 8 MB flash upgrade class | Needed |
| W25Q128 | Winbond | 128 Mbit SPI flash | 16 MB flash upgrade class | Needed |
| GD25Q32 | GigaDevice | 32 Mbit SPI flash | Possible alternate 4 MB flash | Needed |
| GD25Q64 | GigaDevice | 64 Mbit SPI flash | Possible alternate 8 MB flash | Needed |
| GD25Q128 | GigaDevice | 128 Mbit SPI flash | Possible alternate 16 MB flash | Needed |

---

## RT5350F SoC

## Part Info

| Item | Value |
|---|---|
| Part number | RT5350F |
| Manufacturer | Ralink / MediaTek |
| Description | Wi-Fi router SoC |
| Project role | Main A5-V11 processor |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
OpenWrt reference:
Archive link:
```

## Key Specs To Review

- CPU architecture
- Clock speed
- RAM interface
- SPI flash interface
- Ethernet interface
- USB host interface
- Wi-Fi radio
- GPIOs
- UART
- Power requirements
- Thermal behavior
- Package dimensions

## Project Notes

The RT5350F is the heart of the A5-V11.

It matters for:

- OpenWrt target selection
- UART behavior
- Ethernet behavior
- USB support
- Wi-Fi support
- Flash layout
- GPIO mapping
- LED behavior
- PS2 integration limits

---

## RAM Chips

## Winbond W9825G6EH-75

| Item | Value |
|---|---|
| Part number | W9825G6EH-75 |
| Manufacturer | Winbond |
| Description | SDRAM |
| Common project role | 32 MB RAM chip |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Key Specs To Review

- Memory size
- Data width
- Voltage
- Speed grade
- Package
- Pinout
- Timing parameters
- Operating temperature

## Project Notes

This RAM chip is important because U-Boot selection may depend on RAM size.

Before using or replacing U-Boot, confirm the RAM chip and RAM size.

---

## EtronTech EM63A165TS-6G

| Item | Value |
|---|---|
| Part number | EM63A165TS-6G |
| Manufacturer | EtronTech |
| Description | SDRAM |
| Common project role | Alternate 32 MB RAM chip |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Key Specs To Review

- Memory size
- Voltage
- Speed grade
- Package
- Pinout
- Timing
- Compatibility with existing U-Boot

## Project Notes

Some A5-V11 boards may use this RAM chip instead of the Winbond RAM.

Document the RAM chip for every board.

---

## SPI Flash Chips

## Flash Size Reference

| Flash Size | Bit Rating | Byte Size | Hex Size |
|---:|---:|---:|---:|
| 4 MB | 32 Mbit | 4,194,304 bytes | `0x400000` |
| 8 MB | 64 Mbit | 8,388,608 bytes | `0x800000` |
| 16 MB | 128 Mbit | 16,777,216 bytes | `0x1000000` |

---

## Winbond W25Q32

| Item | Value |
|---|---|
| Part number | W25Q32 |
| Manufacturer | Winbond |
| Description | 32 Mbit SPI NOR flash |
| Project role | 4 MB flash class |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Key Specs To Review

- Voltage
- JEDEC ID
- Package
- Pinout
- Erase block size
- Page size
- Read/write commands
- Write protection
- Maximum clock
- Endurance
- Retention

---

## Winbond W25Q64

| Item | Value |
|---|---|
| Part number | W25Q64 |
| Manufacturer | Winbond |
| Description | 64 Mbit SPI NOR flash |
| Project role | 8 MB flash upgrade class |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Project Notes

Useful for 8 MB flash upgrade testing.

Confirm that U-Boot and OpenWrt both detect the chip correctly.

---

## Winbond W25Q128

| Item | Value |
|---|---|
| Part number | W25Q128 |
| Manufacturer | Winbond |
| Description | 128 Mbit SPI NOR flash |
| Project role | 16 MB flash upgrade class |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Project Notes

Useful for the main 16 MB flash upgrade path.

For 16 MB migration, preserve:

- U-Boot
- U-Boot environment
- Factory partition
- Same-board calibration data

---

## GigaDevice SPI Flash Alternates

## GD25Q32

| Item | Value |
|---|---|
| Part number | GD25Q32 |
| Manufacturer | GigaDevice |
| Description | 32 Mbit SPI NOR flash |
| Project role | 4 MB alternate |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

---

## GD25Q64

| Item | Value |
|---|---|
| Part number | GD25Q64 |
| Manufacturer | GigaDevice |
| Description | 64 Mbit SPI NOR flash |
| Project role | 8 MB alternate |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

---

## GD25Q128

| Item | Value |
|---|---|
| Part number | GD25Q128 |
| Manufacturer | GigaDevice |
| Description | 128 Mbit SPI NOR flash |
| Project role | 16 MB alternate |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

---

## SPI Flash Pinout Reference

Common SOIC-8 SPI flash pinout:

```text
        _________
CS   1 |•        | 8 VCC
MISO 2 |         | 7 HOLD
WP   3 |         | 6 CLK
GND  4 |_________| 5 MOSI
```

| Pin | Signal |
|---:|---|
| 1 | CS |
| 2 | DO / MISO |
| 3 | WP |
| 4 | GND |
| 5 | DI / MOSI |
| 6 | CLK |
| 7 | HOLD |
| 8 | VCC |

Always confirm against the exact flash datasheet.

---

## Voltage Supervisors

Voltage supervisors may be used to improve reset reliability after power cycling or power ramp issues.

## MAX809TTR

| Item | Value |
|---|---|
| Part number | MAX809TTR |
| Manufacturer | Analog Devices / Maxim Integrated |
| Description | Microprocessor reset supervisor |
| Project role | A5-V11 reset supervisor mod |
| Package | SOT-23 class |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Key Specs To Review

- Reset threshold
- Reset output polarity
- Reset timeout
- Supply voltage
- Package
- Pinout
- Output type
- Temperature range

## Project Notes

This part is useful for the Flipp'n Caps PCB/Flex and reset reliability experiments.

Confirm threshold selection before use.

---

## ADM809

| Item | Value |
|---|---|
| Part number | ADM809 |
| Manufacturer | Analog Devices |
| Description | Microprocessor reset supervisor |
| Project role | Alternate reset supervisor |
| Package | SOT-23 class |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Project Notes

Potential alternate for MAX809-style supervisor behavior.

Check exact suffix and reset threshold.

---

## USB And Power Parts

## CH341A

| Item | Value |
|---|---|
| Part number | CH341A |
| Manufacturer | WCH |
| Description | USB interface chip used on low-cost SPI programmers |
| Project role | SPI flash recovery and programming |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Programmer board reference:
Archive link:
```

## Project Notes

The CH341A chip is used on many inexpensive flash programmers.

Important:

- Many programmer boards must be verified for 3.3 V operation.
- Do not trust labels blindly.
- Measure programmer voltage before connecting to A5-V11 flash.

---

## USB-C PD Trigger Board Parts

This project may use USB-C power or external regulators in related PS2 builds.

Track any trigger board controller datasheets here once the chip marking is known.

| Part | Manufacturer | Description | Status |
|---|---|---|---|
| Unknown PD trigger IC | Unknown | USB-C PD trigger controller | Needed |
| TPS54331 | Texas Instruments | Buck regulator | Needed |
| SK34 | Multiple | Schottky diode | Needed |

---

## TPS54331

| Item | Value |
|---|---|
| Part number | TPS54331 |
| Manufacturer | Texas Instruments |
| Description | Buck converter |
| Project role | Possible 5 V or 3.3 V regulator in related boards |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Key Specs To Review

- Input voltage range
- Output current
- Switching frequency
- Feedback reference
- Inductor selection
- Catch diode requirements
- Layout recommendations
- Thermal performance

---

## SK34 Schottky Diode

| Item | Value |
|---|---|
| Part number | SK34 |
| Manufacturer | Multiple |
| Description | Schottky rectifier diode |
| Project role | Buck converter diode / power path support |
| Status | Needed |

## Links

```text
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Key Specs To Review

- Reverse voltage
- Average forward current
- Surge current
- Forward voltage
- Package
- Thermal rating

---

## Ethernet Magnetics And Connectors

Ethernet magnetics are important for safe and reliable Ethernet wiring.

Do not bypass magnetics unless the circuit has been fully understood.

## Ethernet Magnetics Parts To Track

| Part | Manufacturer | Description | Project Relevance | Status |
|---|---|---|---|---|
| H0037 | Pulse or compatible | Ethernet magnetic module | Possible Ethernet magnetics reference | Needed |
| PT61018PEL | Pulse or compatible | Ethernet transformer/magnetics | Possible alternate Ethernet magnetics | Needed |
| PS2 T9000 | Sony / unknown | PS2 Ethernet magnetics area reference | Board-specific PS2 reference | Needed |

---

## H0037 Ethernet Magnetics

| Item | Value |
|---|---|
| Part number | H0037 |
| Manufacturer | To confirm |
| Description | Ethernet magnetics |
| Project role | Possible A5-V11/PS2 Ethernet integration reference |
| Status | Unverified |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Notes

Confirm exact manufacturer and pinout before using this part in a PCB.

---

## PT61018PEL Ethernet Magnetics

| Item | Value |
|---|---|
| Part number | PT61018PEL |
| Manufacturer | To confirm |
| Description | Ethernet magnetics |
| Project role | Possible Ethernet transformer alternate |
| Status | Unverified |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Notes

Confirm package, turns ratio, common-mode choke configuration, and pinout before use.

---

## Ethernet Connector References

Track RJ45 and low-profile Ethernet connector references here.

| Part | Manufacturer | Description | Status |
|---|---|---|---|
| Stock A5-V11 RJ45 | Unknown | Stock Ethernet jack | Needed |
| Low-profile RJ45 option | Unknown | Possible replacement connector | Needed |
| Internal Ethernet adapter pads | Custom | Possible PCB/flex connection | Planned |

---

## Capacitors

The A5-V11 uses electrolytic capacitors that may interfere with PS2 internal fitment.

Track replacement and relocation parts here.

## Stock Capacitor Reference

| Item | Value |
|---|---|
| Capacitance | 470 µF |
| Voltage | 6.3 V |
| Type | Electrolytic |
| Project role | A5-V11 bulk capacitance |
| Status | Board measurement needed |

## Links

```text
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Project Notes

The stock capacitors may be relocated or laid flat using the Flipp'n Caps PCB/Flex.

Do not reduce bulk capacitance without testing boot reliability, USB storage, Wi-Fi, and rapid power cycling.

---

## Capacitor Replacement Candidates

| Part Number | Manufacturer | Value | Voltage | Package | Status |
|---|---|---:|---:|---|---|
| TBD | TBD | 470 µF | 6.3 V or higher | SMD electrolytic | Needed |
| TBD | TBD | 470 µF | 6.3 V or higher | Through-hole radial | Needed |
| TBD | TBD | 100 µF | 6.3 V or higher | Ceramic or polymer | Experimental |
| TBD | TBD | 22 µF | 6.3 V or higher | MLCC | Experimental |
| TBD | TBD | 10 µF | 6.3 V or higher | MLCC | Experimental |

---

## MLCC Warning

Ceramic capacitors lose capacitance under DC bias.

A capacitor marked as:

```text
22 µF 6.3 V
```

may provide much less actual capacitance at 5 V depending on package, dielectric, and voltage rating.

Always check:

- DC bias curve
- Temperature rating
- Package size
- Voltage rating
- Effective capacitance

Do not assume a stack of ceramics is equivalent to a 470 µF electrolytic without testing.

---

## Connectors

Track connector datasheets used for internal PS2 service and modular wiring.

## UART Service Connector Candidates

| Connector | Manufacturer | Pitch | Pins | Status |
|---|---|---:|---:|---|
| JST-SH | JST | 1.0 mm | 3 to 5 | Candidate |
| JST-GH | JST | 1.25 mm | 3 to 5 | Candidate |
| JST-PH | JST | 2.0 mm | 3 to 5 | Candidate |
| DF14 | Hirose | 1.25 mm | 3 to 6 | Candidate |
| Pogo pads | Various | N/A | 3 to 5 | Candidate |

---

## Hirose DF14

| Item | Value |
|---|---|
| Series | DF14 |
| Manufacturer | Hirose |
| Description | Board-to-wire connector family |
| Project role | Possible small service connector |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## Notes

Track 3-pin through 6-pin options for UART, service, and internal wiring.

---

## JST Connector Families

## JST-SH

| Item | Value |
|---|---|
| Series | JST-SH |
| Pitch | 1.0 mm |
| Project role | Very small service connector |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## JST-GH

| Item | Value |
|---|---|
| Series | JST-GH |
| Pitch | 1.25 mm |
| Project role | Small locking service connector |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

## JST-PH

| Item | Value |
|---|---|
| Series | JST-PH |
| Pitch | 2.0 mm |
| Project role | Larger service connector |
| Status | Needed |

## Links

```text
Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:
```

---

## PS2-Related Components

Track PS2-side parts that matter for integration.

| Part | Description | Project Relevance | Status |
|---|---|---|---|
| PS2 Slim Ethernet magnetics | Built-in PS2 Ethernet isolation | Internal Ethernet wiring | Needed |
| PS2 USB connector | 5 V source and port reference | Power planning | Needed |
| PS2 RF shield | Thermal and mounting reference | Internal mounting | Board-specific |
| PS2 fan connector | Airflow and clearance reference | Internal mounting | Board-specific |
| PS2 controller port PCB | Clearance and wiring reference | Internal mounting | Board-specific |

---

## PS2 Ethernet Reference

The PS2 Ethernet circuit should be documented per model and board revision.

Record:

```text
PS2 model:
Motherboard revision:
Ethernet PHY:
Ethernet magnetics:
RJ45 connector:
Known tap points:
Datasheet links:
Board photos:
Notes:
```

Do not assume one PS2 Slim revision matches another.

---

## A5-V11 Board Measurement References

Some parts may not have clear markings.

Track measured data here.

| Item | Measurement | Notes |
|---|---:|---|
| A5-V11 PCB length |  | Measure with calipers |
| A5-V11 PCB width |  | Measure with calipers |
| Stock capacitor height |  | Measure before relocation |
| RJ45 height |  | Measure if keeping connector |
| USB Type-A height |  | Measure if keeping connector |
| micro-USB height |  | Measure if keeping connector |
| Flash chip package |  | Confirm SOIC-8 dimensions |
| UART pad pitch |  | Needed for service connector planning |

---

## Datasheet Review Checklist

Before using a part in a design:

| Check | Done |
|---|---|
| Part number confirmed |  |
| Manufacturer confirmed |  |
| Datasheet downloaded or linked |  |
| Package confirmed |  |
| Pinout confirmed |  |
| Voltage rating confirmed |  |
| Current rating confirmed |  |
| Temperature rating confirmed |  |
| Footprint checked |  |
| 3D model checked, if used |  |
| KiCad symbol checked |  |
| KiCad footprint checked |  |
| Alternate parts identified |  |
| Distributor availability checked |  |
| Notes added |  |

---

## Footprint Verification Checklist

Before ordering a PCB:

| Check | Done |
|---|---|
| Datasheet package drawing checked |  |
| Pad dimensions checked |  |
| Pin 1 orientation checked |  |
| Courtyard checked |  |
| Silkscreen does not cover pads |  |
| Solder mask expansion checked |  |
| Hand-soldering clearance checked |  |
| Connector mating direction checked |  |
| Height clearance checked |  |
| Board edge clearance checked |  |
| Test print or 1:1 check completed |  |

---

## Datasheet File Naming

If datasheets are saved locally, use clear names.

Recommended:

```text
RT5350F-MediaTek-Datasheet.pdf
W25Q128JV-Winbond-Datasheet.pdf
W9825G6EH-Winbond-Datasheet.pdf
MAX809-Maxim-Analog-Devices-Datasheet.pdf
TPS54331-Texas-Instruments-Datasheet.pdf
DF14-Hirose-Datasheet.pdf
```

Avoid:

```text
datasheet.pdf
spec.pdf
download.pdf
file.pdf
```

---

## Suggested Folder Structure

```text
References/
├── Datasheet-Links.md
├── Datasheets/
│   ├── SoC/
│   ├── RAM/
│   ├── Flash/
│   ├── Supervisors/
│   ├── Power/
│   ├── Ethernet/
│   ├── Connectors/
│   ├── Capacitors/
│   └── PS2/
└── Source-Notes/
```

---

## Datasheet Link Table

Use this table for quick tracking.

| Part Number | Manufacturer | Description | Datasheet Link | Status | Notes |
|---|---|---|---|---|---|
| RT5350F | Ralink / MediaTek | Router SoC |  | Needed | Main A5-V11 SoC |
| W9825G6EH-75 | Winbond | SDRAM |  | Needed | 32 MB RAM |
| EM63A165TS-6G | EtronTech | SDRAM |  | Needed | Alternate 32 MB RAM |
| W25Q32 | Winbond | SPI NOR flash |  | Needed | 4 MB flash class |
| W25Q64 | Winbond | SPI NOR flash |  | Needed | 8 MB flash class |
| W25Q128 | Winbond | SPI NOR flash |  | Needed | 16 MB flash class |
| GD25Q32 | GigaDevice | SPI NOR flash |  | Needed | 4 MB alternate |
| GD25Q64 | GigaDevice | SPI NOR flash |  | Needed | 8 MB alternate |
| GD25Q128 | GigaDevice | SPI NOR flash |  | Needed | 16 MB alternate |
| MAX809TTR | Analog Devices / Maxim | Reset supervisor |  | Needed | Supervisor mod |
| ADM809 | Analog Devices | Reset supervisor |  | Needed | Supervisor alternate |
| CH341A | WCH | USB/SPI programmer IC |  | Needed | Flash recovery |
| TPS54331 | Texas Instruments | Buck regulator |  | Needed | Power support |
| SK34 | Multiple | Schottky diode |  | Needed | Buck regulator support |
| H0037 | To confirm | Ethernet magnetics |  | Unverified | Confirm exact part |
| PT61018PEL | To confirm | Ethernet magnetics |  | Unverified | Confirm exact part |
| DF14 | Hirose | Connector series |  | Needed | Service connectors |
| JST-SH | JST | Connector series |  | Needed | Service connectors |
| JST-GH | JST | Connector series |  | Needed | Service connectors |
| JST-PH | JST | Connector series |  | Needed | Service connectors |

---

## Part Review Record Template

Use this when a part is fully reviewed.

```text
# Part Review Record

## Part Info

Part number:
Manufacturer:
Description:
Package:
Project use:
Status:

## Links

Manufacturer product page:
Manufacturer datasheet:
Distributor page:
Archive link:

## Important Specs

Supply voltage:
Logic level:
Current rating:
Power rating:
Temperature range:
Package dimensions:
Pin count:
Pin 1 marker:
Recommended footprint:
Height:

## Design Notes

Schematic symbol:
KiCad footprint:
3D model:
Alternate parts:
Hand-solderable:
Assembly notes:
Risks:

## Verification

Datasheet reviewed:
Footprint checked:
Board ordered:
Board tested:
Result:
Notes:
```

---

## Distributor Tracking

Use distributor links for availability, but not as the only technical reference.

| Distributor | Use |
|---|---|
| Digi-Key | Preferred for exact MPNs and datasheets |
| Mouser | Useful for alternates |
| LCSC | Useful for JLCPCB assembly parts |
| Newark | Useful alternate distributor |
| Arrow | Useful alternate distributor |
| AliExpress | Useful for modules, not primary datasheet source |

---

## LCSC / JLCPCB Notes

If a part is used for JLCPCB assembly, record:

```text
Manufacturer part number:
LCSC part number:
Basic or extended:
Package:
Stock:
Substitute:
Datasheet:
Footprint verified:
```

Do not rely on the LCSC footprint preview without checking the datasheet.

---

## AliExpress Warning

AliExpress listings are useful for finding modules or cheap parts, but they are not reliable datasheets.

Use AliExpress for:

- Photos
- Module identification
- Board variants
- Cheap test hardware
- Mechanical examples

Do not use AliExpress alone for:

- Pinout confirmation
- Electrical limits
- Package dimensions
- Safety ratings
- Regulator performance
- Flash chip authenticity

---

## Datasheet Archive Notes

Important datasheets should be archived or saved in the project reference folder if redistribution is allowed.

For each saved datasheet, record:

```text
Original URL:
Date downloaded:
File name:
SHA256:
License or redistribution note:
```

Do not share datasheets if the license does not allow redistribution.

Link to the manufacturer instead.

---

## Datasheet Checksum Template

```text
# Datasheet File Record

File name:
Part number:
Manufacturer:
Original URL:
Date downloaded:
SHA256:
Redistribution allowed:
Notes:
```

Generate checksum:

```text
sha256sum RT5350F-MediaTek-Datasheet.pdf
```

PowerShell:

```text
Get-FileHash .\RT5350F-MediaTek-Datasheet.pdf -Algorithm SHA256
```

---

## Critical Parts To Verify First

Priority datasheets to find and review first:

1. RT5350F SoC
2. W9825G6EH-75 RAM
3. Installed SPI flash chip
4. W25Q128 or chosen 16 MB flash upgrade chip
5. MAX809TTR or chosen supervisor
6. A5-V11 stock capacitor markings
7. Ethernet magnetics used in PS2 integration
8. CH341A programmer voltage/reference
9. Any buck regulator used for internal PS2 power
10. Any connector used on the Flipp'n Caps PCB/Flex

---

## Do Not Do This

Avoid these mistakes:

- Do not design from a seller photo only.
- Do not trust pinouts from random images without checking.
- Do not assume similar part numbers are identical.
- Do not use a flash chip without checking voltage and JEDEC ID.
- Do not use a supervisor without checking reset threshold.
- Do not use a connector footprint without checking mating direction.
- Do not copy an Ethernet magnetics footprint without verifying pinout.
- Do not assume a capacitor has full rated capacitance under DC bias.
- Do not upload datasheets if redistribution is not allowed.
- Do not rely on AliExpress for final electrical specs.

---

## Short Version

This file tracks datasheets and technical references for the A5-V11 project.

Use it to document:

- Part numbers
- Manufacturers
- Datasheet links
- Package details
- Pinouts
- Voltage/current limits
- Footprint notes
- Verification status

Always prefer manufacturer datasheets.

Always verify footprints before ordering PCBs.

For critical work like flash upgrades, reset supervisor mods, Ethernet wiring, and PS2 internal power, do not rely on guesses or seller listings.

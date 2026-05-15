# PS2 Integration

## Summary

This section documents how the A5-V11 mini router can be used with the PlayStation 2.

The main goal is to turn the A5-V11 into a small PS2-focused network appliance.

Possible roles include:

- Wi-Fi bridge for PS2 Ethernet
- wLaunchELF FTP helper
- OPL SMB bridge
- Router-hosted SMB server
- UDPBD server
- UDPFS server
- Internal PS2 network module
- Internal USB storage host
- External test router
- Service and recovery network

The primary target is PlayStation 2 Slim and Ultra Slim style builds, but many notes also apply to PS2 Fat consoles and external test setups.

---

## Important Warning

Do not install the A5-V11 inside a PS2 until the router has been tested externally.

Before internal PS2 integration, confirm:

- The A5-V11 boots reliably.
- The original flash has been backed up.
- The factory partition has been saved.
- UART access works.
- Ethernet works.
- Wi-Fi works, if used.
- USB storage works, if used.
- The firmware is known-good.
- Boot timing is understood.
- Power draw is measured.
- Heat behavior is tested.
- A recovery method exists.

Internal installation makes recovery harder.

A router that is easy to fix on the bench can become difficult to repair once it is buried inside a console.

---

## Section Goals

This section is meant to document:

- How the A5-V11 connects to the PS2
- How to power the A5-V11 from or alongside the PS2
- How to wire Ethernet internally
- How to mount the router inside the console
- How to plan for boot timing
- How to test compatibility
- How to test closed-shell reliability
- How to avoid backfeed and power problems
- How to keep UART and recovery access available
- How to document each internal build

The long-term goal is a repeatable PS2-focused installation method.

---

## Current Status

This section is experimental.

The A5-V11 is cheap, small, and useful, but it is also limited.

Known limitations include:

- Stock 4 MB flash is very limited.
- 32 MB RAM is still tight.
- Firmware and bootloader behavior can vary.
- Wi-Fi antenna quality can vary.
- USB storage timing matters.
- PS2 loader timing matters.
- Internal mounting changes heat and Wi-Fi behavior.
- Recovery becomes harder after installation.

Treat every board and every PS2 model as its own test case.

---

## Recommended Reading Order

Read these files in order:

1. [Use Cases](Use-Cases.md)
2. [Power From PS2](Power-From-PS2.md)
3. [Ethernet Wiring](Ethernet-Wiring.md)
4. [Boot Timing](Boot-Timing.md)
5. [Compatibility Testing](Compatibility-Testing.md)
6. [Internal Mounting](Internal-Mounting.md)

This order starts with the overall purpose, then moves into power, wiring, timing, testing, and final installation.

---

## Documents In This Section

| File | Purpose |
|---|---|
| [Use-Cases.md](Use-Cases.md) | Describes the practical PS2 roles for the A5-V11 |
| [Power-From-PS2.md](Power-From-PS2.md) | Covers powering the router from PS2 USB, internal 5 V, buck regulators, always-on power, and backfeed testing |
| [Ethernet-Wiring.md](Ethernet-Wiring.md) | Covers wiring the A5-V11 Ethernet to the PS2 like a short internal Ethernet cable |
| [Boot-Timing.md](Boot-Timing.md) | Covers router boot time, USB mount time, service-ready timing, and PS2 loader delay |
| [Compatibility-Testing.md](Compatibility-Testing.md) | Defines how to test PS2 models, loaders, firmware builds, storage devices, filesystems, and use cases |
| [Internal-Mounting.md](Internal-Mounting.md) | Covers physically mounting the A5-V11 inside a PS2 safely and serviceably |

---

## Main PS2 Use Cases

| Use Case | Description |
|---|---|
| Wi-Fi bridge | Connect PS2 Ethernet to a home Wi-Fi network |
| FTP helper | Allow PC access to wLaunchELF FTP through the A5-V11 |
| SMB bridge | Bridge the PS2 to an external PC or NAS SMB share |
| Router-hosted SMB | Use the A5-V11 as the SMB server with attached USB storage |
| UDPBD server | Use the A5-V11 as a USB-backed UDPBD server for compatible PS2 loaders |
| UDPFS server | Use the A5-V11 for UDPFS or newer UDP-based loading workflows |
| Internal storage appliance | Mount the router and USB storage inside the PS2 |
| Service router | Use the A5-V11 as a known-good PS2 network test device |
| Simple setup UI | Future PS2-focused web interface for Wi-Fi, IP, and mode selection |

---

## Recommended Development Path

Start simple.

Recommended path:

1. Test the A5-V11 externally.
2. Back up the original flash.
3. Confirm UART recovery access.
4. Test stock Ethernet.
5. Test OpenWrt or chosen firmware.
6. Test the PS2 with a normal Ethernet cable.
7. Test wLaunchELF FTP.
8. Test Wi-Fi bridge behavior.
9. Test OPL SMB bridge behavior.
10. Test USB storage on the A5-V11.
11. Test UDPBD or UDPFS externally.
12. Measure power draw.
13. Measure heat.
14. Test boot timing.
15. Mock up internal mounting.
16. Test internal Ethernet wiring.
17. Test shell open.
18. Test shell closed.
19. Run repeated boot tests.
20. Document the final build.

Do not jump directly to internal installation.

---

## Best First Test

The best first PS2 test is:

```text
PS2 Ethernet -> normal Ethernet cable -> A5-V11 -> Wi-Fi or wired network
```

Then test:

- Router boots
- Ethernet link works
- PS2 IP settings work
- PC can ping router
- PC can ping PS2, if expected
- wLaunchELF FTP works
- OPL can reach the target server, if testing SMB

This proves the network path before internal wiring adds more variables.

---

## Best First Internal Test

The best first internal test is usually:

```text
A5-V11 powered from a stable 5 V source
PS2 connected to A5-V11 by short Ethernet wiring
UART service access retained
No USB storage yet
Wi-Fi bridge or FTP helper mode
```

This keeps the install simple while proving:

- Power
- Ethernet
- Wi-Fi
- Boot timing
- Closed-shell behavior
- Serviceability

After that works, USB storage, UDPBD, UDPFS, or router-hosted SMB can be added.

---

## PS2 Internal Integration Priorities

A good internal A5-V11 install should prioritize:

1. Safe power
2. UART recovery access
3. Ethernet stability
4. Antenna placement
5. Heat control
6. Boot timing
7. USB storage reliability, if used
8. Clean mounting
9. Closed-shell testing
10. Documentation

Fitment alone is not enough.

The board must still work after the shell is closed.

---

## Power Planning

The A5-V11 normally expects 5 V input.

Possible power options:

| Power Option | Notes |
|---|---|
| PS2 USB 5 V | Simple, but current may be limited |
| Internal PS2 5 V rail | Cleaner internal wiring, but must be verified |
| Dedicated buck regulator | Better for router plus USB storage |
| Always-on 5 V | Allows router to be ready before PS2, but requires backfeed testing |
| External 5 V | Best for development and early testing |
| Controller-managed power | Advanced option for future builds |

Power must be tested with the real firmware and real USB storage device.

---

## Ethernet Planning

The recommended Ethernet concept is:

```text
Wire the A5-V11 to the PS2 like a very short Ethernet cable.
```

For 10/100 Ethernet, the important RJ45 pins are:

```text
1, 2, 3, 6
```

Start with straight-through wiring:

```text
1 -> 1
2 -> 2
3 -> 3
6 -> 6
```

If no link appears, test crossover wiring:

```text
1 -> 3
2 -> 6
3 -> 1
6 -> 2
```

Keep the Ethernet magnetics in the circuit.

Do not directly wire PHY-to-PHY unless the circuit has been fully reverse engineered and tested.

---

## Boot Timing Planning

The PS2 can reach OPL, wLaunchELF, NHDDL, Neutrino, or another loader before the A5-V11 is ready.

The A5-V11 may need time to:

- Boot Linux
- Initialize Ethernet
- Join Wi-Fi
- Detect USB storage
- Mount USB storage
- Start SMB, UDPBD, UDPFS, or another service

For early testing, use a manual wait:

```text
Wait 60 seconds before launching the PS2 loader.
```

Then reduce the delay after the real service-ready time is measured.

If the first launch fails but the second launch works, suspect boot timing before blaming the firmware.

---

## Internal Mounting Planning

Before final internal mounting, check:

- Board height
- RJ45 connector height
- USB Type-A connector height
- Capacitor height
- Heatsink height
- RF shield clearance
- Shell clearance
- Fan clearance
- Controller port clearance
- Memory card slot clearance
- Antenna location
- USB storage location
- UART service access
- Reset access
- Wire strain relief
- Insulation from the RF shield

A shell that almost closes is not good enough.

The shell should close naturally without forcing it.

---

## Serviceability Requirement

Every internal install should preserve a recovery path.

Recommended service access:

| Signal | Purpose |
|---|---|
| GND | UART reference |
| Router TX | Read boot logs |
| Router RX | Send commands |
| 3.3 V sense, optional | Measurement only |
| Reset, optional | Recovery or reboot access |

Minimum recommended service connector:

```text
GND
Router TX
Router RX
```

Do not bury the router with no UART access unless the firmware is fully proven and the risk is accepted.

---

## Backfeed Warning

If the A5-V11 is powered while the PS2 is off, test for backfeed.

Possible backfeed paths include:

- Ethernet lines
- USB lines
- UART lines
- GPIO lines
- Shared 5 V rail
- Shared 3.3 V rail
- Controller board signals

Backfeed symptoms may include:

- PS2 LEDs glowing faintly
- Console partially powering
- Ethernet acting strangely
- Unexpected current draw
- PS2 not fully turning off
- PS2 power button behavior changing

Do not finalize an always-on design until backfeed is solved.

---

## Closed-Shell Requirement

A PS2 internal install is not proven until it works with the shell closed.

Closed-shell testing should include:

- Cold boot
- Warm reboot
- Ethernet link
- Wi-Fi signal, if used
- USB storage, if used
- Target service startup
- PS2 loader test
- Temperature check
- At least 30 minutes of operation
- Repeat test after power cycle

If it works open but fails closed, check:

- RF shield shorts
- Pinched wires
- Antenna blockage
- Heat buildup
- Board pressure
- Fan clearance
- USB drive pressure
- Ethernet wire routing

---

## Compatibility Testing

Compatibility results must be specific.

Do not write:

```text
Works with PS2.
```

Write results like:

```text
SCPH-79001, A5-V11 board-003, 16 MB flash, PS2 UDPBD firmware v0.1, OPL UDPBD build, Samsung USB flash drive, exFAT, router powered from PS2 USB, 60 second boot delay, shell closed, passed 1 hour test.
```

A setup is only compatible under the conditions actually tested.

---

## Minimum Test Checklist

Before calling a PS2 A5-V11 setup working:

| Check | Done |
|---|---|
| A5-V11 board identified |  |
| Original flash backed up |  |
| Factory partition saved |  |
| UART works |  |
| Firmware boots |  |
| Ethernet works |  |
| Wi-Fi works, if used |  |
| USB storage works, if used |  |
| Power draw measured |  |
| Boot timing measured |  |
| PS2 loader tested |  |
| Closed-shell test passed, if internal |  |
| Recovery method documented |  |

---

## Final Internal Build Checklist

For a final internal install:

| Check | Done |
|---|---|
| 10 cold boots pass |  |
| 10 warm reboots pass |  |
| Router reaches service-ready every time |  |
| PS2 loader sees service every time |  |
| Ethernet remains stable |  |
| Wi-Fi remains stable, if used |  |
| USB storage remains mounted, if used |  |
| Game or target service test passes |  |
| 30 minute closed-shell test passes |  |
| Thermal behavior is acceptable |  |
| No backfeed issue exists |  |
| UART service access remains available |  |
| Wires are strain relieved |  |
| RF shield is insulated |  |
| Shell closes naturally |  |
| Photos are saved |  |
| Build notes are updated |  |

---

## Suggested Folder Structure

Suggested future structure for this section:

```text
PS2-Integration/
├── README.md
├── Use-Cases.md
├── Power-From-PS2.md
├── Ethernet-Wiring.md
├── Boot-Timing.md
├── Compatibility-Testing.md
├── Internal-Mounting.md
├── Compatibility-Matrix.md
├── Test-Results/
│   ├── FTP/
│   ├── SMB/
│   ├── UDPBD/
│   ├── UDPFS/
│   ├── WiFi-Bridge/
│   └── Internal-Installs/
├── Game-Compatibility/
│   ├── README.md
│   ├── SMB.md
│   ├── UDPBD.md
│   └── UDPFS.md
└── Photos/
    ├── External-Testing/
    ├── Internal-Mounting/
    ├── Ethernet-Wiring/
    ├── Power-Wiring/
    └── Closed-Shell-Tests/
```

---

## Test Result Template

Use this template for PS2 integration test notes.

```text
# PS2 Integration Test Result

## Test Info

Test ID:
Date:
Tester:
Result:

## A5-V11

Board ID:
Flash size:
RAM size:
Firmware:
Firmware role:
Antenna:
Heatsink:
Supervisor IC:
Capacitor mod:

## PS2

Model:
Motherboard revision:
Boot method:
Loader:
Loader version:
Other mods:

## Power

Power source:
Voltage at A5-V11:
Idle current:
Active current:
Backfeed tested:

## Network

Ethernet method:
Straight-through or crossover:
Router IP:
PS2 IP:
PC/server IP:
Network mode:

## Storage

USB storage:
Filesystem:
USB hotplug:
Mount path:

## Timing

Router power-on:
Ethernet ready:
Wi-Fi ready:
USB mounted:
Service ready:
Loader launched:
Recommended delay:

## Testing

FTP:
SMB:
UDPBD:
UDPFS:
Game boot:
Closed-shell:
Thermal:
Long-run:

## Notes

Known issues:
Photos:
Next steps:
```

---

## Photo Documentation

For internal builds, take photos of:

- A5-V11 before modification
- Flash chip and board markings
- UART wiring
- Power tap point
- Ground tap point
- Ethernet wiring
- Antenna location
- USB storage location
- Mounting bracket or plate
- Insulation layer
- RF shield clearance
- Shell clearance
- Final closed-shell build

Suggested file names:

```text
ps2-a5v11-board001-overview.jpg
ps2-a5v11-board001-power.jpg
ps2-a5v11-board001-ethernet.jpg
ps2-a5v11-board001-uart.jpg
ps2-a5v11-board001-antenna.jpg
ps2-a5v11-board001-mounting.jpg
ps2-a5v11-board001-closed-shell.jpg
```

---

## Safety And Legal Notes

This section documents hardware integration, firmware behavior, networking, and testing.

This repo should not host:

- Game ISOs
- PS2 BIOS files
- Commercial software
- Copyrighted game assets
- Piracy-focused instructions

Testing should use legally owned backups or homebrew test files.

---

## Recommended Short-Term Goal

The recommended short-term goal is:

```text
External A5-V11 PS2 test setup
```

Minimum target:

- A5-V11 powered externally
- Ethernet cable to PS2
- Wi-Fi bridge or static network mode
- wLaunchELF FTP working
- UART logs captured
- Power and boot timing measured

This creates a known-good baseline.

---

## Recommended Long-Term Goal

The recommended long-term goal is:

```text
Internal PS2 A5-V11 network appliance
```

Possible final features:

- Internal A5-V11 mounting
- Stable 5 V power
- Short internal Ethernet link
- UART service connector
- Good antenna placement
- Heat path to RF shield or heatsink
- Optional USB storage
- Optional UDPBD or UDPFS support
- Optional simple PS2-focused setup web UI
- Documented recovery path

---

## Short Version

The A5-V11 can be useful with the PS2, but it must be treated as a real embedded Linux device, not just a simple adapter.

For PS2 integration:

- Test externally first.
- Back up the flash.
- Keep UART access.
- Use stable 5 V power.
- Wire Ethernet like a short cable.
- Preserve magnetics.
- Measure boot timing.
- Plan antenna placement.
- Plan heat removal.
- Test with the shell closed.
- Document every board and every build.

The best PS2 integration is not just the one that fits.

The best integration is the one that boots reliably, stays cool, remains serviceable, and works every time the PS2 needs it.

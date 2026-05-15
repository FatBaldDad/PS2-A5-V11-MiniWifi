# Internal Mounting

## Summary

This document covers internal mounting of the A5-V11 mini router inside a PlayStation 2.

The goal is to install the A5-V11 in a way that is:

- Mechanically secure
- Electrically safe
- Thermally stable
- Serviceable
- Recoverable
- Repeatable
- Compatible with PS2 network use
- Clean enough for long-term builds

The primary target is PS2 Slim and Ultra Slim style builds, but many of the same ideas can also apply to PS2 Fat builds or external/internal hybrid setups.

---

## Important Warning

Do not install the A5-V11 inside a PS2 until it has been tested on the bench.

Before internal mounting, confirm:

- The A5-V11 boots reliably.
- The firmware is known-good.
- UART works.
- Ethernet works.
- Wi-Fi works if needed.
- USB storage works if needed.
- Boot timing is understood.
- Power draw is measured.
- Heat behavior is tested.
- The original flash has been backed up.
- The factory partition has been saved.
- A recovery method exists.

Internal mounting makes recovery harder.

A board that is easy to fix on the bench can become a major pain once it is buried inside a console.

---

## Main Rule

The main rule for internal mounting is:

```text
Do not sacrifice serviceability for fitment.
```

The A5-V11 should be mounted so it works, stays cool, does not short, and can still be accessed for recovery or debugging.

---

## Internal Mounting Goals

A good internal A5-V11 install should:

- Fit without forcing the shell closed
- Avoid shorts to the RF shield
- Avoid blocking the fan or airflow
- Avoid stressing the motherboard
- Avoid pinching wires
- Keep Ethernet wiring short
- Keep power wiring short and stable
- Keep the antenna usable
- Keep UART service access available
- Allow firmware recovery planning
- Survive repeated power cycles
- Survive closed-shell thermal testing
- Avoid creating backfeed problems
- Be documented with photos and notes

---

## What Internal Mounting Is For

Internal mounting may support several PS2 network goals.

Possible uses:

- Internal Wi-Fi bridge
- Internal UDPBD server
- Internal UDPFS server
- Internal SMB1 server
- Internal FTP helper
- Internal router-hosted USB storage
- Internal network appliance for PS2 Slim builds
- Internal service board for Ultra Slim builds

The mounting method should match the firmware role.

A bridge-only install may need less storage access than a UDPBD or SMB install.

---

## What Internal Mounting Is Not

Internal mounting should not be treated as a shortcut.

It is not just:

```text
Tape the router inside the shell and hope it works.
```

Internal mounting requires attention to:

- Clearance
- Heat
- Power
- Ethernet signal integrity
- Wi-Fi antenna placement
- USB access
- Service access
- Recovery
- Boot timing
- Mechanical strain

---

## Recommended Development Order

Use this order before final mounting:

1. Test A5-V11 on bench.
2. Back up original flash.
3. Confirm UART.
4. Flash or configure known-good firmware.
5. Test Ethernet externally.
6. Test Wi-Fi externally.
7. Test USB storage externally, if used.
8. Test with PS2 using external Ethernet cable.
9. Test boot timing.
10. Test power draw.
11. Test heat on bench.
12. Choose internal mounting location.
13. Mock up fitment with shell open.
14. Mock up fitment with RF shield installed.
15. Mock up fitment with shell closed.
16. Add internal wiring.
17. Test shell open.
18. Test shell closed.
19. Run long thermal and network test.
20. Document final build.

---

## PS2 Models

Internal mounting space depends heavily on PS2 model.

| PS2 Model Family | Notes |
|---|---|
| SCPH-300xx to SCPH-500xx Fat | More space, but Network Adapter layout differs |
| SCPH-700xx Slim | More internal height than later Slims, but runs warmer |
| SCPH-750xx Slim | Good test candidate, but internal space is still tight |
| SCPH-770xx Slim | Similar Slim fitment concerns |
| SCPH-790xx Slim | Thin board, lower power, good Ultra Slim candidate |
| SCPH-900xx Slim | Internal PSU and layout differences may complicate mounting |

The most practical internal A5-V11 work is likely on Slim and Ultra Slim builds where the optical drive has been removed or where the shell is already being modified.

---

## Slim Versus Ultra Slim Builds

### Standard Slim

A standard PS2 Slim still has most of its original mechanical structure.

Challenges:

- Optical drive may still be present.
- RF shield clearance is tight.
- Fan clearance matters.
- Controller port clearance matters.
- Stock shell has limited height.
- Internal wiring must not interfere with disc drive.

Best A5-V11 use:

- Very compact Wi-Fi bridge
- Router board with tall parts removed or relocated
- Minimal internal wiring
- External USB storage not required, or carefully placed

### Ultra Slim

An Ultra Slim build usually removes or relocates major internal parts.

Advantages:

- More freedom for mounting
- Optical drive may be removed
- More room for custom plates
- Easier to add internal storage
- Easier to use RF shield as a mounting base
- Better fit for custom A5-V11 brackets or flexes

Challenges:

- Very low vertical clearance
- More custom fabrication
- More wiring
- More thermal planning
- Higher expectation for clean appearance

Best A5-V11 use:

- Internal Wi-Fi bridge
- UDPBD or UDPFS appliance
- Router-hosted USB storage
- Clean service connector
- RF shield heatsink mounting

---

## Mounting Location Goals

A good mounting location should have:

- Enough length and width
- Enough component height clearance
- Nearby 5 V power source
- Short Ethernet path
- Good antenna position
- Good heat path
- No contact with moving parts
- No pressure from shell
- No conflict with controller ports
- No conflict with fan
- No conflict with memory card slots
- Space for service wiring
- Space for thermal pad or heatsink
- Reasonable access during assembly

---

## Possible Mounting Locations

Possible locations depend on PS2 model and build style.

| Location | Pros | Cons |
|---|---|---|
| Near controller port area | Short path to front service access, good for compact builds | May conflict with controller ports or fan |
| Behind controller port near fan | Good hidden location in some Slims | Does not fit all Slim models |
| On or near RF shield | Good thermal path | Antenna may be blocked by metal |
| Above motherboard empty space | Easy in optical-drive-removed builds | Clearance depends on shell |
| Under removed optical drive area | Lots of space in no-disc builds | May need custom mounting plate |
| Near original Ethernet area | Short Ethernet path | May be crowded |
| External but hidden in expansion area | Easier access | Less clean internal build |

Every location should be tested with the exact PS2 model and board revision.

---

## Location 1: Near Controller Port Area

This location may be useful when the A5-V11 needs to sit near the front of the console.

Advantages:

- Can keep the board away from rear heat sources
- May allow service access if front shell is modified
- May have space in some Slim builds
- May be near other custom boards like BlueRetro or Button Butler

Disadvantages:

- May conflict with controller ports
- May conflict with memory card slots
- May conflict with fan area
- May be hard to route Ethernet cleanly
- May be crowded in builds with BlueRetro, SD2PSX, or other mods

Use this location only after checking full shell closure and controller-port clearance.

---

## Location 2: Behind Controller Port Beside Fan

This may be a preferred location in some Slim builds if the board fits.

Advantages:

- Hidden area
- Potentially good airflow nearby
- Can fit alongside other mods in some models
- May allow compact mounting

Disadvantages:

- Does not fit all Slim revisions
- Fan clearance must be preserved
- Wires must not touch fan blades
- Heat from nearby parts must be checked
- Antenna may need careful placement

Test with:

- RF shield installed
- Fan installed
- Shell closed
- Controller ports installed
- All screws tightened

---

## Location 3: Mounted To RF Shield

Mounting near or against the PS2 RF shield can be useful for thermal control.

Advantages:

- RF shield can act as a heat spreader
- Good mechanical base
- Can use thermal pad or copper spreader
- Can make the install cleaner
- Can provide a stable mounting plane

Disadvantages:

- RF shield is conductive
- Must prevent shorts
- Wi-Fi antenna may be blocked
- Thermal pad thickness matters
- Board height may become too tall
- Shell pressure can transfer into the PCB

If using the RF shield as a heat spreader, insulate all non-thermal contact areas.

---

## Location 4: Under Optical Drive Area

This location is best for no-disc or Ultra Slim builds.

Advantages:

- More space
- Easier to add USB storage
- Easier to add mounting plate
- Easier to service
- Less conflict with fan and controller ports

Disadvantages:

- Not available if optical drive remains installed
- Requires custom mounting plan
- May need shell modifications
- May affect aesthetics if external access is added

This is a strong candidate for builds where the optical drive is removed and games are loaded from other storage methods.

---

## Location 5: Near Original Ethernet Area

This can reduce Ethernet wiring length.

Advantages:

- Short Ethernet path
- Good for internal PS2-to-A5 wiring
- Keeps network hardware together
- May allow original Ethernet port reuse concepts

Disadvantages:

- Space may be limited
- Rear shell area may be crowded
- RF shield and port structures may interfere
- Antenna may be trapped near metal
- USB access may be harder

This location is most useful when Ethernet wiring is the main concern.

---

## A5-V11 Parts That Affect Fitment

The stock A5-V11 has several parts that may interfere with internal mounting.

| Part | Fitment Concern |
|---|---|
| RJ45 Ethernet jack | Tall and bulky |
| USB Type-A port | Tall and bulky |
| micro-USB port | May interfere with low-profile mounting |
| Electrolytic capacitors | Often too tall |
| Reset button | May hit shell or shield |
| LEDs | May hit shell depending on orientation |
| Antenna wire or trace | Must not be blocked or damaged |
| Heatsink | Adds height |
| UART wires | Need service path |
| Flash chip access | Hard after install |

For tight builds, the board may need connector removal, capacitor relocation, or a helper PCB/flex.

---

## Stock Connector Options

For internal mounting, each connector can be handled differently.

| Connector | Options |
|---|---|
| RJ45 Ethernet | Keep, remove, or wire to pads |
| USB Type-A | Keep, remove, or wire to internal USB storage |
| micro-USB | Keep, remove, or bypass with direct 5 V wiring |
| UART pads | Add service header or wires |
| Reset button | Keep, remove, relocate, or ignore |

Do not remove connectors until the board has been tested and a recovery plan exists.

---

## RJ45 Connector Fitment

The RJ45 connector is usually one of the tallest parts.

Options:

1. Keep RJ45 and use a short internal Ethernet cable.
2. Remove RJ45 and wire to cable-side pads.
3. Create an Ethernet adapter PCB.
4. Mount the board where RJ45 height does not matter.

Keeping the RJ45 is safest electrically.

Removing the RJ45 saves space but increases risk.

---

## USB Type-A Fitment

The USB Type-A connector is also bulky.

Options:

1. Keep it for removable USB storage.
2. Remove it and wire directly to internal USB storage.
3. Replace it with a low-profile connector.
4. Use no USB storage for bridge-only firmware.
5. Route USB to an accessible internal bay.

For UDPBD, UDPFS, or SMB server modes, USB storage access matters.

For bridge-only firmware, the USB port may not be needed.

---

## micro-USB Power Fitment

The micro-USB port is normally only for 5 V input.

Options:

1. Keep it and use a short internal USB power lead.
2. Remove it and wire 5 V/GND directly to the board.
3. Leave it unused and solder to alternate 5 V input points.
4. Add a dedicated internal power connector.

Direct wiring can save height, but it must be strain relieved and protected.

---

## Capacitor Fitment

The stock capacitors may be too tall for some internal PS2 installs.

Options:

- Leave stock capacitors if clearance allows
- Lay capacitors down
- Relocate capacitors with wires
- Use a helper PCB
- Use the Flipp'n Caps PCB/Flex
- Replace with lower-profile parts
- Test ceramic capacitor banks only after bench validation

Do not remove bulk capacitance without testing.

Bad capacitor changes can cause:

- Boot failure
- USB reset
- Wi-Fi instability
- Brownout behavior
- Warm reboot problems

---

## Flipp'n Caps PCB/Flex

The Flipp'n Caps PCB/Flex concept is meant to make capacitor relocation cleaner and more repeatable.

Possible goals:

- Lay tall capacitors flat
- Relocate capacitors to a lower-profile area
- Add a clean supervisor IC footprint
- Reduce hand wiring
- Improve PS2 fitment
- Make the A5-V11 sit closer to a mounting plate or RF shield
- Allow future flex versions after prototype testing

This should be treated as experimental until tested.

---

## Supervisor IC Fitment

A supervisor IC such as MAX809TTR or ADM809 may improve boot reliability.

Internal mounting should leave space for:

- Supervisor IC
- Reset wiring
- Decoupling capacitor if needed
- Clean ground connection
- Protected solder joints

Supervisor mod testing should include:

- Cold boot
- Warm reboot
- Rapid power cycle
- USB attached boot
- PS2-powered boot
- Closed-shell boot

---

## Heatsink Fitment

The RT5350F can run warm.

A heatsink may be useful, especially inside a PS2.

Options:

- Small stick-on heatsink
- Copper heat spreader
- Thermal pad to RF shield
- Copper plate soldered or mounted to board support
- Aluminum mounting plate used as heat spreader

Check:

- Shell clearance
- RF shield clearance
- No shorts
- Thermal pad compression
- Antenna placement
- Board flex
- Long-run temperature

---

## Using The RF Shield As A Heatsink

The PS2 RF shield can be used as a heat spreader if done carefully.

Possible stack:

```text
RT5350F
Thermal pad
Copper spreader or heatsink
Thermal pad
PS2 RF shield
```

or:

```text
RT5350F
Thermal pad
PS2 RF shield
```

Important:

- The RF shield is conductive.
- Only the intended thermal contact area should touch.
- Insulate all surrounding areas.
- Do not let solder joints touch the shield.
- Do not crush the board when the shell is closed.
- Test Wi-Fi signal because metal can block the antenna.

---

## Copper Mounting Plate Concept

A copper or aluminum plate can help mount the A5-V11 and spread heat.

Possible uses:

- Mounting base
- Heat spreader
- RF shield interface
- Mechanical stiffener
- Soldered bracket support
- Laser-cut mounting feature

Important:

- Copper is conductive.
- Insulate carefully.
- Avoid contact with exposed pads.
- Avoid creating antenna shielding problems.
- Do not make the board difficult to remove.

---

## Insulation Requirements

The A5-V11 must be insulated from conductive PS2 parts.

Use:

- Kapton tape
- Fish paper
- Thin FR4 sheet
- 3D printed mount
- Nylon washers
- Nylon standoffs
- Plastic spacers
- Heat-resistant insulating film

Do not rely on:

- Electrical tape alone for long-term builds
- Loose paper
- Foam that melts
- Hot glue as the only insulator
- Bare PCB resting on RF shield

---

## Mounting Hardware

Possible mounting methods:

| Method | Notes |
|---|---|
| Nylon standoffs | Good isolation |
| Brass standoffs | Strong but conductive, needs insulation |
| 3D printed bracket | Good for prototypes |
| Laser-cut plate | Good for repeatable builds |
| Copper plate | Good thermal path but conductive |
| Double-sided tape | Easy but not ideal for heat |
| VHB tape | Strong, but serviceability may suffer |
| Thermal adhesive | Permanent, risky |
| Screws through custom bracket | Strong and serviceable |
| Soldered copper tabs | Strong but requires careful design |

A good mount should be secure but still serviceable.

---

## Adhesive Warning

Avoid relying only on adhesive for final mounting.

Problems with adhesive:

- Can soften with heat
- Can fail over time
- Can make service difficult
- Can stress components during removal
- Can insulate heat instead of spreading it
- Can shift under shell pressure

Adhesive can be useful for prototypes, but mechanical retention is better for final builds.

---

## Serviceability

Internal mounting should allow future service.

Plan access to:

- UART
- Reset button or reset pads
- USB storage if used
- A5-V11 power wiring
- Ethernet wiring
- Flash chip if practical
- Antenna connection
- Mounting screws
- Firmware recovery path

A fully buried board with no UART and no recovery access is risky.

---

## UART Service Access

UART should remain accessible after installation.

Possible options:

- Hidden 3-pin service connector
- Pogo pads
- Small JST connector
- Pads near an access panel
- Wires tucked under removable cover
- Connection to Button Butler or controller board
- Temporary service cable stored internally

Minimum UART service connector:

| Pin | Signal |
|---:|---|
| 1 | GND |
| 2 | Router TX |
| 3 | Router RX |

Optional 4th pin:

| Pin | Signal |
|---:|---|
| 4 | 3.3 V sense only |

Do not expose power pins unless they are clearly labeled and protected.

---

## Reset Access

The stock reset button may become inaccessible.

Options:

- Leave it unused
- Relocate reset button
- Add hidden reset pads
- Add reset access hole
- Use firmware reboot only
- Use UART recovery
- Route reset to a controller board

If the reset button is required for recovery, do not bury it permanently.

---

## USB Storage Access

For UDPBD, UDPFS, or SMB server modes, USB storage access matters.

Options:

- Internal fixed USB flash drive
- Internal USB SSD
- Removable USB slot
- Removable microSD-to-USB adapter
- Hidden service bay
- External access through custom shell cutout
- No removable storage for bridge-only builds

Questions to answer:

- Does the user need to remove the drive?
- Does the drive need to be inserted before boot?
- Does hotplug work?
- Can the drive be updated over the network?
- Is the drive powered safely?
- Does the drive generate heat?
- Can the drive be serviced without full disassembly?

---

## Antenna Placement

Antenna placement is critical.

The A5-V11 has 2.4 GHz Wi-Fi only.

Internal PS2 metal shielding can reduce signal.

Good antenna placement:

- Near plastic shell
- Away from RF shield
- Away from large metal plates
- Away from power regulators
- Away from dense wiring
- Not sandwiched between metal surfaces
- Tested with shell closed

Poor antenna placement:

- Under RF shield
- Directly against metal
- Under copper heat spreader
- Next to noisy switching regulator
- Buried under other boards
- Wrapped around wires

---

## External Antenna Option

An external antenna mod may be useful.

Advantages:

- Better Wi-Fi range
- Less affected by PS2 RF shield
- More predictable signal
- Easier to test placement

Disadvantages:

- Adds visible hardware
- Requires drilling or shell modification
- Adds connector and cable
- Can hurt clean aesthetics
- Needs strain relief

A hidden internal antenna may be cleaner, but it must be tested.

---

## Power Planning

The A5-V11 normally expects 5 V input.

Possible internal power sources:

| Power Source | Notes |
|---|---|
| PS2 USB 5 V | Simple, but current may be limited |
| Internal 5 V rail | Must confirm current capacity |
| Dedicated buck regulator | Best for controlled power |
| Always-on auxiliary 5 V | Useful for router-ready-before-PS2 |
| External power input | Useful for development |
| Controller-managed power | Advanced, allows sequencing |

Measure current before final wiring.

---

## Power Source Questions

Answer these before final mounting:

- Should the router power on with the PS2?
- Should the router remain powered when the PS2 is off?
- Should the router boot before the PS2?
- Does USB storage need extra power?
- Is the 5 V rail stable?
- Is the power source noisy?
- Does the router brown out during Wi-Fi or USB use?
- Does the router backfeed the PS2 when always powered?
- Is there enough bulk capacitance?
- Is a supervisor IC needed?

---

## Power Wiring Guidelines

Good power wiring:

- Short 5 V wire
- Short ground wire
- Adequate wire gauge
- Solid solder joints
- Strain relief
- Good ground return
- Fuse or protection if appropriate
- Stable 5 V supply
- Tested under USB and Wi-Fi load

Avoid:

- Long thin power wires
- Sharing power with noisy loads without testing
- Routing power through weak switch contacts
- Powering USB storage from a marginal rail
- Unprotected wires near RF shield edges

---

## Ethernet Wiring Planning

Ethernet wiring should be planned with the mounting location.

Good Ethernet wiring:

- Short
- Twisted pairs
- Magnetics retained
- Strain relieved
- Routed away from power noise
- No pinching under RF shield
- Tested shell open and closed

Do not wire Ethernet as four random loose wires if it can be avoided.

Use a short section of Ethernet cable or twisted pairs.

---

## Wi-Fi Bridge Mounting Considerations

For Wi-Fi bridge mode, the most important internal mounting concerns are:

- Antenna placement
- Wi-Fi signal through closed shell
- Ethernet wiring to PS2
- Power stability
- Boot timing
- UART access
- Heat

USB storage may not be needed.

This can make the physical install simpler.

---

## UDPBD Mounting Considerations

For UDPBD mode, internal mounting must account for:

- USB storage
- USB power
- USB mount timing
- Router boot timing
- Ethernet stability
- Heat
- Storage access
- Correct OPL UDPBD build
- Service-ready indication
- Possibly no USB hotplug support

The USB drive may need to be inserted before the router powers on.

---

## UDPFS Mounting Considerations

For UDPFS mode, internal mounting must account for:

- Server software requirements
- Storage location
- Network mode
- USB or internal storage path
- Loader compatibility
- Boot timing
- Service startup
- Heat
- Power stability

UDPFS should be tested separately from UDPBD.

---

## SMB Mounting Considerations

For SMB1/OPL mode, internal mounting must account for:

- Samba memory use
- USB storage mount
- SMB1/NT1 compatibility
- Share path
- User/password or guest access
- Power draw
- Heat
- Boot timing
- Wi-Fi signal if bridging to another SMB server

SMB may be too heavy for stock 4 MB builds.

A 16 MB flash upgrade helps with space, but RAM is still limited.

---

## FTP Helper Mounting Considerations

For wLaunchELF FTP access, internal mounting mainly needs:

- Stable network path
- PC-to-PS2 reachability
- Bridge or routed mode clarity
- PS2 static IP or DHCP plan
- Wi-Fi signal
- Ethernet wiring
- Power stability

FTP is usually less storage-sensitive than UDPBD or SMB.

---

## RF Shield Clearance

Always test clearance with the RF shield installed.

Check:

- Does the A5-V11 touch the shield?
- Do solder joints touch the shield?
- Do wires get pinched?
- Does the thermal pad compress too much?
- Does the board flex?
- Does the shield block the antenna?
- Does the shell still close?
- Do screws tighten normally?

Use insulation wherever contact is possible.

---

## Shell Clearance

A shell that almost closes is not good enough.

The shell should close naturally.

Bad signs:

- Shell bulges
- Screws must force the shell down
- Board shifts when closing
- Wires get pinched
- Fan rubs
- Controller ports misalign
- Memory card slot misaligns
- Buttons feel wrong
- Shell creaks under pressure

If the shell does not close normally, fix the fitment before powering the build.

---

## Fan And Airflow Clearance

Do not block the PS2 fan or airflow path.

Check:

- Fan blade clearance
- Fan wire clearance
- Air path across heatsinks
- Intake and exhaust openings
- A5-V11 heat contribution
- Other mods near the fan

If the router is near the fan, secure all wires so they cannot move into the blades.

---

## Controller Port Clearance

If mounting near the controller ports, check:

- Controller plug insertion
- Memory card insertion
- Port PCB clearance
- Button/connector clearance
- BlueRetro wiring clearance
- Shell front alignment
- Screw post clearance

Do not let the A5-V11 or wiring interfere with controller port function.

---

## Optical Drive Clearance

If the optical drive remains installed, check:

- Disc clearance
- Laser sled movement
- Spindle clearance
- Ribbon cable movement
- Lid sensor parts
- Drive shield clearance
- Cable routing around the drive

Do not mount the A5-V11 where it can interfere with disc movement.

For no-disc builds, document that the optical drive is removed.

---

## Interaction With Other Mods

The A5-V11 may share space with other mods.

Possible conflicts:

- BlueRetro internal install
- SD2PSX or MMCE board
- ModBo modchip
- HDMI adapter
- Bluetooth audio board
- PowerOR or USB-C power board
- Button Butler
- Internal USB drive
- Fan mods
- LED wiring
- Chime circuit

Plan layout before wiring.

---

## Mounting Mock-Up

Before soldering final wires, mock up the install.

Use:

- Printed board outline
- Scrap PCB
- Cardboard template
- 3D printed dummy
- Actual A5-V11 with no power
- Calipers
- Kapton tape
- RF shield
- Shell halves

Check fitment before committing.

---

## Measurements To Record

Record these measurements.

| Measurement | Value |
|---|---:|
| A5-V11 PCB length |  |
| A5-V11 PCB width |  |
| Max stock component height |  |
| Max height after cap mod |  |
| Max height with heatsink |  |
| Clearance to RF shield |  |
| Clearance to shell |  |
| Distance to fan |  |
| Distance to controller port |  |
| Ethernet wire length |  |
| Power wire length |  |
| Antenna wire length |  |
| USB storage clearance |  |

---

## Mounting Location Template

Use this template for each location tested.

```text
# Mounting Location Test

PS2 model:
Motherboard revision:
A5-V11 board ID:
A5-V11 firmware:
Optical drive installed:
Other mods installed:

Location:
Orientation:
Mounting method:
RF shield clearance:
Shell clearance:
Fan clearance:
Controller port clearance:
Antenna position:
Power source:
Ethernet route:
USB storage route:
UART access:
Thermal path:
Result:
Notes:
```

---

## Internal Mounting Test Table

| Test | Result | Notes |
|---|---|---|
| Board fits location |  |  |
| RF shield clears |  |  |
| Shell closes naturally |  |  |
| No shorts to shield |  |  |
| Fan path clear |  |  |
| Controller ports clear |  |  |
| Memory card slots clear |  |  |
| Optical drive clears, if installed |  |  |
| Antenna usable |  |  |
| UART accessible |  |  |
| USB storage accessible, if used |  |  |
| Power wires strain relieved |  |  |
| Ethernet wires strain relieved |  |  |
| Thermal path tested |  |  |

---

## First Internal Power Test

Before connecting to the PS2 Ethernet or USB storage, test power.

Steps:

1. Inspect for shorts.
2. Confirm insulation.
3. Confirm 5 V and GND wiring.
4. Power the PS2 or test supply.
5. Measure voltage at the A5-V11.
6. Watch current draw.
7. Watch UART boot log.
8. Check for heat.
9. Power off.
10. Inspect again.

Record:

| Item | Result |
|---|---|
| 5 V measured before connection |  |
| 5 V measured at A5-V11 |  |
| Boot current |  |
| Idle current |  |
| UART boot normal |  |
| Excess heat |  |
| Any smell or smoke |  |
| Notes |  |

---

## First Internal Ethernet Test

After power is stable:

1. Connect Ethernet wiring.
2. Confirm continuity.
3. Confirm no shorts.
4. Power router and PS2.
5. Check Ethernet link.
6. Check UART logs.
7. Test ping if possible.
8. Test wLaunchELF FTP or loader network test.
9. Move shell gently.
10. Confirm link remains stable.

Do not close the shell until Ethernet works reliably open.

---

## First Internal Wi-Fi Test

If Wi-Fi is used:

1. Test with shell open.
2. Record RSSI.
3. Test with RF shield installed.
4. Record RSSI.
5. Test with shell closed.
6. Record RSSI.
7. Test file transfer or ping.
8. Test at normal room distance.
9. Test near and far from home access point.

Record:

| Test State | RSSI | Result | Notes |
|---|---:|---|---|
| Shell open |  |  |  |
| RF shield installed |  |  |  |
| Shell closed |  |  |  |
| Normal use distance |  |  |  |
| Weak signal area |  |  |  |

---

## First Internal USB Storage Test

If USB storage is used:

1. Connect storage.
2. Confirm power draw.
3. Boot router with drive inserted.
4. Confirm `/dev/sda1` or expected device appears.
5. Confirm mount path.
6. Confirm service starts.
7. Confirm PS2 loader sees content.
8. Test warm reboot.
9. Test cold boot.
10. Test closed shell.

Record:

| Item | Result |
|---|---|
| USB drive detected |  |
| USB drive mounted |  |
| Filesystem supported |  |
| Service starts |  |
| PS2 sees service |  |
| Drive accessible after reboot |  |
| Hotplug supported |  |
| Drive temperature acceptable |  |

---

## Closed-Shell Test

The closed-shell test is required.

Steps:

1. Confirm open-shell test passes.
2. Install RF shield.
3. Route all wires.
4. Close the shell without forcing it.
5. Tighten screws normally.
6. Power on.
7. Confirm router boots.
8. Confirm Ethernet link.
9. Confirm Wi-Fi signal, if used.
10. Confirm USB storage, if used.
11. Launch PS2 test.
12. Run for at least 30 minutes.
13. Reboot and repeat.

Pass criteria:

- Shell closes naturally
- No shorts
- No pinched wires
- No fan contact
- No Ethernet dropouts
- No Wi-Fi dropouts
- No USB disconnects
- No thermal failure
- No boot timing failure

---

## Long-Run Test

A final internal build should pass long-run testing.

Suggested tests:

| Test | Duration |
|---|---:|
| Router idle inside closed shell | 1 hour |
| Wi-Fi connected inside closed shell | 1 hour |
| USB storage mounted | 1 hour |
| Target service running | 1 hour |
| PS2 game or loader idle | 1 hour |
| Final confidence test | 4 hours |
| Optional extended test | 24 hours |

Record temperature and stability.

---

## Boot Cycle Test

Run repeated boot tests.

| Test | Count | Pass |
|---|---:|---|
| Cold boot | 10 |  |
| Warm reboot | 10 |  |
| PS2 reset | 5 |  |
| Power off for 5 seconds, power on | 5 |  |
| Power off for 30 seconds, power on | 5 |  |
| Boot with USB attached | 10 |  |
| Boot with shell closed | 10 |  |

If the router fails after rapid power cycles, consider supervisor IC or power sequencing changes.

---

## Backfeed Test

If the A5-V11 can remain powered while the PS2 is off, test for backfeed.

| Test | Result |
|---|---|
| PS2 off, router on |  |
| PS2 power LED normal |  |
| No faint LEDs |  |
| No partial power |  |
| No unexpected current draw |  |
| Ethernet behavior normal |  |
| PS2 powers on normally |  |
| PS2 powers off normally |  |

Backfeed must be solved before final assembly.

---

## Thermal Test

Measure temperatures.

| Location | Temperature |
|---|---:|
| Room ambient |  |
| RT5350F |  |
| A5-V11 flash chip |  |
| A5-V11 RAM chip |  |
| A5-V11 regulator area |  |
| USB storage |  |
| PS2 RF shield near router |  |
| PS2 shell above router |  |
| PS2 main heatsink |  |

Test states:

| State | Result |
|---|---|
| Shell open idle |  |
| Shell closed idle |  |
| Shell closed active transfer |  |
| Shell closed gameplay |  |
| After warm reboot |  |

---

## Final Internal Mounting Checklist

Before calling the install finished:

| Check | Done |
|---|---|
| Board identified |  |
| Firmware known-good |  |
| Full flash backup saved |  |
| Factory partition saved |  |
| UART access retained |  |
| Power source tested |  |
| Current draw measured |  |
| Ethernet tested |  |
| Wi-Fi tested, if used |  |
| USB tested, if used |  |
| Boot timing measured |  |
| Antenna placement tested |  |
| Thermal test passed |  |
| Closed-shell test passed |  |
| Backfeed test passed, if always powered |  |
| Wires strain relieved |  |
| RF shield insulated |  |
| Shell closes naturally |  |
| Photos taken |  |
| Build notes updated |  |

---

## Internal Mounting Documentation Template

Use this template for each completed install.

```text
# A5-V11 Internal Mounting Record

## PS2

Model:
Motherboard revision:
Build name:
Optical drive installed:
Other mods:

## A5-V11

Board ID:
PCB marking:
RAM:
Flash:
Firmware:
Firmware role:
Antenna mod:
Capacitor mod:
Supervisor IC:
Heatsink:

## Mounting

Location:
Orientation:
Mounting hardware:
Insulation:
RF shield contact:
Thermal pad:
Shell clearance:
Fan clearance:
Controller port clearance:

## Wiring

Power source:
Power wire length:
Ethernet method:
Ethernet wire length:
USB storage:
UART service connector:
Reset access:
Antenna location:

## Testing

Cold boot:
Warm reboot:
Ethernet:
Wi-Fi:
USB:
Service:
PS2 loader:
Boot delay:
Thermal:
Closed-shell:
Backfeed:
Long-run:

## Result

Status:
Known issues:
Photos:
Notes:
```

---

## Suggested Photos

Take photos of:

- Empty PS2 mounting area
- A5-V11 before modification
- A5-V11 after capacitor changes
- A5-V11 with heatsink or thermal pad
- Mounting bracket or plate
- Insulation layer
- Ethernet wiring
- Power wiring
- UART service connector
- USB storage location
- Antenna location
- RF shield clearance
- Shell closed
- Final build

Suggested file names:

```text
internal-mount-board001-location.jpg
internal-mount-board001-a5v11-before.jpg
internal-mount-board001-a5v11-modified.jpg
internal-mount-board001-ethernet-wiring.jpg
internal-mount-board001-power-wiring.jpg
internal-mount-board001-uart-service.jpg
internal-mount-board001-antenna.jpg
internal-mount-board001-rf-shield-clearance.jpg
internal-mount-board001-final.jpg
```

---

## Common Internal Mounting Problems

### Problem: Shell Does Not Close

Possible causes:

- Capacitors too tall
- RJ45 too tall
- USB port too tall
- Heatsink too tall
- Wires routed poorly
- Mounting bracket too thick
- RF shield interference

Fixes:

- Relocate capacitors
- Remove unused connectors
- Use thinner mounting plate
- Reroute wires
- Change mounting location
- Use lower-profile heatsink
- Modify RF shield carefully

### Problem: Router Works Open But Fails Closed

Possible causes:

- RF shield short
- Shell pressure on board
- Wi-Fi antenna blocked
- Wires pinched
- Board flexing
- Heat buildup
- USB drive pressure
- Fan airflow blocked

Fixes:

- Add insulation
- Add clearance
- Move antenna
- Reroute wires
- Improve thermal path
- Use thinner parts
- Check closed-shell temperature

### Problem: Wi-Fi Range Is Poor Inside PS2

Possible causes:

- Antenna under RF shield
- Antenna near metal
- Antenna disconnected
- Router orientation bad
- External antenna needed
- PS2 shell or shield blocks signal

Fixes:

- Move antenna near plastic shell
- Repair antenna path
- Add external antenna
- Test shell open and closed
- Keep antenna away from heat spreaders

### Problem: Router Gets Too Hot

Possible causes:

- No heatsink
- Poor airflow
- RF shield traps heat
- USB storage adds heat
- Unused PHYs enabled
- Too many services running
- Closed-shell heat soak

Fixes:

- Add heatsink
- Use RF shield as heat spreader
- Disable unused PHYs
- Reduce services
- Move board
- Improve thermal pad contact
- Test longer

### Problem: USB Storage Drops Out

Possible causes:

- Weak 5 V source
- USB drive current draw
- Long power wiring
- Not enough capacitance
- Heat
- Bad connector
- Firmware mount issue
- Hotplug unsupported

Fixes:

- Use lower-power drive
- Add stable 5 V regulator
- Improve wiring
- Add bulk capacitance
- Boot with drive inserted
- Improve mount scripts
- Test with different drive

### Problem: Ethernet Drops Or No Link

Possible causes:

- Untwisted wires
- Pairs split
- Wiring too long
- Wrong straight/crossover wiring
- Bad solder joint
- RF shield pinch
- Magnetics bypassed
- Wrong interface config

Fixes:

- Use short twisted pairs
- Test external cable first
- Check continuity
- Check pair assignment
- Test straight-through and crossover
- Keep magnetics
- Reroute wires
- Check OpenWrt interface name

### Problem: Router Does Not Boot After PS2 Power Cycle

Possible causes:

- Reset timing issue
- Power ramp issue
- Brownout
- USB drive load
- Capacitor changes
- Need supervisor IC
- Rapid power cycle problem

Fixes:

- Test from bench supply
- Add supervisor IC
- Improve power rail
- Add proper bulk capacitance
- Avoid rapid cycling
- Add startup delay
- Use always-on or pre-boot power

---

## Recommended Mounting Philosophy

A good internal install should feel like part of the console.

It should not be:

- Loose
- Rattling
- Pressed against the shell
- Shorting against the RF shield
- Impossible to service
- Dependent on one lucky wire position
- Unrecoverable if firmware fails

A clean internal install should have:

- Planned location
- Solid mount
- Insulation
- Strain relief
- Thermal path
- Antenna plan
- UART service access
- Documented wiring
- Repeatable test results

---

## Condensed Summary

Internal mounting of the A5-V11 inside a PS2 is possible, but it requires careful planning.

Before final assembly:

- Test the router externally.
- Back up the flash.
- Keep UART access.
- Plan power.
- Plan Ethernet.
- Plan antenna placement.
- Plan heat removal.
- Insulate from the RF shield.
- Keep wires short and strain relieved.
- Test with the shell closed.
- Document everything.

The best internal mount is not just the one that fits.

The best internal mount is the one that still works, stays cool, can be serviced, and survives real PS2 use.

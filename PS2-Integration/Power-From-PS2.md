# Power From PS2

## Summary

This document covers powering the A5-V11 mini router from a PlayStation 2.

The A5-V11 normally expects 5 V input through its micro-USB power port. For an internal PS2 install, that 5 V can come from several possible sources inside or around the console.

Power planning matters because the A5-V11 is not just a passive adapter. It is a tiny Linux router with Wi-Fi, Ethernet, USB host, flash storage, RAM, and startup timing requirements.

A poor power source can cause:

- Failed boot
- Random resets
- USB storage disconnects
- Wi-Fi instability
- Ethernet dropouts
- UDPBD failure
- SMB failure
- Boot timing problems
- Warm reboot problems
- Brownout behavior
- Backfeed into the PS2

---

## Main Rule

The main rule is:

```text
Power the A5-V11 from a stable 5 V source that can handle the router, Wi-Fi activity, and any USB storage load.
```

Do not assume a PS2 power point is safe or strong enough until it is measured.

---

## Important Warning

Before powering the A5-V11 from the PS2:

- Back up the A5-V11 flash.
- Confirm UART works.
- Test the A5-V11 from an external 5 V supply first.
- Measure current draw on the bench.
- Test with the exact firmware.
- Test with the exact USB storage device, if used.
- Check for voltage sag.
- Check for heat.
- Check for backfeed.
- Confirm the PS2 still powers on and off normally.

Do not permanently wire power until the bench setup is proven.

---

## A5-V11 Power Input

The stock A5-V11 is normally powered by 5 V through the micro-USB connector.

| Item | Value |
|---|---|
| Normal input voltage | 5 V |
| Stock connector | micro-USB |
| Power type | DC input |
| Data over micro-USB | Normally not used |
| Internal project wiring | 5 V and GND direct wiring possible after testing |

The micro-USB port should be treated as power input only unless a specific board has been reverse engineered differently.

---

## Do Not Power From 3.3 V Unless Fully Verified

The A5-V11 board has onboard power regulation.

Do not assume it can be powered directly from 3.3 V.

Bad assumption:

```text
PS2 3.3 V rail -> A5-V11 3.3 V point
```

Recommended approach:

```text
Stable 5 V source -> A5-V11 normal 5 V input path
```

Only use a 3.3 V power point if the board has been fully reverse engineered and tested.

---

## Possible PS2 Power Sources

Possible power sources include:

| Power Source | Description |
|---|---|
| PS2 USB 5 V | Use the PS2 USB port 5 V rail |
| Internal 5 V rail | Tap a known internal 5 V supply point |
| Dedicated buck regulator | Convert PS2 input voltage down to 5 V |
| Always-on auxiliary 5 V | Keep router powered even when PS2 is off |
| External 5 V input | Separate external power for router |
| Controller-managed power | Power router first, then PS2 |

Each option has tradeoffs.

---

## Option 1: Power From PS2 USB 5 V

This is the simplest idea.

The A5-V11 can be powered from the PS2 USB 5 V rail if the rail can supply enough current.

Basic concept:

```text
PS2 USB 5 V -> A5-V11 5 V input
PS2 USB GND -> A5-V11 GND
```

Advantages:

- Simple
- Uses an existing 5 V source
- Router powers on with the console
- Router powers off with the console
- Easy for early testing
- No extra regulator required if current is sufficient

Disadvantages:

- PS2 USB current may be limited
- USB storage may draw too much current
- Router starts at the same time as the PS2
- PS2 loader may start before router is ready
- Voltage sag may cause unreliable boot
- Not ideal if router needs to be accessible while PS2 is off

---

## PS2 USB Power Use Cases

Powering from PS2 USB may work best for:

- Wi-Fi bridge only
- FTP helper bridge
- Ethernet-only router testing
- No USB storage attached to A5-V11
- Small low-power USB flash drive only
- Builds where manual launch delay is acceptable

It may be less ideal for:

- USB SSD
- USB hard drive
- Router-hosted SMB
- UDPBD with high USB load
- UDPFS with high USB load
- Always-on router access
- Router-ready-before-PS2 workflows

---

## Option 2: Power From Internal 5 V Rail

The PS2 has internal voltage rails, but the exact locations and current capacity depend on model and board revision.

Basic concept:

```text
PS2 internal 5 V rail -> A5-V11 5 V input
PS2 ground -> A5-V11 ground
```

Advantages:

- Can be cleaner than using USB port wiring
- May provide better current than the USB connector
- Can be routed internally
- Can avoid sacrificing an external USB port

Disadvantages:

- Must identify the correct rail
- Must confirm current capacity
- May be noisy
- May be switched with console power
- Can cause damage if tapped incorrectly
- Requires careful board-specific documentation

Use a multimeter and test under load before committing.

---

## Option 3: Dedicated 5 V Buck Regulator

A dedicated buck regulator can convert the PS2 input voltage or another internal voltage to a stable 5 V for the A5-V11.

Basic concept:

```text
PS2 input voltage or internal rail -> buck regulator -> stable 5 V -> A5-V11
```

Advantages:

- Better controlled power
- Can supply router and USB storage
- Can reduce stress on PS2 USB rail
- Good for advanced internal builds
- Easier to size for worst-case load
- Can include filtering and protection

Disadvantages:

- Requires extra board or module
- Adds heat
- Adds switching noise
- Needs proper grounding and layout
- Needs testing near Ethernet and Wi-Fi
- Takes space inside the console

This is often the best long-term solution for router-hosted USB storage.

---

## Option 4: Always-On Auxiliary 5 V

In this setup, the A5-V11 remains powered even when the PS2 is off.

Basic concept:

```text
Always-on 5 V -> A5-V11
PS2 can be off while router remains on
```

Advantages:

- Router can boot before PS2
- Router can stay service-ready
- PC may access router storage while PS2 is off
- Wi-Fi bridge can already be connected
- OPL or loader does not need to wait as long
- Better user experience for advanced builds

Disadvantages:

- Adds standby power draw
- Adds heat while PS2 is off
- Requires backfeed testing
- May partially power the PS2 through signal lines
- More complex
- Requires long-run stability testing

Do not use always-on power until backfeed is tested.

---

## Option 5: External 5 V Power

The A5-V11 can be powered from an external 5 V supply during development.

Advantages:

- Easiest for bench testing
- Avoids loading PS2 power rails
- Lets router boot before PS2
- Useful for debugging
- Useful for firmware recovery
- Useful for measuring router-only current

Disadvantages:

- Not as clean for final internal builds
- Requires another cable
- User may forget to power both devices
- Grounding and Ethernet behavior should still be checked

External power is recommended for early development.

---

## Option 6: Controller-Managed Power

A controller board can power the A5-V11 first, wait for it to become ready, then power or release the PS2.

Basic concept:

```text
Power button pressed
Controller powers A5-V11
Controller waits for delay or ready signal
Controller powers PS2
PS2 boots after router is ready
```

Advantages:

- Cleanest advanced behavior
- Solves boot timing problem
- Can integrate with Button Butler
- Can use ready LED or ready GPIO
- Can hide router boot time from the user

Disadvantages:

- More complex
- Requires extra hardware
- Requires safe PS2 power control
- Requires reliable firmware ready state
- Requires more testing

This is an advanced option, not the first prototype method.

---

## Power Source Comparison

| Power Source | Simple | Stable | Allows Router Before PS2 | Good For USB Storage | Main Risk |
|---|---|---|---|---|---|
| PS2 USB 5 V | Yes | Maybe | No | Maybe | Current limit |
| Internal 5 V rail | Medium | Maybe | Usually no | Maybe | Wrong tap point |
| Dedicated buck | Medium | Yes if designed well | Maybe | Yes | Extra heat/noise |
| Always-on 5 V | No | Yes if designed well | Yes | Yes | Backfeed |
| External 5 V | Yes | Yes | Yes | Yes | Extra cable |
| Controller-managed | No | Yes if designed well | Yes | Yes | Complexity |

---

## Current Draw Planning

The A5-V11 current draw depends on:

- Firmware
- Wi-Fi enabled or disabled
- Ethernet link active
- USB storage connected
- USB storage type
- CPU load
- SMB/UDPBD/UDPFS activity
- Unused PHYs enabled or disabled
- Heat
- Board variation

Do not rely only on expected values.

Measure the actual board.

---

## Current Draw Test Table

| Test State | Voltage | Current | Power | Notes |
|---|---:|---:|---:|---|
| A5-V11 boot, no USB |  |  |  |  |
| Idle, Ethernet only |  |  |  |  |
| Idle, Wi-Fi connected |  |  |  |  |
| Ethernet transfer |  |  |  |  |
| Wi-Fi transfer |  |  |  |  |
| USB flash drive idle |  |  |  |  |
| USB flash drive active |  |  |  |  |
| USB SSD idle |  |  |  |  |
| USB SSD active |  |  |  |  |
| UDPBD active |  |  |  |  |
| SMB active |  |  |  |  |
| UDPFS active |  |  |  |  |
| Closed-shell test |  |  |  |  |

Power calculation:

```text
Power in watts = Voltage x Current
```

Example:

```text
5.0 V x 0.250 A = 1.25 W
```

---

## USB Storage Current

USB storage can draw more current than the router itself.

Possible storage loads:

| Storage Type | Power Concern |
|---|---|
| Small USB flash drive | Usually lowest risk |
| Large USB flash drive | Can draw more than expected |
| USB SSD | Startup and active current can be significant |
| USB HDD | Often too much for weak internal power |
| USB card reader | Depends on card and adapter |
| microSD-to-USB adapter | Usually low power, but test it |

For UDPBD, UDPFS, or SMB server modes, test the router with the exact storage device attached.

---

## USB Storage Power Rule

Use this rule:

```text
If USB storage is connected to the A5-V11, measure current with the storage active.
```

Do not test the router alone and assume the storage load will be fine.

---

## PS2 USB Port Current Warning

The PS2 USB port was not designed to power an internal Wi-Fi router plus storage device.

It may work for the router alone.

It may not work reliably for:

- Router plus USB flash drive
- Router plus USB SSD
- Router plus USB HDD
- Router plus Wi-Fi under load
- Router plus SMB or UDPBD active transfer

Treat PS2 USB power as limited until tested.

---

## Powering Through The A5-V11 USB Type-A Port

The A5-V11 USB Type-A port is normally a USB host port.

Do not power the router through the USB Type-A port unless the board has been traced and tested.

Possible problems:

- Backfeeding the USB VBUS rail
- Powering the board through an unintended path
- Damaging attached USB storage
- Confusing host/device roles
- Creating unstable boot behavior
- Bypassing input filtering
- Causing reverse current into the PS2 or storage device

Recommended power input:

```text
Use the normal 5 V input path.
```

That usually means the micro-USB 5 V input or a direct solder point on the same 5 V input rail.

---

## Direct 5 V Wiring To The A5-V11

For internal installs, it may be cleaner to bypass the micro-USB connector.

Recommended concept:

```text
PS2 or regulator 5 V -> A5-V11 5 V input rail
PS2 or regulator GND -> A5-V11 GND
```

Important:

- Use the correct 5 V input point.
- Do not solder to a random pad without tracing it.
- Add strain relief.
- Use adequate wire gauge.
- Keep wires short.
- Add insulation.
- Test continuity before power.
- Test voltage before connecting router.
- Power up with current limiting if possible.

---

## Recommended Wire Colors

Suggested convention:

| Signal | Color |
|---|---|
| 5 V | Red |
| GND | Black |
| Switched enable | Yellow |
| Always-on 5 V | Orange |
| Ready signal | Blue |
| Reset/control | White |

This is only a convention.

Always label wires and verify with a meter.

---

## Wire Gauge

For short internal 5 V wiring, use wire that can comfortably handle the measured current.

Suggested minimum:

| Use | Suggested Wire |
|---|---|
| Router only | 26 AWG to 24 AWG |
| Router plus USB flash drive | 24 AWG |
| Router plus USB SSD | 24 AWG to 22 AWG |
| Longer run or higher current | 22 AWG or larger |

Keep power and ground wires short.

Avoid thin wire-wrap wire for power.

---

## Grounding

The A5-V11 ground must connect to the PS2 ground if powered internally.

Good grounding:

- Short ground path
- Solid solder joint
- Adequate wire size
- Ground return close to 5 V supply path
- No loose ground wires
- No reliance on shield contact only

Do not use the RF shield as the only ground return.

Use a real ground wire.

---

## Fuse Or Protection

Consider protection for internal power wiring.

Possible options:

- Small fuse
- Polyfuse
- Current-limited regulator
- Series ferrite bead
- Reverse-current protection
- Power switch or load switch

Benefits:

- Protects PS2 power rail
- Helps isolate faults
- Makes testing safer
- Reduces damage risk from shorts

For early testing, a current-limited bench supply is strongly recommended.

---

## Power Switch Or Load Switch

A load switch can control power to the A5-V11.

Possible uses:

- Turn router on with PS2
- Delay router power
- Power router before PS2
- Disable router for service
- Prevent backfeed
- Let controller board manage router power

A load switch is better than relying on long power wires or manual unplugging.

---

## Common Power Modes

## Mode 1: Switched With PS2

The router powers on and off with the PS2.

```text
PS2 on  -> A5-V11 on
PS2 off -> A5-V11 off
```

Advantages:

- Simple
- No standby heat
- No standby current
- Lower backfeed risk

Disadvantages:

- Router boot time may delay PS2 use
- Loader may start too early
- USB storage may not be ready

Best for:

- Simple builds
- Bridge-only setups
- Manual launch workflows

---

## Mode 2: Always On

The router stays on when the PS2 is off.

```text
PS2 off -> A5-V11 still on
PS2 on  -> A5-V11 already ready
```

Advantages:

- Router is ready before PS2 boots
- PC can access router while PS2 is off
- Wi-Fi bridge remains connected
- Less boot timing trouble

Disadvantages:

- Backfeed risk
- Heat while console is off
- Standby current
- More complex
- Requires long-run testing

Best for:

- Advanced builds
- Router-hosted storage
- Button Butler-style systems
- Builds where off-console access is desired

---

## Mode 3: Pre-Boot Router

The router powers first, then the PS2 powers after a delay.

```text
Power request
A5-V11 powers on
Wait for service-ready
PS2 powers on
```

Advantages:

- Solves boot timing cleanly
- Router does not need to stay on forever
- Good polished behavior

Disadvantages:

- Requires controller board
- Requires PS2 power control
- Requires timing or ready signal
- More complex

Best for:

- Premium internal builds
- Touchscreen/controller-managed systems
- Future Button Butler integration

---

## Boot Timing Impact

Power method affects boot timing.

If the router powers on at the same time as the PS2, the PS2 may reach OPL or another loader before the router is ready.

Possible result:

```text
Router still booting
PS2 loader starts
Games list empty
User thinks firmware failed
```

Fixes:

- Wait before launching loader
- Launch loader manually
- Add boot delay
- Power router before PS2
- Keep router always powered
- Add service-ready LED
- Add ready GPIO to controller board

---

## Recommended Delay Testing

If the router powers with the PS2, test these launch delays:

| Delay Before Loader | Result |
|---:|---|
| 0 seconds |  |
| 15 seconds |  |
| 30 seconds |  |
| 45 seconds |  |
| 60 seconds |  |
| 90 seconds |  |

For many early tests, use:

```text
Wait 60 seconds before launching OPL or the target loader.
```

Then reduce delay after the setup is stable.

---

## Service-Ready Power Test

Record when the router becomes ready.

| Event | Time From Power-On |
|---|---:|
| First UART output |  |
| Kernel starts |  |
| Ethernet ready |  |
| Wi-Fi ready |  |
| USB detected |  |
| USB mounted |  |
| Service started |  |
| Service ready |  |

A power source is not proven until the router reaches service-ready reliably.

---

## Voltage Stability Test

Measure voltage at the A5-V11, not only at the source.

| Test | Voltage At Source | Voltage At A5-V11 | Result |
|---|---:|---:|---|
| Router off |  |  |  |
| Router boot |  |  |  |
| Router idle |  |  |  |
| Wi-Fi active |  |  |  |
| Ethernet transfer |  |  |  |
| USB storage startup |  |  |  |
| USB storage active |  |  |  |
| PS2 reset |  |  |  |
| Closed-shell active |  |  |  |

Watch for voltage sag during:

- Router boot
- Wi-Fi association
- USB drive startup
- Active file transfer
- PS2 power-on
- PS2 reset

---

## Brownout Symptoms

Possible brownout symptoms:

- Router resets
- Router boot loops
- Red and blue LEDs stuck
- UART log restarts
- USB drive disconnects
- Wi-Fi drops
- Ethernet link drops
- OPL games list disappears
- SMB share disconnects
- UDPBD stops
- Router works without USB but fails with USB
- Router works from bench supply but fails from PS2 power

If these happen, improve the 5 V supply before blaming firmware.

---

## Capacitor Support

The A5-V11 has onboard capacitors that support power stability.

If capacitors are relocated or replaced for fitment, retest power stability.

Do not reduce bulk capacitance without testing.

Capacitor changes can affect:

- Boot reliability
- USB storage startup
- Wi-Fi transmit stability
- Warm reboot behavior
- Rapid power cycle behavior
- Brownout margin

---

## Supervisor IC Support

A reset supervisor IC may improve startup reliability.

Possible parts:

- MAX809TTR
- ADM809
- Similar voltage supervisor

A supervisor can help if:

- Router fails after rapid power cycle
- Router hangs after warm reboot
- Power ramp is slow
- Brownout behavior is unreliable
- USB drive startup causes reset problems

Supervisor testing should compare behavior before and after the mod.

---

## Supervisor Test Table

| Test | Without Supervisor | With Supervisor |
|---|---|---|
| Cold boot |  |  |
| Warm reboot |  |  |
| Rapid power cycle |  |  |
| USB attached boot |  |  |
| PS2-powered boot |  |  |
| Closed-shell boot |  |  |

Mark the supervisor mod useful only after repeated tests.

---

## Backfeed Testing

Backfeed happens when one powered device partially powers another through signal or power lines.

If the A5-V11 is powered while the PS2 is off, test for backfeed.

Possible backfeed paths:

- Ethernet lines
- USB lines
- UART lines
- GPIO lines
- Shared 5 V rail
- Shared 3.3 V rail
- Controller board lines
- LEDs or status lines

---

## Backfeed Symptoms

Possible symptoms:

- PS2 power LED glows faintly
- PS2 partially powers up
- Ethernet link acts strange
- PS2 will not fully turn off
- Unexpected current draw
- A5-V11 changes behavior when PS2 is connected
- PS2 power button response changes
- Console makes noise or warms while off

Do not finalize an always-on router design if backfeed exists.

---

## Backfeed Test Table

| Test | Result |
|---|---|
| PS2 off, A5-V11 on |  |
| PS2 LEDs remain normal/off |  |
| No faint glow |  |
| No partial power |  |
| No unexpected current draw |  |
| PS2 powers on normally |  |
| PS2 powers off normally |  |
| Ethernet behavior normal |  |
| USB behavior normal |  |
| UART does not backfeed |  |
| GPIO/control lines isolated |  |

---

## Isolation Options

If backfeed occurs, possible fixes include:

- Power switch/load switch
- Diode OR-ing
- Ideal diode controller
- MOSFET power switch
- Signal isolation
- Series resistors on signal lines
- Keep router switched with PS2
- Disconnect unused USB lines
- Avoid shared always-on signal paths
- Use Ethernet magnetics correctly

Do not use a fix blindly.

Test after every change.

---

## Powering Router While PS2 Is Off

If the goal is to access the A5-V11 while the PS2 is off, document exactly what should remain active.

Possible desired behavior:

| Feature | Active While PS2 Off |
|---|---|
| A5-V11 web UI | Yes or no |
| Wi-Fi connection | Yes or no |
| USB storage share | Yes or no |
| SMB server | Yes or no |
| UDPBD server | Yes or no |
| Ethernet link to PS2 | Usually no useful PS2 activity |
| PS2-side Ethernet PHY | Depends on console state |
| Controller board | Yes or no |

If the PS2 Ethernet side is off, the router may still be reachable over Wi-Fi but may not have a useful PS2 link.

---

## PS2-Off Network Behavior

When the PS2 is off:

- The A5-V11 may still be reachable over Wi-Fi if always powered.
- The A5-V11 may still host USB storage if powered.
- The PS2 Ethernet port may not be active.
- The router may not be able to communicate with the PS2.
- Backfeed must be checked.

This behavior should be documented per build.

---

## USB Storage While PS2 Is Off

If the router stays on and hosts USB storage while the PS2 is off, test:

- Can PC access storage?
- Does storage stay mounted?
- Does storage sleep?
- Does storage overheat?
- Can PS2 later boot and use the same storage?
- Does the service recover after PS2 power-on?
- Does the drive need a keepalive file?
- Does the router stay stable for hours?

Always test long-run behavior.

---

## Heat While Powered Off

If the A5-V11 remains powered while the PS2 is off, heat still matters.

Test:

| Test | Result |
|---|---|
| 1 hour idle, PS2 off |  |
| 4 hour idle, PS2 off |  |
| 24 hour idle, PS2 off |  |
| Shell temperature |  |
| USB drive temperature |  |
| Wi-Fi stability |  |
| Router still reachable |  |

Always-on router installs should include standby thermal testing.

---

## Power From PS2 USB Test Procedure

Use this procedure for early testing.

1. Test A5-V11 from external 5 V first.
2. Measure router current without USB storage.
3. Measure router current with USB storage.
4. Identify PS2 USB 5 V and GND.
5. Confirm voltage with PS2 on.
6. Confirm voltage with PS2 off.
7. Connect A5-V11 power through a current meter if possible.
8. Boot PS2 and A5-V11.
9. Watch UART boot log.
10. Measure voltage at A5-V11 during boot.
11. Test Ethernet.
12. Test Wi-Fi if used.
13. Test USB storage if used.
14. Launch PS2 loader after delay.
15. Repeat cold boot and warm reboot tests.

---

## Dedicated Buck Regulator Test Procedure

Use this procedure for a dedicated 5 V regulator.

1. Choose regulator with enough current margin.
2. Test regulator on bench.
3. Load test regulator at expected current.
4. Check output voltage.
5. Check ripple if possible.
6. Check heat.
7. Connect A5-V11 only.
8. Boot router.
9. Add USB storage load.
10. Test Wi-Fi and Ethernet.
11. Test inside PS2 shell.
12. Check regulator temperature.
13. Check for Ethernet or Wi-Fi noise.
14. Run long test.

---

## Bench Power Test Before PS2 Wiring

Before using PS2 power, test from a bench supply.

| Test | Result |
|---|---|
| 5 V set correctly |  |
| Current limit set |  |
| Router boots |  |
| UART normal |  |
| Ethernet works |  |
| Wi-Fi works |  |
| USB storage works |  |
| Active service works |  |
| Current draw recorded |  |
| Temperature recorded |  |

This gives a known-good reference.

---

## Power Wiring Checklist

Before applying power:

| Check | Done |
|---|---|
| Correct 5 V point identified |  |
| Correct GND point identified |  |
| Polarity verified |  |
| No short between 5 V and GND |  |
| Wires strain relieved |  |
| Wires insulated |  |
| No exposed conductor touches RF shield |  |
| UART connected for first test |  |
| Current meter or current limit ready |  |
| USB storage disconnected for first power test |  |
| Recovery plan exists |  |

---

## First Power-On Checklist

During first power-on:

| Check | Result |
|---|---|
| Current draw normal |  |
| 5 V remains stable |  |
| No smoke or smell |  |
| No hot part immediately |  |
| UART boot log starts |  |
| Router reaches login or service-ready |  |
| PS2 still behaves normally |  |
| No backfeed behavior |  |
| Power-off works normally |  |

If anything looks wrong, power off immediately.

---

## Reboot Reliability Test

Run repeated boot tests.

| Test | Count | Pass |
|---|---:|---|
| Cold boot from PS2 power | 10 |  |
| Warm reboot from firmware | 10 |  |
| PS2 reset | 5 |  |
| Power off for 5 seconds, power on | 5 |  |
| Power off for 30 seconds, power on | 5 |  |
| Boot with USB storage attached | 10 |  |
| Boot shell closed | 10 |  |

If failures appear, record:

- Attempt number
- LED behavior
- UART log
- Voltage
- Current
- USB storage state
- Temperature

---

## Power Test With Loader

Power is not proven until the PS2 use case works.

Test the actual target use:

| Use Case | Test |
|---|---|
| Wi-Fi bridge | PC reaches PS2 FTP through router |
| FTP helper | wLaunchELF FTP transfer completes |
| SMB | OPL sees SMB share and boots game |
| UDPBD | OPL UDPBD sees games and boots game |
| UDPFS | Loader connects and boots/test content |
| USB storage | Drive mounts and stays mounted |
| Always-on | Router remains stable with PS2 off |

---

## Power Test Result Template

Use this template.

```text
# Power Test Result

## Hardware

PS2 model:
PS2 motherboard revision:
A5-V11 board ID:
A5-V11 flash size:
A5-V11 firmware:
USB storage:
Other mods:

## Power Source

Power source:
Voltage source location:
Ground location:
Wire gauge:
Wire length:
Fuse/protection:
Regulator used:
Always-on or switched:
Controller-managed:

## Measurements

Voltage at source:
Voltage at A5-V11:
Idle current:
Boot peak current:
Active current:
USB startup current:
USB active current:
Regulator temperature:
A5-V11 temperature:

## Boot Timing

First UART output:
Ethernet ready:
Wi-Fi ready:
USB mounted:
Service ready:
Recommended PS2 delay:

## Tests

Cold boot:
Warm reboot:
Rapid power cycle:
USB attached boot:
Closed-shell boot:
Backfeed:
Loader test:
Long-run:

## Result

Pass/fail:
Known issues:
Notes:
```

---

## Suggested Photos

Take photos of:

- PS2 power tap point
- Ground tap point
- Regulator board, if used
- Fuse or protection part
- A5-V11 power solder points
- Wire routing
- Strain relief
- Insulation
- USB storage power wiring
- Final mounted power wiring

Suggested file names:

```text
power-board001-ps2-5v-tap.jpg
power-board001-ps2-ground-tap.jpg
power-board001-a5v11-power-input.jpg
power-board001-regulator.jpg
power-board001-wire-routing.jpg
power-board001-final.jpg
```

---

## Troubleshooting: Router Does Not Power On

Check:

- 5 V present at source
- 5 V present at A5-V11
- Ground connected
- Polarity correct
- Wire broken
- Fuse tripped
- Regulator enabled
- Load switch enabled
- micro-USB port or input pad damaged
- Router works from external 5 V

---

## Troubleshooting: Router Boots From External Supply But Not PS2

Possible causes:

- PS2 5 V source cannot supply enough current
- Voltage sag
- Bad ground
- Long thin wires
- USB storage current too high
- PS2 USB rail current limit
- Startup inrush too high
- Brownout
- Capacitor mod instability

Try:

- Remove USB storage
- Use thicker/shorter wires
- Use dedicated buck regulator
- Add bulk capacitance
- Add supervisor IC
- Test with bench supply
- Measure voltage at router during boot

---

## Troubleshooting: Router Resets When USB Drive Starts

Possible causes:

- USB drive inrush current
- Weak 5 V source
- Not enough capacitance
- Long power wires
- USB storage draws too much current
- Regulator current limit

Try:

- Use lower-power USB drive
- Use powered storage
- Use dedicated 5 V regulator
- Add bulk capacitance
- Use shorter wires
- Boot without drive
- Test drive current separately

---

## Troubleshooting: Wi-Fi Drops Under Load

Possible causes:

- Voltage sag during transmit
- Router overheating
- Weak antenna
- Power noise
- Too many services running
- USB storage load affecting 5 V rail

Try:

- Measure voltage during Wi-Fi use
- Improve antenna
- Improve power filtering
- Add heatsink
- Disable unused services
- Test without USB storage
- Test from bench supply

---

## Troubleshooting: Ethernet Drops Under Load

Possible causes:

- Power sag
- Router reset
- Bad Ethernet wiring
- Noise from regulator
- Poor ground
- Heat
- Firmware issue

Try:

- Confirm UART log does not show reboot
- Test with external cable
- Test from external 5 V
- Move Ethernet wires away from regulator
- Shorten Ethernet wiring
- Check voltage at router

---

## Troubleshooting: PS2 Behaves Strange When Router Is Always On

Possible causes:

- Backfeed through Ethernet
- Backfeed through USB
- Backfeed through UART
- Shared control line backfeed
- Ground or power path issue
- Router holding a signal high while PS2 is off

Try:

- Disconnect signal lines one at a time
- Test Ethernet only
- Test power only
- Add isolation
- Switch router power with PS2
- Use load switch
- Avoid always-on mode until fixed

---

## Troubleshooting: Router Fails After Rapid Power Cycle

Possible causes:

- Reset timing issue
- Capacitors not discharged
- Brownout
- Poor power ramp
- USB storage startup issue
- Supervisor IC needed

Try:

- Wait longer before power-on
- Add supervisor IC
- Improve power source
- Add proper reset control
- Test without USB storage
- Capture UART log

---

## Recommended Development Flow

Use this flow:

1. Test A5-V11 on external 5 V.
2. Measure current draw without USB.
3. Measure current draw with USB.
4. Test PS2 externally with normal cable.
5. Choose PS2 power source.
6. Test voltage at source.
7. Wire temporary power with current meter.
8. Boot router from PS2 power.
9. Test UART boot.
10. Test Ethernet.
11. Test Wi-Fi.
12. Test USB storage.
13. Test target PS2 loader.
14. Run repeated boot tests.
15. Check heat.
16. Test shell closed.
17. Add protection or regulator if needed.
18. Document final wiring.

---

## Final Power Checklist

Before final assembly:

| Check | Done |
|---|---|
| A5-V11 external power test passed |  |
| Current draw measured |  |
| USB storage current measured |  |
| PS2 power source identified |  |
| Voltage measured at source |  |
| Voltage measured at A5-V11 |  |
| Polarity confirmed |  |
| Ground confirmed |  |
| Wire gauge adequate |  |
| Wires strain relieved |  |
| Fuse or protection considered |  |
| Regulator tested, if used |  |
| Boot timing measured |  |
| Cold boot test passed |  |
| Warm reboot test passed |  |
| Rapid power cycle tested |  |
| USB attached boot tested |  |
| Backfeed tested |  |
| Closed-shell power test passed |  |
| Thermal test passed |  |
| Photos taken |  |
| Notes updated |  |

---

## Short Version

The A5-V11 should be powered from a stable 5 V source.

Possible PS2 power options include:

- PS2 USB 5 V
- Internal PS2 5 V rail
- Dedicated 5 V buck regulator
- Always-on auxiliary 5 V
- External 5 V supply
- Controller-managed power

For simple builds, PS2 USB 5 V may work if current draw is low.

For USB storage, SMB, UDPBD, UDPFS, or always-on behavior, a dedicated 5 V regulator or controlled power system may be better.

Always measure:

- Voltage
- Current
- Boot behavior
- USB startup load
- Wi-Fi stability
- Ethernet stability
- Heat
- Backfeed

Do not finalize the internal install until the router boots reliably, the PS2 behaves normally, and the exact PS2 use case works under closed-shell conditions.

# Ethernet Wiring

## Summary

This document covers Ethernet wiring between the PlayStation 2 and the A5-V11 mini router.

The goal is to wire the A5-V11 to the PS2 in a way that behaves like plugging a short Ethernet cable between the PS2 Ethernet port and the A5-V11 Ethernet port.

For PS2 integration, Ethernet is one of the most important connections because it is the direct wired link between the console and the router.

Possible uses include:

- Wi-Fi bridge for the PS2
- FTP access using wLaunchELF
- SMB1 access using OPL
- UDPBD loading
- UDPFS loading
- Internal PS2 network module
- Router-hosted USB storage
- External testing before internal installation

---

## Important Warning

Ethernet is not simple low-speed wiring.

Do not treat Ethernet lines like basic DC signal wires.

Ethernet uses differential pairs, transformer isolation, impedance-controlled routing, and proper pair twisting.

Bad Ethernet wiring can cause:

- No link
- Random link drops
- Slow transfer
- Packet loss
- FTP stalls
- SMB disconnects
- UDPBD failure
- UDPFS failure
- Games list not appearing
- Unstable PS2 loader behavior

The safest method is to make the internal connection electrically behave like a very short Ethernet patch cable.

---

## Main Rule

The safest rule is:

```text
Keep the Ethernet magnetics in the circuit.
Wire the PS2 to the A5-V11 as if a short Ethernet cable was plugged between them.
```

Do not directly connect the PS2 Ethernet PHY pins to the A5-V11 Ethernet PHY pins.

Do not bypass the Ethernet transformers unless the circuit has been fully reverse engineered and tested.

---

## What This Document Covers

This document covers:

- Ethernet wiring goals
- RJ45 pinout basics
- Straight-through wiring
- Crossover wiring
- Pair twisting
- PS2 internal wiring concepts
- A5-V11 internal wiring concepts
- Reusing the original PS2 Ethernet port
- Removing the A5-V11 RJ45 jack
- Keeping magnetics in the circuit
- Testing link
- Testing packet loss
- Testing PS2 loader compatibility
- Troubleshooting common Ethernet wiring failures

---

## What This Document Does Not Cover

This document does not provide a final board-specific PS2 motherboard pinout.

PS2 Ethernet wiring may vary by:

- Console model
- Motherboard revision
- Slim vs Fat
- Built-in Ethernet vs network adapter
- Magnetics location
- RJ45 connector style
- Whether the Ethernet transformer is integrated or separate

Before wiring a real console, document the exact PS2 board revision and trace the Ethernet path.

---

## A5-V11 Ethernet Overview

The A5-V11 has one physical 10/100 Mbps Ethernet port.

Typical A5-V11 Ethernet features:

| Feature | Value |
|---|---|
| Ethernet speed | 10/100 Mbps |
| Physical port count | 1 |
| Connector | RJ45 |
| Gigabit support | No |
| SoC | RT5350F |
| OpenWrt interface | May be `eth0`, `eth0.1`, or `br-lan` depending on firmware |
| Main PS2 use | Wired link between PS2 and A5-V11 |

The A5-V11 Ethernet port should be treated as a normal 100 Mbps Ethernet port.

---

## PS2 Ethernet Overview

The PS2 Ethernet side depends on the model.

| PS2 Type | Ethernet Type |
|---|---|
| PS2 Fat | Network Adapter or third-party adapter |
| PS2 Slim SCPH-700xx to SCPH-900xx | Built-in 10/100 Ethernet |

For internal Slim builds, the goal is usually to connect the PS2 built-in Ethernet hardware to the A5-V11 internally.

This should behave the same as plugging an Ethernet cable between the PS2 and the router.

---

## Ethernet Pair Basics

10/100 Ethernet uses two differential pairs.

| RJ45 Pin | 10/100 Function |
|---:|---|
| 1 | Pair 1 positive |
| 2 | Pair 1 negative |
| 3 | Pair 2 positive |
| 6 | Pair 2 negative |
| 4 | Not used for 10/100 Ethernet |
| 5 | Not used for 10/100 Ethernet |
| 7 | Not used for 10/100 Ethernet |
| 8 | Not used for 10/100 Ethernet |

For a short internal link, the important pins are:

```text
1, 2, 3, 6
```

However, if using a real RJ45 connector or cable, keep the normal 8-pin layout.

---

## RJ45 Pinout

Looking into the front of an RJ45 jack with the latch tab down, pin 1 is usually on the left.

```text
Front of RJ45 jack, latch down:

Pin:  1 2 3 4 5 6 7 8
      | | | | | | | |
```

10/100 Ethernet uses:

```text
Pin 1 and Pin 2 = one twisted pair
Pin 3 and Pin 6 = one twisted pair
```

---

## Straight-Through Wiring

A straight-through Ethernet cable connects the same pin on each end.

| End A | End B |
|---:|---:|
| 1 | 1 |
| 2 | 2 |
| 3 | 3 |
| 6 | 6 |

This is the first wiring method to test.

For most modern devices, straight-through should work if one or both sides support auto-MDI/MDIX.

Do not assume every device supports auto-MDI/MDIX until tested.

---

## Crossover Wiring

A crossover cable swaps transmit and receive pairs.

| End A | End B |
|---:|---:|
| 1 | 3 |
| 2 | 6 |
| 3 | 1 |
| 6 | 2 |

If straight-through wiring gives no Ethernet link, test crossover wiring.

---

## Straight-Through First, Crossover Second

Recommended test order:

1. Test with a normal external Ethernet cable.
2. Confirm the PS2 and A5-V11 work externally.
3. Recreate that wiring internally as straight-through.
4. If no link appears, test crossover wiring.
5. Document which wiring works.

Do not guess internally before confirming the external cable test works.

---

## Ethernet Magnetics

Ethernet ports normally use transformer isolation, often called magnetics.

The magnetics may be:

- Built into the RJ45 jack
- A separate transformer module near the RJ45 jack
- A small transformer package on the board

The magnetics are important for proper Ethernet signaling and isolation.

For internal PS2 wiring, the safest approach is to keep the magnetics on both devices.

---

## Do Not Bypass Magnetics

Do not wire directly from the PS2 Ethernet PHY to the A5-V11 Ethernet PHY.

Bad idea:

```text
PS2 PHY pins -> A5-V11 PHY pins
```

Better idea:

```text
PS2 Ethernet port cable-side pins -> A5-V11 Ethernet port cable-side pins
```

or:

```text
PS2 after its magnetics -> short twisted-pair link -> A5-V11 after its magnetics
```

The exact safe tap point depends on the PS2 board and the A5-V11 board.

When in doubt, keep both original Ethernet ports intact and use a short cable or pigtail.

---

## Best Development Method

For first testing, use the stock connectors.

Recommended first setup:

```text
PS2 Ethernet port -> normal Ethernet cable -> A5-V11 Ethernet port
```

Test:

- PS2 link
- Router link
- Ping
- FTP
- SMB
- UDPBD
- UDPFS

Only after the external cable setup works should internal wiring be attempted.

---

## Internal Wiring Concepts

There are several possible internal wiring methods.

| Method | Description | Difficulty |
|---|---|---|
| Method A | Use a very short internal Ethernet cable | Low |
| Method B | Remove A5-V11 RJ45 and wire to its cable-side pads | Medium |
| Method C | Reuse PS2 Ethernet port internally | Medium to High |
| Method D | Use a small interposer or adapter PCB | High |
| Method E | Bypass magnetics and wire PHY-to-PHY | Not recommended |

---

## Method A: Short Internal Ethernet Cable

This is the safest internal concept.

The idea is to keep both Ethernet ports intact and connect them with a very short Ethernet cable or pigtail.

```text
PS2 RJ45 port -> short cable -> A5-V11 RJ45 port
```

Advantages:

- Keeps magnetics intact
- Behaves like a normal cable
- Easiest to debug
- Lowest electrical risk
- Reversible
- Good for first internal testing

Disadvantages:

- Takes more space
- RJ45 connectors are bulky
- Cable must be routed cleanly
- May not fit in tight Slim builds

This is the best method for early proof-of-concept testing.

---

## Method B: Remove A5-V11 RJ45 And Wire To Cable-Side Pads

This method removes the A5-V11 RJ45 jack for clearance.

The A5-V11 is then wired to the PS2 as if a cable was connected to the original jack.

Important:

- Identify whether the A5-V11 RJ45 jack has integrated magnetics.
- Identify whether the Ethernet transformer is separate.
- Keep the magnetics in the circuit.
- Wire only the cable-side Ethernet pairs.
- Do not wire directly to RT5350F PHY pins.

Advantages:

- Saves height and space
- Cleaner internal install
- Can make the A5-V11 fit better in Slim builds

Disadvantages:

- Requires board tracing
- Risk of lifting pads
- Easier to wire the wrong side of magnetics
- Harder to reverse
- Requires careful testing

---

## Method C: Reuse The Original PS2 Ethernet Port

This method keeps the PS2 external RJ45 port as part of the final design.

There are two possible goals:

1. The PS2 Ethernet port remains externally usable.
2. The PS2 Ethernet path is internally connected to the A5-V11.

These are different designs.

If the A5-V11 is permanently connected to the PS2 Ethernet internally, the outside PS2 Ethernet port may no longer behave like a normal external port unless a switching or pass-through design is added.

---

## PS2 Port Reuse Options

| Option | Description |
|---|---|
| Internal-only | PS2 Ethernet is hardwired to A5-V11, external port not used |
| External pass-through | External port still works through switching or routing |
| Service port | External port connects to A5-V11 for setup/recovery |
| Switched mode | User can switch between normal PS2 Ethernet and internal A5-V11 |

A switched or pass-through design is more complex and should be tested carefully.

---

## Method D: Adapter PCB Or Interposer

A small PCB or flex can make Ethernet wiring cleaner.

Possible adapter PCB goals:

- Break out RJ45 pins
- Preserve twisted pair routing
- Add test pads
- Add strain relief
- Add optional straight-through/crossover jumpers
- Add optional Ethernet switch path
- Add mounting holes
- Add labeled pads for PS2 and A5-V11
- Make installation repeatable

Advantages:

- Cleaner install
- Easier documentation
- More repeatable
- Can support multiple PS2 models with variants

Disadvantages:

- Requires PCB design
- Requires testing
- Ethernet layout matters
- Bad layout can cause link issues

---

## Method E: Direct PHY-To-PHY Wiring

This is not recommended.

Do not do this unless the Ethernet PHY circuits, magnetics, termination, biasing, and isolation requirements are fully understood.

Bad approach:

```text
PS2 Ethernet PHY pins -> A5-V11 RT5350F PHY pins
```

Risks:

- No link
- Damaged PHY
- Wrong biasing
- No isolation
- Signal integrity problems
- Hard-to-debug behavior

For this repo, the recommended direction is to keep the link electrically equivalent to a normal Ethernet cable.

---

## Recommended Wire Type

For internal wiring, use twisted pairs.

Good options:

- Cut a short piece of Cat5e cable
- Use two twisted pairs from a small Ethernet cable
- Use fine insulated twisted pair wire
- Use controlled pair routing on a PCB

Avoid:

- Four random loose wires
- Long untwisted runs
- Ribbon cable for Ethernet pairs
- Running Ethernet beside switching power wires
- Running Ethernet under noisy regulators
- Crossing high-current motor or fan wires

---

## Pair Assignment

For 10/100 Ethernet:

| Pair | Pins |
|---|---|
| Pair A | 1 and 2 |
| Pair B | 3 and 6 |

Keep each pair twisted together.

Do not split the pair.

Bad:

```text
Pin 1 routed with Pin 3
Pin 2 routed with Pin 6
```

Good:

```text
Pin 1 twisted with Pin 2
Pin 3 twisted with Pin 6
```

---

## Wire Length

Keep internal Ethernet wiring short.

Recommended:

```text
As short as practical
```

Good target:

```text
Under 100 mm if possible
```

Longer wiring may still work, but it increases risk of:

- Noise pickup
- Pair imbalance
- Link instability
- Reduced transfer speed
- Packet loss

---

## Routing Guidelines

Good routing:

- Keep Ethernet pairs short.
- Keep each pair twisted.
- Keep pair lengths similar.
- Avoid sharp bends.
- Avoid running next to power inductors.
- Avoid running next to switching regulators.
- Avoid running parallel to high-current wires.
- Avoid running directly under Wi-Fi antenna.
- Avoid pinching under the RF shield.
- Add strain relief.

Bad routing:

- Loose untwisted wires across the motherboard
- Ethernet wires bundled with power wires
- Ethernet wires squeezed under metal shield edges
- Ethernet wires crossing noisy regulators
- Ethernet wires wrapped around the fan area

---

## Shielding And Ground

Most internal PS2 wiring should not require shielded Ethernet cable if the run is short and twisted pairs are preserved.

Do not randomly tie Ethernet shield, PS2 ground, and A5-V11 ground together unless the design requires it.

Ethernet magnetics provide isolation.

If using shielded cable, document exactly where the shield is connected.

For early testing, unshielded twisted pairs are usually simpler.

---

## Ground Reference

A normal Ethernet cable does not require a shared DC ground between devices.

However, in an internal PS2 build, the A5-V11 and PS2 may already share power ground.

Important:

- Shared power ground is okay when powering the A5-V11 from the PS2.
- Do not use ground as a replacement for Ethernet magnetics.
- Do not bypass transformer isolation because the grounds are shared.
- Watch for backfeed if the router remains powered while the PS2 is off.

---

## Always-On Router Warning

If the A5-V11 remains powered while the PS2 is off, test for backfeed.

Possible backfeed paths:

- Ethernet lines
- USB lines
- UART lines
- GPIO lines
- Shared 5 V rail
- Shared 3.3 V rail
- Controller board signals

Symptoms of backfeed:

- PS2 LEDs faintly glow
- Console partially powers
- Ethernet behaves strangely
- PS2 will not fully turn off
- Unexpected current draw
- Router only works when PS2 is connected
- PS2 power button behavior changes

Do not finalize an always-on design until backfeed is tested.

---

## Ethernet Connection Modes

The A5-V11 can be used in several Ethernet-related modes.

| Mode | Description |
|---|---|
| Direct PS2-to-A5 | PS2 Ethernet connects directly to A5-V11 Ethernet |
| Wi-Fi bridge | A5-V11 connects PS2 Ethernet to home Wi-Fi |
| Router-hosted server | A5-V11 serves USB storage directly to PS2 |
| External SMB bridge | A5-V11 bridges PS2 to PC/NAS SMB server |
| Service mode | A5-V11 Ethernet used for setup/recovery |

Each mode may need different firmware configuration.

---

## Firmware Interface Warning

The A5-V11 Ethernet interface name may differ between firmware builds.

Possible names:

```text
eth0
eth0.1
br-lan
```

Some OpenWrt notes show that the wired LAN can use `eth0.1`.

If the wrong interface is used in `/etc/config/network`, the router may become unreachable.

Every firmware build should document:

- Ethernet interface name
- Bridge interface name
- Default IP
- DHCP behavior
- Firewall behavior
- PS2-side IP expectations

---

## Basic OpenWrt Ethernet Checks

Useful commands:

```text
ip addr
ifconfig
cat /etc/config/network
logread
dmesg | grep eth
swconfig dev switch0 show
```

Some commands may not exist on every firmware build.

---

## Ethernet DHCP Client Example

This is a reference configuration concept for putting the A5-V11 Ethernet side into DHCP client mode.

Actual interface name may need to be changed.

```text
config interface 'lan'
        option ifname 'eth0.1'
        option proto 'dhcp'
```

If `eth0.1` does not work on your firmware, test `eth0`.

Do not assume.

---

## Static PS2 Link Example

For PS2 direct testing, a static setup may be easier.

Example concept:

| Device | IP |
|---|---|
| A5-V11 | 192.168.1.222 |
| PS2 | 192.168.1.10 |
| PC | 192.168.1.20 |
| Gateway | 192.168.1.1 |

Subnet:

```text
255.255.255.0
```

This is only an example.

The final IP plan depends on the firmware mode and user network.

---

## Straight-Through Internal Wiring Table

Use this when wiring as a normal straight-through Ethernet link.

| PS2 Side | A5-V11 Side |
|---:|---:|
| RJ45 Pin 1 | RJ45 Pin 1 |
| RJ45 Pin 2 | RJ45 Pin 2 |
| RJ45 Pin 3 | RJ45 Pin 3 |
| RJ45 Pin 6 | RJ45 Pin 6 |

Optional unused pins if recreating full connector wiring:

| PS2 Side | A5-V11 Side |
|---:|---:|
| RJ45 Pin 4 | RJ45 Pin 4 |
| RJ45 Pin 5 | RJ45 Pin 5 |
| RJ45 Pin 7 | RJ45 Pin 7 |
| RJ45 Pin 8 | RJ45 Pin 8 |

For 10/100 Ethernet, pins 4, 5, 7, and 8 are normally not used for data.

---

## Crossover Internal Wiring Table

Use this only if straight-through does not link.

| PS2 Side | A5-V11 Side |
|---:|---:|
| RJ45 Pin 1 | RJ45 Pin 3 |
| RJ45 Pin 2 | RJ45 Pin 6 |
| RJ45 Pin 3 | RJ45 Pin 1 |
| RJ45 Pin 6 | RJ45 Pin 2 |

---

## Continuity Test

Before powering anything, test continuity.

Check:

| Test | Expected |
|---|---|
| Pin 1 to matching destination | Continuity |
| Pin 2 to matching destination | Continuity |
| Pin 3 to matching destination | Continuity |
| Pin 6 to matching destination | Continuity |
| Pin 1 to Pin 2 | No short |
| Pin 3 to Pin 6 | No short |
| Pair A to Pair B | No short |
| Ethernet pins to shield | No short unless designed |
| Ethernet pins to 5 V | No short |
| Ethernet pins to ground | No short on cable-side data pins |

Do not apply power until shorts are checked.

---

## Visual Inspection

Before testing:

- Inspect solder joints.
- Check for lifted pads.
- Check for solder bridges.
- Check wire strain relief.
- Check wire routing.
- Check that pairs are twisted.
- Check that the RF shield will not cut wires.
- Check that the shell does not pinch wires.
- Check that the fan is not obstructed.
- Check that the A5-V11 cannot move and stress the wires.

---

## First Ethernet Test

Use this test before PS2 software testing.

1. Power the A5-V11.
2. Power the PS2.
3. Check for Ethernet link.
4. Check A5-V11 logs over UART.
5. Check link LEDs if available.
6. Ping the router from a PC if the network mode allows it.
7. Ping the PS2 if possible.
8. Launch a simple network test before launching games.

If no link appears, stop and troubleshoot before testing OPL or UDPBD.

---

## Link Test Checklist

| Test | Result |
|---|---|
| A5-V11 powers on |  |
| PS2 powers on |  |
| Ethernet link LED appears |  |
| A5-V11 sees Ethernet link |  |
| PS2 network test passes |  |
| Router IP reachable |  |
| PS2 IP reachable |  |
| No packet loss in short ping |  |
| No link drop after moving shell |  |
| No link drop after closing shell |  |

---

## Ping Test

From a PC, if the topology allows it:

```text
ping <router-ip>
ping <ps2-ip>
```

From the router:

```text
ping <ps2-ip>
ping <gateway-ip>
ping <pc-ip>
```

Record packet loss.

| Target | Sent | Lost | Loss % | Notes |
|---|---:|---:|---:|---|
| Router |  |  |  |  |
| PS2 |  |  |  |  |
| PC |  |  |  |  |
| Gateway |  |  |  |  |

---

## Long Ping Test

Run at least 100 pings.

Windows:

```text
ping <target-ip> -n 100
```

Linux/macOS:

```text
ping -c 100 <target-ip>
```

Pass criteria:

- 0 percent packet loss preferred
- No random disconnects
- No large latency spikes during idle testing

---

## FTP Test

FTP is a good first PS2 network test.

Test with wLaunchELF:

1. Start wLaunchELF on the PS2.
2. Start the PS2 FTP server.
3. Connect from PC.
4. Transfer a small file.
5. Transfer a larger file.
6. Disconnect and reconnect.
7. Repeat after reboot.

Record:

| Item | Result |
|---|---|
| PC can ping PS2 |  |
| FTP connects |  |
| Directory listing works |  |
| Small file transfer works |  |
| Large file transfer works |  |
| Reconnect works |  |
| Transfer stalls |  |
| Notes |  |

---

## SMB Test

For OPL SMB testing:

1. Confirm basic Ethernet link first.
2. Confirm PS2 IP settings.
3. Confirm SMB server is reachable.
4. Confirm OPL settings.
5. Launch OPL.
6. Check if games list appears.
7. Boot a game.
8. Watch for freezes or disconnects.

Record:

| Item | Result |
|---|---|
| OPL can reach SMB server |  |
| Games list appears |  |
| Game boots |  |
| FMV behavior acceptable |  |
| No random disconnects |  |
| Notes |  |

---

## UDPBD Test

For UDPBD testing:

1. Connect PS2 Ethernet to A5-V11 Ethernet.
2. Connect USB storage to A5-V11.
3. Power the A5-V11.
4. Wait for router/service ready.
5. Launch the required UDPBD-capable OPL build.
6. Check if games list appears.
7. Boot a game.
8. Test repeated launches.

Record:

| Item | Result |
|---|---|
| Ethernet link works |  |
| USB mounted on A5-V11 |  |
| UDPBD server started |  |
| Correct OPL UDPBD build used |  |
| Games list appears |  |
| Game boots |  |
| Repeated launch works |  |
| Notes |  |

---

## Internal Wiring Stress Test

After the link works, physically stress test the wiring gently.

Test:

- Move the PS2 shell slightly.
- Install the RF shield.
- Close the shell.
- Move the console carefully.
- Power cycle the console.
- Let it warm up.
- Run a network transfer.

Record:

| Test | Result |
|---|---|
| Link stable with shell open |  |
| Link stable with RF shield installed |  |
| Link stable with shell closed |  |
| Link stable after moving console |  |
| Link stable after warmup |  |
| Link stable during transfer |  |

---

## Closed-Shell Test

A wiring job is not finished until it works with the shell closed.

Closed-shell test:

1. Assemble the PS2 normally.
2. Power on.
3. Confirm Ethernet link.
4. Confirm router service.
5. Launch PS2 network tool.
6. Run a transfer or boot a game.
7. Let it run for at least 30 minutes.
8. Reboot and repeat.

Pass criteria:

- No link drop
- No packet loss
- No service failure
- No thermal failure
- No shell pressure on wires
- No shorts to RF shield

---

## Troubleshooting: No Ethernet Link

Possible causes:

- TX/RX pairs reversed
- Straight-through needed but crossover wired
- Crossover needed but straight-through wired
- Wrong tap point
- Magnetics bypassed
- Pair split
- Bad solder joint
- Shorted pair
- Broken wire
- RF shield short
- Router not booted
- PS2 network not initialized
- Firmware interface misconfigured

Try:

1. Test with an external Ethernet cable.
2. Confirm both devices work externally.
3. Check continuity.
4. Check pair order.
5. Try straight-through wiring.
6. Try crossover wiring.
7. Check A5-V11 UART logs.
8. Check OpenWrt interface name.
9. Check for shorts to shield or ground.
10. Rebuild with a short twisted-pair cable.

---

## Troubleshooting: Link Appears But Network Fails

Possible causes:

- Wrong IP settings
- Wrong subnet
- Wrong gateway
- DHCP not working
- Firewall blocking traffic
- A5-V11 using wrong interface
- `eth0` vs `eth0.1` mismatch
- PS2 loader settings wrong
- Wi-Fi bridge not connected
- NAT/routing mismatch

Try:

```text
ip addr
ifconfig
cat /etc/config/network
logread
ping <target-ip>
```

Check:

- Router IP
- PS2 IP
- PC IP
- Subnet mask
- Gateway
- DHCP server
- Firewall
- Network mode

---

## Troubleshooting: Random Disconnects

Possible causes:

- Untwisted wiring
- Long internal wires
- Bad solder joint
- Shell pressure
- RF shield touching wires
- Power instability
- Router overheating
- USB drive drawing too much current
- Firmware service crash
- Wi-Fi bridge drop, if using Wi-Fi

Try:

- Shorten wires
- Use twisted pairs
- Add strain relief
- Move away from power wiring
- Check thermal behavior
- Check A5-V11 power rail
- Check UART logs
- Test with shell open and closed
- Test external cable again

---

## Troubleshooting: Works Open, Fails Closed

Possible causes:

- RF shield shorts a wire
- Shell pinches Ethernet wires
- Wire moves when shell closes
- Antenna is blocked
- A5-V11 overheats
- Router board shifts
- Connector or solder joint stressed
- Ethernet pair routed too close to metal edge

Try:

- Add Kapton tape
- Add strain relief
- Reroute wires
- Shorten wires
- Add insulation between board and shield
- Move antenna
- Check thermal path
- Inspect after closing shell

---

## Troubleshooting: FTP Works But OPL SMB Fails

Ethernet wiring may be okay if FTP works.

Check software and protocol issues:

- SMB1/NT1 enabled
- OPL network config
- Share path
- Username/password
- Guest access
- Firewall
- USB mount path
- Samba running
- Router RAM usage
- Boot timing

Do not assume Ethernet wiring is bad if FTP works reliably.

---

## Troubleshooting: SMB Works But UDPBD Fails

Ethernet wiring may be okay if SMB works.

Check UDPBD-specific issues:

- Correct OPL UDPBD build
- Correct router firmware
- UDPBD server running
- USB drive mounted
- USB drive connected to A5-V11, not PS2
- Loader launched after router ready
- Correct storage path
- Firewall or service issue

---

## Recommended Wiring Documentation

For every internal install, document:

| Item | Value |
|---|---|
| PS2 model |  |
| PS2 motherboard revision |  |
| A5-V11 board ID |  |
| Firmware |  |
| Ethernet method | Short cable, direct pads, adapter PCB, other |
| Straight-through or crossover |  |
| Wire type |  |
| Wire length |  |
| Magnetics kept | Yes or no |
| A5-V11 RJ45 removed | Yes or no |
| PS2 RJ45 reused | Yes or no |
| External Ethernet port still works | Yes or no |
| UART access retained | Yes or no |
| Tested with shell closed | Yes or no |
| Notes |  |

---

## Ethernet Wiring Test Template

```text
# Ethernet Wiring Test

## Hardware

PS2 model:
PS2 board revision:
A5-V11 board ID:
A5-V11 firmware:
A5-V11 flash size:
A5-V11 power source:

## Wiring

Method:
Straight-through or crossover:
Wire type:
Wire length:
Magnetics retained:
A5-V11 RJ45 retained:
PS2 RJ45 retained:
Adapter PCB used:
Shielding:
Strain relief:

## Network

Router IP:
PS2 IP:
PC IP:
Gateway:
Subnet:
Network mode:

## Tests

External cable test:
Internal wiring link:
Ping router:
Ping PS2:
FTP test:
SMB test:
UDPBD test:
UDPFS test:
Closed-shell test:
Long-run test:

## Result

Pass/fail:
Known issues:
Notes:
```

---

## Suggested Photos

Take photos of:

- A5-V11 before Ethernet modification
- A5-V11 after RJ45 removal, if removed
- PS2 Ethernet area before modification
- PS2 Ethernet tap points
- Wire pair routing
- Strain relief
- RF shield clearance
- Final internal mounting
- Closed-shell clearance
- Any adapter PCB or flex

Use clear file names.

Example:

```text
ps2-a5v11-ethernet-board001-before.jpg
ps2-a5v11-ethernet-board001-a5-pads.jpg
ps2-a5v11-ethernet-board001-ps2-pads.jpg
ps2-a5v11-ethernet-board001-routing.jpg
ps2-a5v11-ethernet-board001-final.jpg
```

---

## Recommended Development Flow

Use this flow:

1. Test A5-V11 externally with PC.
2. Test PS2 Ethernet externally with known-good router or switch.
3. Test PS2 to A5-V11 with normal Ethernet cable.
4. Confirm FTP or loader behavior.
5. Shorten to a small external pigtail.
6. Confirm behavior again.
7. Move wiring internally with stock connectors if possible.
8. Confirm behavior again.
9. Remove bulky connectors only after the electrical behavior is proven.
10. Test shell open.
11. Test shell closed.
12. Run long stability test.
13. Document final wiring.

---

## Minimum Pass Criteria

A PS2-to-A5-V11 Ethernet wiring setup passes basic testing if:

- Link comes up reliably.
- Router boots normally.
- PS2 network initializes.
- Ping works where expected.
- At least one PS2 network tool works.
- No packet loss appears during short testing.
- Wiring survives shell movement.
- Wiring survives closed-shell test.
- No shorts occur.
- No backfeed issue appears.

---

## Final Pass Criteria

For a final internal PS2 build, Ethernet wiring should pass:

- 10 cold boots
- 10 warm reboots
- Closed-shell test
- 30 minute network test
- FTP or loader test
- Target PS2 method test
- Power-off backfeed test if router is always powered
- Visual inspection after test
- Thermal check

---

## Safety Notes

Before closing the PS2:

- Insulate exposed pads.
- Add strain relief.
- Keep wires away from fan blades.
- Keep wires away from RF shield edges.
- Keep wires away from screw posts.
- Keep wires away from hot regulators.
- Check for shorts.
- Confirm shell closes without pressure.
- Confirm UART recovery access still exists.

---

## Short Version

For PS2 integration, wire the A5-V11 Ethernet to the PS2 like a very short Ethernet cable.

Use the normal 10/100 Ethernet pairs:

```text
Pins 1 and 2
Pins 3 and 6
```

Start with straight-through wiring:

```text
1 -> 1
2 -> 2
3 -> 3
6 -> 6
```

If there is no link, test crossover wiring:

```text
1 -> 3
2 -> 6
3 -> 1
6 -> 2
```

Keep the Ethernet magnetics in the circuit.

Use short twisted pairs.

Do not wire PHY-to-PHY directly.

Test externally first, then internally, then closed-shell.

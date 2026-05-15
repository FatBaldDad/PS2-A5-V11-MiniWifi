# Compatibility Testing

## Summary

This document defines how to test PlayStation 2 compatibility with the A5-V11 mini router.

The A5-V11 can be used with the PS2 in several different ways:

- Wi-Fi bridge
- FTP access for wLaunchELF
- SMB1 access for OPL
- UDPBD storage server
- UDPFS storage server
- Internal PS2 network module
- External PS2 network adapter
- USB-storage-backed network appliance

Compatibility testing is needed because the A5-V11 is limited, firmware varies, PS2 models vary, loaders vary, storage devices vary, and boot timing can affect results.

A setup should not be called compatible after only one successful boot.

Compatibility should be tested, recorded, repeated, and tied to exact hardware and firmware versions.

---

## Purpose

The purpose of this document is to create a repeatable compatibility test process.

Testing should answer:

- Which PS2 models work?
- Which PS2 loaders work?
- Which firmware builds work?
- Which network modes work?
- Which USB drives work?
- Which filesystems work?
- Which service modes work?
- Which games boot?
- Which games fail?
- Which setups are stable?
- Which setups only work with a delay?
- Which setups only work outside the PS2 shell?
- Which setups are safe enough for internal installation?

---

## Important Compatibility Rule

Compatibility is not universal.

A result only applies to the exact tested setup.

A useful compatibility result must include:

- A5-V11 board ID
- A5-V11 firmware
- Flash size
- PS2 model
- PS2 motherboard revision, if known
- PS2 boot method
- Loader name and version
- Network mode
- Storage device
- Filesystem
- Power source
- Boot timing
- Test result
- Known issues

Do not write:

```text
Works on PS2.
```

Write:

```text
Works on SCPH-79001 using A5-V11 board-003 with 16 MB flash, PS2-UDPBD firmware v0.1, OPL UDPBD build, exFAT Samsung USB flash drive, router powered from PS2 USB, and a 60 second wait before launching OPL.
```

---

## Compatibility Levels

Use these levels when documenting results.

| Level | Meaning |
|---|---|
| Not Tested | No test has been performed |
| Detected | Device or service is detected but not fully used |
| Boots | Loader or game boots |
| Playable | Game or function works during short testing |
| Stable | Repeated tests pass without issue |
| Long-Run Stable | Extended testing passes |
| Internal Stable | Works inside a closed PS2 shell |
| Partial | Works with limitations |
| Fails | Does not work |
| Needs Retest | Result is unclear, old, or affected by later changes |

---

## Test Status Labels

Use these labels throughout the compatibility tables.

| Label | Meaning |
|---|---|
| Pass | Works as expected |
| Fail | Does not work |
| Partial Pass | Works with limitations |
| Unstable | Works sometimes |
| Timing Sensitive | Requires wait or delayed launch |
| Power Sensitive | Depends on power source |
| Heat Sensitive | Fails or degrades when warm |
| Wi-Fi Sensitive | Depends heavily on antenna or signal |
| USB Sensitive | Depends on USB drive or filesystem |
| Loader Specific | Requires a specific PS2 loader build |
| Firmware Specific | Requires a specific A5-V11 firmware |
| Needs Verification | Needs more testing |

---

## Minimum Compatibility Data

Every compatibility result should include:

```text
Test ID:
Date:
Tester:
A5-V11 board ID:
A5-V11 flash size:
A5-V11 firmware:
Firmware role:
PS2 model:
PS2 motherboard revision:
PS2 boot method:
Loader:
Loader version:
Network mode:
Router IP:
PS2 IP:
PC/server IP:
Storage device:
Storage filesystem:
Power source:
Antenna setup:
Heatsink:
Supervisor IC:
Shell open or closed:
Boot delay:
Result:
Notes:
```

---

## Compatibility Test Areas

Compatibility should be tested in these areas.

| Area | Purpose |
|---|---|
| PS2 model compatibility | Check different console models |
| Loader compatibility | Check OPL, wLaunchELF, NHDDL, Neutrino, and other loaders |
| Network mode compatibility | Check bridge, routed, NAT, and server modes |
| Storage compatibility | Check USB devices and filesystems |
| Firmware compatibility | Check A5-V11 firmware builds |
| Power compatibility | Check PS2 USB, internal 5 V, and external power |
| Thermal compatibility | Check bench and internal heat behavior |
| Antenna compatibility | Check Wi-Fi range and internal placement |
| Game compatibility | Check actual game boot and play behavior |
| Boot timing compatibility | Check delayed launch requirements |
| Internal fitment compatibility | Check function inside a closed PS2 shell |

---

## PS2 Model Compatibility

Different PS2 models may behave differently.

Factors include:

- Fat vs Slim
- Built-in Ethernet vs Network Adapter
- Power behavior
- Boot method support
- Internal space
- Heat
- RF shield layout
- USB power behavior
- Modchip behavior
- FMCB or exploit compatibility
- Ethernet wiring path

---

## PS2 Model Test Table

| PS2 Model | Board Revision | Boot Method | Network Method | Result | Notes |
|---|---|---|---|---|---|
| SCPH-30001 |  | Network Adapter |  |  |  |
| SCPH-39001 |  | Network Adapter |  |  |  |
| SCPH-50001 |  | Network Adapter |  |  |  |
| SCPH-70001 |  | Built-in Ethernet |  |  |  |
| SCPH-75001 |  | Built-in Ethernet |  |  |  |
| SCPH-77001 |  | Built-in Ethernet |  |  |  |
| SCPH-79001 |  | Built-in Ethernet |  |  |  |
| SCPH-90001 |  | Built-in Ethernet |  |  |  |

---

## PS2 Slim Compatibility Notes

PS2 Slim models are the main target for internal A5-V11 integration.

Important Slim test points:

- Does the router physically fit?
- Does the RF shield interfere?
- Does the antenna still work?
- Does the shell close fully?
- Does the fan path remain clear?
- Does the router heat soak inside the shell?
- Can the router be powered safely?
- Can Ethernet be wired cleanly?
- Can UART remain accessible?
- Does the setup survive repeated power cycles?

---

## PS2 Fat Compatibility Notes

PS2 Fat models have more internal room, but the network setup is different.

Important Fat test points:

- Network Adapter behavior
- Internal HDD behavior
- OPL network settings
- Whether A5-V11 is external or internal
- Power source
- Ethernet wiring
- Whether the A5-V11 is useful compared to existing Network Adapter options
- Whether UDPBD or SMB improves the workflow

---

## Boot Method Compatibility

PS2 boot method can affect timing and loader behavior.

| Boot Method | Result | Notes |
|---|---|---|
| FMCB |  |  |
| FHDB |  |  |
| OpenTuna |  |  |
| PS2BBL |  |  |
| Modchip boot |  |  |
| wLaunchELF manual launch |  |  |
| OPL manual launch |  |  |
| OPL auto-launch |  |  |
| Memory card exploit |  |  |

---

## Loader Compatibility

The A5-V11 may be used with several PS2-side programs.

| Loader | Purpose |
|---|---|
| wLaunchELF | FTP access and file management |
| OPL | SMB, UDPBD, and game loading depending on build |
| OPL UDPBD build | UDPBD game loading |
| NHDDL | Newer loading workflows |
| Neutrino | Newer loading workflows |
| PS2BBL | Bootloader and launch workflow |
| OpenTuna | Exploit and launcher workflow |
| FMCB menu | Launch environment |

---

## Loader Version Rule

Always record the exact loader version.

Do not write:

```text
OPL works.
```

Write:

```text
OPNPS2LD-v1.2.0-Beta-1973-88079d7-UDPBD.elf works with A5-V11 UDPBD build under the listed test conditions.
```

Some UDPBD workflows require a specific OPL build.

A different OPL build may not work.

---

## Loader Compatibility Table

| Loader | Version | Method | Result | Notes |
|---|---|---|---|---|
| wLaunchELF |  | FTP |  |  |
| OPL |  | SMB |  |  |
| OPL UDPBD |  | UDPBD |  |  |
| NHDDL |  | UDPFS or other |  |  |
| Neutrino |  | UDPFS or other |  |  |
| PS2BBL |  | Boot/launch |  |  |
| FMCB |  | Boot/launch |  |  |
| OpenTuna |  | Boot/launch |  |  |

---

## Network Mode Compatibility

The A5-V11 can be used in different network modes.

Each mode should be tested separately.

| Mode | Description |
|---|---|
| Ethernet-only server | A5-V11 serves storage directly to PS2 by Ethernet |
| Wi-Fi bridge | PS2 Ethernet connects through A5-V11 Wi-Fi to home network |
| Routed mode | PS2 is on a separate subnet behind A5-V11 |
| NAT mode | PS2 traffic is NATed through A5-V11 |
| External SMB bridge | A5-V11 bridges PS2 to a PC or NAS SMB server |
| Internal USB storage server | A5-V11 hosts USB drive for PS2 |
| FTP helper | A5-V11 lets PC reach PS2 wLaunchELF FTP |
| UDPBD appliance | A5-V11 serves USB storage through UDPBD |
| UDPFS appliance | A5-V11 serves files through UDPFS |

---

## Network Mode Test Table

| Mode | Router IP | PS2 IP | PC/Server IP | Result | Notes |
|---|---|---|---|---|---|
| Ethernet-only UDPBD |  |  |  |  |  |
| Wi-Fi bridge |  |  |  |  |  |
| Routed mode |  |  |  |  |  |
| NAT mode |  |  |  |  |  |
| SMB bridge to PC |  |  |  |  |  |
| Router-hosted SMB |  |  |  |  |  |
| FTP helper |  |  |  |  |  |

---

## IP Configuration Compatibility

PS2 networking can be sensitive to IP setup.

| Item | Value |
|---|---|
| Router IP |  |
| PS2 IP |  |
| PC IP |  |
| SMB server IP |  |
| Gateway |  |
| Subnet mask |  |
| DNS |  |
| DHCP used | Yes or no |
| Static IP used | Yes or no |
| Firewall enabled | Yes or no |
| Bridge mode | Yes or no |
| NAT mode | Yes or no |

---

## Recommended First Network Test

Before testing loaders, confirm basic network reachability.

From PC:

```text
ping <router-ip>
ping <ps2-ip>
```

From router:

```text
ping <gateway-ip>
ping <pc-ip>
```

From PS2, use loader network tests if available.

Pass criteria:

- Router is reachable.
- PS2 is reachable when expected.
- PC/server is reachable when expected.
- No packet loss during simple test.

---

## wLaunchELF FTP Compatibility

FTP is one of the simplest useful PS2 network tests.

Purpose:

- Confirm PC can reach PS2 through A5-V11
- Transfer files to and from memory card, USB, HDD, or other PS2 storage
- Confirm bridge or routed mode behavior

---

## FTP Compatibility Test

| Item | Value |
|---|---|
| PS2 model |  |
| wLaunchELF version |  |
| Router firmware |  |
| Network mode |  |
| PS2 IP |  |
| PC IP |  |
| Router IP |  |
| FTP client |  |
| File size tested |  |
| Transfer direction | PC to PS2 or PS2 to PC |
| Transfer speed |  |
| Result |  |
| Notes |  |

---

## FTP Pass Criteria

FTP passes if:

- PC can ping the PS2.
- FTP connects.
- Directory listing works.
- File upload works.
- File download works.
- Transfer completes without timeout.
- Repeated connect/disconnect works.

---

## FTP Failure Notes

If FTP fails, check:

- Can PC ping router?
- Can PC ping PS2?
- Is A5-V11 bridge or routed?
- Is firewall blocking inbound FTP?
- Is PS2 on the same subnet?
- Is wLaunchELF FTP actually running?
- Is passive or active FTP mode causing issues?
- Is Wi-Fi client isolation enabled on the home router?
- Is PS2 using the correct gateway?

---

## OPL SMB Compatibility

OPL SMB compatibility can be more difficult than FTP.

The PS2 often expects old SMB1/NT1 behavior.

The A5-V11 may either:

- Bridge the PS2 to an external SMB server
- Host a USB drive as an SMB share itself

These are different tests.

---

## SMB Test Types

| Test Type | Description |
|---|---|
| External SMB server | PC/NAS hosts share, A5-V11 bridges PS2 to it |
| Router-hosted SMB | A5-V11 hosts USB storage through Samba |
| Wired SMB | PS2 and server are wired through Ethernet |
| Wi-Fi bridged SMB | A5-V11 links PS2 to Wi-Fi network |
| Static IP SMB | All IP settings manually configured |
| DHCP SMB | IP settings assigned automatically |

---

## SMB Compatibility Test

| Item | Value |
|---|---|
| PS2 model |  |
| OPL version |  |
| SMB server type | PC, NAS, A5-V11, other |
| SMB server OS |  |
| SMB server IP |  |
| Router firmware |  |
| Network mode |  |
| SMB protocol | SMB1/NT1, if known |
| Share name |  |
| Username |  |
| Guest access | Yes or no |
| USB drive |  |
| Filesystem |  |
| Games list appears | Yes or no |
| Game boots | Yes or no |
| FMV behavior |  |
| Result |  |
| Notes |  |

---

## SMB Pass Criteria

SMB passes if:

- OPL can connect to the share.
- Games list appears.
- At least one game boots.
- File browsing does not time out.
- Gameplay remains stable during short test.
- Reboot and repeat test still works.

---

## SMB Failure Notes

If SMB fails, check:

- Is SMB1/NT1 enabled?
- Is the share path correct?
- Is the username/password correct?
- Is guest access configured correctly?
- Is the USB drive mounted?
- Is Samba running?
- Is the PS2 IP correct?
- Is the router firewall blocking traffic?
- Is Wi-Fi bridge mode working?
- Is the A5-V11 out of RAM?
- Is the router-hosted Samba build too heavy?

---

## UDPBD Compatibility

UDPBD compatibility is highly specific.

Known A5-V11 UDPBD workflows may require:

- Specific router firmware
- Specific OPL UDPBD build
- USB drive inserted before router power-on
- Router allowed to finish booting before OPL starts
- USB drive connected to the router, not the PS2
- No plug-and-play USB behavior
- Correct folder layout
- Correct filesystem support

---

## UDPBD Important Rules

For UDPBD testing, follow these rules:

- Use the exact OPL UDPBD build being tested.
- Record the router firmware version.
- Insert USB storage into the A5-V11 before power-on if the firmware requires it.
- Do not connect the game USB drive to the PS2 while OPL is running.
- Wait for the router to finish booting.
- Relaunch OPL if the first launch happens too early.
- Test the same UDPBD storage setup from a PC if the PS2 does not see games.
- Record boot timing.

---

## UDPBD Compatibility Test

| Item | Value |
|---|---|
| PS2 model |  |
| OPL UDPBD version |  |
| Router firmware |  |
| UDPBD server version |  |
| Router flash size |  |
| Wi-Fi enabled | Yes or no |
| Ethernet-only | Yes or no |
| USB drive |  |
| USB size |  |
| Partition table | MBR or GPT |
| Filesystem |  |
| Cluster size |  |
| USB inserted before power-on | Yes or no |
| Router boot wait |  |
| Games list appears | Yes or no |
| Game boots | Yes or no |
| Speed result |  |
| FMV behavior |  |
| Long-run result |  |
| Notes |  |

---

## UDPBD Pass Criteria

UDPBD passes if:

- Router boots reliably.
- USB storage mounts.
- UDPBD server starts.
- PS2 loader connects.
- Games list appears.
- At least one game boots.
- Repeated launch works.
- Game remains stable during short play test.
- Boot timing requirement is documented.

---

## UDPBD Failure Notes

If UDPBD fails, check:

- Is the exact required OPL UDPBD build used?
- Is the USB drive connected to the router before power-on?
- Is the USB drive formatted correctly?
- Is the game folder layout correct?
- Did the router finish booting?
- Did the USB mount?
- Did the UDPBD process start?
- Is the PS2 using the correct loader?
- Is the router IP expected by the loader?
- Is Wi-Fi disabled if the build expects Ethernet-only?
- Does the USB drive work with UDPBD on a PC?

---

## UDPFS Compatibility

UDPFS should be tested separately from UDPBD.

UDPFS may use different server software, loader behavior, network assumptions, and folder paths.

---

## UDPFS Compatibility Test

| Item | Value |
|---|---|
| PS2 model |  |
| Loader |  |
| Loader version |  |
| Router firmware |  |
| UDPFS server version |  |
| Network mode |  |
| Storage path |  |
| USB drive |  |
| Filesystem |  |
| Server starts | Yes or no |
| PS2 connects | Yes or no |
| Games list appears | Yes or no |
| Game boots | Yes or no |
| Speed result |  |
| Stability |  |
| Notes |  |

---

## UDPFS Pass Criteria

UDPFS passes if:

- Server starts reliably.
- PS2-side loader detects server.
- Game list or target content appears.
- Game or test content boots.
- Repeated launch works.
- Network remains stable.

---

## NHDDL And Neutrino Compatibility

NHDDL and Neutrino-related testing should record exact builds.

These projects change over time, so exact versioning matters.

---

## NHDDL / Neutrino Test Table

| Item | Value |
|---|---|
| Loader name |  |
| Loader version |  |
| Server type | UDPFS, SMB, other |
| Router firmware |  |
| Network mode |  |
| PS2 model |  |
| Storage source |  |
| Result |  |
| Notes |  |

---

## USB Storage Compatibility

USB storage compatibility matters for UDPBD, UDPFS, SMB, and general testing.

Test multiple drive types.

| Drive Type | Example | Result | Notes |
|---|---|---|---|
| Small USB flash drive |  |  |  |
| Large USB flash drive |  |  |  |
| USB SSD |  |  |  |
| USB HDD external power |  |  |  |
| USB HDD bus powered |  |  |  |
| USB card reader |  |  |  |
| microSD to USB adapter |  |  |  |

---

## USB Storage Test Details

| Item | Value |
|---|---|
| Brand |  |
| Model |  |
| Capacity |  |
| Drive type |  |
| Partition table | MBR or GPT |
| Filesystem |  |
| Cluster size |  |
| Formatting tool |  |
| Current draw |  |
| Detected by router | Yes or no |
| Mounted by router | Yes or no |
| Hotplug works | Yes or no |
| Requires boot with drive inserted | Yes or no |
| PS2 service works | Yes or no |
| Notes |  |

---

## Filesystem Compatibility

Test each filesystem separately.

| Filesystem | Router Mounts | Service Works | PS2 Works | Notes |
|---|---|---|---|---|
| FAT32 |  |  |  |  |
| exFAT |  |  |  |  |
| ext4 |  |  |  |  |
| NTFS |  |  |  |  |

---

## Filesystem Notes

### FAT32

FAT32 is common and simple. It is useful for basic testing and older compatibility, but large file limits can matter.

### exFAT

exFAT is useful for large files and large drives. It may require extra OpenWrt support and may not fit easily on a stock 4 MB flash build.

### ext4

ext4 is useful for Linux and extroot testing, but it is less convenient for Windows users.

### NTFS

NTFS is not a primary target. It may be too heavy or unreliable on tiny OpenWrt builds.

---

## USB Hotplug Compatibility

Some firmware builds may not support plug-and-play USB behavior.

| Action | Result |
|---|---|
| USB inserted before router power-on |  |
| USB inserted after router boot |  |
| USB removed while service running |  |
| USB reinserted while service running |  |
| Service recovers without reboot |  |
| Router reboot required |  |

For builds without hotplug support, document:

```text
USB drive must be inserted before router power-on.
USB drive should be removed only after router power-off.
```

---

## Game Folder Layout Compatibility

Different loaders may expect different folder layouts.

Common examples:

```text
/DVD
/CD
/ART
/VMC
```

| Folder | Required | Present | Notes |
|---|---|---|---|
| DVD |  |  |  |
| CD |  |  |  |
| ART |  |  |  |
| VMC |  |  |  |
| CFG |  |  |  |

Do not assume one loader uses the same layout as another.

---

## Game Compatibility Testing

Game compatibility testing should be done carefully and legally.

This repo should not host game files.

Only record test results from legally owned backups or homebrew test content.

---

## Game Compatibility Table

| Game | Region | Format | Loader | Method | Boots | FMV | Gameplay | Notes |
|---|---|---|---|---|---|---|---|---|
|  | NTSC-U | ISO | OPL | SMB |  |  |  |  |
|  | NTSC-U | ISO | OPL UDPBD | UDPBD |  |  |  |  |
|  | NTSC-U | ISO | Neutrino | UDPFS |  |  |  |  |

---

## Game Result Labels

| Label | Meaning |
|---|---|
| Not Tested | Not tested |
| Boots | Reaches title screen or gameplay |
| Playable | Works during short gameplay |
| Stable | Repeated testing works |
| FMV Stutter | Video playback stutters |
| Slow Loads | Loading is noticeably slow |
| Freezes | Freezes during boot or play |
| Black Screen | Black screen after launch |
| Fails To List | Game does not appear |
| Fails To Boot | Game appears but does not boot |
| Needs Mode | Requires loader compatibility mode |
| Needs Retest | Result uncertain |

---

## Minimum Game Test

For each game:

1. Confirm game appears in loader.
2. Boot game.
3. Reach title screen.
4. Start gameplay.
5. Play or idle for at least 10 minutes.
6. Watch one FMV if the game has an early FMV.
7. Reset and repeat once.
8. Record result.

---

## Better Game Test

For stronger compatibility data:

1. Boot game three times.
2. Test early gameplay.
3. Test FMV.
4. Test save/load if relevant.
5. Test after warm reboot.
6. Test after cold boot.
7. Test inside closed PS2 shell.
8. Test after 30 minutes of router uptime.
9. Record transfer behavior and notes.

---

## Performance Compatibility

Performance should be recorded separately from basic compatibility.

A game may boot but still be unpleasant due to:

- FMV stutter
- Slow loading
- Random pauses
- Network dropouts
- USB storage delay
- Wi-Fi signal issues
- Router CPU/RAM limits

---

## Performance Test Table

| Test | Result | Notes |
|---|---|---|
| Games list load time |  |  |
| Game boot time |  |  |
| Early FMV behavior |  |  |
| Gameplay loading |  |  |
| In-game pauses |  |  |
| Long-run stability |  |  |
| Router CPU load |  |  |
| Router free RAM |  |  |
| Router temperature |  |  |

---

## Boot Timing Compatibility

Boot timing can make a compatible setup look broken.

For each PS2 method, test delays.

| Delay Before Loader | Result |
|---:|---|
| 0 seconds |  |
| 15 seconds |  |
| 30 seconds |  |
| 45 seconds |  |
| 60 seconds |  |
| 90 seconds |  |

Record:

| Event | Time |
|---|---:|
| Router power applied | 0 sec |
| Ethernet ready |  |
| Wi-Fi ready |  |
| USB mounted |  |
| Service ready |  |
| PS2 loader launched |  |
| Games list appears |  |

---

## Timing Compatibility Rule

If the first launch fails but relaunching the loader works, mark the result as:

```text
Timing Sensitive
```

Do not mark it as a complete fail until tested with a proper delay.

---

## Power Compatibility

Power source can affect compatibility.

| Power Source | Result | Notes |
|---|---|---|
| External USB power supply |  |  |
| PC USB port |  |  |
| PS2 USB port |  |  |
| Internal PS2 5 V rail |  |  |
| Dedicated buck regulator |  |  |
| Always-on auxiliary 5 V |  |  |

Record:

| Item | Value |
|---|---|
| Voltage idle |  |
| Voltage during boot |  |
| Current idle |  |
| Current active |  |
| USB storage current |  |
| Boot failures |  |
| Warm reboot failures |  |
| Notes |  |

---

## Power Compatibility Pass Criteria

Power passes if:

- Router boots reliably.
- USB storage does not brown out.
- Wi-Fi remains stable.
- Ethernet remains stable.
- PS2 does not show power-related issues.
- No backfeeding occurs.
- Warm reboot works.
- Rapid power cycle behavior is documented.

---

## Backfeed Compatibility

If the router is powered when the PS2 is off, test for backfeeding.

Possible backfeed paths:

- Ethernet lines
- USB lines
- UART lines
- GPIO lines
- Shared ground/power paths
- Controller board signals

| Test | Result |
|---|---|
| PS2 off, router on |  |
| PS2 LEDs off |  |
| No faint glow |  |
| No partial power |  |
| No unexpected current |  |
| Ethernet behavior normal |  |
| PS2 powers on normally after router has been on |  |

---

## Thermal Compatibility

A setup that works on the bench may fail inside the PS2.

| Test State | Result |
|---|---|
| Bare board on bench |  |
| Board with heatsink |  |
| Board inside PS2 shell open |  |
| Board inside PS2 shell closed |  |
| Board near RF shield |  |
| Board thermally coupled to RF shield |  |
| Long-run active load |  |

Record:

| Location | Temperature |
|---|---:|
| RT5350F SoC |  |
| RAM |  |
| Flash |  |
| USB drive |  |
| PS2 RF shield |  |
| PS2 shell above router |  |
| Ambient |  |

---

## Thermal Pass Criteria

Thermal compatibility passes if:

- Router does not freeze.
- Wi-Fi does not drop.
- USB storage does not disconnect.
- Ethernet remains stable.
- Service remains running.
- Temperature stabilizes.
- Closed-shell test passes.
- Warm reboot still works after heat soak.

---

## Wi-Fi Compatibility

Wi-Fi compatibility depends on antenna, PS2 shell, RF shield, and home network.

| Test | RSSI | Result | Notes |
|---|---:|---|---|
| Bare router near AP |  |  |  |
| Bare router normal distance |  |  |  |
| Router inside PS2 shell open |  |  |  |
| Router inside PS2 shell closed |  |  |  |
| Stock antenna |  |  |  |
| Repaired antenna |  |  |  |
| External antenna |  |  |  |

---

## Wi-Fi Pass Criteria

Wi-Fi passes if:

- Router connects reliably.
- Signal is stable.
- Ping test passes.
- FTP or SMB path works if required.
- Closed PS2 shell does not kill signal.
- Router reconnects after reboot.
- Router reconnects after home AP reboot.

---

## Antenna Placement Compatibility

For internal PS2 builds, record:

| Antenna Location | Result |
|---|---|
| Under RF shield |  |
| Near plastic shell |  |
| Near controller ports |  |
| Near fan |  |
| External pigtail |  |
| Hidden internal wire antenna |  |

Avoid placing the antenna directly under or against metal shielding unless testing proves it works.

---

## Ethernet Compatibility

Ethernet is critical for PS2 use.

Test both external and internal wiring.

| Ethernet Setup | Result | Notes |
|---|---|---|
| Stock A5-V11 RJ45 to PS2 cable |  |  |
| Short external cable |  |  |
| Internal direct wiring |  |  |
| Internal wiring with shell open |  |  |
| Internal wiring with shell closed |  |  |
| Ethernet through original PS2 port |  |  |

---

## Ethernet Pass Criteria

Ethernet passes if:

- Link comes up.
- Ping works.
- Loader connects.
- Transfer is stable.
- No packet loss during test.
- Internal wiring performs like external cable.
- Shell closing does not change behavior.

---

## Internal Fitment Compatibility

Internal compatibility is more than physical fit.

A successful internal install must pass:

- Physical clearance
- Electrical safety
- Power stability
- Ethernet stability
- Wi-Fi signal
- Thermal stability
- USB storage access
- UART service access
- Boot timing
- Loader test
- Closed-shell test

---

## Internal Fitment Test Table

| Item | Result | Notes |
|---|---|---|
| Shell closes fully |  |  |
| RF shield clears board |  |  |
| No short to shield |  |  |
| Fan path clear |  |  |
| Controller port area clear |  |  |
| USB storage accessible |  |  |
| UART accessible |  |  |
| Antenna usable |  |  |
| Heat path acceptable |  |  |
| Power wiring secure |  |  |
| Ethernet wiring secure |  |  |

---

## Firmware Compatibility

Firmware compatibility must be tied to flash size and board ID.

| Firmware | Flash Size | Board ID | Ethernet | Wi-Fi | USB | PS2 Result | Notes |
|---|---:|---|---|---|---|---|---|
| Stock firmware | 4 MB |  |  |  |  |  |  |
| OpenWrt 17.01.7 UDPBD | 4 MB |  |  |  |  |  |  |
| PS2 bridge build | 4 MB |  |  |  |  |  |  |
| PS2 bridge build | 16 MB |  |  |  |  |  |  |
| SMB1 build | 16 MB |  |  |  |  |  |  |
| UDPFS build | 16 MB |  |  |  |  |  |  |

---

## Firmware Pass Criteria

Firmware passes compatibility testing if:

- It boots repeatedly.
- UART output is normal.
- Ethernet works.
- Wi-Fi works if included.
- USB works if included.
- Required service starts.
- PS2 loader detects the service.
- Boot timing is documented.
- Power and thermal behavior are acceptable.
- Recovery method is documented.

---

## Flash Size Compatibility

Test firmware behavior by flash size.

| Flash Size | Expected Use | Result |
|---:|---|---|
| 4 MB | Minimal builds only |  |
| 8 MB | Experimental extra space |  |
| 16 MB | Preferred serious development |  |

4 MB builds should be treated as highly limited.

16 MB flash gives more room, but RAM is still limited.

---

## RAM Compatibility

The target A5-V11 should ideally have 32 MB RAM.

| RAM Chip | RAM Size | Result |
|---|---:|---|
| W9825G6EH-75 | 32 MB |  |
| EM63A165TS-6G | 32 MB |  |
| Unknown |  |  |
| 16 MB variant | 16 MB |  |

Do not assume a firmware build for 32 MB RAM will work on 16 MB RAM boards.

---

## Supervisor IC Compatibility

If using MAX809TTR, ADM809, or another supervisor IC, test before and after.

| Test | Without Supervisor | With Supervisor |
|---|---|---|
| Cold boot |  |  |
| Warm reboot |  |  |
| Rapid power cycle |  |  |
| USB attached boot |  |  |
| PS2 powered boot |  |  |
| Closed-shell boot |  |  |

Mark compatibility as improved only after repeated tests.

---

## Capacitor Mod Compatibility

Capacitor relocation or replacement can affect boot and USB stability.

| Test | Stock Caps | Modified Caps |
|---|---|---|
| Cold boot |  |  |
| Warm reboot |  |  |
| USB attached boot |  |  |
| Wi-Fi transfer |  |  |
| UDPBD active |  |  |
| SMB active |  |  |
| Closed-shell test |  |  |

A cap mod is compatible only if it does not introduce instability.

---

## Flipp'n Caps Compatibility

For the Flipp'n Caps PCB/Flex, test:

| Test | Result |
|---|---|
| Fits A5-V11 board |  |
| Capacitor polarity correct |  |
| No shorts |  |
| Supervisor footprint works |  |
| Router boots |  |
| USB storage works |  |
| Wi-Fi works |  |
| Fits PS2 mounting location |  |
| Shell closes |  |
| Thermal path acceptable |  |
| Long-run stable |  |

---

## Compatibility Test Flow

Recommended full test flow:

1. Identify A5-V11 board.
2. Back up flash and factory partition.
3. Confirm UART access.
4. Test stock boot.
5. Flash or install test firmware.
6. Confirm Ethernet.
7. Confirm Wi-Fi, if used.
8. Confirm USB storage, if used.
9. Confirm required service starts.
10. Test PS2 externally.
11. Test boot timing.
12. Test multiple power cycles.
13. Test target PS2 loader.
14. Test game list.
15. Test game boot.
16. Test gameplay.
17. Test thermal behavior.
18. Test inside PS2 shell open.
19. Test inside PS2 shell closed.
20. Record final result.

---

## Minimum Compatibility Test

For quick early testing:

| Step | Pass |
|---|---|
| Router boots |  |
| Ethernet works |  |
| UART accessible |  |
| USB storage mounts, if needed |  |
| Service starts |  |
| PS2 loader sees service |  |
| One game boots or FTP connects |  |
| Result repeated once |  |

This is only a minimum test.

It is not enough for a final internal install.

---

## Final Compatibility Test

For a final internal build:

| Step | Pass |
|---|---|
| 10 cold boots pass |  |
| 10 warm reboots pass |  |
| USB detected every time |  |
| Service ready every time |  |
| Loader sees service every time |  |
| Game boots repeatedly |  |
| 1 hour gameplay or idle test passes |  |
| Closed-shell thermal test passes |  |
| Wi-Fi signal acceptable, if used |  |
| No backfeed issue |  |
| UART recovery access confirmed |  |
| Recovery method documented |  |

---

## Compatibility Result Template

Use this for each test result.

```text
# Compatibility Test Result

## Test Info

Test ID:
Date:
Tester:
Result:
Status label:

## A5-V11 Hardware

Board ID:
PCB marking:
SoC:
RAM chip:
RAM size:
Flash chip:
Flash size:
Antenna:
Heatsink:
Supervisor IC:
Capacitor mod:
Other mods:

## A5-V11 Firmware

Firmware name:
Firmware version:
OpenWrt version:
Image type:
Default IP:
Network mode:
Service mode:
USB hotplug:
Boot delay required:

## PS2 Hardware

PS2 model:
Motherboard revision:
Power source:
Modchip:
Boot method:
Memory card type:
Internal or external router:

## PS2 Software

Loader:
Loader version:
Configuration:
OPL mode:
Network settings:
Special modes:

## Storage

Storage location:
Drive brand:
Drive model:
Drive size:
Partition table:
Filesystem:
Cluster size:
Folder layout:

## Network

Router IP:
PS2 IP:
PC/server IP:
Gateway:
Subnet:
Wi-Fi SSID:
Wi-Fi RSSI:
Ethernet setup:

## Timing

Router power-on:
Ethernet ready:
Wi-Fi ready:
USB mounted:
Service ready:
Loader launched:
Recommended delay:

## Test Result

Games list:
Game boot:
FTP:
SMB:
UDPBD:
UDPFS:
Gameplay:
FMV:
Long-run:
Thermal:
Power:
Notes:

## Final Result

Compatibility level:
Known issues:
Retest needed:
```

---

## Master Compatibility Matrix

Use this table for high-level tracking.

| Test ID | PS2 Model | Loader | Method | Firmware | Storage | Result | Notes |
|---|---|---|---|---|---|---|---|
| 001 | SCPH-79001 | OPL UDPBD | UDPBD |  | exFAT USB |  |  |
| 002 | SCPH-75001 | wLaunchELF | FTP |  | None |  |  |
| 003 | SCPH-77001 | OPL | SMB |  | USB SMB |  |  |
| 004 | SCPH-50001 | OPL | SMB bridge |  | PC share |  |  |
| 005 | SCPH-79001 | Neutrino | UDPFS |  | USB |  |  |

---

## Known Compatibility Risks

Important risks:

- A5-V11 board variations
- Firmware variation
- Bootloader variation
- 4 MB flash limits
- 32 MB RAM limits
- Wrong OPL build
- UDPBD version mismatch
- USB drive not mounted in time
- USB hotplug unsupported
- Wi-Fi antenna blocked by PS2 shield
- Router boots slower than PS2 loader
- Router powered from weak PS2 USB source
- Internal Ethernet wiring noise
- Heat inside closed shell
- Factory partition loss after flash upgrade

---

## Troubleshooting Compatibility Problems

### Problem: Loader Does Not See Games

Check:

- Correct loader version
- Correct method selected
- Router service ready
- USB drive mounted
- Correct folder layout
- Correct filesystem support
- Correct IP settings
- Boot delay long enough
- UART logs
- Service process running

### Problem: Works On Second Launch

Likely cause:

```text
Boot timing problem
```

Fix:

- Add delay
- Wait for service-ready
- Relaunch loader after router is ready
- Power router before PS2
- Improve firmware startup scripts

### Problem: Works On Bench But Not Inside PS2

Check:

- Heat
- Wi-Fi signal
- RF shield contact
- Power source
- Ethernet wiring
- Shell pressure on board
- Antenna placement
- USB drive clearance
- Grounding or shorts

### Problem: Works With One USB Drive But Not Another

Check:

- Current draw
- Filesystem
- Partition table
- Cluster size
- Drive initialization time
- Drive sleep/parking behavior
- USB hotplug support
- Mount script timing

### Problem: FTP Works But SMB Does Not

Check:

- SMB1/NT1 support
- Samba configuration
- Share name
- Username/password
- Guest access
- Firewall
- OPL settings
- USB mount path
- Router RAM usage

### Problem: SMB Works But UDPBD Does Not

Check:

- Correct UDPBD-capable OPL build
- UDPBD server running
- USB drive connected to router, not PS2
- Correct storage path
- Correct firmware
- Boot timing
- Network mode
- Router logs

### Problem: UDPBD Works Only Sometimes

Check:

- Router boot timing
- USB detection timing
- Power stability
- Warm reboot reliability
- USB drive current draw
- Supervisor IC need
- Heat
- Service startup script

### Problem: Wi-Fi Bridge Works But PS2 FTP Is Not Reachable

Check:

- Bridge versus NAT mode
- PS2 IP subnet
- PC IP subnet
- Firewall
- Wi-Fi client isolation
- Gateway settings
- Passive/active FTP
- Whether PC can ping PS2

### Problem: Router Freezes During Test

Check:

- Heat
- Power sag
- USB drive load
- RAM usage
- CPU load
- Bad firmware build
- Supervisor IC need
- Capacitor mod instability

---

## Compatibility Folder Structure

Suggested repo structure:

```text
PS2-Integration/
├── Compatibility-Testing.md
├── Compatibility-Matrix.md
├── Test-Results/
│   ├── FTP/
│   ├── SMB/
│   ├── UDPBD/
│   ├── UDPFS/
│   ├── WiFi-Bridge/
│   └── Internal-Installs/
└── Game-Compatibility/
    ├── README.md
    ├── SMB.md
    ├── UDPBD.md
    └── UDPFS.md
```

---

## Compatibility File Naming

Suggested file names:

```text
test-001-scph-79001-udpbd-a5v11-board003.md
test-002-scph-75001-ftp-bridge-board001.md
test-003-scph-77001-smb-router-hosted-board004.md
test-004-scph-50001-smb-bridge-board002.md
```

Use simple names that include:

- Test number
- PS2 model
- Method
- Board ID

---

## Compatibility Matrix Columns

Recommended columns for a spreadsheet or markdown table:

```text
Test ID
Date
PS2 Model
PS2 Board Revision
Boot Method
Loader
Loader Version
A5-V11 Board ID
A5 Firmware
Flash Size
Network Mode
Storage Device
Filesystem
Power Source
Boot Delay
Shell State
Result
Issue Label
Notes
```

---

## Legal And Repo Safety Note

This repo should not host:

- Game ISOs
- PS2 BIOS files
- Commercial software
- Copyrighted game assets
- Piracy-focused instructions

Compatibility results should be based on legally owned backups or homebrew test files.

The repo may document folder structure, loader settings, and network behavior without hosting copyrighted content.

---

## Recommended First Compatibility Targets

Start with the simplest tests first.

Recommended order:

1. FTP through wLaunchELF using A5-V11 as bridge.
2. Ethernet-only UDPBD with USB connected to A5-V11.
3. Router-hosted USB storage detection.
4. OPL SMB using external PC or NAS share through A5-V11 bridge.
5. Router-hosted SMB from A5-V11 USB storage.
6. UDPFS testing with exact loader and server versions.
7. Internal PS2 closed-shell testing.
8. Long-run thermal and gameplay testing.

---

## Recommended Known-Good Baseline

Create one known-good baseline setup and test everything else against it.

Baseline should include:

- One known-good A5-V11 board
- Known-good flash backup
- Known-good firmware
- Known-good PS2 model
- Known-good loader
- Known-good USB drive
- Known-good filesystem
- Known-good power source
- Known-good Ethernet cable
- Known-good timing delay

Once the baseline works, change only one variable at a time.

---

## Change One Variable At A Time

Do not change multiple things during compatibility testing.

Bad test:

```text
New firmware, new USB drive, new PS2 model, new loader, and new antenna all at once.
```

Good test:

```text
Same setup as baseline, only change USB drive.
```

This makes failures easier to understand.

---

## Short Version

Compatibility testing must be specific.

Always record:

- PS2 model
- Loader version
- A5-V11 board ID
- A5-V11 firmware
- Flash size
- Network mode
- USB drive
- Filesystem
- Power source
- Boot delay
- Result

A setup is only compatible under the conditions that were actually tested.

For final PS2 internal installs, compatibility must include closed-shell thermal testing, power testing, boot timing testing, and a documented recovery plan.

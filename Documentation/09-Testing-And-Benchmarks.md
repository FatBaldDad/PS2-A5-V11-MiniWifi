# 09 - Testing And Benchmarks

## Summary

This document defines how to test and benchmark the A5-V11 mini router.

The goal is to create repeatable testing methods for stock boards, modified boards, OpenWrt builds, PS2-focused firmware, flash upgrades, thermal improvements, antenna changes, and internal PlayStation 2 installs.

The A5-V11 is small and limited, so testing matters.

A board that works on the bench may fail when:

- Installed inside a PS2
- Powered from the PS2
- Used with USB storage
- Used over Wi-Fi
- Used after a warm reboot
- Used with a different firmware build
- Used with a different USB drive
- Used after capacitor relocation
- Used without a heatsink
- Used with the PS2 RF shield installed

This document should be used to make testing consistent.

## Main Testing Goals

Testing should answer these questions:

- Does the board boot reliably?
- Does UART work?
- Does Ethernet work?
- Does Wi-Fi work?
- Does USB storage work?
- Does the board run too hot?
- Does the board draw too much current?
- Does it recover after warm reboot?
- Does the firmware have enough free RAM?
- Does the firmware have enough free flash/overlay space?
- Does the PS2 detect the network service?
- Does the PS2 loader work reliably?
- Does the router remain stable inside a PS2 shell?
- Do hardware mods improve or hurt reliability?

## Test Categories

The repo should track these test categories:

| Category | Purpose |
|---|---|
| Board identification | Confirm exact hardware |
| Flash backup | Confirm recoverability |
| Boot testing | Confirm startup reliability |
| UART testing | Confirm debug/recovery access |
| Power testing | Measure current draw and voltage stability |
| Thermal testing | Check heat and cooling mods |
| Ethernet testing | Check wired network performance |
| Wi-Fi testing | Check wireless connection and range |
| USB testing | Check storage detection and stability |
| Filesystem testing | Check FAT32, exFAT, ext4, etc. |
| Firmware testing | Check OpenWrt build behavior |
| Service testing | Check SMB, FTP, UDPBD, UDPFS |
| PS2 testing | Check actual console behavior |
| Internal fitment testing | Check function inside PS2 shell |
| Long-run testing | Check stability over time |

## Test Status Labels

Use these labels throughout the repo.

| Label | Meaning |
|---|---|
| Not Tested | No test has been performed |
| Bench Tested | Tested outside a PS2 |
| PS2 Bench Tested | Tested with PS2 externally connected |
| PS2 Internal Tested | Tested inside PS2 shell |
| Pass | Test passed |
| Fail | Test failed |
| Partial Pass | Works with limitations |
| Unstable | Works sometimes but not reliably |
| Needs Retest | Result is old, unclear, or changed |
| Blocked | Test cannot continue due to another issue |

## Test Environment Template

Every test should document the environment.

```text
Test name:
Date:
Tester:
Board ID:
PCB marking:
SoC:
RAM chip:
RAM size:
Flash chip:
Flash size:
Firmware name:
OpenWrt version:
Firmware build date:
Firmware image type:
Bootloader:
Power source:
USB drive:
Filesystem:
Ethernet setup:
Wi-Fi setup:
PS2 model, if used:
PS2 loader, if used:
Room temperature:
Shell/case state:
Heatsink installed:
Supervisor IC installed:
Capacitor mod installed:
Antenna mod installed:
Notes:
```

## Units And Naming

Use clear units.

| Measurement | Preferred Unit |
|---|---|
| Voltage | V |
| Current | mA |
| Power | W |
| Temperature | °C |
| Boot time | seconds |
| Transfer speed | MB/s |
| Network speed | Mbps or MB/s, but label clearly |
| File size | MB or GB |
| Signal strength | dBm when available |

## MB/s Versus Mbps

Be careful with speed units.

| Unit | Meaning |
|---|---|
| MB/s | Megabytes per second |
| Mbps | Megabits per second |

Conversion:

```text
1 MB/s = 8 Mbps
```

Example:

```text
4.2 MB/s = 33.6 Mbps
```

If a test result is copied from another source, keep the original unit but add a note if the unit may be ambiguous.

## Minimum Test Equipment

Recommended minimum equipment:

- 5 V power supply
- USB power meter
- Multimeter
- 3.3 V USB-to-TTL UART adapter
- Ethernet cable
- PC or laptop with Ethernet
- Known-good USB flash drive
- Known-good microSD/USB adapter if used
- Stopwatch or timer
- IR thermometer or thermal camera
- Wi-Fi signal measurement app or tool
- CH341A or equivalent SPI programmer

## Recommended Test Equipment

Better test setup:

- Current-limited bench power supply
- Oscilloscope
- Logic analyzer
- Thermal camera
- USB load tester
- Managed Ethernet switch
- Wi-Fi analyzer
- Multiple USB drives
- Multiple A5-V11 boards
- Known-good PS2 console
- Known-good PS2 memory card setup
- Known-good OPL or loader build
- Known-good network share or test PC
- UART log capture setup

## Safety Rules For Testing

Follow these rules:

- Back up the original flash before firmware tests.
- Use 3.3 V UART only.
- Do not connect UART VCC during normal serial use.
- Use current-limited power when possible.
- Check for shorts after hardware mods.
- Do not run the board unattended during first thermal tests.
- Do not install inside a PS2 until bench tests pass.
- Do not test unknown firmware on the only working board.
- Keep UART connected during first boot of new firmware.
- Keep a known-good recovery image available.

## Baseline Stock Board Test

Run this before any modifications.

| Test | Result |
|---|---|
| Board photos taken |  |
| SoC identified |  |
| RAM identified |  |
| Flash identified |  |
| Stock power-on LED behavior recorded |  |
| Stock Ethernet link works |  |
| Stock IP found |  |
| Stock web UI tested |  |
| Stock telnet tested |  |
| UART boot log captured |  |
| Full flash dumped |  |
| Factory partition saved |  |
| Wi-Fi scan tested |  |
| USB storage tested, if stock firmware supports it |  |
| Idle current measured |  |
| Heat checked after 10 minutes |  |

## Board Identification Benchmark

This is not a performance benchmark. It confirms that the board is known before testing.

Record:

| Item | Value |
|---|---|
| Board ID |  |
| Shell marking |  |
| PCB marking |  |
| SoC marking |  |
| RAM chip |  |
| RAM size |  |
| Flash chip |  |
| Flash size |  |
| MAC address |  |
| Stock firmware version |  |
| Bootloader version |  |
| UART baud rate |  |
| Factory partition saved |  |

Pass criteria:

- Board identity is documented.
- UART log exists.
- Original flash backup exists.
- Factory partition is saved.

## Flash Backup Verification Test

Purpose:

Confirm that the board can be recovered before risky testing.

Steps:

1. Read flash twice with programmer.
2. Compare both reads.
3. Confirm file size.
4. Confirm dump is not all `FF`.
5. Confirm dump is not all `00`.
6. Extract factory partition.
7. Save checksums.

Example commands:

```text
sha256sum board-001-read1.bin
sha256sum board-001-read2.bin
cmp board-001-read1.bin board-001-read2.bin
```

Expected result:

- Reads match.
- Dump size matches flash size.
- Factory partition is saved.

## Boot Reliability Test

Purpose:

Confirm the router boots repeatedly without freezing.

Test states:

- Cold boot
- Warm reboot
- Rapid power cycle
- Reboot command
- Power loss and restore
- USB drive attached
- USB drive removed
- After PS2 power cycle

Suggested test count:

| Test | Count |
|---|---:|
| Cold boot | 10 |
| Warm reboot | 10 |
| Rapid power cycle | 5 |
| Boot with USB drive | 10 |
| Boot without USB drive | 5 |
| Boot inside PS2 shell | 10 |

Record:

| Attempt | Result | Boot Time | Notes |
|---:|---|---:|---|
| 1 |  |  |  |
| 2 |  |  |  |
| 3 |  |  |  |
| 4 |  |  |  |
| 5 |  |  |  |

Pass criteria:

- No hangs.
- No repeated boot loops.
- UART log reaches login or service-ready state.
- Ethernet comes up.
- Wi-Fi comes up if required.
- USB mounts if required.

## Boot Time Test

Purpose:

Measure how long the board takes to become useful.

Measure these times:

| Event | Time From Power-On |
|---|---:|
| First LED activity |  |
| First UART output |  |
| U-Boot starts |  |
| Kernel starts |  |
| Ethernet link active |  |
| OpenWrt console ready |  |
| USB drive detected |  |
| USB drive mounted |  |
| Wi-Fi associated |  |
| Web UI reachable |  |
| SSH reachable |  |
| SMB service ready |  |
| UDPBD service ready |  |
| UDPFS service ready |  |
| FTP reachable |  |

Suggested method:

- Start timer when 5 V is applied.
- Use UART timestamps if available.
- Use ping from PC.
- Use service-specific connection test.

Example ping command from PC:

```text
ping 192.168.1.222
```

Example Linux timestamped ping:

```text
ping 192.168.1.222 | while read line; do echo "$(date +%H:%M:%S) $line"; done
```

## PS2 Boot Timing Test

Purpose:

Determine whether the router is ready before the PS2 loader starts.

Important because some PS2 workflows power the router from the PS2, so the router and PS2 start at the same time.

Record:

| Event | Time |
|---|---:|
| PS2 power on | 0 sec |
| Router power on | 0 sec or other |
| Router Ethernet ready |  |
| Router USB mounted |  |
| Router service ready |  |
| FMCB menu visible |  |
| OPL launched |  |
| Games list visible |  |

Pass criteria:

- Router service is ready before the PS2 loader needs it.

If fail:

- Add PS2-side delay.
- Launch loader manually after waiting.
- Power router before PS2.
- Keep router always powered.
- Add firmware ready indicator.
- Add service-start delay handling.

## Power Consumption Test

Purpose:

Measure current draw in different modes.

Use:

- USB power meter
- Bench supply
- Multimeter in series
- Oscilloscope for transient testing if available

Record voltage and current.

| Test State | Voltage | Current | Power | Notes |
|---|---:|---:|---:|---|
| Power off leakage |  |  |  |  |
| Boot peak |  |  |  |  |
| Idle, Ethernet only |  |  |  |  |
| Idle, Wi-Fi on |  |  |  |  |
| Wi-Fi connected |  |  |  |  |
| Ethernet active transfer |  |  |  |  |
| USB flash drive attached idle |  |  |  |  |
| USB SSD attached idle |  |  |  |  |
| UDPBD active |  |  |  |  |
| SMB active |  |  |  |  |
| FTP active |  |  |  |  |
| Unused PHYs disabled |  |  |  |  |
| Inside PS2, idle |  |  |  |  |
| Inside PS2, active |  |  |  |  |

## Power Calculation

Use:

```text
Power in watts = Voltage x Current
```

Example:

```text
5.0 V x 0.200 A = 1.0 W
```

## Unused Ethernet PHY Power Test

Purpose:

Measure power difference when unused internal Ethernet PHYs are disabled.

Known OpenWrt reference notes report a large current reduction when unused ports are disabled, so this should be tested on each firmware and board.

Commands to test:

```text
swconfig dev switch0 port 1 set disable 1
swconfig dev switch0 port 2 set disable 1
swconfig dev switch0 port 3 set disable 1
swconfig dev switch0 port 4 set disable 1
swconfig dev switch0 set apply
```

Test table:

| State | Current | Temperature | Ethernet Works | Notes |
|---|---:|---:|---|---|
| Before disabling ports |  |  |  |  |
| After disabling ports |  |  |  |  |
| After reboot |  |  |  |  |
| After adding to rc.local |  |  |  |  |

Pass criteria:

- Current decreases.
- Ethernet still works.
- No network instability.
- Setting survives reboot if intended.

Warning:

Do not permanently add these commands until tested.

## Voltage Stability Test

Purpose:

Confirm the 5 V rail stays stable.

Test conditions:

- Boot
- Wi-Fi connect
- USB drive startup
- UDPBD active
- SMB active
- PS2 power-on
- PS2 reset
- Warm reboot
- Rapid power cycle

Record:

| Test | Min Voltage | Max Voltage | Current Peak | Result |
|---|---:|---:|---:|---|
| Cold boot |  |  |  |  |
| USB drive attached |  |  |  |  |
| Wi-Fi association |  |  |  |  |
| UDPBD active |  |  |  |  |
| PS2 power on |  |  |  |  |
| PS2 reset |  |  |  |  |

Pass criteria:

- Voltage does not sag enough to reset the router.
- USB drive does not cause brownout.
- No freeze during power events.

## Thermal Test

Purpose:

Measure how hot the board gets.

Test states:

- Bare board
- Stock plastic shell
- With heatsink
- With copper spreader
- Coupled to PS2 RF shield
- Inside PS2 shell
- Wi-Fi active
- USB active
- UDPBD active
- SMB active
- Long-run idle

Record temperature at these points:

| Location | Temperature |
|---|---:|
| Room ambient |  |
| RT5350F SoC |  |
| RAM chip |  |
| Flash chip |  |
| Voltage regulator area |  |
| USB power area |  |
| Ethernet area |  |
| Capacitors |  |
| PS2 RF shield near router |  |
| PS2 shell above router |  |

## Thermal Test Durations

Suggested durations:

| Test | Duration |
|---|---:|
| Initial safety check | 5 minutes |
| Idle thermal test | 30 minutes |
| Active transfer test | 30 minutes |
| PS2 internal closed-shell test | 60 minutes |
| Long-run stability test | 4 hours |
| Extended reliability test | 24 hours |

## Thermal Pass Criteria

Suggested pass criteria:

- No thermal shutdown.
- No Wi-Fi dropouts.
- No USB disconnects.
- No Ethernet dropouts.
- No boot lockup after warm restart.
- No part becomes dangerously hot.
- Temperature is stable or reaches a safe plateau.

Exact acceptable temperature limits should be refined with testing.

## Heatsink Comparison Test

Purpose:

Compare thermal mods.

| Configuration | SoC Temp Idle | SoC Temp Active | Current | Stability |
|---|---:|---:|---:|---|
| No heatsink |  |  |  |  |
| Small heatsink |  |  |  |  |
| Copper plate |  |  |  |  |
| RF shield thermal pad |  |  |  |  |
| RF shield plus copper spreader |  |  |  |  |

Record photos of each setup.

## Antenna Test

Purpose:

Measure Wi-Fi signal and stability.

Test conditions:

- Stock antenna
- Repaired stock antenna
- External antenna
- Inside PS2 shell open
- Inside PS2 shell closed
- Near PS2 RF shield
- Different board orientations
- Different antenna locations

Record:

| Test | RSSI | Link Rate | Packet Loss | Notes |
|---|---:|---:|---:|---|
| Bare board near router |  |  |  |  |
| Bare board one room away |  |  |  |  |
| Inside PS2 shell open |  |  |  |  |
| Inside PS2 shell closed |  |  |  |  |
| External antenna |  |  |  |  |

## Wi-Fi Scan Commands

OpenWrt examples:

```text
iwinfo
wifi status
iw dev
iw dev wlan0 scan
logread | grep wlan
```

Available commands depend on firmware packages.

## Wi-Fi Stability Test

Purpose:

Confirm the router stays connected to the home Wi-Fi.

Test duration:

- 30 minutes minimum
- 4 hours recommended
- 24 hours for final internal build

Record:

| Time | RSSI | Ping Result | Notes |
|---|---:|---|---|
| 0 min |  |  |  |
| 15 min |  |  |  |
| 30 min |  |  |  |
| 1 hour |  |  |  |
| 4 hours |  |  |  |
| 24 hours |  |  |  |

Ping test from PC:

```text
ping <router-ip>
```

Ping test from router:

```text
ping 192.168.1.1
```

## Wi-Fi Throughput Test

Purpose:

Measure wireless network performance.

Best method if iperf is available:

On PC:

```text
iperf3 -s
```

On router:

```text
iperf3 -c <pc-ip>
```

If iperf3 is too large for the router, use file transfer testing instead.

Record:

| Test | Direction | Speed | RSSI | Notes |
|---|---|---:|---:|---|
| Router to PC | Upload |  |  |  |
| PC to router | Download |  |  |  |
| PS2 FTP through router | Transfer |  |  |  |
| SMB through router | Transfer |  |  |  |
| UDPBD through router | Transfer |  |  |  |

## Ethernet Link Test

Purpose:

Confirm wired Ethernet works.

Test:

- Connect router to PC or switch.
- Confirm link LED if available.
- Confirm ping.
- Confirm IP address.
- Confirm file transfer.

Record:

| Test | Result |
|---|---|
| Ethernet link detected |  |
| Router gets DHCP |  |
| Static IP reachable |  |
| Ping from PC to router |  |
| Ping from router to PC |  |
| SSH or telnet reachable |  |
| Web UI reachable |  |

## Ethernet Throughput Test

Purpose:

Measure wired speed.

Use iperf if available.

PC server:

```text
iperf3 -s
```

Router client:

```text
iperf3 -c <pc-ip>
```

If iperf is unavailable, use file copy or service-specific transfer.

Record:

| Test | Speed | CPU Load | Notes |
|---|---:|---:|---|
| Ethernet upload |  |  |  |
| Ethernet download |  |  |  |
| Ethernet with unused PHYs disabled |  |  |  |
| Ethernet inside PS2 wiring |  |  |  |

## Internal PS2 Ethernet Wiring Test

Purpose:

Confirm the internal wiring does not degrade Ethernet.

Compare:

1. External cable from PS2 to router
2. Internal short wiring
3. Final closed-shell install

Record:

| Setup | Link | Ping | Transfer | Notes |
|---|---|---|---|---|
| External cable |  |  |  |  |
| Internal wiring, shell open |  |  |  |  |
| Internal wiring, shell closed |  |  |  |  |

Pass criteria:

- Link remains stable.
- No packet loss.
- Transfer does not stall.
- PS2 loader behaves the same or better than external cable.

## USB Detection Test

Purpose:

Confirm USB storage detection.

Router commands:

```text
dmesg | grep usb
dmesg | grep sda
ls /dev/sd*
mount
df -h
block info
```

Record:

| USB Device | Detected | Device Node | Mounted | Notes |
|---|---|---|---|---|
| USB flash drive |  |  |  |  |
| USB SSD |  |  |  |  |
| USB HDD |  |  |  |  |
| USB card reader |  |  |  |  |

## USB Hotplug Test

Purpose:

Determine whether the firmware supports plug-and-play USB behavior.

Test states:

| Test | Result |
|---|---|
| USB inserted before power-on |  |
| USB inserted after boot |  |
| USB removed after boot |  |
| USB reinserted after removal |  |
| Service restarts after reinsertion |  |
| Router requires reboot |  |

Pass criteria depends on firmware goal.

For some minimal PS2 firmware, it may be acceptable if USB must be connected before power-on, but this must be documented clearly.

## Filesystem Compatibility Test

Test each filesystem separately.

| Filesystem | Detected | Mounted | Read | Write | PS2 Service Works | Notes |
|---|---|---|---|---|---|---|
| FAT32 |  |  |  |  |  |  |
| exFAT |  |  |  |  |  |  |
| ext4 |  |  |  |  |  |  |
| NTFS |  |  |  |  |  |  |

Record formatting details:

| Detail | Value |
|---|---|
| Partition table | MBR or GPT |
| Cluster size |  |
| Formatting tool |  |
| Drive size |  |
| Drive model |  |
| Filesystem package |  |

## USB Storage Speed Test

Purpose:

Measure raw USB storage performance on the router.

Simple write test:

```text
time dd if=/dev/zero of=/mnt/usb/testfile.bin bs=1M count=64 conv=fsync
```

Simple read test:

```text
time dd if=/mnt/usb/testfile.bin of=/dev/null bs=1M
```

Warning:

This writes a test file to the USB drive.

Delete after testing:

```text
rm /mnt/usb/testfile.bin
```

Record:

| Drive | Filesystem | Write MB/s | Read MB/s | Notes |
|---|---|---:|---:|---|
|  |  |  |  |  |

## Flash / Overlay Space Test

Purpose:

Confirm available storage after firmware boot.

Commands:

```text
df -h
mount
cat /proc/mtd
```

Record:

| Item | Value |
|---|---:|
| Firmware image size |  |
| Rootfs size |  |
| Overlay size |  |
| Overlay free |  |
| `/tmp` free |  |
| Installed packages |  |

Pass criteria:

- Enough space to save settings.
- Enough space for required scripts.
- No `No space left on device` errors.
- Firmware role fits target flash size.

## RAM Usage Test

Purpose:

Confirm enough memory remains during operation.

Commands:

```text
free
top
ps
cat /proc/meminfo
```

Test states:

| State | Free RAM | Used RAM | Notes |
|---|---:|---:|---|
| After boot |  |  |  |
| Wi-Fi connected |  |  |  |
| USB mounted |  |  |  |
| SMB running |  |  |  |
| UDPBD running |  |  |  |
| UDPFS running |  |  |  |
| During transfer |  |  |  |
| After 1 hour |  |  |  |

Pass criteria:

- No out-of-memory events.
- No service crashes.
- Memory usage remains stable over time.

## CPU Load Test

Purpose:

Determine how heavily services load the RT5350F.

Commands:

```text
top
uptime
cat /proc/loadavg
```

Record:

| Service | Idle Load | Active Load | Notes |
|---|---:|---:|---|
| Wi-Fi bridge |  |  |  |
| SMB |  |  |  |
| UDPBD |  |  |  |
| UDPFS |  |  |  |
| FTP |  |  |  |
| Web UI |  |  |  |

## Service Start Test

Purpose:

Confirm services start correctly after boot.

Services may include:

- network
- wireless
- dropbear
- uhttpd
- samba
- udpbd
- udpfs
- custom mount script
- custom PS2 mode script

Commands:

```text
logread
ps
netstat -lntup
/etc/init.d/<service> status
```

Record:

| Service | Starts At Boot | Manual Start Works | Notes |
|---|---|---|---|
| network |  |  |  |
| wireless |  |  |  |
| dropbear |  |  |  |
| uhttpd |  |  |  |
| samba |  |  |  |
| udpbd |  |  |  |
| udpfs |  |  |  |

## FTP Test

Purpose:

Test PS2 FTP access through the A5-V11.

Possible test setups:

- PC to PS2 through A5-V11 Wi-Fi bridge
- PC to PS2 through A5-V11 Ethernet
- PS2 wLaunchELF FTP server reachable from PC

Record:

| Item | Value |
|---|---|
| PS2 model |  |
| PS2 IP |  |
| Router IP |  |
| PC IP |  |
| Network mode | Bridge or routed |
| FTP client |  |
| File size |  |
| Transfer speed |  |
| Stability |  |
| Notes |  |

Pass criteria:

- PC can ping PS2.
- FTP connects.
- File transfer completes.
- Connection remains stable.

## SMB1 / OPL Test

Purpose:

Test OPL SMB access.

Record:

| Item | Value |
|---|---|
| OPL version |  |
| SMB server | A5-V11 or external |
| SMB protocol |  |
| Share path |  |
| USB filesystem |  |
| Game format | ISO or other |
| PS2 IP |  |
| Router IP |  |
| Server IP |  |
| Games list appears |  |
| Game boots |  |
| FMV stutter |  |
| Load times |  |
| Stability |  |

Pass criteria:

- OPL connects.
- Games list appears.
- Game boots.
- No repeated disconnects.
- Performance is acceptable for the target use.

## UDPBD Test

Purpose:

Test UDPBD loading through the A5-V11.

Record exact software versions.

| Item | Value |
|---|---|
| Router firmware |  |
| UDPBD server version |  |
| OPL UDPBD build |  |
| USB drive |  |
| Filesystem |  |
| PS2 model |  |
| PS2 IP |  |
| Router IP |  |
| Wi-Fi enabled |  |
| Ethernet only |  |
| Games list appears |  |
| Game boots |  |
| Measured speed |  |
| Stability |  |
| Notes |  |

Important test notes:

- Some UDPBD setups require a specific OPL build.
- Some builds require the USB drive to be inserted before router power-on.
- Some builds do not support USB hotplug.
- Router boot timing matters.
- If the games list is missing, test the same UDPBD storage setup from a PC first.

## UDPBD Speed Test

Record speed clearly.

| Test | Speed | Unit | Notes |
|---|---:|---|---|
| Claimed/reference speed |  | MB/s or Mbps |  |
| Measured game list load |  | seconds |  |
| Measured file transfer |  | MB/s |  |
| In-game load behavior |  | qualitative |  |
| FMV behavior |  | qualitative |  |

Use consistent units.

If recording a value like `4.2mb/s`, clarify whether the source meant `MB/s` or `Mb/s`.

## UDPFS Test

Purpose:

Test UDPFS or newer PS2 network-loading experiments.

Record:

| Item | Value |
|---|---|
| Router firmware |  |
| UDPFS server version |  |
| PS2 loader |  |
| Loader version |  |
| USB drive |  |
| Filesystem |  |
| Network mode |  |
| PS2 model |  |
| Games list appears |  |
| Game boots |  |
| Speed |  |
| Stability |  |
| Notes |  |

## Game Compatibility Test

Purpose:

Track PS2 game behavior with the A5-V11.

| Game | Region | Loader | Method | Boots | FMV | Gameplay | Notes |
|---|---|---|---|---|---|---|---|
|  |  | OPL | SMB |  |  |  |  |
|  |  | OPL UDPBD | UDPBD |  |  |  |  |
|  |  | Neutrino | UDPFS |  |  |  |  |

Suggested result values:

- Pass
- Fail
- Boots only
- FMV stutter
- Slow loading
- Freezes
- Needs retest

## Long-Run Stability Test

Purpose:

Find issues that do not appear in short tests.

Suggested tests:

| Test | Duration |
|---|---:|
| Idle with Wi-Fi connected | 4 hours |
| Idle with USB mounted | 4 hours |
| Continuous ping | 4 hours |
| Repeated file transfer | 1 hour |
| UDPBD game idle | 1 hour |
| PS2 game running | 1 hour |
| Closed PS2 shell test | 4 hours |
| Final confidence test | 24 hours |

Record:

| Time | Status | Temperature | Wi-Fi | USB | Notes |
|---|---|---:|---|---|---|
| Start |  |  |  |  |  |
| 30 min |  |  |  |  |  |
| 1 hour |  |  |  |  |  |
| 4 hours |  |  |  |  |  |
| 24 hours |  |  |  |  |  |

## Reboot Stress Test

Purpose:

Test reset reliability.

| Attempt | Cold Boot | Warm Reboot | USB Attached | Result |
|---:|---|---|---|---|
| 1 |  |  |  |  |
| 2 |  |  |  |  |
| 3 |  |  |  |  |
| 4 |  |  |  |  |
| 5 |  |  |  |  |
| 10 |  |  |  |  |

Special test:

- Boot with supervisor IC
- Boot without supervisor IC
- Boot after quick power cycle
- Boot after 5-second power-off delay
- Boot after 30-second power-off delay

Pass criteria:

- Router reliably reaches service-ready state.

## Supervisor IC Test

Purpose:

Determine whether MAX809TTR, ADM809, or another supervisor IC improves boot reliability.

Record:

| Test | Without Supervisor | With Supervisor |
|---|---|---|
| Cold boot pass count |  |  |
| Warm reboot pass count |  |  |
| Rapid power cycle pass count |  |  |
| USB attached boot pass count |  |  |
| Failed boots |  |  |
| Notes |  |  |

Also record:

| Item | Value |
|---|---|
| Supervisor part number |  |
| Threshold voltage |  |
| Reset delay |  |
| Wiring method |  |
| Mounted on board/flex |  |
| Tested firmware |  |

## Capacitor Mod Test

Purpose:

Confirm capacitor relocation or replacement does not hurt stability.

Test before and after:

| Test | Stock Caps | Modified Caps |
|---|---|---|
| Cold boot |  |  |
| Warm reboot |  |  |
| USB attached boot |  |  |
| Wi-Fi transfer |  |  |
| Ethernet transfer |  |  |
| UDPBD active |  |  |
| Voltage sag |  |  |
| Heat |  |  |
| Current draw |  |  |

Record:

| Capacitor | Stock Value | Replacement | Notes |
|---|---:|---|---|
| C1 |  |  |  |
| C2 |  |  |  |
| C3 |  |  |  |

Pass criteria:

- No new boot issues.
- No USB resets.
- No Wi-Fi instability.
- No voltage sag under load.
- No overheating.

## Flipp'n Caps PCB/Flex Test

Purpose:

Validate the capacitor relocation helper board or flex.

Test:

| Test | Result |
|---|---|
| Visual inspection |  |
| Continuity check |  |
| No shorts |  |
| Fits A5-V11 |  |
| Fits PS2 location |  |
| Caps oriented correctly |  |
| Supervisor footprint works |  |
| Cold boot |  |
| Warm reboot |  |
| USB load |  |
| Wi-Fi load |  |
| Thermal test |  |
| PS2 shell closed |  |

Record photos:

- Top
- Bottom
- Installed on A5-V11
- Installed inside PS2
- Clearance to RF shield
- Clearance to shell
- Thermal pad/contact area

## PS2 Internal Fitment Test

Purpose:

Confirm physical and electrical fitment inside a PS2.

Record:

| Item | Value |
|---|---|
| PS2 model |  |
| Motherboard revision |  |
| Mounting location |  |
| Router orientation |  |
| RF shield modified |  |
| Heatsink method |  |
| Antenna location |  |
| Power source |  |
| Ethernet wiring method |  |
| USB storage location |  |
| UART service access |  |
| Reset access |  |
| Shell closes fully |  |
| Fan clearance |  |
| Controller port clearance |  |
| Optical drive present |  |
| Notes |  |

Pass criteria:

- Shell closes without pressure.
- Router does not short to RF shield.
- Thermal path is safe.
- Wi-Fi signal remains usable.
- Ethernet remains stable.
- UART service access remains possible.

## PS2 Power-Off Behavior Test

Purpose:

Determine how the A5-V11 behaves when the PS2 is off.

Test cases:

| Test | Result |
|---|---|
| Router powered only when PS2 is on |  |
| Router powered while PS2 is off |  |
| Ethernet connected while PS2 is off |  |
| Router reachable while PS2 is off |  |
| Router USB storage reachable while PS2 is off |  |
| PS2 Ethernet lines inactive but router on |  |
| No backfeed into PS2 |  |
| No phantom power issue |  |

Important:

If the router remains powered when the PS2 is off, test for backfeeding through Ethernet, USB, or signal lines.

## Network Topology Test

Purpose:

Document how the A5-V11 is being used.

Possible modes:

| Mode | Description |
|---|---|
| Bridge | PS2 and home network appear on same subnet |
| Routed | A5-V11 routes between PS2 side and Wi-Fi side |
| NAT | PS2 is behind A5-V11 NAT |
| Server | A5-V11 serves files directly to PS2 |
| Client | A5-V11 connects to another server |
| Ethernet-only | Wi-Fi disabled |
| Wi-Fi-only bridge | Ethernet to Wi-Fi for PS2 |

Record:

| Item | Value |
|---|---|
| Mode |  |
| Router IP |  |
| PS2 IP |  |
| PC IP |  |
| Gateway |  |
| Subnet |  |
| DHCP server |  |
| DNS |  |
| Firewall enabled |  |
| Wi-Fi SSID |  |
| Ethernet interface | eth0 or eth0.1 |
| Wi-Fi interface |  |

## Ping And Packet Loss Test

Purpose:

Measure basic network reliability.

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

Long ping test:

```text
ping <target-ip> -n 100
```

On Linux:

```text
ping -c 100 <target-ip>
```

Record:

| Target | Sent | Lost | Loss % | Min | Avg | Max |
|---|---:|---:|---:|---:|---:|---:|
| Router |  |  |  |  |  |  |
| PS2 |  |  |  |  |  |  |
| Gateway |  |  |  |  |  |  |
| PC |  |  |  |  |  |  |

## Firmware Build Benchmark

Purpose:

Compare firmware builds.

| Firmware | Flash Size | Free Overlay | Free RAM | Boot Time | Notes |
|---|---:|---:|---:|---:|---|
| Stock | 4 MB |  |  |  |  |
| OpenWrt 15.05 | 4 MB |  |  |  |  |
| OpenWrt 17.01.7 | 4 MB |  |  |  |  |
| OpenWrt 18.06 | 4 MB |  |  |  |  |
| OpenWrt 19.07.10 | 4 MB |  |  |  |  |
| Custom 16 MB | 16 MB |  |  |  |  |

Record:

- Build config
- Package list
- Image size
- Boot success
- Ethernet
- Wi-Fi
- USB
- Services
- PS2 behavior

## Firmware Image Size Test

Purpose:

Verify image fits target flash.

Record:

| Firmware | Image Type | Image Size | Target Flash | Fits | Notes |
|---|---|---:|---:|---|---|
|  | factory |  |  |  |  |
|  | sysupgrade |  |  |  |  |
|  | raw firmware |  |  |  |  |

For stock 4 MB flash, firmware partition size is limited.

For 16 MB flash, firmware can be larger only if the partition layout and firmware definition are correct.

## Overlay Persistence Test

Purpose:

Confirm settings survive reboot.

Test:

1. Change hostname.
2. Change IP address or add test file.
3. Reboot.
4. Confirm change remains.

Example:

```text
echo test > /etc/a5-v11-persistence-test.txt
sync
reboot
```

After reboot:

```text
cat /etc/a5-v11-persistence-test.txt
```

Record:

| Test | Result |
|---|---|
| File saved |  |
| File survived reboot |  |
| Network config survived reboot |  |
| Wi-Fi config survived reboot |  |
| Overlay free after change |  |

## Log Review Test

Purpose:

Catch errors that do not show up as obvious failures.

Commands:

```text
dmesg
logread
```

Search for:

```text
error
fail
timeout
reset
oom
jffs2
mtd
wifi
eeprom
calibration
usb
sda
eth
```

Record:

| Error | Count | Notes |
|---|---:|---|
|  |  |  |

## Benchmark Result File Template

Use one file per major test session.

Suggested file name:

```text
Test-Data/Benchmarks/board-001-openwrt-17-01-7-udpbd-test.md
```

Template:

```text
# Benchmark Result

## Test Info

Test name:
Date:
Tester:
Board ID:
Firmware:
Flash size:
Power source:
USB drive:
Filesystem:
Network mode:
PS2 model:
Loader:

## Results

Boot time:
Current idle:
Current active:
SoC temp idle:
SoC temp active:
Wi-Fi RSSI:
Ethernet throughput:
USB read speed:
USB write speed:
Service tested:
PS2 result:

## Notes

## UART Log

## Photos

## Pass / Fail

```

## Recommended Benchmark Folder Structure

Suggested repo layout:

```text
Test-Data/
├── Benchmarks/
│   ├── Power/
│   ├── Thermal/
│   ├── Ethernet/
│   ├── WiFi/
│   ├── USB/
│   ├── Firmware/
│   ├── PS2/
│   └── Long-Run/
├── Boot-Logs/
├── Scope-Captures/
├── Current-Measurements/
└── Compatibility/
```

## Pass Criteria For A PS2-Ready Build

A build should not be considered PS2-ready until it passes:

| Test | Required |
|---|---|
| Full flash backup exists | Yes |
| Factory partition saved | Yes |
| UART access available | Yes |
| Cold boot reliable | Yes |
| Warm reboot reliable | Yes |
| Ethernet stable | Yes |
| Wi-Fi stable if used | Yes |
| USB stable if used | Yes |
| Thermal test passed | Yes |
| Power test passed | Yes |
| PS2 external test passed | Yes |
| PS2 internal test passed | Yes, for internal installs |
| Recovery method documented | Yes |
| Firmware version documented | Yes |

## Suggested Final PS2 Validation Test

Before calling a PS2 internal install successful:

1. Boot PS2 from cold power-off.
2. Confirm router boots.
3. Confirm router service is ready.
4. Launch PS2 loader.
5. Confirm games list appears.
6. Boot a game.
7. Play or idle for 30 minutes.
8. Reboot PS2.
9. Repeat test.
10. Power off for 5 minutes.
11. Power on again.
12. Confirm router still boots.
13. Close shell fully.
14. Repeat closed-shell test.
15. Check temperatures.

Record all results.

## Known Reference Targets

These are not guaranteed goals, but useful reference points.

| Reference | Value |
|---|---|
| Stock useful hardware | RT5350F, 32 MB RAM, 4 MB flash |
| UART speed | 57600 8N1 |
| Stock flash limitation | 4 MB |
| Common OpenWrt default IP | 192.168.1.1 |
| Common stock IP | 192.168.100.1 |
| PS2-focused setup IP idea | 192.168.1.222 |
| UDPBD reference speed claim | Around 4.2 MB/s class, verify on test setup |
| Router boot/init wait for UDPBD workflows | Around 30 seconds boot, wait up to 1 minute before launching loader |
| UART RX resistor | 470 ohm to 1 k ohm |
| GPIO current warning | About 4 mA max |

## What To Avoid

Avoid these testing mistakes:

- Testing without a flash backup
- Testing without UART
- Comparing results from different USB drives without noting it
- Mixing MB/s and Mbps
- Testing Wi-Fi with the shell open only
- Testing thermal behavior outside PS2 but not inside PS2
- Assuming stock firmware results apply to OpenWrt
- Assuming one A5-V11 board represents all boards
- Assuming one OPL build represents all OPL builds
- Assuming USB hotplug works
- Assuming the router is ready when the PS2 loader starts
- Assuming Ethernet internal wiring is fine without packet tests
- Calling a mod stable after one successful boot

## Short Version

Testing should be treated as part of the project, not an afterthought.

For each board and firmware, record:

- Boot reliability
- Power draw
- Temperature
- Ethernet behavior
- Wi-Fi behavior
- USB behavior
- Filesystem support
- Firmware size
- Free RAM
- Free overlay
- Service readiness
- PS2 loader behavior
- Long-run stability

The A5-V11 is cheap and capable, but it is also limited and inconsistent.

Good documentation requires repeatable tests.

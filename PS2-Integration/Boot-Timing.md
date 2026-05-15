# Boot Timing

## Summary

Boot timing is one of the most important parts of using the A5-V11 with a PlayStation 2.

The PS2 can reach its launcher or loader before the A5-V11 has finished booting, mounting USB storage, connecting to Wi-Fi, and starting the required network service.

If the PS2 loader starts too early, the setup may look broken even though the router is still booting.

This document explains how to test, measure, and plan boot timing for A5-V11 PS2 integration.

## Why Boot Timing Matters

The A5-V11 is a tiny Linux router.

It does not become useful the instant power is applied.

It has to pass through several stages:

1. Power becomes stable.
2. U-Boot starts.
3. Linux kernel loads.
4. Root filesystem mounts.
5. Network interfaces initialize.
6. USB drivers initialize.
7. USB storage is detected.
8. USB storage is mounted.
9. Wi-Fi starts or joins a network.
10. Required services start.
11. The router becomes ready for the PS2.

The PS2 also has its own boot sequence.

If the PS2 reaches OPL, wLaunchELF, NHDDL, Neutrino, or another loader before the router is ready, the loader may fail to detect the network device or storage service.

## Common Symptoms Of Bad Boot Timing

Bad boot timing can look like many different problems.

Common symptoms:

- OPL opens but the games list is empty.
- UDPBD games do not appear.
- UDPFS does not connect.
- SMB share is not found.
- FTP is not reachable right after boot.
- Wi-Fi bridge does not work immediately.
- First launch fails, but second launch works.
- Waiting 30 to 60 seconds fixes the problem.
- Rebooting OPL fixes the problem.
- Manual launch works but autoboot fails.
- Router works from external power but fails when powered from PS2.
- USB storage is missing until router is rebooted with the drive inserted.

These symptoms do not always mean the firmware is bad.

They may mean the PS2 is asking for the service before the router is ready.

## Important Terms

## Power-On

The moment 5 V is applied to the A5-V11.

## Boot Start

The moment U-Boot or the first visible UART output appears.

## Kernel Start

The moment Linux begins booting after U-Boot.

## Network Ready

The moment the Ethernet or Wi-Fi interface is usable.

## USB Ready

The moment the USB storage device is detected and mounted.

## Service Ready

The moment the required PS2 service is actually running.

Examples:

- SMB share is available.
- UDPBD server is running.
- UDPFS server is running.
- Wi-Fi bridge is connected.
- FTP path is reachable.
- USB storage is mounted.

## PS2 Loader Start

The moment OPL, wLaunchELF, NHDDL, Neutrino, or another PS2-side program starts trying to access the network.

## Timing Problem

A timing problem happens when the PS2 loader starts before the A5-V11 is service-ready.

## Basic Timing Rule

The basic rule is:

```text
The A5-V11 must be service-ready before the PS2 loader needs it.
```

If the router is not ready yet, the PS2-side software may fail even if the hardware and firmware are otherwise working.

## Timing Variables

Boot timing depends on many variables.

| Variable | Why It Matters |
|---|---|
| Firmware build | Different services start at different speeds |
| Flash size | Larger builds may have different startup behavior |
| USB drive | Some drives initialize slower than others |
| Filesystem | exFAT, FAT32, and ext4 may mount at different speeds |
| Wi-Fi mode | Wi-Fi client mode may need time to associate |
| Network mode | Bridge, routed, and server modes differ |
| Power source | Weak or delayed power can slow or break boot |
| Supervisor IC | Can improve reset timing |
| Capacitor mods | Can affect boot reliability |
| Heat | Warm board may behave differently |
| PS2 boot method | FMCB, OpenTuna, PS2BBL, modchip, or manual launch changes timing |
| Loader used | OPL, NHDDL, Neutrino, and wLaunchELF behave differently |
| Auto-launch settings | Autoboot may start too quickly |
| Internal install | Closed shell heat and Wi-Fi placement can change readiness |

## Main PS2 Timing Scenarios

## Scenario 1: Router Powered Before PS2

This is the easiest timing scenario.

The router is powered first and allowed to become ready before the PS2 is turned on.

Example:

```text
Router power on
Wait for service-ready
PS2 power on
Launch loader
```

Advantages:

- Most reliable
- Router has time to boot
- USB storage can mount
- Wi-Fi can connect
- PS2 loader sees service immediately

Disadvantages:

- Requires separate power or always-on internal power
- Router may remain powered when PS2 is off
- Must check for backfeeding into PS2
- May need extra power management

Best use:

- Development testing
- Final builds with always-on auxiliary power
- Builds where router access while PS2 is off is desired

## Scenario 2: Router Powered From PS2

This is the most common simple internal setup.

The router powers on when the PS2 powers on.

Example:

```text
PS2 power on
Router power on at same time
PS2 boots
Router boots
Loader starts
```

Advantages:

- Simple wiring
- Router turns off with console
- No standby power needed
- Less risk of router staying on accidentally

Disadvantages:

- PS2 may boot faster than the router
- Loader may start before router is ready
- USB storage may not be mounted yet
- Wi-Fi may not be connected yet
- May require boot delay or manual wait

Best use:

- Simple internal builds
- External USB-powered setups
- UDPBD builds with manual wait before launching OPL

## Scenario 3: Router Always Powered

The router remains powered even when the PS2 is off.

Example:

```text
Router always on
PS2 off
Router Wi-Fi and services ready
PS2 power on
Loader starts and service is already ready
```

Advantages:

- Router is always ready
- PC may access router storage while PS2 is off
- Wi-Fi bridge is already connected
- No PS2 boot delay required

Disadvantages:

- Must check backfeed paths
- Adds standby power draw
- More heat over time
- Router may need long-term stability testing
- Internal PS2 wiring must be safe when console is off

Best use:

- Advanced internal builds
- Builds with external management
- Builds where PC access while PS2 is off is desired

## Scenario 4: Router Pre-Boot Controlled By Another Board

A controller board powers the router first, waits for readiness, then powers or releases the PS2.

Example:

```text
User presses PS2 power
Controller powers A5-V11 first
Controller waits fixed delay or ready signal
Controller powers PS2
PS2 boots
Loader starts after router is ready
```

Advantages:

- Most polished internal behavior
- Can hide router boot delay from user
- Can prevent PS2 loader from starting too early
- Can integrate with Button Butler or another controller

Disadvantages:

- More complex
- Requires extra hardware
- Requires safe PS2 power/reset control
- Requires reliable ready signal or conservative delay

Best use:

- Advanced internal PS2 builds
- Button Butler-style control systems
- Builds with touchscreen or mode control

## Timing By Use Case

## Wi-Fi Bridge Timing

A Wi-Fi bridge is ready when:

- Ethernet interface is up.
- Wi-Fi interface is connected.
- Bridge or routing mode is active.
- PS2 can reach the intended network.
- PC can reach the PS2 if FTP is needed.

Timing risks:

- Wi-Fi association takes time.
- DHCP may take time.
- Bridge scripts may start late.
- PS2 may use a static IP before the router is ready.
- PC may not reach PS2 until Wi-Fi is connected.

Recommended test:

```text
Power router
Wait for Wi-Fi connected
Ping router
Ping PS2
Start FTP or loader test
```

## FTP Timing

FTP timing matters when using wLaunchELF.

The router is ready when:

- Router network is up.
- PS2 network path is reachable.
- PC can ping the PS2.
- wLaunchELF FTP server is running on the PS2.

Timing risks:

- Router may not be ready when wLaunchELF starts.
- PS2 may need network settings applied.
- Routed or NAT mode may block inbound FTP.
- Wi-Fi bridge may still be connecting.

FTP is less timing-sensitive than UDPBD or SMB because wLaunchELF is usually launched manually.

## SMB1 / OPL Timing

SMB timing matters when OPL starts.

The router or network path is ready when:

- Ethernet is up.
- Wi-Fi is connected, if used.
- USB storage is mounted, if router hosts the share.
- Samba is running.
- SMB share path exists.
- OPL can reach the server.

Timing risks:

- Samba may start before USB mount is ready.
- OPL may start before Samba is ready.
- Wi-Fi may not be associated yet.
- USB storage may not mount in time.
- Router may run out of memory if too much starts at once.

Recommended test:

```text
Power router
Wait for USB mount
Wait for SMB service
Launch OPL
Check games list
```

## UDPBD Timing

UDPBD timing is very important.

The router is ready when:

- USB storage is detected.
- USB storage is mounted.
- UDPBD server is running.
- Ethernet is up.
- PS2-side UDPBD-capable loader is launched after service is ready.

Timing risks:

- USB drive may need to be inserted before router power-on.
- UDPBD script may only run once at boot.
- PS2 loader may start too early.
- USB storage may not support hotplug.
- Drive spin-up or initialization may delay readiness.

Recommended behavior:

```text
Insert USB drive
Power router
Wait for service-ready
Launch UDPBD-capable OPL or loader
```

If games do not appear, wait and relaunch the loader before assuming failure.

## UDPFS Timing

UDPFS timing should be treated similarly to UDPBD.

The router is ready when:

- Network is up.
- Storage path is available, if used.
- UDPFS server is running.
- PS2-side loader is started after the service is ready.

Timing risks:

- Server not started
- Wrong mount path
- Loader launched too early
- Network mode not ready
- Wi-Fi delay
- USB delay

UDPFS timing should be documented separately from UDPBD.

## USB Storage Timing

USB timing is often the biggest delay.

The router may need time to:

- Detect the USB device
- Load storage driver
- Create `/dev/sda`
- Create `/dev/sda1`
- Identify filesystem
- Mount the filesystem
- Run service scripts after mount

Some minimal firmware builds do not support full USB hotplug.

If the USB drive is inserted after boot, it may not mount automatically.

## USB Timing Test

Record:

| Event | Time From Router Power-On |
|---|---:|
| USB power applied |  |
| USB device detected in dmesg |  |
| `/dev/sda` appears |  |
| `/dev/sda1` appears |  |
| Filesystem recognized |  |
| Mount command starts |  |
| Mount complete |  |
| Service starts |  |
| Service ready |  |

Useful commands:

```text
dmesg | grep usb
dmesg | grep sda
ls /dev/sd*
mount
df -h
logread
```

## Wi-Fi Timing Test

Record:

| Event | Time From Router Power-On |
|---|---:|
| Wireless driver loaded |  |
| Wi-Fi interface created |  |
| Wi-Fi scan starts |  |
| Wi-Fi associates |  |
| DHCP lease received |  |
| Gateway reachable |  |
| PC can reach router |  |
| PS2 path ready |  |

Useful commands:

```text
wifi status
iwinfo
ifconfig
ip addr
logread | grep wlan
logread | grep wifi
```

Commands depend on firmware package availability.

## Ethernet Timing Test

Record:

| Event | Time From Router Power-On |
|---|---:|
| Ethernet driver initialized |  |
| Link detected |  |
| Interface configured |  |
| Static IP active |  |
| DHCP active, if used |  |
| Ping response starts |  |
| PS2 link active |  |

Useful commands:

```text
ifconfig
ip addr
logread
dmesg | grep eth
```

## Service Timing Test

Record each required service.

| Service | Start Time | Ready Time | Notes |
|---|---:|---:|---|
| network |  |  |  |
| wireless |  |  |  |
| USB mount |  |  |  |
| dropbear |  |  |  |
| uhttpd |  |  |  |
| samba |  |  |  |
| UDPBD |  |  |  |
| UDPFS |  |  |  |
| custom PS2 mode script |  |  |  |

Useful commands:

```text
ps
logread
netstat -lntup
```

Some minimal builds may not include `netstat`.

## Measuring Boot Timing

## Method 1: UART Log Timing

The most accurate method is to capture a UART boot log.

Steps:

1. Connect UART.
2. Start terminal logging.
3. Apply power.
4. Capture the complete boot log.
5. Add timestamps if the terminal supports it.
6. Mark when each service becomes ready.

Good terminal programs can timestamp each line.

If your terminal does not timestamp lines, use a stopwatch and add notes manually.

## Method 2: Ping Timing

Use ping from a PC to determine when the router becomes reachable.

Example:

```text
ping 192.168.1.222
```

On Linux, timestamp ping output:

```text
ping 192.168.1.222 | while read line; do echo "$(date +%H:%M:%S) $line"; done
```

This measures when network access starts.

It does not prove USB, SMB, UDPBD, or UDPFS is ready.

## Method 3: Service Probe Timing

Use a service-specific test.

Examples:

- Try connecting to SSH.
- Try opening the web UI.
- Try listing SMB share.
- Try connecting to UDPBD.
- Try checking a mounted USB path.
- Try launching OPL after fixed delays.

This is the most useful method for PS2 behavior.

## Method 4: PS2 Manual Delay Test

This is a practical PS2 test.

Steps:

1. Power router and PS2 at the same time.
2. Wait 15 seconds.
3. Launch loader.
4. Record result.
5. Repeat with 30 seconds.
6. Repeat with 45 seconds.
7. Repeat with 60 seconds.
8. Repeat with 90 seconds if needed.

Test table:

| Wait Time Before Loader | Result |
|---:|---|
| 0 seconds |  |
| 15 seconds |  |
| 30 seconds |  |
| 45 seconds |  |
| 60 seconds |  |
| 90 seconds |  |

Pass result:

- Games list appears
- FTP reachable
- SMB connects
- UDPBD connects
- UDPFS connects

## Method 5: LED Ready Timing

A custom firmware can use the blue LED or another status LED to show service-ready state.

Possible LED behavior:

| LED State | Meaning |
|---|---|
| Red solid | Power applied |
| Blue slow blink | Booting |
| Blue fast blink | USB mounting |
| Blue double blink | Wi-Fi connecting |
| Blue solid | Service ready |
| Blue off | Service failed |

This requires firmware scripting.

It is useful for internal PS2 builds where UART is not visible.

## Service-Ready Definition

Every PS2-focused firmware should define exactly what service-ready means.

Examples:

## Bridge-Only Ready

```text
Ethernet is up.
Wi-Fi is connected.
Router can reach gateway.
PS2 side can reach network.
```

## FTP Helper Ready

```text
Ethernet is up.
Wi-Fi bridge or route is ready.
PC can reach PS2 IP when wLaunchELF FTP is running.
```

## SMB Ready

```text
USB storage is mounted.
SMB service is running.
Share path exists.
Router responds on SMB port.
```

## UDPBD Ready

```text
USB storage is mounted.
UDPBD server is running.
Server is listening on expected interface.
PS2 loader can connect.
```

## UDPFS Ready

```text
Storage or file path is available.
UDPFS server is running.
Server is listening on expected interface.
PS2 loader can connect.
```

## Timing Test Template

Use this template for timing tests.

```text
Test name:
Date:
Tester:
Board ID:
Firmware:
Flash size:
RAM size:
Power source:
PS2 model:
PS2 boot method:
Loader:
USB drive:
Filesystem:
Network mode:
Antenna setup:
Heatsink:
Supervisor IC:
Capacitor mod:
Shell open or closed:

Router power applied:
First UART output:
Kernel start:
Ethernet ready:
Wi-Fi ready:
USB detected:
USB mounted:
Service started:
Service ready:
PS2 loader started:
PS2 success/fail:
Notes:
```

## Timing Result Table

Use this table for repeated tests.

| Attempt | Router Power | Service Ready | Loader Start | Result | Notes |
|---:|---:|---:|---:|---|---|
| 1 | 0 sec |  |  |  |  |
| 2 | 0 sec |  |  |  |  |
| 3 | 0 sec |  |  |  |  |
| 4 | 0 sec |  |  |  |  |
| 5 | 0 sec |  |  |  |  |

## Recommended Delay Values To Test

For PS2-powered router setups, test these delays:

| Delay | Purpose |
|---:|---|
| 0 seconds | Worst case / immediate launch |
| 15 seconds | Fast launch |
| 30 seconds | Common first useful delay |
| 45 seconds | More conservative |
| 60 seconds | Safer for USB and Wi-Fi |
| 90 seconds | Troubleshooting only |

If 60 seconds is required every time, firmware or power sequencing may need improvement.

## Fixed Delay Versus Ready Signal

There are two ways to solve timing:

## Fixed Delay

The PS2 or controller waits a fixed number of seconds.

Advantages:

- Simple
- Easy to test
- No extra router signaling needed

Disadvantages:

- May wait longer than necessary
- May still fail if USB drive is slow
- Does not detect service failure
- Different drives may need different delay

## Ready Signal

The router or controller indicates when service is ready.

Advantages:

- Smarter
- Better user experience
- Can show failure state
- Can avoid guessing

Disadvantages:

- Requires firmware scripting
- May require GPIO or external controller
- More complex
- Needs testing

## Simple Delay Strategy

For early testing, use a simple fixed delay.

Example strategy:

```text
Power router and PS2 together.
Wait 60 seconds before launching OPL or UDPBD loader.
If this works consistently, reduce delay and retest.
```

This helps separate timing problems from real network or firmware problems.

## Better Delay Strategy

A better strategy is:

```text
Power router.
Wait until service-ready.
Then launch PS2 loader.
```

Possible ways to do this:

- Manual wait
- FMCB menu wait
- OPL auto-launch delay
- OpenTuna script delay
- PS2BBL delay
- Button Butler power sequencing
- Router ready LED
- Router GPIO ready signal
- Touchscreen status page

## Manual Launch Strategy

For testing:

1. Power PS2 and router.
2. Wait for router ready LED or fixed time.
3. Launch OPL manually.
4. Test games list.
5. Record delay.

This is the easiest way to confirm whether timing is the problem.

## Auto-Launch Strategy

For final builds, auto-launch may be preferred.

Possible approach:

```text
PS2 boots to launcher.
Launcher waits fixed delay.
Launcher starts OPL or target loader.
```

Important:

The delay must be long enough for the slowest tested boot condition.

Test with:

- Cold boot
- Warm reboot
- USB drive attached
- Wi-Fi reconnect
- Closed shell
- Warm board
- Different USB drives

## Router-Powered-First Strategy

If the router can be powered before PS2, the delay can happen before the PS2 boots.

Example:

```text
Button pressed
Controller powers router
Controller waits 45 seconds
Controller powers PS2
PS2 boots normally
Loader sees ready service
```

This creates a cleaner user experience but requires more hardware control.

## Always-On Router Strategy

If the router remains powered when the PS2 is off, timing becomes easier.

The router should already be:

- Booted
- Wi-Fi connected
- USB mounted
- Service ready

Before using always-on router power, test:

- Standby current
- Heat over 24 hours
- Backfeed into PS2
- Ethernet behavior while PS2 is off
- USB storage behavior while PS2 is off
- Service stability over long idle time
- Recovery access

## Backfeed Warning

If the router is powered while the PS2 is off, check for backfeeding.

Possible backfeed paths:

- Ethernet signal lines
- USB lines
- Shared 5 V rail
- Shared 3.3 V rail
- GPIO lines
- UART lines
- Controller board signals

Symptoms of backfeed:

- PS2 partially powers
- LEDs glow faintly
- Router behaves differently when PS2 is off
- Ethernet link acts strange
- PS2 will not fully power down
- Unexpected current draw

Do not finalize an always-on design until backfeed is tested.

## USB Storage Insert Timing

Some firmware builds may require the USB drive to be inserted before power-on.

Recommended rule for those builds:

```text
Insert USB drive before router power-on.
Remove USB drive only after router power-off.
```

If hotplug is not supported, document it clearly.

## USB Timing Test Table

| Test | Result |
|---|---|
| USB inserted before power-on |  |
| USB inserted 10 seconds after boot |  |
| USB inserted after service start |  |
| USB removed while running |  |
| USB reinserted while running |  |
| Router reboot required |  |
| Service restart required |  |

## Wi-Fi Reconnect Timing

If the A5-V11 connects to a home Wi-Fi network, measure reconnect time.

Test cases:

| Test | Time To Reconnect |
|---|---:|
| Cold boot |  |
| Warm reboot |  |
| Access point reboot |  |
| Router moved farther away |  |
| PS2 shell closed |  |
| Weak signal test |  |

If Wi-Fi reconnect takes too long, consider:

- Static IP
- Better antenna
- External antenna
- Better router placement
- Ethernet-only mode for UDPBD
- Using A5-V11 as server rather than bridge

## SMB Timing Notes

For SMB, the service should not start before USB storage is mounted.

Bad startup order:

```text
Samba starts
USB not mounted yet
Share path missing
OPL connects too early
Games list empty
```

Better startup order:

```text
Wait for USB
Mount USB
Verify share path
Start Samba
Mark service ready
```

SMB scripts should include mount checks.

## UDPBD Timing Notes

For UDPBD, the server should not start before USB storage is ready.

Bad startup order:

```text
UDPBD starts
USB drive not mounted
Server points to missing path
OPL sees no games
```

Better startup order:

```text
Wait for USB
Mount USB
Verify game folders
Start UDPBD
Mark service ready
```

## UDPFS Timing Notes

UDPFS timing depends on the exact server and loader.

The startup script should confirm:

- Network is up
- Required file path exists
- USB storage is mounted if used
- Server starts successfully
- Service is listening

## FTP Timing Notes

FTP timing mostly depends on network path readiness.

For wLaunchELF FTP:

```text
Router ready
PS2 network ready
wLaunchELF FTP server started
PC connects
```

If FTP fails:

- Ping PS2 first.
- Ping router.
- Check whether A5-V11 is bridge or routed.
- Check firewall.
- Check static IPs.
- Check Wi-Fi connection.

## Firmware Ready File Concept

A firmware script can create a ready file after startup.

Example:

```text
/tmp/a5v11-service-ready
```

Possible use:

- Debugging
- Web status page
- LED script
- Controller polling
- UART check

Example script concept:

```text
if mountpoint -q /mnt/usb; then
    touch /tmp/a5v11-usb-ready
fi

if service_is_running; then
    touch /tmp/a5v11-service-ready
fi
```

This is a concept and must be implemented per firmware role.

## Ready LED Concept

A ready LED can help inside PS2 builds.

Example:

| LED Pattern | Meaning |
|---|---|
| Red on | Power |
| Blue slow blink | Booting |
| Blue fast blink | USB wait |
| Blue short blink | Wi-Fi wait |
| Blue solid | Ready |
| Blue off after boot | Failed |

This requires firmware scripting and should be tested on the actual GPIO/LED mapping.

## Ready GPIO Concept

A custom firmware could set a GPIO when ready.

Possible use:

- Button Butler input
- Touchscreen controller
- PS2 power sequencing controller
- Status LED board
- Service-ready latch

Warning:

A5-V11 GPIO current is limited.

Use GPIO as a signal only.

Do not directly drive heavy loads.

## Example Fixed Delay Recommendations

These are starting points only.

| Firmware Role | Starting Delay To Test |
|---|---:|
| Bridge-only Ethernet static IP | 15 to 30 seconds |
| Wi-Fi bridge DHCP | 30 to 60 seconds |
| FTP helper | 30 seconds |
| SMB with USB storage | 45 to 60 seconds |
| UDPBD with USB storage | 45 to 60 seconds |
| UDPFS with USB storage | 45 to 60 seconds |
| Router always powered | 0 seconds after PS2 boot |

Final values must be based on actual testing.

## Timing Test For Firmware Releases

Every PS2-focused firmware release should document:

| Item | Value |
|---|---|
| Firmware name |  |
| Firmware role |  |
| Flash size |  |
| Board ID tested |  |
| USB drive tested |  |
| Filesystem tested |  |
| Network mode |  |
| Boot to Ethernet ready |  |
| Boot to Wi-Fi ready |  |
| Boot to USB mounted |  |
| Boot to service ready |  |
| Recommended PS2 wait |  |
| USB hotplug supported |  |
| Ready LED behavior |  |
| Known timing issues |  |

## Timing Test With Different USB Drives

USB drives can change boot timing.

Test at least:

| Drive Type | Example | Result |
|---|---|---|
| Small USB flash drive |  |  |
| Large USB flash drive |  |  |
| USB SSD |  |  |
| USB HDD with external power |  |  |
| USB card reader |  |  |

Record:

| Drive | Filesystem | Time To Detect | Time To Mount | Service Ready | Notes |
|---|---|---:|---:|---:|---|
|  |  |  |  |  |  |

## Timing Test With Different Power Sources

Power source can change boot reliability and timing.

Test:

| Power Source | Boot Time | Reliability | Notes |
|---|---:|---|---|
| External USB supply |  |  |  |
| PC USB port |  |  |  |
| PS2 USB port |  |  |  |
| Internal 5 V regulator |  |  |  |
| Always-on 5 V rail |  |  |  |
| Bench supply |  |  |  |

Record voltage sag if possible.

## Timing Test With Shell Open And Closed

Internal PS2 builds should be tested both open and closed.

| Test State | Service Ready Time | Wi-Fi RSSI | Temperature | Result |
|---|---:|---:|---:|---|
| PS2 shell open |  |  |  |  |
| PS2 shell closed |  |  |  |  |
| RF shield installed |  |  |  |  |
| RF shield removed |  |  |  |  |

The closed shell can affect:

- Wi-Fi signal
- Heat
- USB drive temperature
- Power stability
- Antenna behavior

## Common Timing Fixes

If the PS2 starts too early, try:

- Wait longer before launching loader.
- Disable auto-launch temporarily.
- Launch OPL manually.
- Add boot delay in PS2 boot path.
- Power router before PS2.
- Keep router always powered.
- Add service-ready LED.
- Add firmware mount retry.
- Add service startup delay.
- Use a faster USB drive.
- Use static IP instead of DHCP.
- Use Ethernet-only mode if Wi-Fi is slow.
- Improve antenna signal.
- Add supervisor IC for reliable boot.
- Improve 5 V power.

## Troubleshooting Timing Problems

## Problem: Games List Empty On First Launch

Possible causes:

- Router still booting
- USB not mounted yet
- UDPBD not started yet
- SMB not started yet
- Wi-Fi not connected yet
- OPL launched too early

Try:

1. Wait 60 seconds.
2. Relaunch OPL.
3. Check UART log.
4. Check USB mount.
5. Check service process.
6. Check network ping.

## Problem: Works After Relaunching OPL

Likely cause:

```text
Boot timing problem
```

Fix:

- Add delay
- Power router earlier
- Add service-ready indicator
- Improve startup script

## Problem: Works With External Power But Not PS2 Power

Possible causes:

- Router boots earlier on external power
- PS2 power source unstable
- USB drive draws too much current
- PS2 boots faster than router
- Voltage sag during PS2 startup

Try:

- Measure 5 V rail
- Use bench supply
- Add delay
- Add bulk capacitance
- Add supervisor IC
- Test with lower-power USB drive

## Problem: USB Missing At Boot

Possible causes:

- Drive inserted too late
- Hotplug unsupported
- Power issue
- Filesystem unsupported
- Mount script runs too early
- Drive slow to initialize

Try:

- Insert drive before power-on
- Add mount retry loop
- Add service delay
- Use different drive
- Use FAT32 test drive
- Check dmesg over UART

## Problem: Wi-Fi Not Ready In Time

Possible causes:

- Weak signal
- Antenna placement
- DHCP delay
- Wrong Wi-Fi config
- PS2 RF shield blocking signal
- Router too far from AP

Try:

- Static IP
- Better antenna
- Move antenna location
- Test shell open and closed
- Use Ethernet-only service mode
- Wait longer before loader

## Problem: Router Freezes After Rapid Power Cycle

Possible causes:

- Poor reset timing
- Capacitors not discharged
- Weak power ramp
- Need supervisor IC
- USB drive startup load
- Firmware boot issue

Try:

- Leave power off for 5 to 10 seconds
- Add supervisor IC
- Improve power rail
- Add proper bulk capacitance
- Test without USB drive
- Check UART log

## Recommended Development Flow

Use this flow:

1. Test router boot timing on bench.
2. Test Ethernet ready time.
3. Test Wi-Fi ready time.
4. Test USB mount time.
5. Test service ready time.
6. Test PS2 externally with manual delay.
7. Reduce delay until failure appears.
8. Pick a safe delay above the failure point.
9. Test inside PS2 shell open.
10. Test inside PS2 shell closed.
11. Repeat cold and warm boot tests.
12. Document final recommendation.

## Minimum Boot Timing Documentation

Every PS2-focused build should include:

```text
Power source:
Firmware:
Board ID:
USB drive:
Filesystem:
Network mode:
Service:
Cold boot service-ready time:
Warm reboot service-ready time:
Recommended PS2 wait time:
USB hotplug supported:
Wi-Fi required:
Ready LED behavior:
Known timing issues:
```

## Example Timing Result

Example format:

```text
Firmware:
A5-V11 PS2 UDPBD Test Build v0.1

Board:
board-001, 16 MB flash

Power:
PS2 USB 5 V

USB:
Samsung USB flash drive, exFAT

Network:
Ethernet-only to PS2

Timing:
First UART output: 2 sec
Kernel start: 7 sec
USB detected: 18 sec
USB mounted: 24 sec
UDPBD started: 31 sec
Service ready: 35 sec

PS2 result:
OPL launched immediately: fail
OPL launched after 30 sec: inconsistent
OPL launched after 45 sec: pass
OPL launched after 60 sec: pass

Recommended delay:
60 seconds
```

## Release Note Requirement

Firmware releases should include a boot timing section.

Template:

```text
## Boot Timing

Cold boot to Ethernet ready:
Cold boot to Wi-Fi ready:
Cold boot to USB mounted:
Cold boot to service ready:
Warm reboot to service ready:
Recommended PS2 delay:
USB drive must be inserted before power-on:
USB hotplug supported:
Ready LED:
Known timing issues:
```

## Short Version

Boot timing matters because the PS2 may launch its loader before the A5-V11 is ready.

For PS2 use, always measure:

- Router boot time
- Ethernet ready time
- Wi-Fi ready time
- USB mount time
- Service ready time
- PS2 loader start time

If the first launch fails but the second launch works, it is probably a timing problem.

For early testing, wait 60 seconds before launching OPL or another network loader.

For final builds, use a measured delay, a ready LED, a ready GPIO, or a controller that powers the router before the PS2.

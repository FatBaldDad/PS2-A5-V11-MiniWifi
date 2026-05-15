# UART Console

## Summary

This document covers using the UART serial console on the A5-V11 mini router.

UART is one of the most important recovery, debugging, and development tools for this project.

UART can help with:

- Capturing boot logs
- Identifying U-Boot behavior
- Interrupting the bootloader
- Recovering from bad network settings
- Diagnosing failed firmware boots
- Checking flash detection
- Checking RAM detection
- Verifying OpenWrt boot
- Testing recovery options
- Debugging PS2 internal installs
- Confirming whether a router is truly bricked

If the router does not respond over Ethernet, Wi-Fi, SSH, telnet, or the web UI, UART may still show exactly what is happening.

---

## Main Rule

The main rule is:

```text
Do not assume the router is dead until UART has been checked.
```

A router with no web UI or no Ethernet response may still be booting normally.

UART tells you what stage the board reaches.

---

## Important Warning

The A5-V11 UART is 3.3 V TTL serial.

Do not connect true RS-232 directly to the router.

Do not connect 5 V UART signals.

Using the wrong serial voltage can damage the A5-V11.

Correct:

```text
3.3 V USB-to-TTL adapter
```

Incorrect:

```text
PC COM port RS-232 directly to A5-V11
5 V Arduino serial directly to A5-V11
```

---

## What UART Can Show

UART can show:

- U-Boot banner
- RAM size
- SPI flash detection
- U-Boot menu
- TFTP recovery prompts
- Kernel boot messages
- Flash partition layout
- OpenWrt boot messages
- Kernel panic messages
- Network initialization
- USB initialization
- Wi-Fi errors
- Login prompt
- Shell access if enabled

UART is the first thing to use when normal network access fails.

---

## What UART Cannot Fix By Itself

UART is a communication interface.

It does not automatically fix:

- Dead flash chip
- Corrupt U-Boot with no boot output
- Hardware damage
- Wrong voltage damage
- Missing factory partition
- Bad soldering
- Shorted power rail

However, UART can help identify those problems.

---

## Basic UART Settings

Common A5-V11 UART settings:

| Setting | Value |
|---|---|
| Voltage | 3.3 V TTL |
| Baud rate | 57600 |
| Data bits | 8 |
| Parity | None |
| Stop bits | 1 |
| Flow control | None |

Short form:

```text
57600 8N1
```

---

## Required Adapter

Use a USB-to-TTL serial adapter that supports 3.3 V logic.

Good adapter types:

- FTDI-style USB-to-TTL adapter
- CH340 USB-to-TTL adapter
- CP2102 USB-to-TTL adapter
- PL2303 USB-to-TTL adapter
- Other verified 3.3 V TTL serial adapter

Avoid:

- True RS-232 serial adapter
- PC DB9 COM port directly
- 5 V-only UART adapter
- Unknown voltage adapter
- Adapter with VCC accidentally connected

---

## RS-232 Warning

A DB9 serial port on a PC is usually RS-232, not TTL.

RS-232 can use much higher positive and negative voltages.

Do not connect DB9 RS-232 directly to the A5-V11 UART.

If using a PC COM port, you need an RS-232-to-TTL level converter that outputs 3.3 V TTL logic.

---

## UART Wiring

Basic UART wiring:

| A5-V11 | USB-to-TTL Adapter |
|---|---|
| GND | GND |
| TX | RX |
| RX | TX |
| VCC | Leave disconnected |

Important:

```text
Router TX goes to adapter RX.
Router RX goes to adapter TX.
Ground must be shared.
VCC is normally not connected.
```

---

## Recommended RX Series Resistor

A small series resistor on the router RX line is recommended.

Suggested value:

```text
470 ohm to 1 k ohm
```

Connection:

```text
Adapter TX -> 470 ohm to 1 k ohm resistor -> A5-V11 RX
```

This can help protect the router RX pin and reduce problems if the adapter drives the line during boot.

---

## Do Not Connect VCC For Normal Console Use

For normal UART console use, do not connect the adapter VCC pin to the A5-V11.

Use only:

```text
GND
TX
RX
```

Leave VCC disconnected.

The A5-V11 should be powered from its normal 5 V input or test power supply.

---

## UART Pin Labels

The A5-V11 board may have UART pads marked with labels such as:

```text
TX
RX
GND
VCC
```

or similar markings.

Do not rely only on silkscreen if the board is unknown.

Verify with:

- Board photos
- Continuity checks
- Known guides
- UART boot output
- Logic probe or oscilloscope if needed

---

## Finding TX

Router TX is the line that sends boot messages out of the router.

If unsure:

1. Connect adapter GND to router GND.
2. Connect adapter RX to one suspected UART pad.
3. Power the router.
4. Watch terminal for boot text.
5. Try the other suspected pad if no output appears.

Do not connect adapter TX to unknown pads until TX/RX are understood.

---

## Finding RX

Router RX is the line that receives keystrokes from the adapter.

After TX is found and boot text is visible:

1. Connect adapter TX through a 470 ohm to 1 k ohm resistor.
2. Connect to suspected router RX.
3. Reboot the router.
4. Press the key needed to interrupt U-Boot.
5. If the menu does not respond, check wiring and terminal settings.

---

## Ground Is Required

UART will not work reliably without a shared ground.

Required:

```text
Adapter GND -> A5-V11 GND
```

Symptoms of missing ground:

- Garbage characters
- No output
- Output only when touching wires
- Random characters
- Input does not work
- Terminal behaves unpredictably

---

## Power Source During UART

For UART debugging, power the A5-V11 from a stable 5 V source.

Recommended:

- Bench supply
- Known-good USB power supply
- Known-good micro-USB cable
- Dedicated 5 V regulator

Avoid during recovery:

- Weak PC USB port
- PS2 USB power during initial recovery
- Unknown internal PS2 rail
- Long thin power wires
- Power source that sags under Wi-Fi or USB load

If the router is installed inside a PS2, test externally first if possible.

---

## Terminal Software

Common terminal programs:

| Platform | Software |
|---|---|
| Windows | PuTTY |
| Windows | Tera Term |
| Windows | RealTerm |
| Windows | Arduino Serial Monitor, limited use |
| Linux | minicom |
| Linux | screen |
| Linux | picocom |
| macOS | screen |
| macOS | CoolTerm |

Recommended for logging:

- Tera Term
- PuTTY with logging enabled
- minicom with capture
- screen with terminal logging from shell

---

## Windows PuTTY Settings

PuTTY settings:

| Setting | Value |
|---|---|
| Connection type | Serial |
| Serial line | COM port for adapter |
| Speed | 57600 |
| Data bits | 8 |
| Stop bits | 1 |
| Parity | None |
| Flow control | None |

Example:

```text
Serial line: COM3
Speed: 57600
Flow control: None
```

The COM port number depends on the adapter and PC.

---

## Windows Tera Term Settings

Tera Term settings:

| Setting | Value |
|---|---|
| Port | Adapter COM port |
| Baud rate | 57600 |
| Data | 8 bit |
| Parity | None |
| Stop | 1 bit |
| Flow control | None |

Enable logging before powering the router.

---

## Linux screen Example

Example:

```text
screen /dev/ttyUSB0 57600
```

To exit screen:

```text
Ctrl-A
K
Y
```

Device names may include:

```text
/dev/ttyUSB0
/dev/ttyUSB1
/dev/ttyACM0
```

---

## Linux minicom Example

Start minicom setup:

```text
sudo minicom -s
```

Common settings:

```text
Serial device: /dev/ttyUSB0
Bps/Par/Bits: 57600 8N1
Hardware flow control: No
Software flow control: No
```

Start minicom:

```text
sudo minicom
```

---

## Linux picocom Example

```text
picocom -b 57600 /dev/ttyUSB0
```

Exit picocom:

```text
Ctrl-A
Ctrl-X
```

---

## macOS screen Example

Find serial devices:

```text
ls /dev/tty.*
```

Connect:

```text
screen /dev/tty.usbserial-XXXX 57600
```

Exit:

```text
Ctrl-A
K
Y
```

---

## Adapter Loopback Test

Before blaming the router, test the adapter.

Loopback test:

1. Disconnect adapter from router.
2. Connect adapter TX to adapter RX.
3. Open terminal.
4. Type characters.
5. Characters should echo back.

If loopback fails:

- Wrong COM port
- Bad driver
- Bad adapter
- Wrong terminal setting
- Flow control issue

Fix the adapter before connecting to the router.

---

## First UART Boot Capture

Procedure:

1. Connect GND.
2. Connect router TX to adapter RX.
3. Leave router RX disconnected at first.
4. Open terminal at 57600 8N1.
5. Enable logging.
6. Apply 5 V power to A5-V11.
7. Watch for boot text.
8. Save complete log.

If boot text appears, TX and baud rate are likely correct.

---

## Adding RX For Input

After boot text is confirmed:

1. Power off router.
2. Connect adapter TX to router RX through 470 ohm to 1 k ohm resistor.
3. Power on router.
4. Press the required key during U-Boot countdown.
5. Confirm keyboard input works.

If input does not work:

- Check TX/RX wiring
- Disable flow control
- Try pressing key earlier
- Try another terminal
- Check resistor connection
- Check adapter loopback

---

## U-Boot Interrupt

Some U-Boot menus can be interrupted during boot.

Common behavior:

```text
Please choose the operation:
```

or a boot countdown.

Possible actions:

- Press a number for menu option
- Press any key during countdown
- Press `4` for command line if menu shows it

Behavior depends on U-Boot version.

Do not select write options unless you are ready.

---

## Common U-Boot Menu

Some A5-V11 bootlogs show a menu similar to:

```text
1: Load system code to SDRAM via TFTP.
2: Load system code then write to Flash via TFTP.
3: Boot system code via Flash (default).
4: Enter boot command line interface.
7: Load Boot Loader code then write to Flash via Serial.
9: Load Boot Loader code then write to Flash via TFTP.
```

Dangerous options:

```text
7
9
```

These are bootloader write options.

Do not select them by accident.

---

## Safe U-Boot Observation

For first UART testing, only observe the boot.

Safe actions:

- Capture boot log
- Record U-Boot version
- Record RAM size
- Record flash detection
- Record menu options
- Let default boot continue

Avoid:

- Flash write options
- Bootloader write options
- Manual erase commands
- Unknown U-Boot commands

---

## What To Record From U-Boot

Record:

| Item | Value |
|---|---|
| Board ID |  |
| U-Boot version |  |
| Build date |  |
| RAM size reported |  |
| Flash chip detected |  |
| Flash size reported |  |
| Boot menu shown |  |
| Boot delay |  |
| Default boot option |  |
| TFTP options |  |
| Environment warning |  |
| Kernel load address |  |
| Firmware boot address |  |

This information is important for recovery and flash upgrades.

---

## Healthy UART Boot Signs

Healthy boot signs may include:

- U-Boot banner
- RAM size detected
- SPI flash detected
- Boot menu or countdown
- Kernel checksum OK
- Kernel uncompresses
- Linux starts
- MTD partitions appear
- Network interfaces initialize
- Login prompt or shell appears

Example healthy signs:

```text
DRAM: 32 MB
Flash component: SPI Flash
Verifying Checksum ... OK
Uncompressing Kernel Image ... OK
Starting kernel
```

Exact text varies.

---

## Bad UART Boot Signs

Bad signs include:

- No output at all
- Garbage output at correct settings
- Wrong RAM size
- Flash not detected
- Unrecognized flash chip
- Kernel checksum failure
- Kernel panic
- Root filesystem mount failure
- Boot loop
- Hang before kernel
- Hang after kernel
- Repeated reset messages
- Watchdog reset
- No login prompt when expected

Record the full log before changing anything.

---

## UART Shows U-Boot But No Kernel

Likely category:

```text
Firmware partition problem
```

Possible causes:

- Wrong firmware image
- Wrong image type
- Firmware written to wrong offset
- Firmware too large
- Bad flash layout
- Corrupt kernel
- Bad flash write

Recovery:

- U-Boot TFTP firmware recovery
- CH341A firmware partition restore
- Restore known-good image
- Do not replace U-Boot if U-Boot still works

---

## UART Shows Kernel Panic

Likely category:

```text
Kernel or root filesystem problem
```

Possible causes:

- Wrong OpenWrt target
- Wrong rootfs
- Bad partition layout
- Corrupt firmware
- Bad flash chip
- Image too large
- Unsupported flash layout

Recovery:

- Capture full log
- Check exact panic message
- Reflash known-good firmware
- Use TFTP or CH341A
- Verify image type and flash size

---

## UART Shows OpenWrt Boot Complete But No Network

Likely category:

```text
Network configuration problem
```

This is usually not a hard brick.

Check from UART shell:

```text
ip addr
ifconfig
cat /etc/config/network
cat /proc/mtd
logread
dmesg | grep eth
```

Common issue:

```text
eth0 vs eth0.1
```

Fix network config before reflashing if possible.

---

## UART Login Prompt

If the router boots to a login prompt, it may ask for:

```text
root
```

or another stock firmware login.

OpenWrt behavior depends on password state.

Possible states:

- Telnet open if no root password set
- SSH enabled after password is set
- UART shell available
- Login required
- No password accepted because firmware is custom or stock

Record what prompt appears.

---

## Stock Firmware Shell Notes

Some stock A5-V11 firmware may expose telnet or serial shell behavior.

Possible default credentials:

```text
admin / admin
```

Behavior varies by firmware.

If stock shell is available, use it carefully.

Avoid random flash commands until backups are saved.

---

## OpenWrt Shell Commands

Useful commands from UART shell:

```text
cat /proc/mtd
cat /proc/meminfo
cat /etc/openwrt_release
cat /etc/config/network
ip addr
ifconfig
logread
dmesg
df -h
mount
ps
free
```

Not every command exists on every build.

---

## Checking Flash Partitions

Use:

```text
cat /proc/mtd
```

Record partition names, offsets, and sizes if available.

Common layout:

```text
u-boot
u-boot-env
factory
firmware
```

Do not assume MTD numbers.

Always check names.

---

## Checking RAM

Use:

```text
cat /proc/meminfo
free
```

RAM size matters for U-Boot selection and firmware compatibility.

Expected useful/common A5-V11 boards are often 32 MB RAM.

Treat unknown boards as variants.

---

## Checking Network Interfaces

Use:

```text
ip addr
ifconfig
cat /etc/config/network
```

Possible interface names:

```text
eth0
eth0.1
br-lan
wlan0
```

If Ethernet does not work, the wrong interface may be configured.

---

## Checking Wi-Fi

Use:

```text
wifi status
iwinfo
logread | grep wifi
logread | grep wlan
dmesg | grep rt2
```

Some builds may not include all commands.

If Wi-Fi fails after flash work, check factory partition and antenna.

---

## Checking USB

Use:

```text
dmesg | grep usb
dmesg | grep sda
ls /dev/sd*
mount
df -h
logread
```

USB problems may be firmware, power, storage, or timing related.

---

## Capturing Logs

Always save logs.

Useful logs:

- U-Boot boot log
- Full kernel boot log
- OpenWrt login log
- Failsafe log
- TFTP recovery log
- Kernel panic log
- USB detection log
- Wi-Fi error log
- PS2 internal install boot log

Logs make problems repeatable and diagnosable.

---

## Log File Naming

Suggested names:

```text
uart-board001-stock-bootlog.txt
uart-board001-openwrt-firstboot.txt
uart-board001-16mb-flash-test.txt
uart-board001-kernel-panic.txt
uart-board001-tftp-recovery.txt
uart-board001-ps2-internal-power.txt
```

Keep logs with board notes.

---

## UART Boot Log Template

Use this template.

```text
# UART Boot Log Record

## Board Info

Board ID:
PCB marking:
RAM chip:
RAM size:
Flash chip:
Flash size:
Firmware:
Power source:
UART adapter:
Baud rate:

## Boot Result

U-Boot output:
RAM detected:
Flash detected:
Boot menu:
Environment warning:
Kernel starts:
OpenWrt starts:
Login prompt:
Network status:
Errors:

## Full Log

<paste full UART log here>

## Notes

Notes:
```

---

## UART Recovery Record Template

Use this template when using UART for recovery.

```text
# UART Recovery Record

## Session Info

Date:
Tester:
Board ID:
Reason for recovery:

## Symptom

LED behavior:
Network behavior:
Wi-Fi behavior:
Last known working state:
Action before failure:

## UART

Adapter:
Baud:
Output present:
U-Boot present:
Kernel present:
Login prompt:
Error messages:

## Recovery Attempt

Method:
Commands used:
TFTP used:
Failsafe used:
Files used:
Image type:
Result:

## Final Status

Boots:
Ethernet:
Wi-Fi:
USB:
Notes:
```

---

## UART And OpenWrt Failsafe

If OpenWrt boots far enough, failsafe mode may be available.

Failsafe can help recover from bad config.

Possible use:

```text
mount_root
firstboot
reboot
```

Warning:

```text
firstboot
```

resets the writable overlay.

It can delete custom settings.

Use only when needed.

---

## UART And TFTP Recovery

UART is strongly recommended for TFTP recovery.

UART can show:

- U-Boot menu
- Router recovery IP
- Server IP
- Filename requested
- Transfer progress
- Flash erase progress
- Flash write progress
- Boot errors after recovery

TFTP without UART is mostly guessing.

---

## UART And CH341A Recovery

UART and CH341A work together.

Use UART to decide what needs to be fixed.

Examples:

| UART Result | Likely Recovery |
|---|---|
| U-Boot works, firmware bad | Restore firmware partition |
| No U-Boot output | Check flash with CH341A |
| Kernel panic | Reflash known-good firmware |
| OpenWrt boots, network bad | Fix config through UART |
| Wi-Fi calibration errors | Check factory partition |
| Flash not detected | Check flash chip soldering/programming |

Do not use CH341A blindly if UART shows a simpler fix.

---

## UART For 16 MB Flash Upgrades

UART is required for serious 16 MB flash testing.

Record:

- U-Boot flash detection
- Flash size reported by U-Boot
- Kernel flash detection
- MTD partition layout
- Firmware partition size
- Factory partition location
- OpenWrt boot result
- Ethernet result
- Wi-Fi result

Important commands after boot:

```text
cat /proc/mtd
dmesg | grep -i spi
dmesg | grep -i mtd
df -h
```

---

## UART For PS2 Internal Installs

For PS2 internal installs, UART should remain accessible.

Minimum service connector:

| Pin | Signal |
|---:|---|
| 1 | GND |
| 2 | Router TX |
| 3 | Router RX |

Optional:

| Pin | Signal |
|---:|---|
| 4 | 3.3 V sense only |
| 5 | Reset |

Do not bury the A5-V11 inside a PS2 without a recovery plan.

---

## Internal Service Connector Ideas

Possible UART service access options:

- Hidden JST connector
- Pogo pads
- Test pads near access panel
- Wires tucked under removable cover
- Header hidden inside expansion area
- Connection to Button Butler or service board
- Temporary connector removed after final testing

Label the connector clearly.

---

## UART Wire Color Convention

Suggested wire colors:

| Signal | Color |
|---|---|
| GND | Black |
| Router TX | Yellow |
| Router RX | White |
| 3.3 V sense | Red or orange |
| Reset | Blue |

This is only a convention.

Always verify with a meter and notes.

---

## Do Not Expose VCC Casually

If a service connector includes a 3.3 V pin, mark it as:

```text
3.3 V sense only
```

Do not use it as a power input unless the design is specifically made for that.

A service connector that exposes power can cause accidental shorts or backfeeding.

---

## UART And Backfeed

UART lines can backfeed if the adapter is connected while the router is off.

Symptoms:

- LEDs glow faintly
- Router partially powers
- PS2 partially powers
- Adapter powers part of the board through TX/RX
- UART behaves strangely

Avoid backfeed by:

- Leaving VCC disconnected
- Using a series resistor on RX
- Connecting ground first
- Powering router normally
- Disconnecting UART when not in use
- Testing always-on PS2 builds carefully

---

## Common UART Problems

## Problem: No Output

Possible causes:

- Wrong COM port
- Wrong baud rate
- TX not connected to adapter RX
- Ground not connected
- Router not powered
- Adapter not 3.3 V
- Bad adapter driver
- Bootloader corrupt
- Flash chip not responding
- Hardware damage

Try:

- Adapter loopback test
- Confirm 57600 8N1
- Swap suspected TX/RX
- Check GND
- Check router 5 V
- Check for boot LED activity
- Use CH341A if no output after wiring is confirmed

---

## Problem: Garbage Characters

Possible causes:

- Wrong baud rate
- Missing ground
- Bad connection
- Wrong voltage
- Electrical noise
- Bad terminal settings
- Flow control enabled

Try:

- Confirm 57600 baud
- Try 115200 only if 57600 fails and source suggests it
- Disable flow control
- Reconnect ground
- Shorten wires
- Use better adapter

---

## Problem: Output Works But Keyboard Input Does Not

Possible causes:

- Adapter TX not connected to router RX
- TX/RX reversed
- Flow control enabled
- Boot menu timeout missed
- Router RX line loaded
- Adapter TX voltage wrong
- Bad solder joint

Try:

- Adapter loopback test
- Disable flow control
- Press key earlier
- Add 470 ohm to 1 k ohm series resistor
- Check router RX pad
- Rewire TX to RX

---

## Problem: Router Hangs When RX Is Connected

Possible causes:

- Adapter drives RX during boot
- Wrong voltage
- RX line pulled incorrectly
- Bad adapter
- No series resistor
- Router RX connected to wrong pad

Try:

- Boot with only GND and router TX connected
- Add RX after boot
- Add 470 ohm to 1 k ohm series resistor
- Use another adapter
- Confirm voltage is 3.3 V
- Confirm pad

---

## Problem: Terminal Shows Nothing After Firmware Change

Possible causes:

- U-Boot corrupted
- Flash chip not programmed correctly
- Flash chip soldering issue
- Wrong flash chip orientation
- Wrong U-Boot
- Power issue
- UART wires disturbed

Check:

- Power voltage
- Current draw
- UART wiring
- Flash chip orientation
- CH341A read
- Original U-Boot backup

---

## Problem: U-Boot Input Missed

Possible causes:

- Boot delay very short
- Terminal opened too late
- Wrong key
- Input wiring problem
- Flow control enabled

Try:

- Open terminal before applying power
- Hold or repeatedly press key during power-on
- Confirm RX works
- Disable flow control
- Capture log and identify exact prompt

---

## Problem: UART Works On Bench But Not Inside PS2

Possible causes:

- Service connector wired wrong
- Ground issue
- PS2 power noise
- Backfeed
- Wires pinched
- Connector inaccessible
- Router not powered
- RX/TX swapped at service connector

Try:

- Check continuity
- Test with shell open
- Use stable external power
- Confirm ground
- Check for backfeed
- Retest router outside PS2

---

## UART Safety Checklist

Before connecting:

| Check | Done |
|---|---|
| Adapter is 3.3 V TTL |  |
| Not true RS-232 |  |
| Router VCC not connected |  |
| GND connected |  |
| Router TX to adapter RX |  |
| Adapter TX to router RX through resistor |  |
| Baud set to 57600 |  |
| Flow control disabled |  |
| Stable 5 V router power ready |  |
| Logging enabled |  |

---

## First UART Test Checklist

| Test | Result |
|---|---|
| Adapter loopback passed |  |
| Router boot text visible |  |
| U-Boot banner captured |  |
| RAM size recorded |  |
| Flash size recorded |  |
| Boot menu captured |  |
| Kernel starts |  |
| Firmware boot captured |  |
| Login prompt captured |  |
| Log saved |  |

---

## Recovery Diagnosis Checklist

If the router appears bricked:

| Check | Result |
|---|---|
| Correct 5 V power |  |
| LEDs behavior |  |
| Current draw |  |
| SoC temperature |  |
| UART output present |  |
| U-Boot appears |  |
| Kernel starts |  |
| OpenWrt/firmware boots |  |
| Login prompt appears |  |
| Network interface starts |  |
| Error message captured |  |
| Next recovery step chosen |  |

---

## Recommended UART Workflow

Use this workflow for every A5-V11 board:

1. Assign board ID.
2. Photograph board.
3. Identify flash chip.
4. Identify RAM chip.
5. Connect UART TX only plus ground.
6. Capture first boot log.
7. Add RX with series resistor.
8. Confirm input works.
9. Record U-Boot menu.
10. Let stock firmware boot.
11. Save log.
12. Back up flash.
13. Only then begin firmware experiments.

---

## Do Not Do This

Avoid these mistakes:

- Do not connect RS-232 directly.
- Do not use 5 V UART.
- Do not connect adapter VCC during normal console use.
- Do not omit ground.
- Do not assume no web UI means no boot.
- Do not flash firmware before capturing boot log.
- Do not select U-Boot write options casually.
- Do not ignore UART error messages.
- Do not bury the router inside a PS2 with no service access.
- Do not keep powering a board that gets hot abnormally.

---

## Short Version

UART is the most important A5-V11 recovery and debugging interface.

Use:

```text
57600 8N1
3.3 V TTL
GND shared
Router TX -> adapter RX
Adapter TX -> router RX through 470 ohm to 1 k ohm
VCC disconnected
```

UART can tell you whether the problem is:

- Power
- U-Boot
- Firmware
- Kernel
- Root filesystem
- Network config
- Wi-Fi/factory data
- USB/storage
- PS2 integration

If U-Boot still works, protect it.

If OpenWrt boots, fix config before reflashing.

If there is no UART output after wiring and power are confirmed, use CH341A recovery.

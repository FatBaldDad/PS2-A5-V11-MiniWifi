# 06 - UART Serial Console

## Summary

The A5-V11 has an internal UART serial console.

UART access is one of the most important tools for working with this router.

It allows direct low-level access to the bootloader, kernel boot log, stock firmware shell, OpenWrt shell, and recovery messages.

For serious A5-V11 work, UART access should be considered mandatory.

It is especially important before:

- Flashing firmware
- Replacing U-Boot
- Testing OpenWrt builds
- Upgrading to 8 MB or 16 MB flash
- Debugging no-network conditions
- Recovering from bad network settings
- Installing the board inside a PlayStation 2
- Testing PS2-specific firmware

## What UART Gives You

UART can provide access to:

- Bootloader output
- U-Boot menu
- Kernel boot log
- OpenWrt console
- Stock firmware console
- BusyBox shell
- Network configuration repair
- Firmware flashing messages
- USB detection messages
- Wi-Fi startup messages
- Filesystem and partition messages
- Crash or boot-loop messages

If Ethernet, Wi-Fi, web UI, SSH, or telnet stop working, UART may still tell you what is happening.

## UART Is Not USB

The A5-V11 UART is not the same thing as USB.

The micro-USB connector on the A5-V11 is normally for 5 V power input.

The UART console uses small internal solder pads on the PCB.

Do not plug the micro-USB port into a PC and expect a serial console.

## Important Voltage Warning

The A5-V11 UART is 3.3 V TTL serial.

Use a 3.3 V USB-to-TTL serial adapter.

Do not use 5 V serial logic.

Do not connect true RS-232 voltage levels directly to the A5-V11.

A real PC 9-pin serial port or RS-232 adapter can use positive and negative voltages that can damage the router unless it is converted to 3.3 V TTL first.

Safe adapters include common 3.3 V TTL adapters based on:

- CP2102
- CH340
- FT232
- PL2303
- Other USB-to-TTL adapters that support 3.3 V logic

Unsafe or risky without proper conversion:

- Direct PC COM port
- Direct DB9 RS-232 adapter
- 5 V Arduino serial pins
- 5 V USB-to-TTL adapters
- Unknown-voltage serial cables

## Required Tools

Minimum tools:

- 3.3 V USB-to-TTL serial adapter
- Soldering iron
- Fine solder
- Flux
- Small wire or pin header
- Terminal program
- Multimeter

Recommended tools:

- 470 ohm to 1 k ohm resistor
- Magnification
- Tweezers
- Kapton tape
- Heat shrink tubing
- Logic analyzer
- Current-limited bench power supply
- USB power meter
- CH341A or similar SPI programmer for firmware recovery work

## Terminal Programs

Common terminal programs:

| Platform | Program |
|---|---|
| Windows | PuTTY |
| Windows | Tera Term |
| Windows | RealTerm |
| Windows | Arduino Serial Monitor, limited but usable |
| Linux | screen |
| Linux | minicom |
| Linux | picocom |
| macOS | screen |
| macOS | minicom |
| macOS | CoolTerm |

PuTTY is a simple choice on Windows.

## UART Settings

Common A5-V11 UART settings:

| Setting | Value |
|---|---|
| Baud rate | 57600 |
| Data bits | 8 |
| Parity | None |
| Stop bits | 1 |
| Flow control | None |

Short form:

```text
57600 8N1
Flow control: None
```

If the output is unreadable, check wiring and baud rate.

## Board Orientation

Use this orientation when identifying the UART pads:

- USB Type-A host port on the left
- Ethernet RJ45 jack on the right
- Ralink / MediaTek RT5350F SoC on the opposite side of the board
- UART pads at the lower-right area of the PCB

In this orientation, the four UART pads are commonly read from left to right.

## UART Pad Order

Common A5-V11 UART pad order, left to right:

| Pad | Function | Connection |
|---:|---|---|
| 1 | VCC 3.3 V | Do not connect for normal serial use |
| 2 | TX | Connect to RX on USB-to-TTL adapter |
| 3 | RX | Connect to TX on USB-to-TTL adapter through 470 ohm to 1 k ohm resistor |
| 4 | GND | Connect to GND on USB-to-TTL adapter |

## Basic Wiring

Recommended basic wiring:

| A5-V11 Pad | Adapter Pin |
|---|---|
| TX | RX |
| RX | TX through 470 ohm to 1 k ohm resistor |
| GND | GND |
| VCC | Leave disconnected |

Do not connect VCC during normal serial-console work.

Power the A5-V11 from its normal 5 V input.

Power the USB-to-TTL adapter from the PC USB port.

Only the signal ground must be shared.

## Why TX And RX Cross

Serial TX means transmit.

Serial RX means receive.

The router transmit line must go to the adapter receive line.

The adapter transmit line must go to the router receive line.

Correct wiring:

```text
Router TX -> Adapter RX
Router RX <- Adapter TX
Router GND -> Adapter GND
```

If you get no output, TX and RX may be swapped.

## VCC Pad Warning

The VCC pad is 3.3 V.

For normal UART access, do not connect it.

Reasons to leave VCC disconnected:

- The router is already powered from 5 V.
- The adapter does not need to power the router.
- Backfeeding the router through UART can cause unstable behavior.
- Some adapters provide 5 V on their VCC pin.
- Mistakes can damage the router or adapter.

Use the VCC pad only for measurement or a specific documented test.

## RX Resistor Recommendation

A series resistor is recommended between the USB-to-TTL adapter TX pin and the A5-V11 RX pad.

Recommended value:

```text
470 ohm to 1 k ohm
```

This resistor helps because some A5-V11 boards may hang during boot when the adapter TX line is connected directly to the router RX pad before power-up.

Suggested wiring:

```text
Adapter TX -> 470 ohm to 1 k ohm resistor -> Router RX
```

The router TX line to adapter RX usually does not need this resistor.

## Boot-Hang Workaround

If the router hangs when UART is connected:

1. Disconnect the adapter TX wire from the router RX pad.
2. Leave router TX connected to adapter RX.
3. Leave ground connected.
4. Power the router.
5. Watch the boot log.
6. After boot starts, reconnect the adapter TX to router RX.
7. Add a 470 ohm to 1 k ohm series resistor for future use.

This issue usually affects the router RX line, which is driven by the adapter TX line.

## Read-Only UART Mode

For safest first testing, use read-only UART mode.

Connect only:

```text
Router TX -> Adapter RX
Router GND -> Adapter GND
```

Leave disconnected:

```text
Adapter TX -> Router RX
Router VCC
```

This lets you watch the boot log without sending anything to the router.

Read-only mode is useful when:

- You only need boot logs
- You are worried about boot hang
- You are verifying baud rate
- You are testing a new adapter
- You are documenting stock behavior

To type commands or interrupt U-Boot, you must also connect adapter TX to router RX.

## Full UART Mode

Full UART mode allows both reading and typing.

Connect:

```text
Router TX -> Adapter RX
Adapter TX -> 470 ohm to 1 k ohm resistor -> Router RX
Router GND -> Adapter GND
Router VCC -> Not connected
```

Use full UART mode when:

- You need shell access
- You need to interrupt U-Boot
- You need to repair network settings
- You need to run commands
- You need to use bootloader recovery
- You need to test OpenWrt console input

## Header Options

Possible UART connection methods:

- Solder wires directly to pads
- Solder a 4-pin header
- Solder a 3-pin header using TX, RX, and GND only
- Use test hooks
- Add castellated adapter PCB
- Add pads to a future PS2 integration board
- Add a hidden internal service connector

For development boards, a removable connector is recommended.

For PS2 internal installs, leave some way to access UART later.

## Header Pitch Note

The UART pads are small.

Some references describe the pad spacing as close to 2.0 mm, but a 2.54 mm header may be made to fit with care.

Do not force a header if it stresses the pads.

For a clean build, use small-gauge wire or a small service connector.

## Suggested Wire Colors

Suggested color convention:

| Signal | Suggested Color |
|---|---|
| GND | Black |
| Router TX | Yellow |
| Router RX | White |
| VCC, if measured only | Red |

This is only a convention.

Always label wires and verify with a meter.

## Adapter Loopback Test

Before connecting the adapter to the A5-V11, test the adapter.

Loopback test:

1. Disconnect the adapter from the router.
2. Connect adapter TX to adapter RX.
3. Open terminal program.
4. Select the correct COM port.
5. Set baud rate to 57600.
6. Type in the terminal window.
7. Characters should echo back.

If nothing appears:

- Wrong COM port
- Driver missing
- Adapter not working
- Terminal settings wrong
- Flow control enabled
- TX/RX loopback not connected

After loopback test, remove the TX-to-RX jumper before connecting the router.

## PuTTY Setup On Windows

Basic PuTTY setup:

1. Open PuTTY.
2. Select `Serial`.
3. Set `Serial line` to your COM port.
4. Set `Speed` to `57600`.
5. Go to `Connection -> Serial`.
6. Set `Data bits` to `8`.
7. Set `Stop bits` to `1`.
8. Set `Parity` to `None`.
9. Set `Flow control` to `None`.
10. Click `Open`.
11. Power the router.

Example settings:

```text
Connection type: Serial
Serial line: COM3
Speed: 57600
Data bits: 8
Stop bits: 1
Parity: None
Flow control: None
```

Your COM port may be different.

## Tera Term Setup On Windows

Basic Tera Term setup:

1. Open Tera Term.
2. Select `Serial`.
3. Choose the adapter COM port.
4. Go to `Setup -> Serial port`.
5. Set speed to `57600`.
6. Set data to `8 bit`.
7. Set parity to `none`.
8. Set stop bits to `1 bit`.
9. Set flow control to `none`.
10. Power the router.

Tera Term is useful because it can easily log serial output to a file.

## Linux screen Example

Example command:

```text
screen /dev/ttyUSB0 57600
```

To exit screen:

```text
Ctrl-A
K
Y
```

Your adapter may appear as:

```text
/dev/ttyUSB0
/dev/ttyUSB1
/dev/ttyACM0
```

## Linux minicom Example

Example setup:

```text
sudo minicom -s
```

Set:

```text
Serial device: /dev/ttyUSB0
Speed: 57600
Hardware flow control: No
Software flow control: No
```

Then save the setup and start minicom.

## macOS screen Example

Example command:

```text
screen /dev/tty.usbserial-0001 57600
```

Find serial devices with:

```text
ls /dev/tty.*
```

The exact device name depends on the adapter.

## First UART Test Procedure

Use this procedure for first UART connection.

1. Open the router shell.
2. Identify the UART pads.
3. Connect adapter GND to router GND.
4. Connect router TX to adapter RX.
5. Leave router RX disconnected for first test.
6. Leave router VCC disconnected.
7. Open terminal at 57600 8N1.
8. Apply 5 V power to the router.
9. Watch for boot text.
10. Save the log.
11. If output is readable, add adapter TX to router RX through a 470 ohm to 1 k ohm resistor.
12. Reboot and test keyboard input.

## Expected Boot Output

A working serial connection may show U-Boot output first.

Example boot-log style:

```text
U-Boot 1.1.7
Board: Ralink APSoC
DRAM: 32 MB
Ralink UBoot Version
ASIC 5350
Flash component: SPI Flash
The CPU freq = 360 MHZ
Please choose the operation:
1: Load system code to SDRAM via TFTP.
2: Load system code then write to Flash via TFTP.
3: Boot system code via Flash.
4: Enter boot command line interface.
7: Load Boot Loader code then write to Flash via Serial.
9: Load Boot Loader code then write to Flash via TFTP.
```

Exact output varies by bootloader.

## Expected Linux Boot Output

After U-Boot, Linux may start.

Example boot-log style:

```text
Starting kernel ...
Linux version ...
SoC Type: Ralink RT5350
MIPS: machine is A5-V11
Kernel command line: console=ttyS0,57600 rootfstype=squashfs,jffs2
Memory: ...
m25p80 ... spi flash ...
Creating MTD partitions ...
eth0 ...
usbcore ...
OpenWrt ...
```

Exact output depends on firmware version.

## Stock Firmware Console

Stock firmware may show a BusyBox shell or a limited shell.

Example style:

```text
BoC Login: admin
Password: admin

BusyBox v1.12.1 built-in shell
Enter 'help' for a list of built-in commands.

BoC Router>
```

Some stock shells are very limited.

Some commands may not work until a fuller shell is enabled.

## OpenWrt Console

OpenWrt may show:

```text
Please press Enter to activate this console.
```

Press Enter.

Depending on version and password state, you may get:

```text
root@OpenWrt:/#
```

or a login prompt.

## Useful Commands

Once you have shell access, useful commands include:

```text
cat /proc/cmdline
cat /proc/cpuinfo
cat /proc/meminfo
cat /proc/mtd
cat /proc/partitions
dmesg
logread
ifconfig
ip addr
route
df -h
mount
free
ps
uname -a
```

These help document:

- Kernel command line
- CPU information
- RAM size
- Flash partition layout
- USB detection
- Network configuration
- Mounted filesystems
- Available space
- Running services
- Firmware version

## Stock Firmware Commands

On some stock firmware versions, the shell may be limited.

Useful stock commands may include:

```text
help
show system revision
ping
traceroute
restore_defaults
restart_httpd
runshellcmd
```

Some firmware versions support:

```text
runshellcmd
```

This may enable a fuller shell.

Example:

```text
BoC Router> runshellcmd
shell mode on
BoC Router> cat /proc/cmdline
console=ttyS1,57600n8 root=/dev/ram0
```

Not every stock firmware supports this.

## U-Boot Access

UART can allow access to U-Boot.

U-Boot access may be needed for:

- TFTP loading
- Firmware recovery
- Flashing firmware
- Reading environment variables
- Checking RAM size
- Checking flash detection
- Bootloader testing

To interrupt U-Boot, power on the router and press a key when prompted.

Exact timing varies.

## U-Boot Warning

Do not randomly use U-Boot menu options.

Some options can overwrite firmware or bootloader areas.

Dangerous actions include:

- Writing firmware to flash
- Writing bootloader to flash
- Erasing flash
- Changing boot environment
- Loading unknown images
- Using images for the wrong RAM size
- Using images for the wrong flash size

Before using U-Boot recovery, document the boot log and confirm the correct method.

## Common U-Boot Menu Options

A common Ralink U-Boot menu may include options similar to:

| Option | Meaning |
|---:|---|
| 1 | Load system code to SDRAM via TFTP |
| 2 | Load system code then write to Flash via TFTP |
| 3 | Boot system code via Flash |
| 4 | Enter boot command line interface |
| 7 | Load Boot Loader code then write to Flash via Serial |
| 9 | Load Boot Loader code then write to Flash via TFTP |

These options may vary.

Do not assume the menu is identical on every board.

## Loading Firmware Over Serial Or TFTP

UART is often used with TFTP recovery.

General concept:

1. Connect UART.
2. Start terminal logging.
3. Set PC Ethernet to the expected static IP.
4. Start a TFTP server.
5. Interrupt U-Boot.
6. Choose the correct load or flash option.
7. Enter router IP, server IP, and file name if prompted.
8. Watch the transfer and flash messages.
9. Do not power off during writing.
10. Reboot and verify.

This is covered in more detail in the recovery documentation.

## Capturing Logs

Always save UART logs.

Logs help with:

- Board identification
- Firmware debugging
- Partition layout documentation
- RAM size confirmation
- Flash chip identification
- USB detection
- Wi-Fi startup
- Network interface names
- Boot failure diagnosis
- Repo documentation

Save logs as text files.

Suggested file names:

```text
board-001-stock-uart-bootlog.txt
board-001-openwrt-bootlog.txt
board-001-uboot-menu.txt
board-001-failed-flash-log.txt
board-001-usb-detection-log.txt
board-001-ps2-test-bootlog.txt
```

## What To Record From UART

Record:

| Item | Value |
|---|---|
| Board ID |  |
| Date |  |
| Adapter used |  |
| Terminal program |  |
| Baud rate |  |
| Wiring method |  |
| RX resistor value |  |
| Bootloader version |  |
| RAM size shown |  |
| Flash chip detected |  |
| Kernel command line |  |
| Firmware version |  |
| MTD partitions |  |
| Network interfaces |  |
| USB detection |  |
| Wi-Fi detection |  |
| Errors |  |
| Notes |  |

## Troubleshooting: No Output

If there is no serial output:

- Verify router has 5 V power.
- Verify adapter is detected by the PC.
- Verify the correct COM port.
- Verify terminal is set to 57600 baud.
- Verify flow control is disabled.
- Verify GND is connected.
- Swap TX and RX.
- Try read-only mode with router TX to adapter RX.
- Check solder joints.
- Check that the adapter is 3.3 V TTL.
- Try another USB cable.
- Try another terminal program.
- Try another adapter.
- Check if the router is actually booting.
- Check for shorts near the UART pads.

## Troubleshooting: Gibberish Output

If output is unreadable or garbage:

- Wrong baud rate
- Bad ground connection
- TX/RX wiring issue
- Adapter not using TTL levels
- Inverted serial adapter
- Loose wire
- Poor solder joint
- Electrical noise
- Router brownout during boot

Try:

```text
57600
115200
38400
9600
```

The expected A5-V11 setting is usually 57600.

## Troubleshooting: Router Hangs With UART Connected

If the router hangs or refuses to boot with UART connected:

- Disconnect adapter TX from router RX.
- Keep router TX connected to adapter RX.
- Keep GND connected.
- Boot the router.
- Add a 470 ohm to 1 k ohm resistor in series with router RX.
- Reconnect router RX only after boot starts.
- Confirm adapter TX is not holding the router RX line in a bad state.

This is a known issue on some setups.

## Troubleshooting: Can Read But Cannot Type

If boot logs appear but keyboard input does not work:

- Adapter TX may not be connected to router RX.
- TX and RX may be reversed.
- The RX resistor may not be connected.
- Flow control may be enabled.
- Terminal window may not be focused.
- The shell may not be accepting input yet.
- U-Boot timeout may have already passed.
- Router RX pad solder joint may be bad.
- Adapter may be receive-only or damaged.

Check wiring:

```text
Adapter TX -> resistor -> Router RX
Router GND -> Adapter GND
```

## Troubleshooting: Characters Do Not Echo

Many serial consoles do not echo characters until the shell is ready.

Try pressing Enter.

If nothing happens:

- Confirm full UART wiring.
- Confirm flow control is off.
- Confirm router is not stuck in boot.
- Confirm terminal program is connected.
- Confirm adapter TX works with loopback test.

## Troubleshooting: COM Port Does Not Appear

On Windows:

- Check Device Manager.
- Install adapter driver.
- Try another USB cable.
- Try another USB port.
- Avoid charge-only USB cables.
- Check for driver errors.
- Note the assigned COM number.

Common driver families:

- CH340
- CP210x
- FTDI
- PL2303

## Troubleshooting: Permission Denied On Linux

If Linux cannot open the serial adapter:

```text
sudo usermod -a -G dialout $USER
```

Then log out and back in.

Temporary access:

```text
sudo screen /dev/ttyUSB0 57600
```

## UART And PS2 Internal Installs

If the A5-V11 is installed inside a PS2, plan UART access before final assembly.

Possible options:

- Leave a small internal service connector
- Route UART pads to a hidden header
- Route UART to Button Butler or another controller board
- Add test pads near an access panel
- Use pogo pads
- Leave enough wire slack for service
- Add a removable connector
- Document the pinout inside the build notes

Do not bury the router permanently with no recovery access unless the firmware is fully proven.

## UART Service Connector Suggestion

Suggested 3-pin service connector:

| Pin | Signal |
|---:|---|
| 1 | GND |
| 2 | Router TX |
| 3 | Router RX |

Optional 4-pin service connector:

| Pin | Signal |
|---:|---|
| 1 | GND |
| 2 | Router TX |
| 3 | Router RX |
| 4 | 3.3 V sense only |

If 3.3 V is included, clearly label it as sense only unless the design specifically supports powering something from it.

## UART Safety Checklist

Before connecting UART:

| Check | Done |
|---|---|
| Adapter is 3.3 V TTL |  |
| Adapter is not true RS-232 level |  |
| VCC is not connected |  |
| GND is connected |  |
| Router TX goes to adapter RX |  |
| Adapter TX goes through resistor to router RX |  |
| Terminal is set to 57600 8N1 |  |
| Flow control is off |  |
| Router is powered from normal 5 V input |  |
| No shorts near UART pads |  |

## First Boot Log Checklist

When capturing the first boot log, look for:

| Item | Found |
|---|---|
| U-Boot version |  |
| RAM size |  |
| Flash chip ID |  |
| CPU frequency |  |
| Boot menu |  |
| Kernel command line |  |
| SoC type |  |
| Machine name |  |
| MTD partition layout |  |
| Ethernet driver |  |
| USB driver |  |
| Wi-Fi driver |  |
| Root filesystem |  |
| Errors |  |
| Login prompt |  |

## Useful Boot Log Sections

Important sections to save or quote in board notes:

```text
U-Boot version
DRAM size
Flash chip ID
CPU frequency
Boot menu
Kernel command line
MTD partitions
Ethernet initialization
USB initialization
Wi-Fi initialization
Root filesystem mount
Console login prompt
```

These sections help identify the board and firmware.

## Common Good Signs

Good signs:

- U-Boot text appears
- DRAM size is detected
- Flash is detected
- Kernel starts
- Machine is detected as A5-V11 or compatible
- MTD partitions are listed
- Ethernet initializes
- USB initializes
- Console prompt appears
- No repeated crash loop
- No flash read errors
- No kernel panic

## Common Bad Signs

Bad signs:

- No output at all
- Garbled output at every baud rate
- U-Boot starts but flash is not detected
- U-Boot loops
- Kernel never starts
- Kernel panic
- Repeated watchdog reset
- MTD partition errors
- Root filesystem cannot mount
- Ethernet driver crashes
- USB driver crashes
- Wi-Fi calibration errors
- Factory partition missing
- Crash loop after network startup

## UART And Factory Data

UART can help confirm factory data issues.

Watch for messages related to:

- Wi-Fi EEPROM
- RF calibration
- MAC address
- factory partition
- mtd factory
- rt2x00
- EEPROM checksum
- missing calibration data

If Wi-Fi fails after a flash upgrade, check UART logs for calibration or EEPROM errors.

## UART And Flash Upgrades

UART is especially important during 8 MB and 16 MB flash upgrades.

Use UART to confirm:

- Bootloader still starts
- RAM is detected correctly
- Flash chip is detected
- Firmware partition size is correct
- Kernel boots
- Factory partition is found
- Wi-Fi calibration works
- Overlay is created
- No boot loops occur

Do not rely only on LEDs.

## UART And Network Recovery

If OpenWrt boots but network access is broken, UART can repair it.

Common recovery commands:

```text
mount_root
vi /etc/config/network
/etc/init.d/network restart
firstboot
reboot
```

Use caution with `firstboot` because it resets overlay configuration.

If the firmware is experimental, back up configuration files first.

## UART And USB Debugging

UART is useful for USB debugging.

Commands:

```text
dmesg | grep usb
dmesg | grep sda
ls /dev/sd*
mount
block info
```

Useful questions:

- Does the USB device appear?
- Does `/dev/sda` appear?
- Does `/dev/sda1` appear?
- Is the filesystem supported?
- Did the mount script run?
- Did the drive draw too much power?
- Did the drive need to be present before boot?

## UART And Wi-Fi Debugging

UART is useful for Wi-Fi debugging.

Commands:

```text
dmesg | grep rt2
dmesg | grep phy
wifi status
iwinfo
ifconfig
logread
```

Useful questions:

- Did the Wi-Fi driver load?
- Was the RF calibration found?
- Was the interface created?
- Did the router associate to the access point?
- Did the custom config start Wi-Fi correctly?
- Is the antenna issue hardware instead of firmware?

## UART And PS2 Testing

For PS2-focused firmware, UART can confirm:

- Router boot time
- USB drive mount time
- Ethernet link state
- Wi-Fi connection state
- UDPBD service start
- UDPFS service start
- SMB service start
- FTP reachability
- Crash loops
- Service memory use
- Heat-related resets
- Power instability

During PS2 testing, save logs with test notes.

## Suggested PS2 UART Test Log

Use this template:

```text
Board ID:
Firmware:
Flash size:
PS2 model:
Power source:
USB storage:
Network mode:
PS2 loader:
UART connected:
Boot start time:
Ethernet ready time:
Wi-Fi ready time:
USB mounted time:
Service ready time:
PS2 loader start time:
Errors:
Notes:
```

## Serial Log Storage Location

Suggested repo folder:

```text
Test-Data/Boot-Logs/
```

Suggested structure:

```text
Test-Data/Boot-Logs/
├── Stock-Firmware/
├── OpenWrt/
├── U-Boot/
├── Recovery/
├── PS2-Tests/
└── Failed-Boots/
```

## File Naming Convention

Suggested log names:

```text
board-001-stock-firmware-boot-2026-01-01.txt
board-001-openwrt-17-01-7-boot-2026-01-01.txt
board-001-uboot-menu-2026-01-01.txt
board-001-16mb-flash-first-boot-2026-01-01.txt
board-001-ps2-udpbd-test-2026-01-01.txt
```

Use dates and board IDs.

## Do Not Publicly Share Sensitive Data Without Review

UART logs may contain:

- MAC addresses
- Wi-Fi SSIDs
- IP addresses
- Hostnames
- File paths
- Password-related messages
- Factory data references

Review logs before publishing them.

For public examples, redact private information.

## Recommended UART Install For Development Boards

For a development A5-V11 board:

- Add a small 3-pin header or connector.
- Use GND, TX, RX only.
- Leave VCC disconnected.
- Add the RX series resistor in-line or on a small adapter.
- Label the connector clearly.
- Capture a stock boot log before firmware changes.
- Keep the header accessible during testing.

## Recommended UART Plan For Internal PS2 Boards

For a PS2 internal build:

- Do not bury UART pads permanently.
- Add a service connector.
- Keep wires short.
- Keep UART wires away from noisy power wiring.
- Label TX, RX, and GND.
- Do not expose 3.3 V unless needed.
- Document access method in the build notes.
- Test UART before final assembly.

## Short Version

The A5-V11 UART serial console is a 3.3 V TTL serial interface.

Common settings are:

```text
57600 baud
8 data bits
No parity
1 stop bit
No flow control
```

Common pad order, left to right with USB on the left and Ethernet on the right:

```text
VCC, TX, RX, GND
```

Use:

```text
Router TX -> adapter RX
Router RX -> adapter TX through 470 ohm to 1 k ohm resistor
Router GND -> adapter GND
Router VCC -> not connected
```

UART is one of the most important tools for A5-V11 firmware development, recovery, flash upgrades, and PS2 integration.

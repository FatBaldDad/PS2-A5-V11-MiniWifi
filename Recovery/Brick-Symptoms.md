# Brick Symptoms

## Summary

This document describes common A5-V11 brick symptoms, what they may mean, and how to classify them before attempting recovery.

The A5-V11 is easy to soft-brick because it has very limited flash space, many firmware variants, different bootloader behavior, and very little margin for mistakes.

Not every failure is a true brick.

Some failures are only:

- Wrong IP address
- Wrong network interface
- Failed Wi-Fi setup
- Missing SSH
- Full overlay
- Bad firmware config
- Boot timing issue
- USB mount issue
- Power problem
- Brownout
- Bad Ethernet wiring
- Wrong PS2 boot timing

Before reflashing anything, identify the symptom carefully.

---

## Main Rule

The main rule is:

```text
Do not assume the router is dead until UART has been checked.
```

UART is the best way to tell the difference between:

- Bad network config
- Bad firmware
- Failed kernel boot
- Bad bootloader
- Bad flash chip
- Power problem
- True hard brick

---

## Important Warning

Do not keep flashing random files when the router stops responding.

Stop and diagnose.

Repeated blind flashing can make recovery worse, especially if it overwrites:

- U-Boot
- U-Boot environment
- Factory partition
- MAC address data
- Wi-Fi calibration data
- Firmware partition layout

Before recovery work, collect:

- Board ID
- Flash size
- RAM size
- Firmware file used
- Image type used
- Flash method used
- LED behavior
- IP behavior
- UART behavior
- Power draw
- Heat behavior

---

## Brick Severity Levels

Use these levels when documenting a failure.

| Level | Name | Meaning |
|---:|---|---|
| 0 | Not Bricked | Router works, but something is misconfigured |
| 1 | Network Lockout | Router boots but cannot be reached normally |
| 2 | Service Failure | Router boots, but required service does not start |
| 3 | OpenWrt Soft Brick | Router boots partly or fully, but config or image is broken |
| 4 | Bootloader Recovery Needed | U-Boot works, but firmware does not boot |
| 5 | SPI Programmer Recovery Needed | Router does not boot usable firmware or bootloader recovery is not available |
| 6 | Possible Hardware Damage | No UART, abnormal heat, abnormal current, or flash chip not responding |

---

## Quick Symptom Table

| Symptom | Likely Category | First Check |
|---|---|---|
| No LED at all | Power or hardware fault | Check 5 V input |
| Red and blue LEDs on | Firmware hang, boot issue, or hardware fault | Check UART |
| Dim red and blue LEDs | Possible hard fault or bad flash | Check current and UART |
| Blue LED flashing | Bootloader, recovery, or firmware activity | Check IP and UART |
| Red LED only | Firmware state or LED config | Check UART and network |
| No SSID | Wi-Fi not started or RF/factory issue | Check UART and `wifi status` |
| No Ethernet IP | Network config or interface issue | Check `eth0` vs `eth0.1` |
| Ping works, login refused | Missing service or wrong login method | Check UART |
| Telnet works, SSH refused | Dropbear missing or password not set | Check packages/config |
| SSH works, web UI broken | LuCI/uhttpd issue or no space | Check overlay/free space |
| USB not detected | Missing USB package, power, or mount issue | Check `dmesg` |
| Games list missing | PS2 timing/service/storage issue | Check service-ready timing |
| No UART output | Bootloader/power/flash/hardware issue | Check wiring and flash |
| Router gets hot and no boot | Possible SoC or flash fault | Power off and inspect |

---

## Not Every Failure Is A Brick

Many A5-V11 problems look like bricks but are recoverable.

Examples:

| Looks Like | Might Actually Be |
|---|---|
| No web page | Wrong IP or web server not installed |
| No SSH | Dropbear not installed or password not set |
| No telnet | OpenWrt password was set, so telnet closed |
| No Wi-Fi | Wi-Fi disabled, antenna disconnected, or bad factory data |
| No Ethernet | Wrong interface config |
| No USB drive | Missing USB storage packages |
| No games in OPL | Router not service-ready yet |
| Router unreachable | IP changed or DHCP assigned a different address |
| Firmware did not change | Stock bootloader rejected image |
| Only red LED | Blue LED not configured |
| Reboot problem | Power ramp or supervisor issue |

Always verify with UART before declaring the board dead.

---

## Common Brick Causes

Common A5-V11 brick causes include:

- Flashing the wrong image type
- Flashing a sysupgrade image as a full flash image
- Flashing a factory image to the wrong partition
- Flashing a full flash image from another board
- Flashing the wrong U-Boot
- Flashing a U-Boot meant for the wrong RAM size
- Flashing firmware built for the wrong flash size
- Overwriting the factory partition
- Losing Wi-Fi calibration data
- Bad OpenWrt network configuration
- Wrong Ethernet interface name
- Full overlay on 4 MB flash
- Missing SSH after telnet closes
- Bad power during flashing
- Removing power during flash write
- Bad SPI flash soldering
- Bad flash chip
- Bad CH341A write
- Wrong voltage programmer
- Corrupt firmware image
- Router brownout during boot
- Capacitor modification instability
- Missing supervisor/reset issue
- USB drive pulling too much current

---

## Image Type Mistakes

Image type mistakes are one of the easiest ways to brick the A5-V11.

| Image Type | Correct Use |
|---|---|
| `factory.bin` | First install from compatible stock firmware or bootloader method |
| `sysupgrade.bin` | Upgrade from an existing OpenWrt install |
| Full flash dump | External SPI programmer only |
| U-Boot image | Bootloader area only, high risk |
| Factory partition | Board-specific calibration area only |
| Raw firmware partition | Direct partition write only when layout is known |

Do not mix these up.

A `sysupgrade.bin` is not a full flash image.

A full flash image is not a normal firmware update.

A U-Boot image is not router firmware.

---

## U-Boot RAM Size Warning

Some A5-V11 bootloader files are tied to RAM size.

A common warning is:

```text
128 in the file name may indicate 16 MB RAM.
256 in the file name may indicate 32 MB RAM.
```

Flashing the wrong U-Boot can hard-brick the router.

Before touching U-Boot, confirm:

- Board marking
- RAM chip
- RAM size
- Flash size
- Original U-Boot backup
- UART access
- External SPI programmer recovery

Do not flash U-Boot casually.

---

## Stock Firmware Rejected Image

Symptom:

- Stock web UI reports success
- Progress reaches 100 percent
- Router reboots
- Router is still on stock firmware
- IP returns to stock address
- OpenWrt never appears

Possible cause:

```text
Stock firmware or bootloader rejected the image.
```

This can happen because some A5-V11 units have modified or restricted bootloaders.

What to check:

- Stock firmware version
- Bootloader behavior
- UART log
- Whether the image was actually written
- Whether stock firmware requires a vendor-style image
- Whether another install method is needed

Do not keep retrying random images from the stock web UI.

---

## Network Lockout

A network lockout means the router probably boots, but you cannot reach it over Ethernet or Wi-Fi.

Symptoms:

- LEDs show activity
- UART shows Linux booting
- Router does not respond at expected IP
- Web page does not load
- SSH does not connect
- Telnet does not connect
- DHCP server does not show expected lease

Likely causes:

- Wrong static IP
- DHCP client mode changed address
- DHCP server disabled
- Firewall blocking access
- Wrong OpenWrt interface name
- `eth0` vs `eth0.1` mismatch
- Bridge interface misconfigured
- Wi-Fi disabled
- LAN moved to another subnet

First recovery path:

- Use UART.
- Check `/etc/config/network`.
- Check `ip addr`.
- Check `logread`.
- Try OpenWrt failsafe if available.

---

## Wrong IP Address

Symptom:

- Router appears dead
- No web UI at expected IP
- No SSH at expected IP
- LEDs look normal
- UART shows boot complete

Possible cause:

```text
Router is alive but using a different IP address.
```

Common possible IPs:

| Firmware State | Possible IP |
|---|---|
| Stock firmware | 192.168.100.1 |
| OpenWrt default | 192.168.1.1 |
| Custom PS2 setup | 192.168.1.222 |
| DHCP client mode | Assigned by home router |
| Failsafe | Usually 192.168.1.1 |

What to try:

- Check DHCP leases on your home router.
- Try the known stock IP.
- Try OpenWrt default IP.
- Set PC static IP in the matching subnet.
- Use UART to run `ip addr`.

---

## Wrong Ethernet Interface

Symptom:

- OpenWrt boots
- UART works
- Ethernet does not respond
- Static IP config appears correct
- Router unreachable over wired LAN

Possible cause:

```text
Wrong Ethernet interface name in OpenWrt network config.
```

Depending on firmware, the A5-V11 Ethernet may use:

```text
eth0
eth0.1
br-lan
```

A config that works on one build may lock you out on another.

Check with UART:

```text
ip addr
ifconfig
cat /etc/config/network
logread
dmesg | grep eth
```

If the wrong interface is configured, fix `/etc/config/network` from UART or failsafe.

---

## SSH Refused After Setting Password

Symptom:

- Telnet used to work
- Password was set
- Telnet closes or stops working
- SSH connection is refused
- Router still responds to ping

Possible causes:

- Dropbear SSH server is missing
- Dropbear is not enabled
- Firewall blocks SSH
- OpenWrt image was too minimal
- Password set but SSH package not included

This can look like a brick, but the router may be alive.

Recovery options:

- UART console
- Failsafe mode
- Reflash known-good firmware
- Build firmware with Dropbear included
- Confirm SSH service before disabling telnet

---

## Web UI Broken

Symptom:

- Router boots
- Ping works
- SSH or telnet may work
- Web page does not load
- LuCI fails
- Web UI redirects wrong
- Web UI returns to home page
- Settings do not save

Possible causes:

- No LuCI installed
- uhttpd not running
- No space left on device
- Bad web config
- Stock firmware bug
- Browser redirected to wrong IP
- Overlay full
- 4 MB flash limitation

Check:

```text
df -h
logread
ps
/etc/init.d/uhttpd status
```

On 4 MB builds, the web UI may simply be too large or unreliable.

---

## No Space Left On Device

Symptom:

- Cannot set password
- Cannot save config
- Cannot create directory
- Cannot install packages
- `opkg` fails
- LuCI behaves strangely
- Overlay is full

Likely cause:

```text
4 MB flash is full or nearly full.
```

Check:

```text
df -h
mount
opkg list-installed
```

Important note:

Deleting built-in packages from a SquashFS OpenWrt image usually does not truly free flash space because the base firmware is read-only and changes are stored in overlay.

Better fixes:

- Build a smaller image
- Remove unused packages at build time
- Use 8 MB or 16 MB flash upgrade
- Use extroot for experiments
- Avoid full LuCI on stock 4 MB builds

---

## Firmware Boots But Services Fail

Symptom:

- Router responds to ping
- SSH or UART works
- Required PS2 service does not start
- OPL sees no games
- SMB share missing
- UDPBD missing
- UDPFS missing
- USB not mounted

This is usually not a brick.

Possible causes:

- USB storage not mounted
- Service starts before USB mount
- Missing package
- Wrong filesystem support
- Wrong path
- Wrong interface
- Not enough RAM
- Script error
- Service not executable
- Boot timing issue

Check:

```text
ps
logread
dmesg
mount
df -h
ls /mnt
```

---

## No Wi-Fi Or No SSID

Symptom:

- Router boots
- Ethernet may work
- No Wi-Fi network appears
- STA mode does not connect
- Wi-Fi range is extremely poor
- PS2 Wi-Fi bridge mode fails

Possible causes:

- Wi-Fi disabled in firmware
- Wireless config missing
- Bad factory partition
- Missing RF calibration data
- Disconnected antenna
- Damaged antenna trace
- PS2 RF shield blocking antenna
- Wrong country/channel settings
- Wi-Fi driver not loaded

Check:

```text
wifi status
iwinfo
logread | grep wlan
logread | grep wifi
dmesg | grep rt2x00
```

If the factory partition was overwritten, Wi-Fi may not work correctly.

---

## Red And Blue LEDs On

Symptom:

- Red and blue LEDs are both on
- No SSID
- No Ethernet response
- Router appears frozen
- May or may not have UART output

Possible causes:

- Bad firmware
- Bad flash contents
- Boot hang
- Kernel panic
- Bad U-Boot environment
- Wrong flash layout
- Power issue
- Rapid reboot freeze
- Hardware damage

First checks:

1. Check 5 V input.
2. Check current draw.
3. Check whether the Ralink chip gets hot.
4. Connect UART.
5. Capture boot log.
6. Try reset/failsafe only if UART indicates firmware reaches that stage.
7. If no UART output, prepare SPI programmer recovery.

---

## Dim Red And Blue LEDs

Symptom:

- Red and blue LEDs are both dim
- No blinking
- No network
- Router draws abnormal current
- SoC may heat up
- No UART output

This may indicate a serious problem.

Possible causes:

- Corrupt bootloader
- Dead or unresponsive flash chip
- Short on board
- Bad power rail
- Damaged SoC
- Bad flash soldering
- Wrong voltage applied
- Failed SPI flash chip

Stop testing if the chip gets hot quickly.

Next steps:

- Check power voltage.
- Check for shorts.
- Check current draw.
- Try UART.
- Inspect flash chip soldering.
- Read flash externally with CH341A.
- Compare flash dump size and contents.
- Consider replacing flash chip.

---

## Blue LED Flashing

Symptom:

- Blue LED flashes during boot or recovery
- Router may or may not respond to IP
- Reset button may change blink pattern

Possible meanings:

- Stock firmware boot activity
- OpenWrt boot activity
- U-Boot recovery/TFTP mode
- Failsafe mode
- Wi-Fi activity
- Firmware-specific LED behavior

Do not assume one LED pattern means one thing on every firmware.

Check:

- UART log
- IP address
- Ping response
- TFTP behavior
- Failsafe behavior
- Firmware documentation

---

## No LEDs

Symptom:

- No lights at all
- No heat
- No UART
- No network

Possible causes:

- No 5 V input
- Bad USB cable
- Bad power source
- Broken micro-USB connector
- Blown fuse or regulator
- Bad solder joint
- Board damage

Check first:

```text
5 V at input
5 V after connector
Ground continuity
Current draw
Visible damage
```

Do not start flash recovery until power is confirmed.

---

## No UART Output

Symptom:

- LEDs may or may not light
- No serial text during boot
- No U-Boot output
- No kernel output

Possible causes:

- UART wired wrong
- Wrong baud rate
- Wrong voltage adapter
- RX/TX swapped incorrectly
- Ground missing
- Adapter problem
- Router not powered
- Bootloader corrupt
- Flash chip not responding
- Hardware damage

UART checklist:

| Check | Expected |
|---|---|
| Adapter voltage | 3.3 V TTL |
| Baud rate | 57600 |
| Data format | 8N1 |
| Router TX | Adapter RX |
| Router RX | Adapter TX through resistor |
| GND | Shared |
| VCC | Do not connect |

If the router hangs when RX is connected, power the router first and then connect RX, or use a 470 ohm to 1 k ohm series resistor on RX.

---

## UART Shows U-Boot But No Kernel

Symptom:

- U-Boot prints normally
- Kernel does not start
- Bad checksum
- Bad image
- Boot loops
- Stops at booting image

Likely category:

```text
Firmware partition problem
```

Possible causes:

- Bad firmware image
- Wrong image type
- Wrong flash offset
- Corrupt kernel/rootfs
- Firmware too large
- Wrong partition layout
- Wrong flash size build

Recovery options:

- U-Boot TFTP recovery
- U-Boot menu option to write firmware
- SPI programmer write known-good firmware partition
- Restore full flash backup if needed

Do not overwrite U-Boot if U-Boot still works.

---

## UART Shows Kernel Panic

Symptom:

- U-Boot works
- Kernel starts
- Kernel panics
- Root filesystem cannot mount
- Reboots repeatedly

Possible causes:

- Bad rootfs
- Wrong rootfs type
- Bad partition offsets
- Firmware image too large
- Wrong target build
- Corrupt flash write
- Bad flash chip
- Wrong OpenWrt branch or target

Recovery:

- Use U-Boot TFTP if available.
- Use failsafe if it reaches preinit.
- Reflash known-good sysupgrade/factory image by correct method.
- Use CH341A if bootloader recovery is not enough.

---

## UART Shows OpenWrt Boot Complete But Network Dead

Symptom:

- UART reaches OpenWrt shell or login
- Ethernet does not respond
- Wi-Fi does not respond
- Web/SSH unreachable

Likely category:

```text
Network configuration problem
```

Check:

```text
ip addr
cat /etc/config/network
cat /etc/config/firewall
logread
```

Common fixes:

- Restore default network config
- Correct `eth0` vs `eth0.1`
- Disable firewall temporarily for bench test
- Set known static IP
- Use failsafe and `firstboot`
- Reflash known-good config

---

## Router Responds To Ping But Login Fails

Symptom:

- Ping works
- Telnet login fails
- SSH refused
- Web UI may or may not work

Possible causes:

- Wrong firmware state
- Wrong password
- Telnet disabled
- SSH missing
- Dropbear not running
- Stock firmware login changed
- Device is in unexpected factory firmware

Check:

- Try stock credentials only on stock firmware:

```text
admin / admin
```

- Try OpenWrt SSH:

```text
ssh root@192.168.1.1
```

- Use UART if login methods fail.

---

## OpenWrt Failsafe Symptoms

Failsafe may be available if OpenWrt reaches preinit.

Possible symptoms:

- LED changes during boot
- Button press during boot enters failsafe
- Router responds at OpenWrt failsafe IP
- Telnet available without password
- Overlay can be reset

Typical use:

```text
mount_root
firstboot
reboot
```

Warning:

`firstboot` resets the writable overlay and deletes custom settings.

Use it only when config recovery is needed.

---

## TFTP Recovery Symptoms

TFTP recovery may be available if the bootloader supports it.

Possible symptoms:

- Blue LED flashes after holding reset at power-on
- Router listens at a recovery IP
- TFTP transfer succeeds
- Router reboots after transfer

Important:

Not all bootloaders support the same TFTP recovery behavior.

Some modified bootloaders support TFTP recovery.

Some stock bootloaders may not.

Some bootloaders may look for a specific IP or filename.

Always confirm with UART when possible.

---

## SPI Flash Recovery Symptoms

Use SPI programmer recovery when:

- No network recovery works
- U-Boot is corrupt
- Firmware partition is corrupt and TFTP is unavailable
- Flash size was upgraded
- Wrong full flash image was written
- Factory partition needs restoration
- Router has no UART output but flash can be read
- Router is stuck before bootloader output

Tools may include:

- CH341A
- SOIC clip
- Hot air rework
- External flash socket
- flashrom
- AsProgrammer
- NeoProgrammer

Out-of-circuit programming is usually more reliable than in-circuit programming.

---

## Possible Hardware Damage Symptoms

Possible hardware damage signs:

- No UART output with confirmed correct wiring
- No flash response to SPI programmer
- SoC gets hot immediately
- Flash chip gets hot
- 5 V rail shorted
- 3.3 V rail shorted
- Current draw much higher than expected
- Board only shows dim LEDs
- Visible burnt component
- Wrong voltage applied
- Pads lifted around flash chip

If hardware damage is suspected, stop applying power until shorts are checked.

---

## Power-Related False Brick

Power problems can look like firmware failure.

Symptoms:

- Router starts sometimes
- Router freezes after hard reboot
- Router needs power removed for several seconds
- Red/blue LEDs stuck
- USB drive disconnects
- Wi-Fi drops under load
- Ethernet drops under load
- UART log restarts
- Works from bench supply but not PS2 USB

Possible fixes:

- Use better 5 V source
- Use shorter power wires
- Use thicker power wires
- Test without USB storage
- Add proper bulk capacitance
- Add reset supervisor
- Add heatsink
- Avoid rapid power cycling
- Use dedicated buck regulator

---

## Rapid Power Cycle Freeze

Symptom:

- Router works from cold boot
- Router freezes after reboot or quick power cycle
- Router needs to sit without power for several seconds
- Hard reboot is unreliable

Possible causes:

- Bad reset timing
- Capacitors not discharging
- Power ramp issue
- Brownout
- Supervisor IC needed
- USB storage startup load

Possible fix:

- Add MAX809TTR, ADM809, or similar reset supervisor
- Improve power source
- Wait 5 seconds after power-off
- Test with and without USB storage
- Capture UART logs

---

## Flash Chip Or Soldering Symptoms

Symptoms after flash replacement:

- No UART
- Wrong flash size detected
- Bootloader sees unrecognized chip
- Kernel cannot find partitions
- Flash read returns all `FF`
- Flash read returns all `00`
- Reads are different each time
- Router boots only when pressure is applied
- CH341A cannot identify chip
- Writes verify incorrectly

Check:

- Chip orientation
- Pin 1 location
- Solder bridges
- Lifted pads
- Correct voltage
- Correct chip type
- Correct programmer setting
- Full erase/write/verify
- Dump comparison

---

## Factory Partition Damage

Symptoms:

- Router boots
- Ethernet may work
- Wi-Fi does not work
- Wi-Fi MAC address missing or duplicated
- RF calibration errors
- Poor Wi-Fi range
- Wireless driver complains in logs

Possible cause:

```text
Factory partition was overwritten or copied from another board.
```

Recovery:

- Restore factory partition from the same board backup.
- If no backup exists, Wi-Fi may be difficult or impossible to restore correctly.
- Do not use another board's factory data unless you understand the consequences.

---

## Bad Firmware Size Or Layout

Symptoms:

- Image flashes but does not boot
- Kernel starts from wrong offset
- Rootfs missing
- Firmware partition overlaps factory data
- 16 MB flash build does not use full flash
- 4 MB build written to 16 MB chip but layout is wrong
- U-Boot cannot find image

Possible causes:

- Wrong DTS/partition layout
- Wrong image size
- Wrong flash-size target
- Wrong `IMAGE_SIZE`
- Wrong factory/sysupgrade format
- Full image assembled incorrectly

Recovery:

- Compare partition offsets.
- Confirm flash size.
- Confirm firmware start offset.
- Restore known-good dump.
- Rebuild firmware for exact flash layout.

---

## PS2-Specific False Brick Symptoms

When installed inside a PS2, the router may appear bricked due to PS2 integration issues.

| Symptom | Possible PS2 Integration Cause |
|---|---|
| Router does not boot | PS2 5 V rail sag |
| Router freezes | PS2 power cycle timing |
| No Ethernet | Internal Ethernet wiring issue |
| No Wi-Fi | Antenna blocked by RF shield |
| No USB | USB storage power issue |
| Games missing | PS2 loader launched too early |
| Works open, fails closed | Shell pressure, heat, or RF shield short |
| Works external, fails internal | Power, heat, antenna, or wiring issue |

Always retest externally before assuming firmware is bad.

---

## Symptom Recording Template

Use this template for every brick or failure event.

```text
# Brick Symptom Record

## Basic Info

Date:
Tester:
A5-V11 board ID:
PCB marking:
RAM chip:
RAM size:
Flash chip:
Flash size:
Firmware attempted:
Image type:
Flash method:
Power source:

## What Happened

Last known working state:
Action taken before failure:
Did power fail during flashing:
Did router reboot by itself:
Was USB attached:
Was PS2 attached:
Was UART attached:

## LED Behavior

No LEDs:
Red LED:
Blue LED:
Both LEDs:
Blink pattern:
Dim or bright:
Changes after reset button:

## Network Behavior

Expected IP:
Ping response:
Web UI:
Telnet:
SSH:
DHCP lease:
Wi-Fi SSID:
Ethernet link:

## UART Behavior

UART connected:
Baud rate:
Any output:
U-Boot output:
Kernel output:
OpenWrt output:
Error messages:

## Power Behavior

Voltage at input:
Current draw:
SoC temperature:
Flash temperature:
Any shorts:
Any abnormal heat:

## Recovery Tried

Reset button:
Failsafe:
TFTP:
UART commands:
SPI read:
SPI write:
Known-good image:
Result:

## Diagnosis

Brick severity:
Likely cause:
Next step:
Notes:
```

---

## First Diagnostic Checklist

Before reflashing, check:

| Check | Done |
|---|---|
| Correct 5 V power confirmed |  |
| Current draw measured |  |
| SoC temperature checked |  |
| Ethernet link checked |  |
| Known IPs tested |  |
| DHCP leases checked |  |
| UART connected |  |
| Correct UART settings used |  |
| U-Boot output checked |  |
| Kernel output checked |  |
| Failsafe attempted if available |  |
| TFTP recovery checked if bootloader supports it |  |
| Original flash backup located |  |
| Factory partition backup located |  |
| Image type confirmed |  |
| Flash size confirmed |  |
| RAM size confirmed |  |

---

## Do Not Do This

Avoid these mistakes:

- Do not keep power cycling rapidly.
- Do not flash random firmware files.
- Do not flash U-Boot without a backup.
- Do not use a U-Boot file for the wrong RAM size.
- Do not write a sysupgrade image as a full flash image.
- Do not overwrite the factory partition.
- Do not assume no web UI means dead.
- Do not assume no SSH means dead.
- Do not assume no Wi-Fi means dead.
- Do not power from an unstable PS2 rail during recovery.
- Do not attempt PS2 internal debugging before bench testing externally.
- Do not continue powering a board that gets hot abnormally.

---

## Recommended Recovery Order

Use this order:

1. Check power.
2. Check current draw.
3. Check heat.
4. Check Ethernet link.
5. Check known IP addresses.
6. Check DHCP leases.
7. Connect UART.
8. Capture boot log.
9. Try OpenWrt failsafe if firmware reaches preinit.
10. Try U-Boot TFTP if bootloader works.
11. Use SPI programmer to read flash.
12. Save the current broken dump before overwriting.
13. Compare with known-good backup.
14. Restore only what is needed.
15. Restore full flash only when necessary.
16. Retest on bench before PS2 installation.

---

## Brick Severity Decision Tree

```text
Does the router get correct 5 V?
    No -> Power problem
    Yes -> Continue

Does current draw look abnormal or does the SoC get hot fast?
    Yes -> Possible hardware damage
    No -> Continue

Is there UART output?
    No -> Check UART wiring, then suspect bootloader/flash/hardware
    Yes -> Continue

Does U-Boot appear?
    No -> Bootloader or flash problem
    Yes -> Continue

Does the kernel start?
    No -> Firmware partition/image problem
    Yes -> Continue

Does OpenWrt or stock firmware finish booting?
    No -> Kernel/rootfs/config problem
    Yes -> Continue

Can network be reached?
    No -> Network config/interface/IP problem
    Yes -> Continue

Does the required service work?
    No -> Service/config/storage/timing problem
    Yes -> Not bricked
```

---

## Common Recovery Paths By Symptom

| Symptom | Best First Recovery Path |
|---|---|
| Wrong IP | UART or DHCP lease check |
| SSH refused | UART, check Dropbear |
| Web UI missing | SSH/UART, check uhttpd/LuCI |
| Full overlay | Failsafe or rebuild smaller image |
| Bad network config | Failsafe or UART edit |
| Firmware fails after U-Boot | U-Boot TFTP or SPI firmware restore |
| No U-Boot | SPI programmer restore |
| Bad flash replacement | Reinspect soldering and reprogram |
| Lost factory data | Restore same-board factory backup |
| Rapid reboot freeze | Power/supervisor testing |
| PS2 internal failure | Remove from PS2 and bench test |

---

## Short Version

A bricked A5-V11 is not always truly dead.

First decide what kind of failure it is:

- Power problem
- Network lockout
- Missing SSH/web service
- Full overlay
- Bad OpenWrt config
- Bad firmware image
- Bad bootloader
- Bad flash chip
- Lost factory partition
- PS2 integration problem
- Actual hardware damage

The most important recovery tool is UART.

The safest recovery plan is:

```text
Check power.
Check UART.
Capture boot log.
Identify where boot stops.
Recover only the broken layer.
Avoid touching U-Boot or factory data unless necessary.
```

If U-Boot still works, do not overwrite it.

If the factory partition is still intact, protect it.

If the board gets hot and gives no UART output, stop and inspect hardware before continuing.

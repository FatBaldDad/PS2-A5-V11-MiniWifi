# 08 - Known Issues

## Summary

This document tracks known and likely issues with the A5-V11 mini router.

The A5-V11 is useful, cheap, and small, but it is also old, inconsistent, and very limited in stock form.

Most issues come from:

- 4 MB flash limitation
- 32 MB RAM limitation
- Board-to-board variation
- Stock firmware variation
- Bootloader variation
- Weak or missing antenna connection
- Heat
- Power instability
- Bad flash attempts
- Wrong U-Boot files
- Poor recovery planning
- USB storage timing
- PS2 integration constraints

This document should be updated as more boards are tested.

## Issue Status Labels

Use these labels when documenting problems.

| Label | Meaning |
|---|---|
| Confirmed | Reproduced or documented from a reliable source |
| Observed | Seen on at least one tested board |
| Likely | Plausible based on symptoms and known behavior |
| Experimental | Possible issue during experimental work |
| Needs Testing | Not confirmed yet |
| PS2-Specific | Mainly affects PlayStation 2 integration |
| Critical | Can brick or damage hardware |
| Workaround Available | A known fix or partial fix exists |

## Quick Issue Index

| Issue | Severity | Area |
|---|---|---|
| 4 MB flash is too small | High | Firmware |
| 32 MB RAM is limiting | High | Firmware |
| Stock firmware varies | High | Firmware |
| Bootloader varies | Critical | Recovery |
| Wrong U-Boot can brick board | Critical | Recovery |
| Factory partition loss | Critical | Flash |
| Web UI flash may silently fail | High | Firmware |
| Bad network config can lock out access | Medium | Network |
| `eth0` vs `eth0.1` confusion | Medium | Network |
| Unused Ethernet PHYs waste power | Medium | Power/Thermal |
| Board gets hot | Medium | Thermal |
| Antenna may be disconnected | Medium | Wi-Fi |
| Blue LED may not work by default | Low | LEDs |
| UART RX can cause boot hang | Medium | UART |
| GPIO current is limited | Medium | Hardware |
| USB storage may need to be connected before boot | Medium | USB/PS2 |
| USB drive power draw can destabilize board | Medium | USB/Power |
| Router boot time can be too slow for PS2 auto-launch | Medium | PS2 |
| No plug-and-play USB behavior on some builds | Medium | USB/PS2 |
| Supervisor IC may be needed for reliable reset | Medium | Power/Reset |
| Dim red/blue LEDs may indicate serious brick | Critical | Recovery |
| Similar boards are not always compatible | High | Hardware |

## 4 MB Flash Is Too Small

### Status

Confirmed

### Severity

High

### Area

Firmware

### Description

The stock A5-V11 commonly has only 4 MB of SPI flash.

This is one of the biggest limitations of the board.

The flash must contain:

- U-Boot
- U-Boot environment
- Factory data
- Linux kernel
- Root filesystem
- Writable overlay

That leaves very little space for useful packages.

### Symptoms

- OpenWrt image barely fits
- No overlay space
- Password cannot be saved
- SSH may be missing
- LuCI may not fit
- USB storage packages may not fit
- exFAT support may not fit
- SMB support may not fit
- Firmware builds fail due to image size
- Web UI exists but cannot save settings
- `No space left on device`

### Causes

- Stock 4 MB SPI flash
- Modern OpenWrt images are too large
- Kernel size growth
- Package size growth
- LuCI and storage packages consume too much space

### Workarounds

- Build a very minimal image
- Remove LuCI
- Remove IPv6 if not needed
- Remove PPP and 3G modem packages if not needed
- Use only one service mode at a time
- Use ImageBuilder or Buildroot to trim packages
- Use extroot for experiments
- Upgrade flash to 8 MB or 16 MB
- Use UART for development instead of relying on web UI

### Recommended Repo Direction

For stock 4 MB boards, only support very focused firmware roles.

Examples:

- Wi-Fi bridge only
- UDPBD-only
- Minimal recovery image
- Minimal USB storage test image

For serious PS2 use, 16 MB flash should be the preferred long-term direction.

## 32 MB RAM Is Limiting

### Status

Confirmed

### Severity

High

### Area

Firmware

### Description

The useful/common A5-V11 has 32 MB RAM.

This is enough for older OpenWrt builds and single-purpose tasks, but it is still very limited.

### Symptoms

- Services crash under load
- OOM behavior
- Slow web UI
- SMB instability
- USB storage issues
- Wi-Fi and storage together may be unreliable
- Multiple services running at once can overwhelm the board

### Causes

- Only 32 MB RAM
- Old embedded SoC
- Heavy services
- Too many packages
- Too many daemons
- USB storage buffers
- Samba memory use
- Web UI memory use

### Workarounds

- Run one major service at a time
- Avoid full LuCI on 4 MB builds
- Avoid Samba unless specifically testing SMB
- Avoid multiple storage services at once
- Disable unnecessary daemons
- Keep logs small
- Test RAM usage during PS2 loads
- Use simple scripts instead of heavy services

### Recommended Repo Direction

Treat the A5-V11 as a single-purpose appliance.

Do not try to make one firmware that does everything at once.

## Stock Firmware Varies

### Status

Confirmed

### Severity

High

### Area

Firmware

### Description

A5-V11 stock firmware varies heavily.

Two routers that look the same can have different firmware, web interfaces, shell access, update behavior, and bootloader behavior.

### Symptoms

- Different default IP address
- Different web UI
- Different language
- Qualcomm-branded UI on Ralink/MediaTek hardware
- Telnet works on one board but not another
- `runshellcmd` works on one board but not another
- Web flashing works on one board but not another
- USB flashing works on one board but not another

### Causes

- Generic unbranded production
- Different vendors
- Different firmware builds
- Different bootloaders
- Grey-market or clone manufacturing
- Component substitutions

### Workarounds

- Identify each board individually
- Photograph each board
- Record firmware version
- Record web UI behavior
- Record telnet behavior
- Capture UART logs
- Dump flash before changes
- Do not assume guides apply to every board

### Recommended Repo Direction

Create board logs.

Do not write instructions as if every A5-V11 behaves the same.

## Bootloader Varies

### Status

Confirmed

### Severity

Critical

### Area

Recovery

### Description

Many A5-V11 boards use U-Boot, but not all U-Boot builds behave the same.

Some bootloaders accept standard OpenWrt images.

Some only accept vendor-modified images.

Some support TFTP recovery.

Some do not.

Some have reset-button GPIO issues.

### Symptoms

- Web flash appears successful but stock firmware remains
- TFTP recovery does not start
- Reset button does not trigger expected mode
- U-Boot menu differs from guide
- Router accepts only certain image formats
- Standard OpenWrt factory image is rejected
- Router bricks after bootloader replacement

### Causes

- Different U-Boot builds
- Vendor-modified bootloaders
- Wrong GPIO mapping
- Wrong RAM-size bootloader
- Wrong flash-size assumptions
- Locked or crippled bootloader

### Workarounds

- Capture U-Boot log over UART
- Back up original U-Boot
- Confirm RAM size before flashing U-Boot
- Confirm flash size before flashing U-Boot
- Use external programmer before risky bootloader work
- Avoid replacing U-Boot unless required
- Keep a known-good flash dump

### Recommended Repo Direction

Document U-Boot behavior per board.

Do not treat one U-Boot file as universal.

## Wrong U-Boot Can Brick The Board

### Status

Confirmed

### Severity

Critical

### Area

Recovery

### Description

Flashing the wrong U-Boot can hard-brick the A5-V11.

Older guides may reference U-Boot files for different RAM sizes.

A common warning is that files with `128` may be for 16 MB RAM units, while files with `256` may be for 32 MB RAM units.

### Symptoms

- No serial output
- No Ethernet link
- No TFTP recovery
- Red and blue LEDs stuck on
- Router heats up
- Flash programmer required
- Flash chip may need removal

### Causes

- Wrong U-Boot file
- Wrong RAM-size bootloader
- Wrong flash-size bootloader
- Wrong board variant
- Interrupted bootloader write
- Blindly following old guides

### Workarounds

- Confirm RAM chip and RAM size
- Back up original bootloader
- Use UART during flashing
- Use only known-good U-Boot for the exact board
- Have CH341A or equivalent programmer ready
- Do not flash U-Boot unless necessary

### Recommended Repo Direction

Mark all U-Boot operations as high risk.

## Factory Partition Loss

### Status

Confirmed

### Severity

Critical

### Area

Flash

### Description

The factory partition may contain board-specific RF calibration and MAC address data.

Losing or overwriting this partition can break Wi-Fi or create duplicate MAC addresses.

### Symptoms

- Wi-Fi missing
- Wi-Fi driver errors
- Poor Wi-Fi range
- EEPROM checksum errors
- RF calibration errors
- MAC address missing
- Duplicate MAC address
- OpenWrt boots but wireless does not work

### Causes

- Full flash overwrite from another board
- Bad 16 MB migration
- Erasing flash without backup
- Writing firmware at wrong offset
- Confusing full flash image with firmware image
- Using someone else's factory data

### Workarounds

- Dump original flash first
- Extract factory partition
- Save multiple copies
- Keep factory partition at expected offset
- Restore board-specific factory partition after flash upgrade
- Do not publish or reuse random factory partitions

### Recommended Repo Direction

Every flash guide should repeat:

Back up the factory partition before changing anything.

## Web UI Flash May Silently Fail

### Status

Confirmed

### Severity

High

### Area

Firmware

### Description

Some stock web interfaces may appear to accept a firmware update but do not actually replace the firmware.

### Symptoms

- Web upload reaches 100 percent
- Router reboots
- Stock firmware still loads
- IP address remains stock
- OpenWrt never appears
- LED behavior remains stock
- No change in telnet prompt

### Causes

- Vendor-modified firmware validation
- Crippled bootloader
- Image format mismatch
- Web UI rejects unofficial images
- Web UI gives misleading success message

### Workarounds

- Verify flash result through UART
- Check OpenWrt banner
- Check IP behavior
- Check telnet or SSH behavior
- Use UART/U-Boot method
- Use stock telnet `mtd_write` only if confirmed safe
- Use external SPI programmer

### Recommended Repo Direction

Do not trust web UI success messages.

Always verify the actual firmware after flashing.

## Bad Network Config Can Lock Out Access

### Status

Confirmed

### Severity

Medium

### Area

Network

### Description

A bad network configuration can make the router unreachable over Ethernet or Wi-Fi.

### Symptoms

- No web UI
- No SSH
- No telnet
- Router boots but cannot be reached
- DHCP does not work
- Static IP unknown
- PC cannot ping router
- Router is alive over UART only

### Causes

- Wrong interface name
- Wrong bridge config
- DHCP disabled
- Static IP outside expected subnet
- Firewall enabled unexpectedly
- DNSMasq disabled incorrectly
- Wi-Fi client mode misconfigured
- Wrong VLAN interface

### Workarounds

- Use UART to inspect and fix `/etc/config/network`
- Use OpenWrt failsafe
- Keep a known recovery IP
- Document default IP for each build
- Avoid changing multiple network settings at once
- Test Ethernet before Wi-Fi

### Recommended Repo Direction

Every firmware build should document:

- Default IP
- Interface names
- DHCP behavior
- Recovery method
- UART access plan

## `eth0` vs `eth0.1` Confusion

### Status

Confirmed

### Severity

Medium

### Area

Network

### Description

Some A5-V11 OpenWrt configurations use `eth0.1` for LAN instead of plain `eth0`.

Using the wrong interface can make Ethernet unreachable.

### Symptoms

- Ethernet link appears but no IP
- DHCP client/server does not work
- Router unreachable after flash
- Wi-Fi works but Ethernet does not
- Serial console shows network config errors

### Causes

- VLAN interface expected by firmware
- OpenWrt branch differences
- Device tree or switch config differences
- Copying config from another board
- Incorrect PS2-focused network config

### Workarounds

- Check UART boot log
- Run `ip addr`
- Run `ifconfig`
- Check `/etc/config/network`
- Test both `eth0` and `eth0.1` in development
- Document the working interface for each build

### Recommended Repo Direction

Firmware release notes must list the Ethernet interface name.

## Unused Ethernet PHYs Waste Power

### Status

Confirmed

### Severity

Medium

### Area

Power/Thermal

### Description

The RT5350F has internal Ethernet switch/PHY features beyond the single physical port exposed on the A5-V11.

Unused internal PHYs may still consume power unless disabled.

### Symptoms

- Higher idle current
- More heat
- Router runs warm in plastic shell
- Router runs warmer inside PS2
- Long-term stability concerns

### Causes

- Internal PHYs enabled by default
- Firmware does not disable unused switch ports
- One physical Ethernet port but multiple internal switch ports active

### Workaround

Disable unused switch ports.

Example concept:

```text
swconfig dev switch0 port 1 set disable 1
swconfig dev switch0 port 2 set disable 1
swconfig dev switch0 port 3 set disable 1
swconfig dev switch0 port 4 set disable 1
swconfig dev switch0 set apply
```

To make it persistent, add tested commands to:

```text
/etc/rc.local
```

### Warning

Do not blindly add these commands until Ethernet is tested.

Wrong switch settings may break network access.

### Recommended Repo Direction

Power-optimized firmware should document whether unused PHYs are disabled.

## Board Gets Hot

### Status

Confirmed

### Severity

Medium

### Area

Thermal

### Description

The A5-V11 can run hot, especially in its plastic shell or inside another enclosure.

### Symptoms

- RT5350F too hot to touch comfortably
- Wi-Fi instability
- Random lockups
- Failed boot after warm reset
- USB storage disconnects
- Router works on bench but fails inside PS2
- Long-term reliability concerns

### Causes

- Small board
- Poor airflow
- Plastic shell
- Internal switch PHYs active
- Wi-Fi load
- USB storage load
- Inside PS2 shell
- Near other heat sources
- No heatsink

### Workarounds

- Remove stock plastic case
- Add heatsink to RT5350F
- Use thermal pad to PS2 RF shield
- Add copper heat spreader
- Disable unused switch ports
- Disable unused services
- Avoid running Wi-Fi, SMB, UDPBD, and web UI all at once
- Test inside the actual PS2 shell

### Recommended Repo Direction

Every PS2 internal install should include thermal testing.

## Antenna May Be Disconnected Or Poor

### Status

Confirmed

### Severity

Medium

### Area

Wi-Fi

### Description

Some A5-V11 boards have poor Wi-Fi range because the antenna path is missing, disconnected, poorly soldered, or badly implemented.

### Symptoms

- Very short Wi-Fi range
- Works near router but fails across room
- STA/client mode unreliable
- Wi-Fi scan shows weak signal
- Poor PS2 internal performance
- Better performance when board is repositioned
- Poor signal after putting PS2 RF shield back on

### Causes

- Disconnected antenna
- Poor antenna solder point
- Bad antenna trace
- Metal shield blocking signal
- PS2 shell/RF shield interference
- Internal mounting location too close to metal
- Damaged RF path

### Workarounds

- Inspect antenna path under magnification
- Repair missing solder connection
- Add external antenna mod
- Move antenna away from RF shield
- Use plastic shell area for antenna placement
- Test signal before and after final assembly
- Keep Wi-Fi antenna away from other wireless modules when possible

### Recommended Repo Direction

Antenna inspection should be part of every board log.

## Blue LED May Not Work By Default

### Status

Confirmed

### Severity

Low

### Area

LEDs

### Description

Some OpenWrt builds only enable the red LED by default.

The blue LED may need manual configuration.

### Symptoms

- Red LED works
- Blue LED never lights
- Wi-Fi works but blue LED has no activity
- LED behavior differs from stock firmware

### Cause

OpenWrt LED configuration does not assign the blue LED by default.

### Workaround

Example blue Wi-Fi LED config:

```text
config led
        option default '0'
        option name 'WIFI'
        option sysfs 'a5-v11:blue:system'
        option trigger 'netdev'
        option dev 'wlan0'
        option mode 'link tx rx'
```

### Recommended Repo Direction

Firmware release notes should state LED behavior.

## UART RX Can Cause Boot Hang

### Status

Confirmed

### Severity

Medium

### Area

UART

### Description

Some A5-V11 boards may hang during boot if a serial adapter TX line is connected directly to the router RX pad before power-up.

### Symptoms

- Router boots normally without UART RX connected
- Router hangs when UART adapter TX is connected
- No full boot log
- Boot continues if RX is connected after power-up
- U-Boot or kernel does not continue

### Cause

The USB-to-TTL adapter TX line may hold the router RX line in a state that interferes with boot.

### Workarounds

Use a resistor between adapter TX and router RX.

Recommended value:

```text
470 ohm to 1 k ohm
```

Safe wiring:

```text
Router TX -> Adapter RX
Adapter TX -> 470 ohm to 1 k ohm resistor -> Router RX
Router GND -> Adapter GND
Router VCC -> Not connected
```

Alternative workaround:

1. Power router first.
2. Wait for boot to start.
3. Connect adapter TX to router RX after boot begins.

### Recommended Repo Direction

Every UART guide should include the RX resistor warning.

## GPIO Current Is Limited

### Status

Confirmed

### Severity

Medium

### Area

Hardware

### Description

A5-V11 GPIOs have limited current capability.

Known notes warn that GPIOs can handle only about 4 mA.

### Symptoms

- GPIO pin voltage droops
- LED too dim or pin overloaded
- Unstable output
- Possible SoC damage
- External circuit not switching correctly

### Causes

- GPIO used to directly drive a load
- No transistor or buffer
- LED resistor too low
- Relay or external circuit driven directly
- GPIO used beyond its safe current limit

### Workarounds

- Use GPIO only as a logic signal
- Use transistor, MOSFET, buffer, or logic gate
- Use proper resistor values
- Do not directly drive relays, buzzers, motors, or heavy LEDs
- Keep PS2 integration signals high impedance where possible

### Recommended Repo Direction

All GPIO hardware mods should include a driver circuit.

## USB Storage May Need To Be Connected Before Boot

### Status

Confirmed on some PS2-focused builds

### Severity

Medium

### Area

USB/PS2

### Description

Some A5-V11 firmware builds only detect or mount the USB drive during boot.

If the USB drive is connected after boot, the service may not start correctly.

### Symptoms

- USB drive not detected
- No games listed
- UDPBD does not start
- SMB share missing
- `/dev/sda1` missing
- Mount point empty
- Reboot with drive inserted fixes it

### Causes

- Mount script only runs at boot
- No hotplug handling
- Minimal firmware lacks plug-and-play support
- USB storage service starts before drive is ready
- Drive power-up delay

### Workarounds

- Insert USB drive before powering router
- Reboot router after inserting USB drive
- Add hotplug scripts
- Add mount retry logic
- Add service start delay
- Use a known-good USB drive
- Use stable power

### Recommended Repo Direction

PS2 firmware notes must state whether USB hotplug is supported.

## USB Drive Power Draw Can Destabilize The Board

### Status

Likely / Observed in small embedded systems

### Severity

Medium

### Area

USB/Power

### Description

USB storage can draw enough current to cause voltage dips or unstable boot behavior.

This is especially important when powering the A5-V11 from a PS2 USB port or internal 5 V source.

### Symptoms

- Router resets when drive spins up
- USB drive disappears
- Boot hangs
- Wi-Fi drops
- UDPBD stops
- Board works without USB drive but fails with it
- SSD works but mechanical HDD fails
- Large drive fails during startup

### Causes

- USB drive inrush current
- Weak 5 V source
- Thin wiring
- Poor ground return
- Too little bulk capacitance
- Capacitors relocated or reduced too aggressively
- PS2 USB current limit
- Drive needs more current than router can provide

### Workarounds

- Use low-power USB flash drive
- Use powered USB storage
- Use separate 5 V regulator for drive
- Add adequate bulk capacitance
- Keep power wires short
- Use thicker power and ground wires
- Test current draw during boot
- Avoid mechanical hard drives unless externally powered

### Recommended Repo Direction

Every USB storage test should record drive model and current draw.

## Router Boot Time Can Be Too Slow For PS2 Auto-Launch

### Status

Confirmed in PS2-focused workflows

### Severity

Medium

### Area

PS2

### Description

The router may need time to boot, mount USB storage, connect Wi-Fi, and start services before the PS2 loader tries to access it.

### Symptoms

- OPL starts before router is ready
- Games list is empty
- UDPBD not detected
- SMB share not found
- FTP not reachable immediately
- Waiting and restarting loader fixes it
- Auto-launch fails but manual launch works

### Causes

- Router boot time
- USB mount delay
- Wi-Fi association delay
- Service startup delay
- PS2 boots faster than router
- Router powered from PS2 USB, so it starts at the same time as PS2

### Workarounds

- Add PS2-side boot delay
- Power router before PS2
- Keep router always powered
- Add firmware service-ready LED
- Add startup script delays
- Use loader configuration with delayed launch
- Start OPL manually after router is ready

### Recommended Repo Direction

Every PS2 test should record router boot-to-ready time.

## No Plug-And-Play USB Behavior On Some Builds

### Status

Confirmed on some PS2-focused builds

### Severity

Medium

### Area

USB/PS2

### Description

Some minimal builds do not support full plug-and-play USB behavior.

The USB drive may need to be connected before power-on and removed only after power-off.

### Symptoms

- Drive inserted after boot is ignored
- Drive removed while running causes service failure
- Reinserted drive does not remount
- Games list disappears
- Mount point does not update

### Causes

- Minimal hotplug support
- Service scripts only run once
- No automount daemon
- Limited RAM and flash
- Purpose-built firmware design

### Workarounds

- Insert drive before powering router
- Power down before removing drive
- Add hotplug scripts
- Add remount button or web command
- Add service restart script
- Use a stable drive and do not hot-swap

### Recommended Repo Direction

Documentation should clearly state when hotplug is not supported.

## Supervisor IC May Be Needed For Reliable Reset

### Status

Observed / Recommended by PS2-focused A5-V11 work

### Severity

Medium

### Area

Power/Reset

### Description

Some A5-V11 boards may not reliably boot after a hard reboot or short power interruption.

A supervisor IC such as MAX809TTR or ADM809 may help by holding reset until voltage is stable.

### Symptoms

- Router does not start after hard reboot
- Router needs power removed for several seconds
- Router freezes during boot
- Red and blue LEDs stay on
- Router works after full power drain
- Unreliable PS2 power-on behavior

### Causes

- Poor reset timing
- Power ramp issue
- Brownout behavior
- Capacitor discharge timing
- USB drive startup load
- Weak 5 V rail
- Board variation

### Workarounds

- Add supervisor IC mod
- Improve 5 V power source
- Add controlled power sequencing
- Add boot delay
- Add adequate bulk capacitance
- Avoid rapid power cycling
- Test cold and warm boot repeatedly

### Recommended Repo Direction

Supervisor IC mod should be documented as a reliability improvement, especially for PS2 internal installs.

## Dim Red/Blue LEDs May Indicate Serious Brick

### Status

Observed in community reports

### Severity

Critical

### Area

Recovery

### Description

A board showing dim red and blue LEDs with no serial output may be seriously bricked or damaged.

### Symptoms

- Red and blue LEDs stuck dim
- No blinking
- No Ethernet activity
- No DHCP
- No UART output
- Ralink chip gets warm
- Reset button does nothing
- TFTP not available

### Causes

- Corrupted flash
- Corrupted U-Boot
- Wrong bootloader
- Bad flash chip
- Hardware damage
- Power issue
- Failed firmware write

### Workarounds

- Check power first
- Check UART with read-only wiring
- Try external SPI programmer
- Dump current flash for analysis
- Reprogram known-good full flash image
- Replace flash chip if unreadable
- Treat as parts board if no recovery is possible

### Recommended Repo Direction

Document exact LED behavior before attempting recovery.

## Similar Boards Are Not Always Compatible

### Status

Confirmed

### Severity

High

### Area

Hardware/Firmware

### Description

Some HAME, MIFI, unbranded, and travel-router boards look similar but are not identical.

They may have different RAM, flash, bootloaders, firmware, GPIO, or recovery behavior.

### Symptoms

- Firmware for A5-V11 does not boot
- U-Boot file bricks board
- Ethernet does not work
- Wi-Fi does not work
- Reset button does not work
- Partition layout differs
- RAM size differs
- Flash size differs

### Causes

- Similar enclosure
- Similar RT5350F platform
- Different board layout
- Different flash or RAM
- Different bootloader
- Different GPIO mapping
- Clone devices

### Workarounds

- Identify PCB markings
- Identify SoC
- Identify RAM chip
- Identify flash chip
- Capture UART boot log
- Compare partition layout
- Do not flash until confirmed
- Keep board-specific notes

### Recommended Repo Direction

This repo should focus on confirmed A5-V11 boards and clearly mark variants.

## SSH May Be Missing

### Status

Observed

### Severity

Medium

### Area

Firmware

### Description

Some firmware builds may not include SSH or may disable it.

On some OpenWrt versions, telnet closes after setting a password, but SSH may not actually be available in a broken or minimal build.

### Symptoms

- Telnet worked before password
- Password was set
- Telnet closes
- SSH connection refused
- SCP does not work
- Router is reachable by ping but no login works

### Causes

- Dropbear missing
- SSH disabled
- Bad config
- Minimal build
- Firmware bug
- Not enough flash space

### Workarounds

- Use UART
- Confirm Dropbear is included
- Test SSH before relying on it
- Keep telnet enabled only on isolated development builds
- Use failsafe
- Rebuild firmware with Dropbear
- Do not set password until SSH behavior is understood on unknown builds

### Recommended Repo Direction

Each firmware release note should state whether SSH is included.

## LuCI May Not Fit Or May Be Unusable

### Status

Confirmed

### Severity

Medium

### Area

Firmware

### Description

LuCI is heavy for the stock 4 MB A5-V11.

Even when a web interface fits, there may be no room left to save settings or install needed packages.

### Symptoms

- LuCI missing
- LuCI loads but changes fail
- Redirects to home page
- No space left
- Package install fails
- Web UI very slow
- Overlay full

### Causes

- 4 MB flash
- Large kernel
- LuCI package size
- Limited overlay
- Too many packages

### Workarounds

- Remove LuCI
- Use SSH/UART
- Use tiny custom web UI
- Use 8 MB or 16 MB flash
- Use extroot for experiments
- Build role-specific images

### Recommended Repo Direction

For PS2 firmware, prefer a tiny custom setup page over full LuCI.

## Overlay Space May Be Misunderstood

### Status

Confirmed

### Severity

Medium

### Area

Firmware

### Description

OpenWrt squashfs images use a read-only root filesystem with a writable overlay.

Deleting built-in files does not truly free space from the original read-only firmware image.

### Symptoms

- Deleting files does not recover expected space
- `opkg install` still fails
- Overlay remains full
- System cannot save settings
- Confusion about `/rom` and root filesystem

### Causes

- Squashfs read-only base
- OverlayFS behavior
- 4 MB flash limit
- Built-in files remain in read-only image

### Workarounds

- Rebuild smaller image
- Remove packages before building
- Use extroot
- Upgrade flash
- Avoid installing packages after flashing on 4 MB boards

### Recommended Repo Direction

Explain overlay behavior in firmware docs.

## USB Storage Packages May Not Fit

### Status

Confirmed

### Severity

Medium

### Area

Firmware/USB

### Description

USB storage requires kernel modules and filesystem support.

On a 4 MB build, adding these packages can consume too much space.

### Symptoms

- USB drive detected but no `/dev/sda1`
- Kernel sees USB device but no block device
- Filesystem cannot mount
- `opkg install` fails
- No space left
- exFAT unavailable
- ext4 unavailable

### Causes

- Missing `kmod-usb-storage`
- Missing filesystem driver
- Missing block mount support
- No room for packages
- Wrong OpenWrt branch
- Minimal firmware lacks storage modules

### Workarounds

- Build packages into firmware
- Remove unused packages
- Use 8 MB or 16 MB flash
- Use extroot during development
- Use FAT32 if easiest
- Use exFAT only on builds that support it
- Test USB detection over UART

### Recommended Repo Direction

Each firmware build should list supported filesystems.

## exFAT Support May Be Branch-Dependent

### Status

Likely / Needs Testing Per Build

### Severity

Medium

### Area

Firmware/USB

### Description

exFAT support depends on the OpenWrt branch, kernel, available packages, and image space.

### Symptoms

- exFAT drive not mounted
- `/dev/sda1` exists but mount fails
- Drive works on PC but not router
- FAT32 works but exFAT does not
- OPL or UDPBD cannot see files

### Causes

- Missing exFAT driver
- Wrong filesystem package
- Kernel branch limitation
- Insufficient flash space
- Drive formatted in unsupported way
- GPT/MBR mismatch depending on scripts

### Workarounds

- Document exact firmware branch
- Document exFAT package used
- Test FAT32, exFAT, and ext4 separately
- Use known formatting tools
- Record partition table type
- Record cluster size
- Use 16 MB flash for comfort

### Recommended Repo Direction

Create a USB filesystem compatibility table.

## Wi-Fi Client Mode May Be Unreliable On Stock Firmware

### Status

Observed

### Severity

Medium

### Area

Wi-Fi/Stock Firmware

### Description

Stock firmware client or bridge mode may be inconsistent or poorly documented.

### Symptoms

- Blue LED flashes but no connection
- Ethernet device cannot reach network
- Wi-Fi settings require reboot
- Device changes IP unexpectedly
- Works as AP but not as client
- No clear bridge mode

### Causes

- Stock firmware limitations
- Poor UI
- Antenna issue
- Wrong mode selected
- DHCP/routing confusion
- Firmware variation

### Workarounds

- Use OpenWrt instead of stock firmware
- Test with UART logs
- Verify Wi-Fi signal
- Test router mode and client mode separately
- Use static IPs for first tests
- Document exact stock firmware behavior

### Recommended Repo Direction

Do not depend on stock firmware for final PS2 bridge use.

## Firmware From Old Guides May Be Gone Or Risky

### Status

Confirmed

### Severity

High

### Area

Firmware

### Description

Many A5-V11 guides are old.

Links may be dead, files may be missing, and instructions may refer to outdated or board-specific images.

### Symptoms

- Download links dead
- File names do not match guide
- Firmware image too large
- Wrong U-Boot file
- Missing source
- Unknown license
- Instructions do not match board
- Following guide bricks router

### Causes

- Old blogs
- Old forum posts
- Vendor file hosting disappeared
- Google Drive links removed
- Firmware not archived
- Guides written for different variants

### Workarounds

- Prefer source builds
- Mirror only files with clear license
- Record checksums
- Use known-good board-specific backups
- Do not blindly follow old instructions
- Verify RAM and flash size first
- Use external programmer for risky tests

### Recommended Repo Direction

This repo should preserve instructions and references, but avoid blindly redistributing unknown binaries.

## Wrong Image Type Can Brick Or Fail

### Status

Confirmed

### Severity

High

### Area

Firmware

### Description

OpenWrt often provides different image types, such as factory and sysupgrade images.

Using the wrong type in the wrong place can fail or brick the board.

### Symptoms

- Stock web UI rejects image
- Flash appears to work but board does not boot
- Sysupgrade fails
- Kernel starts but rootfs fails
- U-Boot cannot boot image
- Router becomes unreachable

### Causes

- factory image used as full flash image
- sysupgrade image used in stock web UI
- full flash dump used as sysupgrade
- raw firmware partition written at wrong offset
- wrong target image
- wrong flash size image

### Workarounds

- Confirm image type
- Confirm install method
- Confirm target board
- Confirm flash size
- Confirm firmware partition offset
- Use UART
- Have programmer backup

### Recommended Repo Direction

Every firmware file should clearly state its intended flash method.

## Flash Upgrade Can Preserve Boot But Break Wi-Fi

### Status

Likely / Observed In Similar Work

### Severity

High

### Area

Flash/Wi-Fi

### Description

A 16 MB flash upgrade may boot correctly but Wi-Fi may fail if factory data is missing, moved, corrupted, or not referenced correctly.

### Symptoms

- OpenWrt boots
- Ethernet works
- Wi-Fi missing
- Wi-Fi driver complains about EEPROM
- Poor signal
- MAC address wrong
- Calibration errors in UART log

### Causes

- Factory partition not copied
- Factory partition wrong offset
- Factory data from another board
- Device tree partition map wrong
- Bad full image assembly
- Flash write corruption

### Workarounds

- Preserve original factory partition
- Keep factory partition at expected offset
- Confirm `/proc/mtd`
- Check UART logs
- Compare factory partition checksum
- Test Wi-Fi before and after upgrade
- Do not use another board's factory partition

### Recommended Repo Direction

16 MB upgrade docs must include Wi-Fi calibration checks.

## Reducing Or Relocating Capacitors Can Cause Instability

### Status

Likely / Needs Testing

### Severity

Medium

### Area

Hardware/Power

### Description

The stock capacitors may be physically too tall for PS2 internal mounting.

However, reducing or relocating them incorrectly can cause boot, Wi-Fi, USB, or power stability issues.

### Symptoms

- Router boots inconsistently
- USB drive resets
- Wi-Fi drops
- Brownout behavior
- Router freezes under load
- Works without USB drive but fails with drive
- Works on bench supply but fails from PS2 power

### Causes

- Too little bulk capacitance
- High ESR replacement
- Long capacitor relocation wires
- Ceramic-only replacement not tested
- USB inrush current
- Poor 5 V source
- Ground bounce
- Wi-Fi transmit current spikes

### Workarounds

- Measure stock capacitor values
- Replace with equal or better capacitance where practical
- Keep relocation paths short
- Use proper polarity
- Use a helper PCB or flex
- Test cold boot, warm boot, Wi-Fi, Ethernet, and USB load
- Add supervisor IC if needed
- Use stable 5 V power

### Recommended Repo Direction

Flipp'n Caps documentation should include before/after boot and load testing.

## PS2 Internal RF Shield Can Hurt Wi-Fi

### Status

Likely / Needs Testing Per Build

### Severity

Medium

### Area

PS2/Wi-Fi

### Description

The PS2 RF shield can be useful as a heat spreader, but it can also block or weaken Wi-Fi if the antenna is placed poorly.

### Symptoms

- Wi-Fi works outside console but poorly inside
- Signal drops when RF shield is installed
- Signal changes with shell position
- Wi-Fi range poor unless external antenna used
- PS2 metal parts detune antenna

### Causes

- Antenna too close to RF shield
- Antenna under metal
- No external antenna
- Router orientation
- Other wireless modules nearby
- Shield used as heatsink without antenna planning

### Workarounds

- Test Wi-Fi before final assembly
- Move antenna away from shield
- Use external antenna mod
- Put antenna near plastic shell area
- Avoid sandwiching antenna between metal layers
- Record signal strength before and after closing shell

### Recommended Repo Direction

PS2 mounting guides must include antenna placement notes.

## PS2 Power Source May Not Be Stable Enough

### Status

Likely / Needs Testing Per Build

### Severity

Medium

### Area

PS2/Power

### Description

The A5-V11 expects stable 5 V input.

Powering it from a PS2 USB port or internal rail may cause issues if current demand is too high or the rail is noisy.

### Symptoms

- Router resets when PS2 powers on
- Router fails with USB drive connected
- Router works from external USB supply but not PS2
- Wi-Fi drops under load
- USB drive disconnects
- Random boot failures

### Causes

- PS2 USB current limit
- Voltage drop in wiring
- Shared rail noise
- USB drive inrush
- Internal regulator not sized correctly
- Poor grounding
- Power sequencing issue

### Workarounds

- Measure current draw
- Use stable 5 V regulator
- Use separate storage power if needed
- Keep wiring short
- Add bulk capacitance
- Test under worst-case load
- Consider always-on or pre-boot power for router
- Use supervisor IC

### Recommended Repo Direction

Every PS2 install should document power source and current draw.

## Ethernet Wiring Inside PS2 Can Be Noisy Or Unreliable

### Status

Likely / Needs Testing Per Build

### Severity

Medium

### Area

PS2/Ethernet

### Description

Internal Ethernet wiring is not just simple DC wiring.

Poor routing can cause link problems or unreliable network behavior.

### Symptoms

- No Ethernet link
- Link drops
- Slow transfer
- UDPBD unreliable
- SMB disconnects
- FTP stalls
- Works with external cable but not internal wiring
- Only works when shell is open

### Causes

- Untwisted wiring
- Wires too long
- Wrong pair routing
- Signal pair swapped
- Poor ground reference
- Running Ethernet next to noisy power wiring
- Magnetics bypassed incorrectly
- Bad solder joints
- RF shield contact/short

### Workarounds

- Keep Ethernet wiring short
- Preserve twisted pairs where possible
- Use proper magnetics path
- Avoid routing near switching regulators
- Verify continuity
- Test with known-good cable first
- Compare external cable versus internal wiring
- Use strain relief

### Recommended Repo Direction

PS2 Ethernet wiring needs its own detailed guide.

## UDPBD Or UDPFS Version Mismatch

### Status

Likely / PS2-Specific

### Severity

Medium

### Area

PS2/Firmware

### Description

UDPBD and UDPFS depend on matching router-side and PS2-side software expectations.

Using the wrong OPL or loader build may fail.

### Symptoms

- Games list missing
- Loader cannot see server
- UDPBD server runs but PS2 does not connect
- Works with one OPL build but not another
- Network test passes but games do not load

### Causes

- Wrong OPL build
- Wrong UDPBD protocol version
- Wrong server binary
- Wrong network mode
- Wrong USB mount path
- Firewall issue
- Service not started
- PS2 launched before router ready

### Workarounds

- Document exact OPL build
- Document exact UDPBD/UDPFS binary
- Document firmware version
- Document server command
- Disable firewall for isolated test
- Confirm service start in UART/logread
- Wait for router ready before launching loader

### Recommended Repo Direction

PS2 test results must include exact loader and router firmware versions.

## SMB1 Support Can Be Hard To Fit And Tune

### Status

Likely / PS2-Specific

### Severity

Medium

### Area

PS2/SMB

### Description

OPL SMB usually needs old SMB1/NT1 behavior.

Samba can be heavy for the A5-V11, especially on stock 4 MB flash and 32 MB RAM.

### Symptoms

- Samba package will not fit
- SMB share not visible
- OPL cannot connect
- Authentication fails
- Slow browsing
- Router runs out of memory
- Service crashes

### Causes

- 4 MB flash limit
- 32 MB RAM limit
- Samba package size
- Protocol mismatch
- Guest access config
- Firewall config
- Wrong share path
- USB drive not mounted

### Workarounds

- Use 16 MB flash
- Use minimal Samba config
- Force SMB1/NT1 where required
- Use guest share for testing
- Disable unused services
- Test memory usage
- Consider UDPBD/UDPFS instead
- Use external SMB server if router is only bridge

### Recommended Repo Direction

SMB should be a separate firmware role, not enabled by default in every build.

## FTP Use Depends On Network Direction

### Status

Likely / PS2-Specific

### Severity

Low to Medium

### Area

PS2/FTP

### Description

wLaunchELF can run FTP on the PS2, but the network layout must allow the PC to reach the PS2.

A routed or NAT-style setup may not behave the same as a bridge.

### Symptoms

- PS2 can reach network but PC cannot reach PS2 FTP
- FTP works on wired network but not over A5-V11 Wi-Fi
- Passive/active FTP issues
- IP address confusion
- PS2 static IP wrong for subnet

### Causes

- A5-V11 operating as router/NAT instead of bridge
- PS2 on different subnet
- Firewall blocks inbound traffic
- DHCP not passing through
- Wrong gateway
- Wrong static IP
- Wi-Fi client isolation on home router

### Workarounds

- Decide bridge versus routed mode
- Document IP plan
- Disable firewall in isolated testing
- Use static PS2 IP
- Ensure PC and PS2 can route to each other
- Test ping before FTP
- Test FTP from same subnet

### Recommended Repo Direction

FTP guide should include clear network diagrams.

## Recovery May Be Hard After Internal PS2 Install

### Status

Likely / PS2-Specific

### Severity

High

### Area

PS2/Recovery

### Description

Once the A5-V11 is installed inside a PS2, recovery access becomes harder.

### Symptoms

- Router fails inside console
- No access to UART
- No access to reset button
- No access to USB drive
- Must disassemble PS2 to recover
- Firmware change requires opening console

### Causes

- UART buried
- Reset button inaccessible
- Flash chip inaccessible
- No service connector
- No external status LED
- No recovery plan

### Workarounds

- Add UART service connector
- Add reset access if needed
- Keep firmware stable before install
- Keep backup image
- Test before final assembly
- Use socketed or accessible storage if possible
- Document disassembly/recovery process

### Recommended Repo Direction

Every internal install should include recovery access planning.

## Known Issue Template

Use this template for adding new issues.

```text
Issue name:
Status:
Severity:
Area:
Board ID:
Firmware:
Flash size:
RAM size:
PS2 model, if applicable:
Symptoms:
Conditions:
Steps to reproduce:
Expected behavior:
Actual behavior:
UART log:
Power source:
USB drive:
Network mode:
Possible cause:
Workaround:
Fix:
Notes:
```

## Issue Severity Guide

| Severity | Meaning |
|---|---|
| Low | Annoying but not damaging |
| Medium | Causes unreliable function or requires workaround |
| High | Can block normal use or require recovery |
| Critical | Can brick hardware, corrupt data, or damage board |

## Area Labels

Use these area labels:

| Label | Area |
|---|---|
| Hardware | Physical board issue |
| Firmware | OpenWrt or stock firmware issue |
| Flash | SPI flash or partition issue |
| Recovery | Brick or unbrick issue |
| Network | Ethernet, IP, DHCP, bridge, routing |
| Wi-Fi | Wireless or antenna issue |
| USB | USB storage or USB power |
| Power | Voltage, current, reset, boot reliability |
| Thermal | Heat or cooling |
| UART | Serial console |
| PS2 | PlayStation 2 integration |
| SMB | OPL SMB use |
| UDPBD | UDPBD use |
| UDPFS | UDPFS use |
| FTP | wLaunchELF FTP use |

## Recommended Debug Order

When something fails, debug in this order:

1. Check power.
2. Check heat.
3. Check UART.
4. Check boot log.
5. Check flash layout.
6. Check factory partition.
7. Check Ethernet link.
8. Check IP address.
9. Check Wi-Fi.
10. Check USB detection.
11. Check service startup.
12. Check PS2-side settings.
13. Check firmware version.
14. Check hardware modifications.
15. Check board-specific variation.

## Minimum Information For A Useful Bug Report

A useful issue report should include:

- Board photos
- Board ID
- SoC marking
- RAM chip
- Flash chip
- Flash size
- Firmware version
- Bootloader information
- UART boot log
- Power source
- Network layout
- USB drive used
- Exact symptom
- Steps to reproduce
- What was already tested
- Whether the original flash backup exists

## Short Version

The A5-V11 is useful but fragile.

The most important known issues are:

- Stock 4 MB flash is too small.
- 32 MB RAM is limiting.
- Stock firmware and bootloader behavior vary.
- Wrong U-Boot can brick the router.
- The factory partition must be preserved.
- Web flashing may silently fail.
- UART is essential for recovery.
- Some boards have poor antenna connection.
- The board can run hot.
- USB storage timing matters.
- PS2 internal installs need power, heat, antenna, Ethernet, and recovery planning.

Treat every board as its own test case.

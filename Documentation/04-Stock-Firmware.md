# 04 - Stock Firmware

## Summary

This document covers the stock firmware found on A5-V11 mini routers.

The A5-V11 stock firmware is important because it is often the first way to identify, test, configure, back up, or flash the router.

However, stock firmware behavior varies a lot between units.

Two A5-V11 routers that look the same may have different firmware, different web interfaces, different bootloader behavior, different default IP behavior, and different ways of accepting or rejecting firmware updates.

This document is not a universal guarantee.

It is a field guide for documenting and safely working with whatever stock firmware is found on a specific board.

## Important Warning

Do not flash or erase anything until the stock firmware has been documented and the original flash has been backed up.

Before modifying firmware:

1. Identify the board.
2. Photograph the board.
3. Record stock firmware behavior.
4. Test web access.
5. Test telnet access.
6. Test UART access if possible.
7. Dump the original flash.
8. Save the factory partition.
9. Only then start firmware experiments.

The factory partition may contain Wi-Fi calibration data, RF data, MAC address data, and other board-specific settings.

Losing this data can make the board harder to recover.

## Why Stock Firmware Matters

The stock firmware matters because it can provide:

- First access to the router
- Web configuration
- Telnet access
- Firmware version information
- Hardware revision information
- Network settings
- USB storage behavior
- Firmware update page
- Shell access
- Possible flash-writing commands
- A way to install OpenWrt without removing the flash chip
- Clues about the bootloader and partition layout

Even if the stock firmware is not useful long term, it should be documented before being replaced.

## Stock Firmware Is Not Consistent

A5-V11 stock firmware can vary heavily.

Known or reported variations include:

- Chinese web UI
- English web UI
- Chinese/English selectable web UI
- Qualcomm-branded web UI on a Ralink/MediaTek device
- Unbranded web UI
- Web firmware update page that works
- Web firmware update page that rejects OpenWrt
- Web firmware update page that appears to work but does not actually flash
- Very limited BusyBox shell
- More complete BusyBox shell
- Telnet enabled
- Telnet disabled or restricted
- SSH not included
- Different default IP behavior
- Different DHCP behavior
- Different USB storage behavior
- Different bootloader recovery behavior

Do not assume a method works until it is tested on the specific board.

## Common Stock Login

Many stock A5-V11 units use:

| Service | Username | Password |
|---|---|---|
| Web UI | admin | admin |
| Telnet | admin | admin |

This is common, not guaranteed.

Some firmware versions may have different credentials, disabled services, or broken login behavior.

## Common Stock IP Behavior

Possible stock IP behavior includes:

| Behavior | Possible IP |
|---|---|
| Router default IP | 192.168.100.1 |
| DHCP client mode | Router receives IP from existing network |
| After OpenWrt flash | 192.168.1.1 |
| Custom PS2 firmware idea | 192.168.1.222 |

The router may not always appear at the IP address listed in older guides.

Recommended discovery methods:

- Check the DHCP client list on your main router.
- Try a static PC IP in the 192.168.100.x range.
- Try a static PC IP in the 192.168.1.x range.
- Use a network scanner.
- Connect UART and watch the boot log.
- Check ARP tables after connecting Ethernet.

## First Stock Firmware Test

Use this process before changing anything.

1. Connect the A5-V11 to 5 V power.
2. Connect Ethernet to a test network or directly to a PC.
3. Watch the red and blue LEDs.
4. Check whether the router requests a DHCP address.
5. Try opening the router in a browser.
6. Try telnet.
7. Record all behavior.
8. Do not flash anything yet.

## Suggested Safe Test Network

For first testing, use a simple isolated setup when possible.

Recommended setup:

| Device | Setting |
|---|---|
| PC Ethernet | Static IP 192.168.100.2 |
| Subnet mask | 255.255.255.0 |
| Gateway | Blank or 192.168.100.1 |
| Router candidate IP | 192.168.100.1 |

Then try:

- Browser to 192.168.100.1
- Telnet to 192.168.100.1
- Ping 192.168.100.1

If that fails, try a 192.168.1.x setup.

| Device | Setting |
|---|---|
| PC Ethernet | Static IP 192.168.1.2 |
| Subnet mask | 255.255.255.0 |
| Gateway | Blank or 192.168.1.1 |
| Router candidate IP | 192.168.1.1 |

If that still fails, connect through a main router and check the DHCP table.

## LED Behavior During Stock Boot

Common stock behavior may include:

- Red LED turns on
- Blue LED turns on
- Blue LED flashes
- Both LEDs briefly light during boot
- LEDs change after Ethernet or Wi-Fi activity

LED behavior varies by firmware.

Document the exact LED behavior for each board.

Suggested LED log:

| Event | Red LED | Blue LED | Notes |
|---|---|---|---|
| Power applied |  |  |  |
| 5 seconds after power |  |  |  |
| Ethernet connected |  |  |  |
| Web UI accessible |  |  |  |
| Telnet accessible |  |  |  |
| Reset button held |  |  |  |
| Failed boot |  |  |  |

## Stock Web Interface

Many A5-V11 units have a stock web interface.

The web interface may allow:

- Viewing status
- Changing LAN IP
- Changing DHCP settings
- Changing Wi-Fi settings
- Changing language
- Rebooting the router
- Restoring defaults
- Updating firmware
- Configuring 3G/4G USB modem settings
- Configuring storage or sharing features

The web UI may be useful for basic testing, but it should not be trusted blindly.

Some web update pages may reject unofficial images.

Some may claim an update succeeded but leave the original firmware installed.

## Stock Web UI Items To Record

When the web UI is accessible, record:

| Item | Value |
|---|---|
| Board ID |  |
| Web UI IP |  |
| Username |  |
| Password |  |
| Language |  |
| Branding |  |
| Firmware version |  |
| Hardware version |  |
| Product model |  |
| LAN IP |  |
| DHCP enabled |  |
| Wi-Fi SSID |  |
| Wi-Fi mode |  |
| Storage page present |  |
| Firmware update page present |  |
| Backup settings option |  |
| Restore defaults option |  |
| Reboot option |  |
| Notes |  |

## Possible Web UI Branding

Known branding may include:

- Unbranded
- Chinese generic interface
- English generic interface
- Qualcomm-branded interface

The Qualcomm branding can be misleading because the A5-V11 hardware is based on a Ralink/MediaTek RT5350F SoC.

Record the branding, but identify the hardware by the actual chips and PCB markings.

## Language Switching Issue

Some stock web interfaces allow changing language.

Older notes report that changing the language can redirect the browser to the wrong IP address.

If this happens:

1. Do not assume the router crashed.
2. Manually type the correct IP address again.
3. Continue from the correct address.
4. Record the behavior in the board log.

## Stock Firmware Update Page

Some stock firmware versions include a firmware update page.

Possible outcomes when using the web update page:

- OpenWrt factory image flashes successfully.
- Image is rejected.
- Upload reaches 100 percent but does not actually flash.
- Router reboots back to stock firmware.
- Router becomes unreachable.
- Router is bricked.
- Router changes IP range after reboot.
- Router boots OpenWrt at 192.168.1.1.

Do not use the firmware update page until the original flash has been backed up or until the board is considered expendable.

## Web Flashing Warning

A stock web UI success message does not always mean the flash actually changed.

After flashing from the web UI, verify by:

- Checking IP behavior
- Checking telnet prompt
- Checking web UI appearance
- Checking UART boot log
- Checking OpenWrt banner
- Checking kernel boot messages
- Checking partition layout
- Checking firmware version

If the router still shows the stock interface, the web flash did not actually replace the firmware.

## Stock Telnet Access

Many A5-V11 units expose telnet.

Common connection:

| Item | Value |
|---|---|
| Protocol | Telnet |
| Port | 23 |
| Username | admin |
| Password | admin |

Example:

```text
telnet 192.168.100.1
```

or:

```text
telnet <router-ip-address>
```

If the password appears not to type, remember that many telnet prompts hide password input.

## Stock Telnet Prompt

A common stock prompt may look like:

```text
BoC Login: admin
Password: admin

BusyBox v1.12.1 built-in shell (msh)
Enter 'help' for a list of built-in commands.

BoC Router>
```

The exact BusyBox version and prompt may vary.

## Limited Stock Shell

Some stock firmware versions have a very limited shell.

Common available commands may include:

| Command | Purpose |
|---|---|
| help | Display help |
| ? | Display help |
| clear | Clear tables or settings |
| ping | Ping a host |
| traceroute | Trace route |
| ipmac | IP/MAC binding settings |
| quit | Close session |
| show | Display information |
| restart_httpd | Restart web server |
| restore_defaults | Restore factory settings |
| ated | Manufacturing or RF test command |

The limited shell may not support normal Linux commands.

Commands like `cat`, `ls`, `mount`, `wget`, `ftp`, or `tftp` may not work unless a fuller shell is enabled.

## Checking System Revision

Some stock firmware versions support:

```text
show system revision
```

This may show:

- Software version
- Product model
- Serial number
- Hardware version
- Firmware release date

Example fields to record:

| Field | Value |
|---|---|
| Software version |  |
| Product model |  |
| Serial number |  |
| Hardware version |  |
| Firmware release date |  |

## Full Shell Using runshellcmd

Some firmware versions allow enabling a fuller shell using:

```text
runshellcmd
```

Example flow:

```text
BoC Router> cat /proc/cmdline
Unknow command

BoC Router> runshellcmd
shell mode on

BoC Router> cat /proc/cmdline
console=ttyS1,57600n8 root=/dev/ram0
```

This is useful because the limited shell may block normal Linux commands.

Not every firmware supports this.

## Useful Stock Shell Commands

If a full shell is available, useful commands may include:

```text
cat /proc/cmdline
cat /proc/meminfo
cat /proc/mtd
cat /proc/partitions
ifconfig
route
dmesg
mount
ls
cat
ps
free
df
```

These can help identify:

- Kernel command line
- RAM size
- MTD partition layout
- Mounted filesystems
- Network configuration
- USB device detection
- Boot behavior
- Available storage

## SSH Warning

Do not assume stock firmware has SSH.

Some users have reported that password changes work, but SSH is not available or refuses connections.

Possible SSH-related symptoms:

- Port 22 closed
- Connection refused
- SSH missing from firmware
- SCP not available
- Password set but SSH still unavailable

Telnet and UART are usually more important on stock firmware.

## Stock Network Storage Behavior

Some stock firmware versions may include USB storage sharing.

Possible behavior:

- USB drive appears as a network share.
- A share such as MEDIA may appear.
- Login may use admin/admin.
- FAT32 drives may work.
- Larger drives may behave inconsistently.
- Storage behavior may require reboot.
- Documentation may be missing.

This is useful to document because the original firmware may already include a simple network storage feature.

For PS2 work, this is mostly reference material because custom OpenWrt firmware will likely be preferred.

## Stock Wi-Fi Behavior

The stock firmware may support several Wi-Fi modes.

Possible options:

- Access point mode
- Client mode
- Router mode
- Repeater mode
- 3G/4G sharing mode
- WISP-style mode, depending on firmware

Record:

| Item | Value |
|---|---|
| Default SSID |  |
| Default password |  |
| Wi-Fi mode |  |
| Can scan networks |  |
| Can join network |  |
| Can bridge Ethernet to Wi-Fi |  |
| Requires reboot after changes |  |
| Signal strength |  |
| Notes |  |

Some stock firmware versions require a reboot after almost every setting change.

## Stock DHCP Behavior

Stock DHCP behavior may vary.

Possible modes:

- Router acts as DHCP server.
- Router acts as DHCP client.
- Router uses 192.168.100.1.
- Router requests an IP from the upstream network.
- Router changes IP after a mode change.
- Router becomes unreachable after disabling DHCP.
- Router reverts after reset.

Always record network changes before applying them.

## Restoring Defaults

Some stock firmware versions support restoring defaults from:

- Web UI
- Reset button
- Telnet command
- Limited shell command

Possible command:

```text
restore_defaults
```

Possible web option:

```text
Restore Defaults
```

Button behavior varies.

Document the exact reset behavior for each board.

## Reset Button Behavior

The reset button may do different things depending on firmware and bootloader.

Possible behaviors:

- Factory reset stock firmware
- Enter OpenWrt failsafe
- Enter bootloader recovery
- Trigger TFTP mode
- Do nothing
- Use the wrong GPIO after bootloader replacement

Record:

| Test | Result |
|---|---|
| Press after boot |  |
| Hold during power-on |  |
| Hold 5 seconds after boot |  |
| Hold 10 seconds after boot |  |
| Hold 30 seconds after boot |  |
| LED behavior |  |
| IP behavior after reset |  |

## USB Firmware Flashing From Stock Firmware

Some stock firmware versions can use a USB drive to flash U-Boot and firmware from telnet.

Known general flow from community notes:

1. Copy files to a FAT or VFAT USB drive.
2. Plug USB drive into the router.
3. Telnet into stock firmware.
4. Mount the USB drive.
5. Verify the files are visible.
6. Use `mtd_write` to write bootloader or firmware.
7. Reboot.

Example commands from known methods may look like:

```text
mount /dev/sda1 /mnt
ls /mnt
mtd_write write /mnt/uboot_usb_256_03.img Bootloader
mtd_write write /mnt/firmware.bin Kernel
reboot
```

Warning:

These commands are dangerous.

Writing the wrong file to the wrong partition can brick the router.

## mtd_write Warning

`mtd_write` can permanently overwrite bootloader or firmware partitions.

Before using it, verify:

- Board model
- RAM size
- Flash size
- Correct U-Boot file
- Correct firmware file
- Correct partition name
- USB file visibility
- Stable power
- UART access if possible
- Full flash backup exists

Do not reset or unplug power while writing.

## U-Boot File Warning

Some older instructions use U-Boot file names that imply RAM size.

Common warning:

| File Name Pattern | Often Means |
|---|---|
| 128 | 16 MB RAM target |
| 256 | 32 MB RAM target |

This is not something to guess.

Confirm the correct U-Boot for your exact board before flashing.

A wrong bootloader can create a hard brick.

## Stock Firmware And OpenWrt Install Paths

Possible OpenWrt install paths from stock firmware:

| Method | Notes |
|---|---|
| Web UI firmware update | Works on some units, fails or silently does nothing on others |
| Telnet and `mtd_write` | Works on some units if shell and USB access are available |
| UART and U-Boot | Safer for debugging, still risky |
| TFTP recovery | Depends on bootloader |
| CH341A flash programmer | Best for full backup and hard recovery |
| Direct SPI flash replacement | Useful for 8 MB or 16 MB upgrades |

This repo should document all known paths, but the safest development method is to have a full flash backup and hardware programmer available.

## Stock Firmware Backup Priority

The stock firmware may not be easy to find again.

Before replacing it, back it up.

Backup priority:

1. Full flash dump
2. Factory partition
3. U-Boot partition
4. U-Boot environment
5. Firmware partition
6. Stock web UI screenshots
7. Stock telnet output
8. Stock boot log
9. Stock IP behavior
10. Stock LED behavior

Store these in a board-specific folder.

## Suggested Stock Backup Folder

Suggested folder structure:

```text
Test-Data/Board-Logs/board-001/
├── photos/
├── stock-web-ui/
├── stock-telnet/
├── uart-logs/
├── flash-dumps/
├── factory-partition/
└── notes.md
```

Do not commit private or board-unique factory data to the public repo unless it has been intentionally cleaned and reviewed.

## Flash Dump Naming

Suggested file names:

```text
board-001-stock-full-flash-4mb.bin
board-001-stock-uboot.bin
board-001-stock-uboot-env.bin
board-001-stock-factory.bin
board-001-stock-firmware.bin
board-001-stock-bootlog.txt
board-001-stock-telnet-log.txt
```

For public documentation, use placeholder names.

Do not publish files that contain private or board-unique data unless reviewed.

## Stock Firmware Documentation Checklist

Use this checklist for each stock board.

| Item | Result |
|---|---|
| Board ID |  |
| Date tested |  |
| Shell label |  |
| PCB marking |  |
| SoC |  |
| RAM chip |  |
| Flash chip |  |
| Stock IP at boot |  |
| DHCP client behavior |  |
| Web UI accessible |  |
| Web UI URL |  |
| Web username |  |
| Web password |  |
| Web UI language |  |
| Web UI branding |  |
| Firmware version |  |
| Hardware version |  |
| Product model |  |
| Telnet accessible |  |
| Telnet username |  |
| Telnet password |  |
| Shell prompt |  |
| BusyBox version |  |
| Limited shell only |  |
| `runshellcmd` works |  |
| SSH accessible |  |
| USB storage detected |  |
| Firmware update page present |  |
| Web flash tested |  |
| Reset button tested |  |
| UART boot log captured |  |
| Full flash dumped |  |
| Factory partition saved |  |
| Notes |  |

## Suggested Telnet Log

When telnet works, capture a log.

Suggested commands to try:

```text
help
show system revision
runshellcmd
cat /proc/cmdline
cat /proc/meminfo
cat /proc/mtd
ifconfig
route
df
mount
dmesg
```

Not all commands will work.

Record failures too.

Failures are useful documentation.

## Suggested Web UI Screenshots

Capture screenshots of:

- Login page
- Status page
- Firmware version page
- LAN settings
- DHCP settings
- Wi-Fi settings
- Storage settings
- Firmware update page
- Reboot page
- Restore defaults page

Do not include private network passwords in screenshots.

## Stock Firmware Risks

Risks include:

- Web UI flash may fail silently.
- Web UI flash may brick the board.
- Telnet methods may write the wrong partition.
- Wrong U-Boot can brick the board.
- Wrong firmware can exceed flash size.
- USB drive may not mount where expected.
- Power loss during flash can brick the board.
- Firmware may change IP after reboot.
- SSH may not exist after setting password.
- Reset button behavior may not match guides.
- Stock firmware may have hardcoded credentials or security issues.
- Stock firmware should not be used as a modern secure router.

## Security Note

The stock firmware is old and should not be trusted as a secure modern router.

Possible concerns:

- Old BusyBox
- Old web server
- Default passwords
- Telnet access
- Unknown vendor modifications
- Possible hardcoded credentials
- No modern security updates
- Inconsistent firmware sources

For this repo, the stock firmware is treated as a recovery, research, and documentation target.

It is not recommended as a secure internet-facing router firmware.

## PS2-Relevant Stock Firmware Notes

The stock firmware may be useful for early PS2 experiments if it can act as a Wi-Fi bridge or simple storage server.

Possible PS2-relevant stock firmware uses:

- Basic Ethernet-to-Wi-Fi bridge testing
- Simple network storage testing
- Wi-Fi signal testing
- Power draw testing
- Boot timing testing
- Heat testing
- Baseline comparison before OpenWrt

However, for final PS2 use, a custom OpenWrt-based firmware is likely better because it can be trimmed and configured for a specific task.

## PS2 Testing Questions For Stock Firmware

If testing stock firmware with a PS2, record:

| Question | Result |
|---|---|
| Can the PS2 ping through it? |  |
| Can wLaunchELF FTP be reached through it? |  |
| Can it act as a Wi-Fi bridge? |  |
| Can it host SMB storage? |  |
| Does it support SMB1/NT1? |  |
| Does USB storage appear over the network? |  |
| Does it require reboot after changes? |  |
| How long does it take to boot? |  |
| Does the PS2 need a startup delay? |  |
| Does it stay stable inside the PS2 shell? |  |
| Does Wi-Fi range suffer inside the PS2 shell? |  |

## Known Stock Firmware Strengths

Possible strengths:

- Already boots without modification
- May have web UI
- May support telnet
- May support USB storage
- May support Wi-Fi router modes
- May allow firmware update from web UI
- May allow flashing through telnet
- Useful for first testing
- Useful for board identification
- Useful as a baseline before OpenWrt

## Known Stock Firmware Weaknesses

Common weaknesses:

- Inconsistent between boards
- Old and insecure
- Limited shell
- Missing SSH
- Poor documentation
- Strange default IP behavior
- Web UI may be misleading
- Web flashing may not work
- Firmware update may silently fail
- Little or no package flexibility
- Not ideal for PS2-specific firmware goals
- Not suitable as a modern secure router

## Recommended Stock Firmware Policy For This Repo

This repo should document stock firmware but not depend on it.

Recommended policy:

- Preserve original flash dumps privately.
- Document stock firmware behavior publicly.
- Do not publish personal factory partitions casually.
- Do not treat one stock firmware as universal.
- Do not assume one board's firmware works on another board.
- Prefer reproducible OpenWrt builds for final use.
- Use stock firmware mainly for identification, backup, and first access.

## Board Log Template For Stock Firmware

```text
Board ID:
Date tested:
Tester:
Shell label:
PCB marking:
SoC:
RAM chip:
Flash chip:
Power source:
Ethernet connected to:
Initial LED behavior:
Initial IP:
DHCP behavior:
Web UI accessible:
Web UI branding:
Web UI language:
Web UI username/password:
Firmware version:
Hardware version:
Product model:
Telnet accessible:
Telnet username/password:
Shell prompt:
BusyBox version:
runshellcmd works:
SSH accessible:
USB storage works:
Firmware update page present:
Reset button behavior:
UART connected:
UART baud:
Boot log saved:
Full flash dumped:
Factory partition saved:
Notes:
```

## Recommended First-Time Stock Firmware Procedure

Use this procedure for a new board.

1. Photograph the board and shell.
2. Identify the SoC, RAM, and flash.
3. Power from a known good 5 V supply.
4. Watch LED behavior.
5. Check for excessive heat.
6. Connect Ethernet.
7. Check DHCP table.
8. Try 192.168.100.1.
9. Try 192.168.1.1.
10. Try web login with admin/admin.
11. Try telnet with admin/admin.
12. Capture stock web UI screenshots.
13. Capture telnet output.
14. Connect UART if possible.
15. Capture UART boot log.
16. Dump the full flash.
17. Save the factory partition.
18. Only then consider flashing OpenWrt.

## Short Version

The A5-V11 stock firmware is useful but inconsistent.

It may provide a web UI, telnet access, USB storage sharing, firmware update options, and basic network features.

Common login is often admin/admin, and common IP behavior may involve 192.168.100.1 or DHCP.

Some units can flash OpenWrt from the web UI or telnet, while others reject images, silently fail, or require bootloader or SPI programmer work.

Before replacing stock firmware, document it and back up the full flash.

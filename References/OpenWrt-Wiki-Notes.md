# OpenWrt Wiki Notes

## Summary

This document summarizes important A5-V11 information collected from the OpenWrt Wiki page for the unbranded A5-V11 3G/4G router.

These notes are not meant to replace the OpenWrt Wiki.

They are meant to preserve the important A5-V11-specific details that matter for this repo, especially for PS2-focused development.

Use this file as a research summary and cross-checking reference.

---

## Source

Primary source:

```text
OpenWrt Wiki
A5-V11 3G/4G Router
Device family: Unbranded / evaluation board style router
SoC family: Ralink / MediaTek RT5350F
```

Source status:

```text
Source type: OpenWrt community wiki
Status: Strong reference
Use level: Reference only
Verification needed: Yes, per board
```

Important:

```text
The OpenWrt Wiki page may change over time.
This repo should record the date accessed and keep local notes about what was tested.
```

---

## Main Takeaway

The A5-V11 is a very small RT5350F-based router that can run OpenWrt, but it is severely limited by stock hardware.

The stock board commonly has:

- 4 MB SPI flash
- 32 MB RAM
- RT5350F SoC
- 2.4 GHz Wi-Fi
- One 10/100 Ethernet port
- One USB 2.0 host port
- micro-USB power input
- UART serial pads
- U-Boot bootloader

For this repo, the OpenWrt Wiki is useful for:

- Device identification
- Stock hardware notes
- OpenWrt support limitations
- Flash layout
- UART pinout
- U-Boot behavior
- TFTP recovery notes
- GPIO notes
- Ethernet interface caveats
- Known heat and antenna issues

---

## Critical OpenWrt Warning

The OpenWrt Wiki warns that this device is not recommended for future OpenWrt use due to low flash and RAM.

Important warning:

```text
4 MB flash / 32 MB RAM is very limited.
Modern OpenWrt builds are not a good fit for the stock board.
```

The wiki notes that OpenWrt support for 4 MB / 32 MB devices has ended, and that 19.07.10 was the last official build for 4 MB / 32 MB devices.

For this project, that means:

- Do not expect current OpenWrt to fit well on stock hardware.
- Do not expect full LuCI plus extra PS2 services on 4 MB flash.
- Treat 4 MB builds as minimal, legacy, or recovery-only.
- Use 16 MB flash for serious development.
- Keep RAM limits in mind even after flash upgrade.

---

## Repo Interpretation

This repo is not trying to make the A5-V11 a modern general-purpose router.

The PS2-focused goal is different:

```text
Use the A5-V11 as a small, purpose-built PS2 network appliance.
```

Possible target roles:

- Wi-Fi bridge
- wLaunchELF FTP helper
- OPL SMB bridge
- UDPBD server
- UDPFS server
- Router-hosted USB storage server
- Internal PS2 network module

Because of the hardware limits, each firmware should do only what is needed.

---

## Hardware Summary From Wiki

| Item | OpenWrt Wiki Notes |
|---|---|
| Device | A5-V11 3G/4G Router |
| Vendor | Unbranded |
| SoC | MediaTek / Ralink RT5350F |
| CPU | Ralink RT5350 MIPS 24KEc |
| CPU clock | 360 MHz |
| Flash | 4 MB SPI flash |
| Common flash chip | Pm25LQ032 |
| RAM | 32 MB |
| Common RAM chips | W9825G6EH-75 or EM63A165TS-6G |
| Wi-Fi | Ralink integrated 2.4 GHz Wi-Fi |
| Ethernet | 1 x 100M Ethernet |
| USB | 1 x USB 2.0 host |
| Power | micro-USB power |
| Serial | Yes |
| Bootloader | U-Boot |

---

## Physical Size

The wiki describes the router as very small.

Recorded size:

```text
62 mm x 24 mm x 14.5 mm
```

This matters for PS2 integration because the A5-V11 can potentially fit inside a Slim or Ultra Slim style PS2 build after connector, capacitor, and heatsink planning.

---

## Device Identification

The wiki notes that the PCB marking may be:

```text
A5-V11
```

or:

```text
MIFI
```

The marking may be near the Ethernet connector.

The wiki also warns that similar devices may have almost identical PCBs but different components.

For this repo, always record:

- PCB marking
- SoC marking
- RAM chip
- Flash chip
- Antenna style
- Stock firmware behavior
- U-Boot behavior
- MAC prefix
- Board photos

Do not assume all A5-V11-looking boards are identical.

---

## Hardware Variant Warning

The wiki warns that unbranded A5-V11-style routers can vary a lot.

Possible differences include:

- Stock firmware
- Web UI language
- Bootloader behavior
- RAM chip
- RAM size
- Flash chip
- Flash size
- Telnet shell access
- Recovery behavior
- Antenna connection
- GPIO behavior

This repo should treat every physical board as its own test case.

---

## Board Identification Checklist

Use this checklist for every board.

| Check | Value |
|---|---|
| Board ID |  |
| PCB marking |  |
| SoC marking |  |
| RAM chip |  |
| RAM size |  |
| Flash chip |  |
| Flash size |  |
| Antenna connected |  |
| Stock firmware IP |  |
| Stock login |  |
| U-Boot version |  |
| UART works |  |
| OpenWrt image tested |  |
| Recovery method tested |  |

---

## Stock Firmware Notes

The wiki notes that factory firmware can vary.

Possible stock firmware behavior:

- Some units accept standard OpenWrt images.
- Some units only accept vendor-modified images.
- Some units have very limited BusyBox shell access.
- Some units have a more complete BusyBox shell.
- Some units have no easy way to fetch files from a shell.
- Some units have English or Chinese/English web UI.
- Some units have misleading branding in the web UI.

Known stock login noted by the wiki:

```text
admin / admin
```

Possible stock firmware command prompt:

```text
BoC Router>
```

Possible stock firmware version shown in wiki example:

```text
software version: 2.1.3.8
product model: Mifi-Storage-3G
hardware version: 1.0
```

---

## Stock Firmware Shell Notes

The wiki notes that some stock firmware shells are limited.

Example limited commands include:

```text
help
clear
ping
traceroute
ipmac
quit
show
restart_httpd
restore_defaults
ated
```

The wiki also notes a way to enable shell mode on some stock firmware:

```text
runshellcmd
```

After enabling shell mode, `/proc/cmdline` may be readable.

Example:

```text
console=ttyS1,57600n8 root=/dev/ram0
```

This behavior may not exist on every unit.

---

## OpenWrt Support Notes

The wiki indicates that A5-V11 support existed in older OpenWrt / LEDE eras.

Important points for this repo:

- OpenWrt support for this stock class of 4 MB / 32 MB devices is old.
- Modern OpenWrt is not a practical target for stock 4 MB units.
- Older targets such as `ramips/rt305x` are historically relevant.
- Image Builder support existed for A5-V11 in older releases.
- Firmware image type matters.

Do not mix instructions from different OpenWrt versions without checking the target and image format.

---

## Image Type Notes

OpenWrt image types mentioned by the wiki include:

```text
factory.bin
sysupgrade.bin
```

Basic interpretation:

| Image Type | Intended Use |
|---|---|
| factory image | First install from compatible stock firmware or matching install method |
| sysupgrade image | Upgrade from an existing OpenWrt install |
| full flash dump | External programmer use only |
| U-Boot image | Bootloader replacement only, critical risk |

Do not use these interchangeably.

---

## Official Image Warning

The wiki references older OpenWrt images for A5-V11.

This repo should not blindly recommend old images as final user firmware.

Instead, record:

- OpenWrt version
- target
- subtarget
- image type
- flash size
- package list
- tested board ID
- recovery method
- result

For the PS2 project, custom minimal builds are likely more useful than generic old router builds.

---

## Flash Layout Notes

The wiki boot log shows a common 4 MB MTD layout.

Common layout:

| Partition | Offset Start | Offset End | Size | Notes |
|---|---:|---:|---:|---|
| `u-boot` | `0x000000` | `0x030000` | `0x030000` | Bootloader |
| `u-boot-env` | `0x030000` | `0x040000` | `0x010000` | Bootloader environment |
| `factory` | `0x040000` | `0x050000` | `0x010000` | Board-specific data |
| `firmware` | `0x050000` | `0x400000` | `0x3B0000` | Kernel and root filesystem |

Important:

```text
Factory starts at 0x040000.
Firmware starts at 0x050000.
```

Do not write firmware over the factory partition.

---

## Factory Partition Notes

The `factory` partition is critical.

Common factory location:

```text
Offset: 0x040000
Size:   0x010000
```

This partition may contain:

- Wi-Fi calibration
- RF calibration
- MAC address
- Board-specific data

For this repo:

```text
Always back up factory before flashing.
Always preserve same-board factory data during 16 MB flash migration.
Do not publish factory partitions in the public repo.
```

---

## Rootfs Data Notes

The wiki boot log shows `rootfs_data` being created near the end of the 4 MB flash.

Example from the wiki snapshot:

```text
rootfs_data around 0x330000-0x400000
```

This highlights how little writable space exists on stock 4 MB flash.

Practical meaning:

- Installing packages after flashing may fail.
- Saving settings may fail if overlay is too small.
- LuCI may consume too much space.
- Custom PS2 firmware must be trimmed.
- 16 MB flash upgrade is strongly preferred for serious development.

---

## Image Builder Notes

The wiki includes older Image Builder usage.

Example concept:

```text
wget http://downloads.openwrt.org/chaos_calmer/15.05/ramips/rt305x/OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64.tar.bz2
tar xfj OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64.tar.bz2
cd OpenWrt-ImageBuilder-15.05-ramips-rt305x.Linux-x86_64
make image PROFILE="A5-V11"
```

Repo note:

```text
This is historical.
Do not assume current OpenWrt uses the same target, profile, package set, or image builder behavior.
```

For this project, preserve this as historical reference only.

---

## Extroot Notes

The wiki suggests extroot as a way to work around 4 MB flash limitations.

Extroot may be useful for experimentation, but for PS2 internal work it has tradeoffs.

Potential advantages:

- More package space
- Easier testing
- Can install tools after boot

Potential disadvantages:

- Requires USB storage
- Adds boot timing complexity
- Adds power draw
- Adds another failure point
- May not be ideal for final PS2 internal builds
- USB storage may need to be inserted before boot

For final PS2 firmware, a purpose-built image may be better than relying on extroot.

---

## U-Boot Notes

The wiki shows U-Boot boot logs and menu options.

Example U-Boot menu:

```text
1: Load system code to SDRAM via TFTP.
2: Load system code then write to Flash via TFTP.
3: Boot system code via Flash (default).
4: Enter boot command line interface.
7: Load Boot Loader code then write to Flash via Serial.
9: Load Boot Loader code then write to Flash via TFTP.
```

Important:

- Option 2 may be used for firmware TFTP recovery.
- Option 7 writes bootloader through serial.
- Option 9 writes bootloader through TFTP.
- Options 7 and 9 are critical risk.

Do not use bootloader write options casually.

---

## U-Boot Version Notes

The wiki boot log includes an example U-Boot version:

```text
U-Boot 1.1.7
Ralink UBoot Version: 3.6.0.0
Date: Dec 13 2011
```

The example boot log also reports:

```text
TOTAL_MEMORY_SIZE: 32 MBytes
CPU freq = 360 MHz
```

Record the exact U-Boot version for every board.

---

## U-Boot Environment Warning

The wiki boot log includes:

```text
Warning - bad CRC, using default environment
```

This may be normal on some boards.

Do not automatically assume this means the board is bricked.

Record it in the board notes.

---

## U-Boot Flash Detection Warning

The wiki boot log includes a warning like:

```text
Warning: un-recognized chip ID, please update bootloader!
```

This matters for flash chip upgrades.

If U-Boot does not recognize the flash chip correctly, recovery or boot behavior may be unreliable.

For 16 MB flash upgrades, record:

- U-Boot flash detection
- Flash chip ID
- Flash size reported
- Kernel MTD layout
- Whether firmware boots
- Whether TFTP recovery still works

---

## U-Boot Replacement Warning

The wiki references U-Boot replacement methods and files.

Important warning from wiki notes:

```text
256 in file name means 32 MB RAM.
128 means 16 MB RAM.
Act accordingly.
```

Repo policy:

```text
Do not flash U-Boot without verified backups and CH341A recovery.
```

Before U-Boot work, confirm:

- RAM size
- flash size
- board ID
- original U-Boot backup
- factory partition backup
- known-good recovery image
- external SPI programmer access

---

## Alternative U-Boot Notes

The wiki mentions an alternate `uboot256.img` from a GitHub source and notes problems:

```text
This uboot256.img does not support emergency firmware restore via tftp.
Reset pressed on boot does not work because GPIO is incorrect.
```

This is critical for recovery planning.

Do not assume an alternate U-Boot is better.

Test recovery features before relying on them.

---

## TFTP Recovery Notes

The wiki describes loading an image over serial-assisted U-Boot TFTP.

General concept:

1. Connect UART.
2. Start TFTP server.
3. Boot device and enter U-Boot menu.
4. Choose option 2.
5. Enter device IP.
6. Enter server IP.
7. Enter firmware filename.
8. Let U-Boot write firmware.

The wiki also describes a TFTP method without serial access, but warns it was performed with a modified bootloader already flashed.

Important note:

```text
Button-triggered TFTP may not work on stock bootloader.
```

---

## Button TFTP Pattern From Wiki

The wiki records this pattern for a modified bootloader:

```text
1. Rename known working sysupgrade image to firmware.bin.
2. Hold reset while powering the device.
3. Blue LED should start flashing.
4. Set host IP to 192.168.1.2.
5. TFTP firmware.bin to 192.168.1.1.
6. Use binary mode.
```

Example command:

```text
tftp 192.168.1.1
tftp> mode binary
tftp> put firmware.bin
```

Repo note:

```text
Treat this as bootloader-specific.
Confirm with UART and Wireshark before relying on it.
```

---

## Serial Console Notes

The wiki gives a UART pad order.

Board orientation from wiki:

```text
USB jack to the left
Ethernet jack to the right
Ralink CPU on the other side of the board
4 pads in the bottom-right corner
```

Pad order from left to right:

| Pad | Signal | Note |
|---:|---|---|
| 1 | VCC | 3.3 V, do not connect |
| 2 | TX | Connect to RX on 3.3 V USB serial adapter |
| 3 | RX | Connect to TX on adapter through 470 ohm to 1 k ohm resistor |
| 4 | GND | Connect to adapter GND |

UART settings:

```text
57600 8N1
3.3 V TTL
```

---

## UART RX Hang Warning

The wiki notes that some devices may hang if the USB serial adapter is connected to router RX before power-on.

Workaround:

```text
Power the router first, then connect RX.
```

Better fix:

```text
Use a 470 ohm to 1 k ohm resistor between adapter TX and router RX.
```

Repo standard:

```text
Adapter TX -> 470 ohm to 1 k ohm -> A5-V11 RX
```

---

## GPIO Notes

The wiki lists several GPIO observations.

Important note:

```text
GPIOs can handle 4 mA max.
```

Do not directly drive heavy loads from GPIO.

Use GPIO only as signal-level control.

---

## LED GPIO Notes

The wiki lists:

| GPIO | Function |
|---:|---|
| GPIO17 | Red power LED |
| GPIO20 | Blue system LED |

The wiki notes only the red LED may be enabled by default.

Example blue LED config from wiki:

```text
config led
        option default '0'
        option name 'WIFI'
        option sysfs 'a5-v11:blue:system'
        option trigger 'netdev'
        option dev 'wlan0'
        option mode 'link tx rx'
```

For PS2 firmware, LED behavior could be repurposed for:

- Booting
- Wi-Fi connecting
- USB mounting
- Service ready
- Failure state
- Recovery mode

---

## USB GPIO Notes

The wiki lists:

| GPIO | Function |
|---:|---|
| GPIO7 | USB power |
| GPIO12 | USB root hub power |

These may matter for:

- USB storage startup
- UDPBD
- UDPFS
- SMB server mode
- Power saving
- Boot timing
- Service-ready detection

Verify behavior on the actual board before using these GPIOs in scripts.

---

## Ethernet PHY Power Notes

The wiki notes that the RT5350 SoC may expose multiple Ethernet PHYs internally even though not all are physically connected.

The wiki notes a power-saving observation:

```text
Wi-Fi off, all Ethernet PHYs on: about 203 mA
Wi-Fi off, one Ethernet PHY on: about 128 mA
```

The wiki gives commands to disable ports 1 through 4:

```text
swconfig dev switch0 port 1 set disable 1
swconfig dev switch0 port 2 set disable 1
swconfig dev switch0 port 3 set disable 1
swconfig dev switch0 port 4 set disable 1
swconfig dev switch0 set apply
```

These settings may need to be added to:

```text
/etc/rc.local
```

after testing.

For PS2 internal use, disabling unused PHYs may reduce heat and current draw.

---

## Networking Notes

The wiki warns that Ethernet interface naming can be tricky.

One wiki note says the device may use:

```text
eth0.1
```

for wired Ethernet.

Another note says a later or different trunk build needed:

```text
eth0
```

instead.

Repo interpretation:

```text
Do not assume eth0 or eth0.1.
Check the actual firmware and boot log.
```

Useful commands:

```text
ip addr
ifconfig
cat /etc/config/network
logread
dmesg | grep eth
```

---

## Network Lockout Warning

The wiki notes that using the wrong interface in `/etc/config/network` can make the router inaccessible without serial recovery or failsafe.

For this repo:

```text
Always keep UART access while changing network config.
```

Before changing network config:

- Confirm interface names.
- Save current config.
- Have UART connected.
- Know failsafe method.
- Avoid making multiple changes at once.

---

## Ethernet DHCP Client Example From Wiki

The wiki gives an example concept for Ethernet DHCP client mode.

Example:

```text
mount_root

passwd

/etc/init.d/dnsmasq stop
/etc/init.d/firewall stop
/etc/init.d/dnsmasq disable
/etc/init.d/firewall disable

cat > /etc/config/network <<\EOF
config interface 'loopback'
        option ifname 'lo'
        option proto 'static'
        option ipaddr '127.0.0.1'
        option netmask '255.0.0.0'

config interface 'lan0'
        option ifname 'eth0'

config interface 'lan1'
        option ifname 'eth0.1'
        option proto 'dhcp'
EOF

sync

/etc/init.d/network reload
```

Repo warning:

```text
This is historical and firmware-specific.
Confirm eth0 vs eth0.1 before using.
```

---

## odhcpd Crash Loop Note

The wiki notes that if the serial console shows:

```text
procd: Instance odhcpd::instance1 s in a crash loop 6 crashes, 0 seconds since last crash
```

then there may be extra or incorrect network interfaces in the network configuration.

This is useful for debugging custom firmware.

---

## Antenna Notes

The wiki notes that some models may have a disconnected antenna, causing very poor wireless range, especially in STA mode.

For PS2 integration, this matters a lot because:

- The PS2 RF shield may block Wi-Fi.
- A disconnected or weak antenna can look like bad firmware.
- Internal mounting can reduce range.
- STA mode is important for Wi-Fi bridge use.

Before blaming firmware, check:

- Antenna solder joint
- Antenna wire or trace
- Antenna placement
- RF shield interference
- Signal with shell open
- Signal with shell closed

---

## Heat Notes

The wiki notes that some models get very hot during long 24/7 operation and suggests a heatsink may be useful.

For PS2 use:

- Closed-shell heat must be tested.
- RF shield mounting may help as a heat spreader.
- Disabling unused PHYs may reduce heat.
- USB storage adds heat.
- Always-on router mode needs standby thermal testing.

Record temperature during:

- Idle
- Wi-Fi connected
- Ethernet transfer
- USB storage mounted
- UDPBD active
- SMB active
- Closed-shell PS2 use

---

## USB Storage Notes

The wiki notes USB 2.0 / EHCI support.

For this repo, USB matters for:

- UDPBD
- UDPFS
- Router-hosted SMB
- extroot
- firmware transfer from stock shell
- flash experiments

Always test:

- USB detection
- USB power
- filesystem support
- mount timing
- hotplug behavior
- service startup after mount
- current draw

---

## Stock Firmware USB Update Notes

The wiki includes a stock firmware workflow using a VFAT USB flash drive.

Key points:

- Copy U-Boot and firmware files to USB.
- Mount USB as `/mnt`.
- Verify files are visible before writing.
- Use `mtd_write` to write bootloader or kernel.

Critical warning:

```text
Do not continue if files are not visible.
Do not reset during bootloader or firmware write.
```

This method is high risk, especially bootloader writing.

---

## Historical Stock Firmware Command Pattern

The wiki includes command patterns like:

```text
mount /dev/sda1 /mnt
ls /mnt
mtd_write write /mnt/uboot_usb_256_03.img Bootloader
mtd_write write /mnt/firmware.bin Kernel
reboot
```

Repo warning:

```text
This is historical reference only.
Bootloader writes are critical risk.
Do not use without backups and CH341A recovery.
```

---

## OpenWrt Failsafe Notes

The wiki mentions OpenWrt failsafe mode in relation to the A5-V11.

Possible behavior:

```text
Power on.
Wait until red light disappears.
Press the button a few times.
```

Failsafe behavior may vary by firmware and bootloader.

For this repo:

- Test failsafe per board.
- Record LED timing.
- Record IP used.
- Record whether telnet works.
- Record whether `firstboot` works.
- Do not rely on failsafe alone.

---

## Alternative Images Mentioned By Wiki

The wiki mentions community images such as:

- `mini_luci_web_wifi.bin`
- OpenWrt Chaos Calmer images
- Modems and Men images
- Alternative U-Boot images

Repo policy:

```text
Do not mirror unknown binaries without license clarity.
Prefer source links, checksums, and notes.
Mark old binaries as historical.
```

---

## 4 MB Firmware Strategy

The wiki makes it clear that 4 MB is very tight.

For this repo, a stock 4 MB build should be minimal.

Possible 4 MB roles:

- Basic Wi-Fi bridge
- Basic FTP helper
- Basic Ethernet test
- Minimal recovery build
- UDPBD if carefully trimmed and tested

Poor 4 MB roles:

- Full LuCI
- Samba plus USB plus many extras
- UDPFS plus web UI plus extras
- General-purpose router firmware
- Package-heavy development environment

---

## 16 MB Firmware Strategy

The wiki is based on stock 4 MB hardware, but this project also explores 16 MB flash upgrades.

For 16 MB builds:

- Preserve U-Boot.
- Preserve U-Boot environment.
- Preserve same-board factory partition.
- Expand firmware partition carefully.
- Confirm OpenWrt DTS/layout.
- Confirm U-Boot flash detection.
- Confirm kernel partition detection.
- Confirm Wi-Fi calibration.
- Confirm UART boot.
- Save a new full 16 MB backup after a successful boot.

Even with 16 MB flash, RAM is still limited.

---

## PS2 Project Relevance

The OpenWrt Wiki notes are especially useful for PS2 integration because they identify hardware limits and recovery paths.

Important PS2-related takeaways:

- Keep firmware minimal.
- Preserve UART access.
- Do not trust all board variants.
- Watch heat in closed shell.
- Check antenna connection and placement.
- Watch boot timing.
- Verify Ethernet interface name.
- Preserve factory partition.
- Avoid casual U-Boot replacement.
- Use CH341A backups before flash upgrades.
- Consider disabling unused PHYs to reduce heat/current.

---

## Wiki Claims To Verify In This Repo

| Claim | Repo Status | Notes |
|---|---|---|
| Board has RT5350F | Needs board-by-board verification | Check SoC marking |
| Stock flash is 4 MB | Needs board-by-board verification | Check flash chip |
| Stock RAM is 32 MB | Needs board-by-board verification | Check RAM chip and UART |
| UART is 57600 8N1 | Verify per board | Most important recovery test |
| UART pad order is VCC, TX, RX, GND | Verify with board photo and continuity | Do not connect VCC |
| Factory partition is at 0x040000 | Verify with full dump and `/proc/mtd` | Critical |
| Firmware starts at 0x050000 | Verify with boot log and layout | Critical |
| eth0.1 may be LAN | Firmware-specific | Test before final config |
| Button TFTP works after modified U-Boot | Bootloader-specific | Do not assume stock support |
| Some antennas are disconnected | Verify physical board | Important for PS2 |
| Some units run hot | Test closed-shell | Important for internal mounting |
| GPIOs can handle 4 mA max | Treat as limit | Use drivers for loads |

---

## Conflicts And Cautions

The OpenWrt Wiki includes some notes that may conflict depending on firmware version.

Examples:

| Topic | Caution |
|---|---|
| `eth0` vs `eth0.1` | Interface naming may differ by build |
| TFTP recovery | Button recovery may require modified U-Boot |
| U-Boot replacement | Some replacement U-Boot images lose TFTP/reset recovery |
| factory/sysupgrade use | Image expectations depend on install method |
| LuCI on 4 MB | Some old images fit, but free overlay may be too small |
| failsafe | Some images may not have expected failsafe IP behavior |

Document the exact board and firmware before applying any wiki command.

---

## Commands Collected From Wiki

### Disable Unused Ethernet PHY Ports

```text
swconfig dev switch0 port 1 set disable 1
swconfig dev switch0 port 2 set disable 1
swconfig dev switch0 port 3 set disable 1
swconfig dev switch0 port 4 set disable 1
swconfig dev switch0 set apply
```

### Blue LED Netdev Trigger

```text
config led
        option default '0'
        option name 'WIFI'
        option sysfs 'a5-v11:blue:system'
        option trigger 'netdev'
        option dev 'wlan0'
        option mode 'link tx rx'
```

### TFTP Client Upload Pattern

```text
tftp 192.168.1.1
tftp> mode binary
tftp> put firmware.bin
```

### dnsmasq TFTP Server Pattern

```text
dnsmasq --port=0 --enable-tftp --tftp-root=/your/folder --interface=eth0 --bind-interfaces
```

Note:

```text
The exact dnsmasq syntax may vary.
Use the correct Ethernet interface for your PC.
```

### Stock Firmware USB Mount Pattern

```text
mount /dev/sda1 /mnt
ls /mnt
```

### Stock Firmware Write Pattern

```text
mtd_write write /mnt/uboot_usb_256_03.img Bootloader
mtd_write write /mnt/firmware.bin Kernel
```

Critical warning:

```text
Do not run these blindly.
Bootloader writes can hard-brick the router.
```

---

## Useful Wiki-Derived Test Checklist

Use this checklist when testing a new board.

| Test | Result |
|---|---|
| PCB marking checked |  |
| RAM chip identified |  |
| Flash chip identified |  |
| UART pad order confirmed |  |
| UART boot log captured |  |
| U-Boot menu captured |  |
| RAM size reported |  |
| Flash chip reported |  |
| `/proc/mtd` saved |  |
| factory partition backed up |  |
| Ethernet interface tested |  |
| Wi-Fi antenna checked |  |
| Wi-Fi scan tested |  |
| USB detection tested |  |
| TFTP recovery behavior tested |  |
| failsafe behavior tested |  |
| heat checked |  |

---

## OpenWrt Wiki Source Record Template

Use this template when logging the wiki as a source.

```text
# Source Record

Source ID:
Title:
URL:
Date accessed:
Archive URL:
Source type:
Status:

## Key Topics

Hardware:
Installation:
Recovery:
UART:
GPIO:
Networking:
Known issues:

## Claims Used

Claim 1:
Claim 2:
Claim 3:

## Verification

Board tested:
Firmware tested:
Result:
Notes:
```

---

## Board-Specific Verification Template

Use this template to compare one real board against the wiki notes.

```text
# OpenWrt Wiki Verification

## Board

Board ID:
PCB marking:
SoC marking:
RAM chip:
Flash chip:
Antenna:
Stock firmware:

## Wiki Match

A5-V11 marking present:
RAM matches wiki:
Flash matches wiki:
UART pad order matches:
Baud 57600 works:
U-Boot menu matches:
Factory offset matches:
Firmware offset matches:
Ethernet interface:
Wi-Fi works:
USB works:

## Differences

Difference 1:
Difference 2:
Difference 3:

## Result

Status:
Notes:
```

---

## Public Repo Safety

Do not commit:

- Full flash dumps
- Factory partitions
- Private MAC addresses
- Wi-Fi passwords
- Random U-Boot binaries
- Unknown firmware binaries
- Copyrighted files
- PS2 BIOS files
- Game files

The repo can include:

- Notes
- Links
- Warnings
- Tested configs
- Build instructions
- Patches
- Checksums
- Board photos
- Public logs with private data redacted

---

## Recommended Repo Credit

Use this credit note when appropriate:

```text
These notes summarize public OpenWrt Wiki information for the A5-V11 unbranded RT5350F router, combined with project-specific interpretation for PS2 integration. Verify all commands and offsets against your own board before flashing or modifying hardware.
```

---

## Do Not Do This

Avoid these mistakes:

- Do not assume all A5-V11 boards are identical.
- Do not flash U-Boot from the wiki without confirming RAM size.
- Do not use `uboot128` or `uboot256` based only on filename.
- Do not overwrite factory data.
- Do not treat button TFTP as universal.
- Do not assume `eth0.1` always works.
- Do not assume `eth0` always works.
- Do not rely on 4 MB flash for full PS2 service firmware.
- Do not bury the router inside a PS2 before UART and recovery are tested.
- Do not ignore heat and antenna warnings.
- Do not publish private flash backups.

---

## Short Version

The OpenWrt Wiki is one of the most important A5-V11 references.

The biggest takeaways are:

- Stock A5-V11 is commonly RT5350F, 4 MB flash, 32 MB RAM.
- 4 MB / 32 MB is not suitable for modern full OpenWrt use.
- OpenWrt support for this class of device is historical.
- Hardware and firmware variants exist.
- UART is critical.
- Factory partition must be preserved.
- U-Boot replacement is dangerous.
- TFTP behavior depends on bootloader.
- Ethernet interface naming may differ.
- Some boards have antenna or heat issues.
- GPIO current is limited.
- PS2 firmware should be minimal and purpose-built.

For this repo, the wiki should be treated as a strong starting reference, not a substitute for board-specific testing.

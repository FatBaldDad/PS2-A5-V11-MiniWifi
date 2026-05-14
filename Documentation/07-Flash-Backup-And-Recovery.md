# 07 - Flash Backup And Recovery

## Summary

This document covers flash backup, factory partition preservation, and recovery methods for the A5-V11 mini router.

The A5-V11 normally uses a small SPI flash chip. The stock board commonly has 4 MB of flash, which contains the bootloader, bootloader environment, factory data, kernel, root filesystem, and writable overlay.

Before modifying firmware, replacing the flash chip, installing OpenWrt, upgrading to 8 MB or 16 MB flash, or installing the board inside a PlayStation 2, the original flash should be backed up.

The most important rule is:

Back up the original flash before changing anything.

## Critical Warning

Do not erase or overwrite the original flash until it has been dumped and verified.

The original flash may contain board-specific data such as:

- MAC address
- Wi-Fi calibration data
- RF calibration data
- Factory settings
- Bootloader environment
- Original bootloader
- Original firmware

Losing this data can cause:

- No Wi-Fi
- Poor Wi-Fi range
- Duplicate MAC address
- Broken Ethernet identity
- Failed OpenWrt boot
- Hard-to-recover router
- Total brick if U-Boot is lost

The factory partition is not generic.

Do not assume another board's factory partition belongs on your board.

## Purpose Of This Document

This document is meant to help with:

- Backing up a stock A5-V11
- Preserving the factory partition
- Understanding the stock flash layout
- Recovering from bad firmware
- Recovering from bad network configuration
- Recovering from failed OpenWrt flashes
- Preparing for 8 MB or 16 MB flash upgrades
- Organizing flash dumps in the repo
- Avoiding accidental loss of calibration data
- Creating a repeatable recovery process

## What This Document Does Not Do

This document does not guarantee recovery from every brick.

Some failures may be unrecoverable without:

- A valid flash dump
- Working SPI flash chip
- Working bootloader
- Working UART
- External SPI programmer
- Microsoldering
- Replacement flash chip

If the flash chip is physically damaged or cannot be read, recovery may require replacing the chip and reconstructing the image from known-good parts.

## Recovery Priority Order

Use the least destructive method first.

Recommended order:

1. Fix network settings through web UI, SSH, telnet, or UART.
2. Use OpenWrt failsafe if OpenWrt still boots.
3. Use sysupgrade if OpenWrt still works.
4. Use UART and U-Boot recovery.
5. Use TFTP recovery if supported.
6. Use external SPI programmer.
7. Replace the SPI flash chip.
8. Rebuild flash image from saved partitions.

Do not jump directly to writing U-Boot unless there is no safer option.

## Important Terms

| Term | Meaning |
|---|---|
| SPI flash | The 8-pin flash chip that stores bootloader, firmware, and factory data |
| U-Boot | Bootloader used on many A5-V11 boards |
| U-Boot environment | Small area that stores bootloader settings |
| Factory partition | Board-specific data area, usually includes RF calibration and MAC data |
| Firmware partition | Main area containing kernel and root filesystem |
| Kernel | Linux kernel |
| Rootfs | Root filesystem |
| Rootfs data | Writable overlay area used by OpenWrt |
| MTD | Linux memory technology device interface used for flash partitions |
| Sysupgrade | OpenWrt firmware upgrade process |
| TFTP | Simple network file transfer often used by bootloaders |
| UART | Serial console used for boot logs and recovery |
| CH341A | Common low-cost SPI flash programmer |

## Typical Stock Flash Layout

A common stock A5-V11 4 MB flash layout is:

| Offset | Size | Partition |
|---:|---:|---|
| 0x000000 | 0x030000 | u-boot |
| 0x030000 | 0x010000 | u-boot-env |
| 0x040000 | 0x010000 | factory |
| 0x050000 | 0x3B0000 | firmware |

Total stock flash size:

```text
0x400000
```

or:

```text
4 MB
```

The firmware partition begins at:

```text
0x050000
```

## Important Factory Partition Offset

On the common stock layout, the factory partition is located at:

```text
Offset: 0x040000
Size:   0x010000
```

That means the factory partition is 64 KB.

Using 64 KB blocks:

```text
factory = block 4
```

This is useful when extracting it from a full flash dump.

## Why The Factory Partition Matters

The factory partition may contain:

- Wi-Fi EEPROM data
- RF calibration data
- MAC address
- Board-specific radio configuration
- Hardware identity data

If this partition is missing or wrong, Wi-Fi may fail or perform badly.

Symptoms of missing or bad factory data may include:

- Wi-Fi interface missing
- Wi-Fi driver loads with errors
- EEPROM checksum error
- RF calibration error
- No MAC address
- Duplicate MAC address
- Very poor wireless range
- OpenWrt boots but wireless does not work

Always preserve the original factory partition.

## Minimum Backup Set

At minimum, save:

| File | Purpose |
|---|---|
| Full flash dump | Complete original image |
| U-Boot partition | Bootloader backup |
| U-Boot environment | Bootloader settings |
| Factory partition | Calibration and MAC data |
| Firmware partition | Original firmware |
| UART boot log | Hardware and partition reference |
| Board photos | Chip and board reference |

The full flash dump is the most important file.

The factory partition is the second most important file.

## Recommended Backup Folder Structure

Use one folder per board.

Example:

```text
Test-Data/Board-Logs/board-001/
├── photos/
├── uart-logs/
├── stock-web-ui/
├── stock-telnet/
├── flash-dumps/
│   ├── raw-reads/
│   ├── verified/
│   ├── partitions/
│   └── checksums/
└── notes.md
```

## Recommended File Names

Example names:

```text
board-001-stock-full-flash-read1.bin
board-001-stock-full-flash-read2.bin
board-001-stock-full-flash-verified.bin
board-001-stock-u-boot.bin
board-001-stock-u-boot-env.bin
board-001-stock-factory.bin
board-001-stock-firmware.bin
board-001-stock-bootlog.txt
board-001-stock-checksums.txt
```

For public repo examples, use placeholder names.

Do not publish board-specific factory data unless it has been intentionally reviewed and cleaned.

## Backup Verification

A flash backup is not trusted until it is verified.

Recommended verification:

1. Read the flash at least twice.
2. Compare both reads.
3. Confirm file size.
4. Generate checksums.
5. Open the file in a hex editor.
6. Confirm it is not all `FF`.
7. Confirm it is not all `00`.
8. Confirm recognizable bootloader text exists near the beginning.
9. Confirm expected partition offsets.
10. Save read logs.

Example checksum command on Linux:

```text
sha256sum board-001-stock-full-flash-read1.bin
sha256sum board-001-stock-full-flash-read2.bin
```

Example compare command:

```text
cmp board-001-stock-full-flash-read1.bin board-001-stock-full-flash-read2.bin
```

No output from `cmp` usually means the files match.

## What A Bad Dump Looks Like

Bad dump signs:

- File is the wrong size
- File is all `FF`
- File is all `00`
- Reads do not match
- Bootloader text is missing
- Factory area looks empty
- Programmer reports chip ID errors
- Programmer voltage is wrong
- Clip connection is unstable
- Board is backfeeding power
- Other chips on the board interfere with reading

Do not use a bad dump as a recovery image.

## Backup Method Options

There are three main backup methods.

| Method | Best Use |
|---|---|
| External SPI programmer | Best full backup and hard recovery method |
| OpenWrt MTD dump | Useful if OpenWrt is already running |
| Stock firmware shell dump | Possible on some firmware, varies heavily |

The safest and most complete method is an external SPI programmer.

## Method 1: External SPI Programmer

An external SPI programmer is the preferred method for serious work.

Common tool:

```text
CH341A SPI programmer
```

Other compatible SPI flash programmers can also work.

Benefits:

- Can dump flash before flashing OpenWrt
- Can recover from bad firmware
- Can recover from bad network settings
- Can program replacement flash chips
- Can prepare 8 MB or 16 MB upgrades
- Does not require the router to boot
- Does not require OpenWrt to already be installed

## External Programmer Safety

Before using a programmer:

- Confirm flash chip part number.
- Confirm voltage requirement.
- Use 3.3 V for normal 25-series SPI NOR flash.
- Do not use 5 V programming voltage.
- Make sure the clip orientation is correct.
- Make sure pin 1 is aligned.
- Disconnect router power.
- Avoid backfeeding the board.
- Read more than once.
- Compare reads before writing.
- Save original dumps before erasing anything.

## In-Circuit Programming Warning

Reading or writing the flash while it is still soldered to the board may or may not work.

Possible problems:

- SoC holds SPI lines
- Power backfeeds through the programmer
- Other parts load the SPI bus
- Clip connection is poor
- Read results are unstable
- Writes fail verification
- Router partially powers through the programmer
- Flash chip is not detected reliably

If in-circuit reads are inconsistent, remove the flash chip or lift the required pins only if you have the skill and tools.

For reliable programming, programming the chip out-of-circuit is usually better.

## CH341A Backup Workflow

General workflow:

1. Remove power from the A5-V11.
2. Identify the flash chip.
3. Confirm chip orientation and pin 1.
4. Connect SOIC clip or adapter.
5. Select the correct flash chip in programmer software.
6. Read the flash.
7. Save as read 1.
8. Read the flash again.
9. Save as read 2.
10. Compare read 1 and read 2.
11. If they match, save a verified copy.
12. Generate checksum.
13. Extract important partitions.
14. Store backups in multiple places.

## CH341A Software

Common software options:

| Platform | Tool |
|---|---|
| Windows | AsProgrammer |
| Windows | NeoProgrammer |
| Windows | CH341A Programmer software |
| Linux | flashrom |
| Linux | minipro, depending on programmer |
| macOS | flashrom, depending on adapter support |

Use the software that correctly identifies and verifies the chip.

## flashrom Example

Example command to identify a chip:

```text
flashrom -p ch341a_spi
```

Example read command:

```text
flashrom -p ch341a_spi -r board-001-stock-full-flash-read1.bin
```

Second read:

```text
flashrom -p ch341a_spi -r board-001-stock-full-flash-read2.bin
```

Compare:

```text
cmp board-001-stock-full-flash-read1.bin board-001-stock-full-flash-read2.bin
```

Generate checksum:

```text
sha256sum board-001-stock-full-flash-read1.bin > board-001-stock-checksums.txt
```

## Expected Full Dump Sizes

Expected full dump sizes:

| Flash Size | Bytes | Hex Size |
|---:|---:|---:|
| 4 MB | 4,194,304 | 0x400000 |
| 8 MB | 8,388,608 | 0x800000 |
| 16 MB | 16,777,216 | 0x1000000 |

If the file size does not match the chip size, stop and investigate.

## Extracting Partitions From A 4 MB Dump

Using the common stock layout:

| Partition | Offset | Size |
|---|---:|---:|
| u-boot | 0x000000 | 0x030000 |
| u-boot-env | 0x030000 | 0x010000 |
| factory | 0x040000 | 0x010000 |
| firmware | 0x050000 | 0x3B0000 |

## Extract Partitions Using dd

From a verified 4 MB full dump:

```text
dd if=board-001-stock-full-flash-verified.bin of=board-001-stock-u-boot.bin bs=1 skip=$((0x000000)) count=$((0x030000))
dd if=board-001-stock-full-flash-verified.bin of=board-001-stock-u-boot-env.bin bs=1 skip=$((0x030000)) count=$((0x010000))
dd if=board-001-stock-full-flash-verified.bin of=board-001-stock-factory.bin bs=1 skip=$((0x040000)) count=$((0x010000))
dd if=board-001-stock-full-flash-verified.bin of=board-001-stock-firmware.bin bs=1 skip=$((0x050000)) count=$((0x3B0000))
```

Using 64 KB blocks for the factory partition:

```text
dd if=board-001-stock-full-flash-verified.bin of=board-001-stock-factory.bin bs=64K skip=4 count=1
```

## Verify Extracted Factory Partition

Check file size:

```text
ls -l board-001-stock-factory.bin
```

Expected size:

```text
65536 bytes
```

Generate checksum:

```text
sha256sum board-001-stock-factory.bin
```

Store the checksum in the board notes.

## Method 2: Backup From OpenWrt

If OpenWrt is already running, MTD partitions can often be dumped from Linux.

First, check partition layout:

```text
cat /proc/mtd
```

Example expected style:

```text
dev:    size   erasesize  name
mtd0: 00030000 00010000 "u-boot"
mtd1: 00010000 00010000 "u-boot-env"
mtd2: 00010000 00010000 "factory"
mtd3: 003b0000 00010000 "firmware"
```

Partition numbering may vary.

Do not assume the numbers match until checking `/proc/mtd`.

## OpenWrt Backup To USB

If USB storage is available, mount a USB drive and dump directly to it.

Example:

```text
mkdir -p /mnt/backup
mount /dev/sda1 /mnt/backup
cat /proc/mtd
```

Then dump partitions:

```text
cat /dev/mtd0 > /mnt/backup/board-001-u-boot.bin
cat /dev/mtd1 > /mnt/backup/board-001-u-boot-env.bin
cat /dev/mtd2 > /mnt/backup/board-001-factory.bin
cat /dev/mtd3 > /mnt/backup/board-001-firmware.bin
```

If the MTD numbers are different, adjust the commands.

## OpenWrt Backup Full Flash

A full flash dump may be possible through the full flash MTD device depending on the firmware and partition exposure.

Check available MTD devices:

```text
cat /proc/mtd
ls /dev/mtd*
```

If a full flash device is not exposed directly, use the partition dumps and the original programmer dump instead.

External programmer backup is still preferred.

## Copying Backups Off The Router

Possible methods:

- USB drive
- SCP
- Netcat
- TFTP
- HTTP server
- FTP, if available
- Serial transfer, only as last resort

On tiny builds, SCP may not be available.

USB backup is often simpler if USB storage works.

## SCP Example

From a PC:

```text
scp root@192.168.1.1:/tmp/board-001-factory.bin .
```

This only works if SSH and SCP are available.

Some minimal images may not include SCP or SFTP support.

## Netcat Example

On the PC, listen:

```text
nc -l -p 9000 > board-001-factory.bin
```

On the router, send:

```text
cat /dev/mtd2 | nc 192.168.1.2 9000
```

Adjust IP addresses and MTD numbers.

Netcat may not be installed on all builds.

## Method 3: Backup From Stock Firmware

Some stock firmware versions may allow shell access.

Possible access:

```text
telnet 192.168.100.1
```

Common login:

```text
admin
admin
```

Some stock shells are very limited.

Some support:

```text
runshellcmd
```

to enable a fuller shell.

If a full shell is available, try:

```text
cat /proc/mtd
```

If `/proc/mtd` exists and USB storage can be mounted, partition backup may be possible.

Stock firmware varies too much to rely on this method as the primary backup method.

## Stock Shell Backup Caution

Do not run `mtd_write` when trying to make a backup.

`mtd_write` writes to flash.

For backup, commands should read from flash, not write to it.

Read-style commands may include:

```text
cat /dev/mtdX > file.bin
dd if=/dev/mtdX of=file.bin
```

Write-style commands are dangerous:

```text
mtd_write write ...
mtd write ...
flashcp ...
sysupgrade ...
```

Do not use write commands unless intentionally flashing.

## Dangerous Commands

Treat these as dangerous:

```text
mtd_write write
mtd write
mtd erase
flash_erase
flashcp
sysupgrade
firstboot
jffs2reset
dd of=/dev/mtdX
```

These can erase, overwrite, or reset important data.

Use only when the goal is clearly understood.

## Firmware Installation Versus Backup

Backup and installation are different operations.

Backup commands read data from the router.

Firmware installation commands write data to the router.

Do not mix these up.

Backup example:

```text
cat /dev/mtd2 > /mnt/backup/factory.bin
```

Write example:

```text
mtd_write write /mnt/firmware.bin Kernel
```

The first reads from flash.

The second writes to flash.

## Known mtd_write Installation Pattern

Some A5-V11 guides use a pattern like:

```text
ls /media/sda1/
mtd_write write /media/sda1/uboot_usb_256_03.img Bootloader
mtd_write write /media/sda1/lede-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin Kernel
reboot
```

or:

```text
mount /dev/sda1 /mnt
ls /mnt
mtd_write write /mnt/uboot_usb_256_03.img Bootloader
mtd_write write /mnt/firmware.bin Kernel
reboot
```

This is an installation method, not a backup method.

It can brick the board if the wrong file is used.

## U-Boot File Warning

Some U-Boot file names imply RAM size.

Common naming clue:

| File Name Pattern | Often Associated With |
|---|---|
| 128 | 16 MB RAM |
| 256 | 32 MB RAM |

Do not guess.

Before flashing U-Boot, confirm:

- Board model
- RAM size
- Flash size
- U-Boot source
- U-Boot target
- Recovery method
- Original U-Boot backup
- External programmer availability

Flashing the wrong U-Boot can hard-brick the router.

## Recovery Method 1: OpenWrt Failsafe

Use OpenWrt failsafe when OpenWrt still boots but network access or login is broken.

Possible uses:

- Fix bad network config
- Reset password
- Disable broken startup script
- Reset overlay
- Restore default settings

General process varies by firmware.

Typical OpenWrt recovery steps may include:

```text
mount_root
passwd
vi /etc/config/network
/etc/init.d/network restart
reboot
```

To reset overlay:

```text
firstboot
reboot
```

Warning:

`firstboot` resets the writable overlay. It can remove custom configuration.

## Recovery Method 2: UART Console Repair

Use UART when:

- Ethernet IP is unknown
- Web UI is unreachable
- SSH is not working
- Telnet is not working
- Network config is wrong
- Router boots but cannot be reached
- Services fail to start

UART allows direct console access.

Useful commands:

```text
cat /proc/mtd
cat /etc/config/network
ifconfig
ip addr
route
logread
dmesg
```

Network repair example:

```text
vi /etc/config/network
/etc/init.d/network restart
```

## Recovery Method 3: Sysupgrade

Use sysupgrade only when OpenWrt is running and the image is correct for the board.

Example:

```text
sysupgrade -v -n /tmp/openwrt-a5-v11-sysupgrade.bin
```

or from USB:

```text
sysupgrade -v -n /mnt/openwrt-a5-v11-sysupgrade.bin
```

Warning:

- Use sysupgrade images, not factory images, unless documentation says otherwise.
- Confirm flash size.
- Confirm target board.
- Confirm enough free RAM and storage.
- Keep UART connected if possible.

## Recovery Method 4: U-Boot Over UART And TFTP

If U-Boot still works, firmware may be loaded through TFTP.

General process:

1. Connect UART.
2. Open terminal at 57600 8N1.
3. Connect Ethernet to the PC.
4. Set PC static IP.
5. Start TFTP server.
6. Put firmware image in TFTP root.
7. Power the router.
8. Interrupt U-Boot.
9. Select the correct TFTP option.
10. Enter router IP, server IP, and file name.
11. Watch transfer.
12. Write to flash only if the correct option is selected.
13. Do not power off while writing.
14. Reboot and verify.

## Example TFTP Server Using dnsmasq

Example Linux command:

```text
dnsmasq --port=0 --enable-tftp --interface=eth0 --tftp-root=/your/tftp/folder
```

Interface name may be different.

Common interface names:

```text
eth0
enp3s0
eno1
```

Check with:

```text
ip addr
```

## U-Boot Menu Example

A common Ralink U-Boot menu may show options like:

| Option | Meaning |
|---:|---|
| 1 | Load system code to SDRAM via TFTP |
| 2 | Load system code then write to Flash via TFTP |
| 3 | Boot system code via Flash |
| 4 | Enter boot command line interface |
| 7 | Load Boot Loader code then write to Flash via Serial |
| 9 | Load Boot Loader code then write to Flash via TFTP |

Option 2 writes firmware to flash.

Option 9 writes bootloader to flash.

Use extreme caution.

## Recovery Method 5: TFTP Without Serial

Some modified bootloaders may support TFTP recovery without serial.

A commonly documented pattern is:

1. Rename known-good firmware to:

```text
firmware.bin
```

2. Hold reset while powering the router.
3. Wait for the blue LED to flash.
4. Set PC IP to:

```text
192.168.1.2
```

5. TFTP the firmware to:

```text
192.168.1.1
```

Example:

```text
tftp 192.168.1.1
mode binary
put firmware.bin
```

Warning:

This may only work with some bootloaders.

It may not work with stock U-Boot.

Do not depend on this as the only recovery plan.

## Recovery Method 6: External SPI Programmer

Use an external programmer when:

- U-Boot is damaged
- Firmware will not boot
- No serial output appears
- TFTP does not work
- Wrong firmware was flashed
- Wrong partition layout was flashed
- Network recovery is impossible
- Flash chip needs replacement
- Upgrading to 8 MB or 16 MB flash

External programmer recovery is the most direct method.

It requires a valid image or enough saved partitions to rebuild one.

## External Programmer Recovery Workflow

General recovery workflow:

1. Remove power from the router.
2. Connect SPI programmer.
3. Read current flash.
4. Save damaged dump for analysis.
5. Program known-good full flash image.
6. Verify write.
7. Reinstall chip if removed.
8. Connect UART.
9. Power router.
10. Watch boot log.
11. Confirm Ethernet and Wi-Fi.
12. Confirm factory data works.

## Rebuilding A 4 MB Recovery Image

A stock 4 MB recovery image can be rebuilt from:

- Known-good U-Boot
- Known-good U-Boot environment
- Original factory partition
- Known-good firmware image

The factory partition should come from the same board.

Example layout:

```text
0x000000 u-boot
0x030000 u-boot-env
0x040000 factory
0x050000 firmware
```

## Rebuilding A 16 MB Upgrade Image

A 16 MB image usually keeps the early partitions in the same locations and expands the firmware area.

Common concept:

```text
0x000000 u-boot
0x030000 u-boot-env
0x040000 factory
0x050000 firmware
...
0x1000000 end of 16 MB flash
```

The OpenWrt device definition must also know the larger firmware size.

Do not simply write a 4 MB image to a 16 MB chip and expect the firmware to use the full space.

## Example 16 MB Image Assembly Concept

This is a concept example, not a universal command set.

Create empty 16 MB image:

```text
truncate -s 16M board-001-16mb-working-image.bin
```

Copy original early partitions from the stock dump:

```text
dd if=board-001-stock-full-flash-verified.bin of=board-001-16mb-working-image.bin bs=1 skip=$((0x000000)) seek=$((0x000000)) count=$((0x050000)) conv=notrunc
```

Write a 16 MB-compatible firmware image at offset `0x050000`:

```text
dd if=openwrt-a5-v11-16mb-firmware.bin of=board-001-16mb-working-image.bin bs=1 seek=$((0x050000)) conv=notrunc
```

Then program the resulting 16 MB image to the 16 MB flash chip.

Warning:

The firmware image must be built for the correct 16 MB layout.

## Full Flash Restore Warning

Restoring a full flash image from another board can clone:

- MAC address
- RF calibration
- Factory data
- Board identity

This can cause duplicate MAC addresses and wrong calibration.

Only use another board's full image for emergency research or parts testing.

For a proper restore, use your own board's factory partition.

## Common Brick Symptoms

Possible brick symptoms:

- Red and blue LEDs stuck on
- Red and blue LEDs dim
- No Ethernet link
- No DHCP activity
- No Wi-Fi
- No web UI
- No telnet
- No SSH
- No UART output
- U-Boot output only
- Kernel panic
- Boot loop
- Watchdog reset loop
- Root filesystem mount failure
- Flash chip not detected
- Router gets hot quickly
- TFTP recovery fails

Document symptoms before attempting recovery.

## Brick Diagnosis Table

| Symptom | Possible Cause | First Recovery Step |
|---|---|---|
| No network but UART works | Bad network config | Fix config over UART |
| OpenWrt boots but no login | Password or Dropbear issue | UART or failsafe |
| U-Boot works but firmware does not | Bad firmware image | TFTP or sysupgrade |
| No U-Boot output | Bootloader or flash issue | SPI programmer |
| LEDs stuck on and warm | Bad flash or hardware fault | UART, then programmer |
| Wi-Fi missing after flash | Bad factory data | Restore factory partition |
| Ethernet missing after flash | Bad config or driver issue | UART logs |
| TFTP fails | Bootloader mismatch | Programmer recovery |
| Flash reads do not match | Bad clip or bus conflict | Reconnect or remove chip |

## Firmware Size Checks

Before flashing, check image size.

For stock 4 MB flash, firmware partition size is approximately:

```text
0x3B0000
```

or:

```text
3,866,624 bytes
```

A firmware image larger than the firmware partition will not fit.

For 16 MB flash, the firmware partition can be much larger, but only if the layout is updated.

Always verify:

- Flash size
- Partition size
- Image size
- Image type
- Target device
- Target OpenWrt branch
- Factory versus sysupgrade image type

## Factory Image Versus Sysupgrade Image

Use the correct image type.

| Image Type | Typical Use |
|---|---|
| factory.bin | First install from stock firmware or vendor update method |
| sysupgrade.bin | Upgrade from OpenWrt |
| full flash dump | External programmer only |
| raw firmware partition | Direct partition write only when layout is known |

Do not write a sysupgrade image to the wrong place unless the method specifically requires it.

Do not program a factory image as a full flash image.

Do not program a firmware partition image at offset 0x000000.

## Safe Flashing Checklist

Before flashing anything:

| Check | Done |
|---|---|
| Board identified |  |
| SoC confirmed |  |
| RAM size confirmed |  |
| Flash size confirmed |  |
| Original full flash dumped |  |
| Dump verified by two matching reads |  |
| Factory partition extracted |  |
| Factory partition checksum saved |  |
| U-Boot backed up |  |
| U-Boot environment backed up |  |
| UART connected |  |
| Recovery method planned |  |
| Image type confirmed |  |
| Image size checked |  |
| Target flash size confirmed |  |
| Stable power available |  |
| Do-not-reset warning understood |  |

## Backup Checklist

For every board:

| Item | Done |
|---|---|
| Board photos saved |  |
| Chip markings recorded |  |
| UART boot log saved |  |
| Full flash read 1 saved |  |
| Full flash read 2 saved |  |
| Reads compared |  |
| Verified full dump saved |  |
| SHA256 checksums saved |  |
| U-Boot partition extracted |  |
| U-Boot environment extracted |  |
| Factory partition extracted |  |
| Firmware partition extracted |  |
| MAC address recorded |  |
| Backup copied to second location |  |
| Backup copied to offline storage |  |

## Recovery Checklist

When recovering a board:

| Item | Done |
|---|---|
| Current symptoms documented |  |
| Photos taken |  |
| UART attempted |  |
| UART log saved |  |
| Network scan attempted |  |
| Failsafe attempted if OpenWrt boots |  |
| U-Boot menu checked |  |
| TFTP recovery checked |  |
| Current damaged flash dumped |  |
| Known-good backup located |  |
| Factory partition located |  |
| Recovery image assembled |  |
| Programmed image verified |  |
| First boot log captured |  |
| Ethernet tested |  |
| Wi-Fi tested |  |
| USB tested |  |
| Notes updated |  |

## Board Notes Template

Use this template for flash work.

```text
Board ID:
Date:
Tester:
PCB marking:
SoC:
RAM chip:
RAM size:
Original flash chip:
Original flash size:
Replacement flash chip:
Replacement flash size:
Programmer:
Programmer software:
Read 1 file:
Read 2 file:
Verified dump file:
SHA256:
Factory partition file:
Factory SHA256:
U-Boot file:
U-Boot env file:
Firmware file:
UART log:
Recovery method:
Current status:
Notes:
```

## Public Repo Policy For Flash Dumps

Do not casually commit flash dumps to the public repo.

Avoid publishing:

- Full stock flash dumps
- Factory partitions
- U-Boot environment with board-specific data
- MAC addresses
- RF calibration data
- Unknown vendor firmware binaries
- Third-party firmware files without license clarity

Preferred public repo content:

- Instructions
- Templates
- Placeholder filenames
- Checksums for public release files
- Build configs
- Patches
- Scripts
- Clean examples
- Redacted logs
- Links to upstream sources

## Private Backup Policy

Keep private backups in multiple places.

Recommended locations:

- Local project folder
- External USB drive
- NAS
- Cloud backup
- Offline archive

Minimum:

- One working copy
- One backup copy
- One offline or cloud copy

Do not rely on only one flash dump.

## PS2 Integration Recovery Planning

If the A5-V11 is installed inside a PS2, recovery becomes harder.

Before internal installation:

- Confirm firmware is stable.
- Confirm cold boot is stable.
- Confirm warm reboot is stable.
- Confirm PS2 power source is stable.
- Confirm Ethernet works.
- Confirm Wi-Fi works.
- Confirm USB storage works if used.
- Add UART service access.
- Keep reset access if useful.
- Keep a known-good recovery image.
- Save the board's original flash dump.
- Document how to access the board if it fails.

Do not bury a router inside a PS2 without a recovery plan.

## Internal PS2 Service Connector

For PS2 internal installs, consider a hidden service connector.

Minimum signals:

| Pin | Signal |
|---:|---|
| 1 | GND |
| 2 | Router TX |
| 3 | Router RX |

Optional:

| Pin | Signal |
|---:|---|
| 4 | 3.3 V sense only |
| 5 | Reset button line, if safely exposed |

Do not expose power pins unless the design is clearly labeled and protected.

## Known Recovery Risks

Risks include:

- Programming at wrong voltage
- Clip installed backwards
- Pin 1 orientation wrong
- Flash chip selected incorrectly
- Bad dump used as backup
- Factory partition lost
- Wrong U-Boot flashed
- Wrong RAM-size U-Boot flashed
- Wrong flash-size firmware flashed
- Power loss during write
- Writing image to wrong offset
- Using sysupgrade image as full flash image
- Using full flash image as sysupgrade image
- Publishing board-specific factory data by mistake

## Recommended Development Rule

For development, use this rule:

Never test a risky flash on the only working board.

Use a sacrificial board for:

- Unknown U-Boot files
- New 16 MB layouts
- New flash chips
- New OpenWrt device definitions
- New partition maps
- New recovery methods
- Unknown firmware from the internet

## Recommended Milestone Path

A good project milestone path:

1. Identify board.
2. Capture stock UART log.
3. Dump original 4 MB flash.
4. Verify dump.
5. Extract factory partition.
6. Restore stock dump to same chip as a test.
7. Program stock dump to replacement 4 MB chip.
8. Boot replacement 4 MB chip.
9. Program preserved data into 16 MB chip.
10. Boot 16 MB chip with stock-compatible layout.
11. Build 16 MB OpenWrt firmware.
12. Boot 16 MB OpenWrt firmware.
13. Confirm Wi-Fi calibration survives.
14. Confirm Ethernet and USB work.
15. Begin PS2-focused firmware testing.

## Condensed Summary

The A5-V11 flash contains more than just firmware.

It also contains the bootloader, bootloader environment, and board-specific factory data.

The factory partition is critical because it may contain Wi-Fi calibration and MAC address data.

Before modifying anything:

```text
Dump the full flash.
Verify the dump.
Extract the factory partition.
Save multiple copies.
Connect UART.
Have a recovery method.
```

For serious development, use a CH341A or other SPI programmer and keep board-specific backups organized by board ID.

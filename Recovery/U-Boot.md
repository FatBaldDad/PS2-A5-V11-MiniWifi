# U-Boot

## Summary

This document covers U-Boot on the A5-V11 mini router.

U-Boot is the bootloader. It is the first major software that runs when the router powers on. It initializes the hardware, detects RAM and flash, provides recovery options, and loads the firmware from SPI flash.

U-Boot is important because it can help recover a broken firmware image.

U-Boot is also dangerous because flashing the wrong bootloader can hard-brick the router.

Treat U-Boot as a critical recovery component.

---

## Main Rule

The main rule is:

```text
Do not flash U-Boot unless you have a verified backup and a hardware recovery method.
```

The second rule is:

```text
If U-Boot still works, avoid overwriting it.
```

For normal firmware recovery, fix the firmware partition first.

Do not touch U-Boot unless it is actually needed.

---

## What U-Boot Does

U-Boot may handle:

- Early hardware initialization
- RAM detection
- SPI flash detection
- Boot menu
- TFTP recovery
- Serial recovery
- Firmware loading
- Kernel checksum verification
- Boot arguments
- MAC address handling
- Environment variables
- Flash erase and write operations

Without a working bootloader, the router usually cannot boot firmware or use normal TFTP recovery.

---

## Why U-Boot Matters On The A5-V11

The A5-V11 has several firmware and bootloader variations.

Some units may have a U-Boot that accepts standard OpenWrt images.

Some units may have a restricted or modified U-Boot that rejects non-vendor images.

Some units may have bootloader recovery features.

Some units may not.

Because of this, U-Boot behavior must be documented per board.

Do not assume two A5-V11 routers behave the same just because the plastic shell looks the same.

---

## Critical Warning

Flashing the wrong U-Boot can cause a hard brick.

Possible results of a bad U-Boot flash:

- No UART output
- No boot menu
- No TFTP recovery
- No Ethernet recovery
- No firmware boot
- Red and blue LEDs stuck
- Router gets warm and does nothing
- SPI programmer recovery required
- Flash chip replacement required

Do not experiment with U-Boot on the only working board.

---

## U-Boot Is Not Firmware

U-Boot and firmware are different things.

| Item | Purpose |
|---|---|
| U-Boot | Bootloader that starts first |
| U-Boot environment | Bootloader settings |
| Factory partition | Board-specific calibration and identity data |
| Firmware | Linux/OpenWrt kernel and root filesystem |

Updating OpenWrt normally should not require replacing U-Boot.

---

## Typical A5-V11 Flash Layout

A common 4 MB flash layout is:

| Partition | Offset | Size | Notes |
|---|---:|---:|---|
| U-Boot | `0x000000` | `0x030000` | Bootloader |
| U-Boot Env | `0x030000` | `0x010000` | Bootloader environment |
| Factory | `0x040000` | `0x010000` | Board-specific data |
| Firmware | `0x050000` | `0x3B0000` | Kernel and root filesystem |

Important:

```text
U-Boot starts at 0x000000.
Factory data commonly starts at 0x040000.
Firmware commonly starts at 0x050000.
```

Do not write firmware over the U-Boot, U-Boot environment, or factory partition.

---

## U-Boot Partition

The U-Boot partition is commonly:

```text
Offset: 0x000000
Size:   0x030000
```

That is:

```text
196608 bytes
```

Always confirm the layout before writing.

---

## U-Boot Environment Partition

The U-Boot environment is commonly:

```text
Offset: 0x030000
Size:   0x010000
```

That is:

```text
65536 bytes
```

The environment may store bootloader variables.

Some boot logs may show:

```text
Warning - bad CRC, using default environment
```

This can happen when U-Boot does not find a valid saved environment and falls back to defaults.

Do not automatically assume this warning means the router is dead.

---

## Factory Partition Reminder

The factory partition is commonly:

```text
Offset: 0x040000
Size:   0x010000
```

This may contain:

- Wi-Fi calibration
- RF calibration
- MAC address
- Board-specific data

Do not overwrite it with U-Boot or firmware.

---

## Common U-Boot Menu

Some A5-V11 bootlogs show a U-Boot menu similar to this:

```text
1: Load system code to SDRAM via TFTP.
2: Load system code then write to Flash via TFTP.
3: Boot system code via Flash (default).
4: Enter boot command line interface.
7: Load Boot Loader code then write to Flash via Serial.
9: Load Boot Loader code then write to Flash via TFTP.
```

Not every board or bootloader will show the same menu.

Document the exact menu from each board.

---

## U-Boot Menu Option Meanings

| Option | Meaning | Typical Risk |
|---:|---|---|
| 1 | Load system code to RAM through TFTP | Lower |
| 2 | Load system code through TFTP and write it to flash | Medium to High |
| 3 | Boot firmware already stored in flash | Low |
| 4 | Enter U-Boot command line | Medium to High |
| 7 | Write bootloader through serial | Critical |
| 9 | Write bootloader through TFTP | Critical |

For normal firmware recovery, option `2` may be useful if the bootloader supports it and the firmware image is correct.

Avoid options `7` and `9` unless intentionally replacing the bootloader.

---

## Dangerous U-Boot Options

These options are critical risk:

```text
7: Load Boot Loader code then write to Flash via Serial.
9: Load Boot Loader code then write to Flash via TFTP.
```

They are for replacing the bootloader itself.

Only use them if:

- U-Boot replacement is required
- Correct replacement U-Boot is confirmed
- RAM size is confirmed
- Flash size is confirmed
- Original U-Boot backup exists
- CH341A recovery is available
- You accept the risk

For most users, these options should be avoided.

---

## RAM Size Warning

Some A5-V11 U-Boot files are associated with RAM size.

A common warning is:

```text
128 in the file name may indicate 16 MB RAM.
256 in the file name may indicate 32 MB RAM.
```

Example concept:

| File Name Clue | Possible RAM Target |
|---|---|
| `uboot128` | 16 MB RAM |
| `uboot256` | 32 MB RAM |

Do not flash a U-Boot file until the RAM size is confirmed.

Using the wrong RAM-size bootloader can brick the router.

---

## Confirm RAM Size Before U-Boot Work

Confirm RAM before touching U-Boot.

Possible methods:

- Read RAM chip marking
- Check UART boot log
- Check OpenWrt `cat /proc/meminfo`
- Check stock firmware shell, if available
- Check board documentation
- Compare with known board photos

Do not guess.

---

## Common RAM Chips

Known A5-V11-related 32 MB RAM chips include:

| RAM Chip | Typical RAM Size |
|---|---:|
| W9825G6EH-75 | 32 MB |
| EM63A165TS-6G | 32 MB |

Some similar routers may have 16 MB RAM.

Treat unknown boards as variants.

---

## Confirm Flash Size Before U-Boot Work

Confirm flash size before U-Boot work.

Common sizes:

| Flash Size | Bytes | Hex |
|---:|---:|---:|
| 4 MB | 4194304 | `0x400000` |
| 8 MB | 8388608 | `0x800000` |
| 16 MB | 16777216 | `0x1000000` |

A U-Boot that works with one flash chip may not automatically handle another flash size correctly.

---

## U-Boot And 16 MB Flash Upgrades

For 16 MB flash upgrades, U-Boot behavior matters.

Questions to answer:

- Does U-Boot detect the 16 MB chip?
- Does U-Boot understand the flash ID?
- Does U-Boot still boot from `0x050000`?
- Does U-Boot load the kernel correctly?
- Does the kernel detect the full flash?
- Does OpenWrt use the expanded firmware partition?
- Does TFTP recovery still work?
- Does the reset button recovery still work?

A 16 MB flash upgrade may boot with the original U-Boot, but that must be tested.

---

## U-Boot Flash Detection

A UART boot log may show SPI flash detection.

Record:

```text
Flash component:
SPI flash ID:
Flash size:
Warnings:
```

Important warnings may include:

```text
Warning: un-recognized chip ID, please update bootloader!
```

This may mean the bootloader does not fully recognize the flash chip.

Do not ignore flash detection warnings during a flash upgrade.

---

## U-Boot And The Factory Partition

U-Boot may read early flash areas, including factory data or MAC-related data.

Do not assume the factory partition is only used by Linux.

Preserve the factory partition during any bootloader or full-flash work.

---

## U-Boot And TFTP Recovery

U-Boot may provide TFTP recovery.

Common methods include:

- U-Boot menu option to load firmware into RAM
- U-Boot menu option to load firmware and write to flash
- Reset-button TFTP recovery on some modified bootloaders
- Manual U-Boot command-line TFTP

TFTP behavior is bootloader-specific.

Document the exact behavior for each board.

---

## U-Boot And Reset Button Recovery

Some modified U-Boot builds may support reset-button TFTP recovery.

Other U-Boot builds may not.

Some notes warn that certain U-Boot builds have incorrect GPIO behavior for reset recovery.

Test reset-button recovery before relying on it.

Do not assume the reset button works in U-Boot just because it works in firmware.

---

## U-Boot Backup Policy

Before replacing or modifying U-Boot, back it up.

Minimum backup:

```text
Full flash dump
U-Boot partition
U-Boot environment
Factory partition
```

Best backup:

```text
Two matching full flash dumps
Extracted U-Boot partition
Extracted U-Boot environment
Extracted factory partition
Checksums
Board photos
UART boot log
```

Store backups privately.

---

## Extracting U-Boot From Full Flash

For the common layout:

```text
U-Boot offset: 0x000000
U-Boot size:   0x030000
```

Linux `dd` command:

```text
dd if=verified-stock-fullflash.bin of=a5v11-board001-u-boot.bin bs=1 skip=$((0x000000)) count=$((0x030000))
```

Expected size:

```text
196608 bytes
```

Generate checksum:

```text
sha256sum a5v11-board001-u-boot.bin > a5v11-board001-u-boot.sha256
```

---

## Extracting U-Boot Environment

For the common layout:

```text
U-Boot environment offset: 0x030000
U-Boot environment size:   0x010000
```

Linux `dd` command:

```text
dd if=verified-stock-fullflash.bin of=a5v11-board001-u-boot-env.bin bs=1 skip=$((0x030000)) count=$((0x010000))
```

Expected size:

```text
65536 bytes
```

Generate checksum:

```text
sha256sum a5v11-board001-u-boot-env.bin > a5v11-board001-u-boot-env.sha256
```

---

## OpenWrt Backup Method

If OpenWrt is running, check partitions:

```text
cat /proc/mtd
```

If U-Boot is exposed as `mtd0`, backup with:

```text
cat /dev/mtd0 > /tmp/u-boot.bin
```

If U-Boot environment is exposed as `mtd1`, backup with:

```text
cat /dev/mtd1 > /tmp/u-boot-env.bin
```

Then copy off the router.

Example:

```text
scp root@192.168.1.1:/tmp/u-boot.bin ./a5v11-board001-u-boot.bin
scp root@192.168.1.1:/tmp/u-boot-env.bin ./a5v11-board001-u-boot-env.bin
```

Warning:

Do not assume U-Boot is always `mtd0`.

Always check `/proc/mtd`.

---

## U-Boot Backup Checklist

Before touching U-Boot:

| Check | Done |
|---|---|
| Board ID assigned |  |
| Board photos taken |  |
| RAM chip identified |  |
| RAM size confirmed |  |
| Flash chip identified |  |
| Flash size confirmed |  |
| Full flash read 1 saved |  |
| Full flash read 2 saved |  |
| Full flash reads match |  |
| U-Boot partition extracted |  |
| U-Boot environment extracted |  |
| Factory partition extracted |  |
| SHA256 checksums saved |  |
| UART boot log saved |  |
| CH341A recovery available |  |

Do not continue until this checklist is complete.

---

## U-Boot Replacement Policy

Avoid replacing U-Boot unless there is a real reason.

Possible valid reasons:

- Stock bootloader rejects all useful firmware images
- Stock bootloader has no needed recovery path
- U-Boot is corrupt
- U-Boot cannot detect upgraded flash
- Project requires a tested recovery-enabled bootloader
- You have a known-good replacement for the exact board

Invalid reasons:

- Trying random files
- Hoping it fixes Wi-Fi
- Hoping it increases speed
- Following an old guide blindly
- Using a bootloader from a different board
- Using a bootloader without confirming RAM size

---

## U-Boot Replacement Requirements

Before replacing U-Boot, confirm:

| Requirement | Confirmed |
|---|---|
| Replacement source known |  |
| License/redistribution status known |  |
| Target SoC is RT5350F or compatible |  |
| Target RAM size matches |  |
| Target flash size works |  |
| Board target is compatible |  |
| Original U-Boot backup exists |  |
| Factory partition backup exists |  |
| CH341A recovery is available |  |
| UART is connected |  |
| Known-good firmware image exists |  |
| Risk is accepted |  |

---

## U-Boot Replacement Methods

Possible methods:

| Method | Notes |
|---|---|
| Stock telnet `mtd_write` | Risky but documented in some A5-V11 workflows |
| U-Boot serial option | Critical risk |
| U-Boot TFTP option | Critical risk |
| CH341A full flash programming | Most controlled for recovery or chip upgrade |
| CH341A partition write | Controlled if offsets are correct |

For bootloader replacement, CH341A with verified image and readback is usually the safest.

---

## Stock Firmware `mtd_write` Method

Some stock firmware workflows write U-Boot from a USB drive.

Example command pattern:

```text
mtd_write write /mnt/uboot_usb_256_03.img Bootloader
```

or:

```text
mtd_write write /media/sda1/uboot_usb_256_03.img Bootloader
```

This is risky.

Before using this method:

- Confirm RAM size
- Confirm U-Boot file is correct
- Confirm USB file is visible
- Confirm power is stable
- Confirm CH341A recovery is available
- Do not interrupt the write

Do not use this method blindly.

---

## U-Boot TFTP Bootloader Write

Some U-Boot menus may include:

```text
9: Load Boot Loader code then write to Flash via TFTP.
```

This is a bootloader write option.

This is not normal firmware recovery.

Do not select this by accident.

---

## U-Boot Serial Bootloader Write

Some U-Boot menus may include:

```text
7: Load Boot Loader code then write to Flash via Serial.
```

This is also a bootloader write option.

It is critical risk.

Do not select this unless intentionally replacing U-Boot.

---

## Normal Firmware TFTP Write

Some U-Boot menus include:

```text
2: Load system code then write to Flash via TFTP.
```

This is for firmware, not U-Boot.

Use this only with a correct firmware image.

Do not send a U-Boot file to a system firmware write option.

Do not send a full flash dump unless the bootloader specifically expects that format.

---

## U-Boot Command Line

Some bootloaders allow:

```text
4: Enter boot command line interface.
```

This can be useful but dangerous.

Manual U-Boot commands may erase or write flash directly.

Only use manual commands if you know:

- RAM load address
- Flash erase offset
- Flash write offset
- Image size
- Partition layout
- Boot command
- Recovery plan

A wrong command can brick the router.

---

## U-Boot Environment

The U-Boot environment may store settings such as:

- Boot command
- Boot delay
- Router IP
- Server IP
- Firmware load address
- Boot arguments
- MAC address variables
- Flash layout variables

Not every A5-V11 exposes or uses the environment the same way.

A bad environment can cause boot failure or recovery confusion.

---

## Bad CRC Environment Warning

A boot log may show:

```text
Warning - bad CRC, using default environment
```

This means U-Boot did not find a valid saved environment checksum and is using defaults.

This may be normal for some boards.

However, if recovery IPs or boot commands behave unexpectedly, the environment should be documented.

---

## Do Not Randomly Edit U-Boot Environment

Do not change U-Boot environment variables unless needed.

Possible risks:

- Wrong boot command
- Wrong firmware offset
- Wrong TFTP IP
- Wrong boot arguments
- Router no longer boots firmware
- Recovery becomes harder

If editing environment, record original values first.

---

## Useful U-Boot Data To Record

For each board, record:

| Item | Value |
|---|---|
| U-Boot version |  |
| Build date |  |
| Boot menu present |  |
| RAM size reported |  |
| Flash chip detected |  |
| Flash size reported |  |
| CPU frequency |  |
| Boot delay |  |
| Default boot option |  |
| TFTP supported |  |
| Reset-button recovery supported |  |
| U-Boot command line available |  |
| Factory data read during boot |  |
| Environment warning |  |

---

## U-Boot Boot Log Template

Save the full UART boot log.

Use this template in notes:

```text
# U-Boot Boot Log Record

Board ID:
Date:
UART baud:
Power source:
Flash chip:
Flash size:
RAM chip:
RAM size:
U-Boot version:
Build date:

Boot log:

<paste full boot log here>

Notes:
```

---

## Healthy U-Boot Signs

Healthy U-Boot usually shows:

- UART output at power-on
- U-Boot banner
- RAM size detected
- SPI flash detected
- CPU information
- Boot menu or countdown
- Firmware image address
- Kernel checksum verification
- Kernel decompression
- Transfer to Linux

Example healthy signs:

```text
DRAM: 32 MB
Flash component: SPI Flash
Please choose the operation:
Booting image at bc050000
Verifying Checksum ... OK
Uncompressing Kernel Image ... OK
Starting kernel
```

Exact text varies.

---

## U-Boot Problem Signs

Possible U-Boot problems:

- No UART output
- No boot menu
- Garbage UART output at correct settings
- Wrong RAM size detected
- Flash chip not detected
- Unrecognized flash chip
- Bad checksum on firmware
- Cannot load kernel
- Cannot write flash
- TFTP never starts
- Boot loops before kernel
- Bootloader menu freezes
- Reset button does nothing when expected

These symptoms require careful diagnosis.

---

## No UART Output

If there is no UART output:

Check:

- 3.3 V TTL adapter
- Baud rate
- TX/RX wiring
- Ground connection
- Router power
- Flash chip soldering
- Flash chip contents
- U-Boot partition
- Hardware damage

If UART wiring and power are confirmed, use CH341A to read the flash.

---

## U-Boot Works But Firmware Does Not Boot

If U-Boot appears but firmware does not boot, do not replace U-Boot first.

Likely causes:

- Bad firmware image
- Wrong image type
- Corrupt firmware partition
- Wrong flash layout
- Firmware too large
- Bad kernel/rootfs
- Bad flash write

Recovery path:

1. Use U-Boot TFTP firmware recovery if supported.
2. Restore firmware partition with CH341A.
3. Restore full flash only if needed.
4. Leave U-Boot alone if it works.

---

## U-Boot Does Not Detect Flash Correctly

Symptoms:

- Flash ID wrong
- Flash size wrong
- Unrecognized flash warning
- Cannot read firmware
- Cannot write firmware
- Boot fails after flash upgrade

Possible causes:

- Unsupported flash chip
- Bad soldering
- Wrong chip orientation
- Bad SPI lines
- U-Boot lacks chip support
- Flash chip damaged

Fixes:

- Check soldering
- Try known-supported flash chip
- Restore original chip
- Use CH341A to verify chip
- Consider U-Boot replacement only after confirming hardware

---

## U-Boot And Firmware Offset

The common firmware start offset is:

```text
0x050000
```

A boot log may show booting from an address corresponding to the firmware location.

If the firmware is written to the wrong offset, U-Boot may not find a valid image.

Do not move firmware start unless the bootloader and OpenWrt layout are changed intentionally.

---

## U-Boot And Full Flash Images

A full flash image is for external programmer use.

Do not feed a full flash image to a normal U-Boot firmware update option unless the bootloader specifically expects that.

A normal U-Boot firmware update option usually expects system firmware, not the entire chip image.

---

## U-Boot And Sysupgrade Images

Some A5-V11 recovery notes use an OpenWrt sysupgrade image with U-Boot TFTP.

This may work for certain bootloader methods.

However, image expectations vary.

Always document:

- Image type
- Filename
- U-Boot option used
- Flash size
- Result
- UART output

---

## U-Boot And Factory Images

Factory images are usually intended for first install from compatible stock firmware or vendor web UI.

Some bootloaders may not accept them.

Do not assume a factory image is correct for U-Boot TFTP unless tested or documented.

---

## U-Boot And Raw Firmware Partition Images

A raw firmware partition image may be appropriate when directly writing the firmware area with CH341A or exact flash commands.

It is not the same as a full flash dump.

It is not the same as a sysupgrade image.

Use only when the layout is known.

---

## U-Boot And PS2 Internal Builds

For PS2 internal builds, U-Boot matters because recovery access becomes harder after installation.

Before installing inside a PS2:

- Capture U-Boot boot log
- Confirm boot menu access
- Confirm firmware recovery path
- Confirm UART service connector
- Confirm flash backup
- Confirm factory backup
- Confirm default IP after recovery

Do not bury a router inside a PS2 without a recovery plan.

---

## UART Access Requirement

Every internal A5-V11 PS2 install should preserve UART access if possible.

Minimum service signals:

| Signal | Purpose |
|---|---|
| GND | Common reference |
| Router TX | Read boot logs |
| Router RX | Send commands |

Optional:

| Signal | Purpose |
|---|---|
| 3.3 V sense | Measurement only |
| Reset | Recovery or reboot access |

Do not rely only on web UI recovery.

---

## U-Boot Recovery Planning

For each board, answer:

| Question | Answer |
|---|---|
| Does U-Boot show a menu? |  |
| Can the menu be interrupted? |  |
| Does TFTP option 1 work? |  |
| Does TFTP option 2 work? |  |
| Does reset-button recovery work? |  |
| What IP does recovery use? |  |
| What filename does recovery expect? |  |
| Does U-Boot detect flash correctly? |  |
| Does U-Boot detect RAM correctly? |  |
| Does CH341A recovery work? |  |

---

## U-Boot Test Procedure

Use this procedure to document a board.

1. Connect UART.
2. Power the board from stable 5 V.
3. Capture complete boot log.
4. Identify U-Boot version.
5. Record RAM size.
6. Record flash detection.
7. Record boot menu.
8. Let it boot normally.
9. Confirm firmware boots.
10. Reboot and interrupt menu.
11. Test menu access without writing anything.
12. Exit or boot normally.
13. Save notes.

Do not test write options unless ready to recover.

---

## Safe TFTP Test Without Flash Writing

If U-Boot option `1` is available, it may load system code to SDRAM only.

This can be useful for testing TFTP transfer without writing flash.

Still be careful:

- Use correct firmware image
- Use UART
- Use known TFTP server
- Do not select flash write options accidentally

Record results.

---

## U-Boot Replacement With CH341A

If U-Boot must be replaced, CH341A is usually the most controlled method.

Recommended process:

1. Back up original full flash twice.
2. Verify reads match.
3. Extract U-Boot, U-Boot env, and factory.
4. Save checksums.
5. Build or obtain correct U-Boot.
6. Confirm RAM size target.
7. Confirm flash size target.
8. Assemble full flash image or patch U-Boot partition.
9. Program with CH341A.
10. Verify write.
11. Read back and compare.
12. Boot with UART connected.
13. Confirm U-Boot menu.
14. Confirm flash detection.
15. Confirm firmware boot.
16. Save new boot log.

---

## U-Boot Replacement With `mtd_write`

If using stock firmware `mtd_write`, understand that it writes directly to the bootloader partition.

Example pattern:

```text
mtd_write write /mnt/uboot_usb_256_03.img Bootloader
```

Do not run this unless:

- The file is visible on USB
- The file is correct for the board
- The RAM size matches
- The flash size is compatible
- Power is stable
- You have CH341A recovery ready
- You accept the risk

Do not interrupt the write.

---

## U-Boot Replacement Failure Recovery

If U-Boot replacement fails:

1. Remove power.
2. Do not keep power cycling.
3. Connect CH341A.
4. Read current flash if possible.
5. Save broken dump.
6. Restore original U-Boot from backup.
7. Restore original full flash if needed.
8. Verify write.
9. Boot with UART.
10. Diagnose before trying again.

---

## U-Boot Record Template

Use this template for each board.

```text
# U-Boot Record

## Board Info

Board ID:
PCB marking:
SoC:
RAM chip:
RAM size:
Flash chip:
Flash size:
Stock firmware:

## U-Boot Info

U-Boot version:
Build date:
Boot menu:
Boot delay:
Command line available:
Reset-button recovery:
TFTP recovery:
Serial recovery:
RAM reported:
Flash reported:
Flash warning:
Environment warning:

## Backups

Full flash backup:
Full flash SHA256:
U-Boot backup:
U-Boot SHA256:
U-Boot env backup:
U-Boot env SHA256:
Factory backup:
Factory SHA256:

## Recovery

TFTP option 1 tested:
TFTP option 2 tested:
Reset-button TFTP tested:
CH341A recovery tested:
Known-good firmware:
Known-good recovery image:

## Notes

Notes:
```

---

## U-Boot Replacement Record Template

Use this template if U-Boot is replaced.

```text
# U-Boot Replacement Record

## Session Info

Date:
Tester:
Board ID:
Reason for replacement:

## Original U-Boot

Original file:
Original SHA256:
Original U-Boot version:
Original boot log saved:
Original recovery behavior:

## Replacement U-Boot

Replacement file:
Replacement SHA256:
Source:
Target RAM size:
Target flash size:
Expected features:
Known warnings:

## Method

Method used:
CH341A:
mtd_write:
TFTP:
Serial:
Power source:
UART connected:

## Verification

Write verified:
Readback matches:
UART output:
RAM detected:
Flash detected:
Boot menu works:
Firmware boots:
TFTP recovery tested:
Reset recovery tested:

## Result

Pass/fail:
Known issues:
Next step:
```

---

## Common U-Boot Mistakes

Avoid these mistakes:

- Flashing U-Boot before backing up original flash
- Using `uboot128` on a 32 MB RAM board
- Using `uboot256` on an incompatible board
- Flashing a bootloader from another device
- Selecting U-Boot write option instead of firmware write option
- Sending firmware to a bootloader write option
- Sending U-Boot to a firmware write option
- Interrupting power during bootloader write
- Assuming reset-button recovery works
- Assuming TFTP recovery works on stock U-Boot
- Assuming all A5-V11 boards use the same U-Boot
- Overwriting factory data during full image assembly

---

## Troubleshooting: U-Boot Menu Does Not Appear

Possible causes:

- UART not connected correctly
- Wrong baud rate
- U-Boot silent mode
- Bootloader corrupted
- Flash chip problem
- Power problem
- Board hardware fault

Try:

- Confirm UART wiring
- Confirm 57600 8N1
- Confirm 3.3 V TTL
- Try power cycling with terminal already open
- Check flash with CH341A
- Restore original U-Boot backup if needed

---

## Troubleshooting: U-Boot Appears But Keyboard Input Does Not Work

Possible causes:

- Adapter TX not connected to router RX
- Router RX needs series resistor
- Wrong terminal settings
- Flow control enabled
- Bad solder joint
- Boot delay too short
- Wrong key timing

Try:

- Disable flow control
- Use 470 ohm to 1 k ohm series resistor on router RX
- Press menu key repeatedly during boot
- Swap TX/RX if needed
- Confirm adapter works with loopback test

---

## Troubleshooting: U-Boot Does Not Boot Firmware

Possible causes:

- Firmware image corrupted
- Firmware at wrong offset
- Wrong image type
- Kernel checksum failure
- Rootfs missing
- Flash chip read problem
- Bad flash layout
- Firmware too large

Fix:

- Use TFTP firmware recovery if available
- Restore firmware partition with CH341A
- Rebuild firmware for correct layout
- Check boot log for exact failure

---

## Troubleshooting: TFTP Does Not Work From U-Boot

Possible causes:

- Wrong PC IP
- Wrong router IP
- Wrong filename
- TFTP server not running
- Firewall blocking transfer
- Ethernet cable issue
- Bootloader Ethernet not initialized
- U-Boot expects client upload instead of server fetch
- U-Boot expects a different recovery pattern

Fix:

- Use UART prompts
- Use Wireshark
- Set static IP
- Use simple filename
- Use direct Ethernet cable or simple switch
- Disable PC Wi-Fi during recovery
- Confirm TFTP server root folder

---

## Troubleshooting: Reset Button Recovery Does Not Work

Possible causes:

- Bootloader does not support it
- Wrong reset timing
- Button GPIO differs
- Modified U-Boot has wrong GPIO
- Firmware reset behavior confused with bootloader behavior
- Button hardware issue

Fix:

- Use UART menu instead
- Use CH341A if needed
- Document that reset recovery is unsupported on this board

---

## Troubleshooting: Wrong RAM Size Detected

Possible causes:

- Wrong U-Boot
- Bad RAM chip
- Board variant
- Bad bootloader configuration
- Soldering issue
- Wrong board target

If RAM size is wrong after U-Boot replacement, restore original U-Boot or use a correct one.

Do not continue firmware testing with wrong RAM detection.

---

## Troubleshooting: Wrong Flash Size Detected

Possible causes:

- Unsupported flash chip
- Wrong U-Boot
- Bad soldering
- Wrong chip ID
- Flash upgrade issue
- Chip selected incorrectly in programmer
- U-Boot lacks support

Fix:

- Check chip orientation and soldering
- Test chip with CH341A
- Use supported flash chip
- Restore original chip
- Consider correct U-Boot only after hardware is verified

---

## Troubleshooting: Router Hard-Bricked After U-Boot Write

Symptoms:

- No UART output
- No boot menu
- No TFTP
- No normal boot
- LEDs stuck or dim
- Router warms up

Recovery:

1. Remove power.
2. Use CH341A.
3. Read current flash if possible.
4. Save broken dump.
5. Restore original full flash backup.
6. Verify write.
7. Boot with UART.
8. Do not retry the same U-Boot until the cause is known.

---

## U-Boot And Public Repo Policy

Do not commit random U-Boot binaries to the public repo.

Preferred public content:

- Notes
- Checksums
- Source links
- Build instructions
- Metadata
- Warnings
- Board-specific test results

Avoid committing:

- Unknown U-Boot binaries
- Personal full flash dumps
- Factory partitions
- Board-specific data
- U-Boot files with unclear license
- U-Boot files copied from random mirrors

If a U-Boot binary is ever included, it must have metadata and a warning.

---

## U-Boot Binary Metadata Template

Every U-Boot binary reference should include:

```text
File name:
SHA256:
Source:
Author/project:
License:
Target SoC:
Target board:
Target RAM size:
Target flash size:
Known features:
Known issues:
TFTP recovery:
Reset-button recovery:
Tested board IDs:
Risk level:
Notes:
```

---

## U-Boot Warning Label

Any U-Boot binary reference should include this warning:

```text
WARNING:
This is a bootloader image.
Flashing the wrong U-Boot can hard-brick the A5-V11.
Confirm RAM size, flash size, board revision, and recovery method before use.
Back up the original U-Boot first.
```

---

## Recommended U-Boot Development Flow

Use this flow:

1. Identify board.
2. Confirm RAM size.
3. Confirm flash size.
4. Capture stock U-Boot boot log.
5. Back up full flash twice.
6. Extract U-Boot, U-Boot environment, and factory partition.
7. Save checksums.
8. Test normal firmware recovery paths first.
9. Only consider U-Boot replacement if needed.
10. Use known-good U-Boot for exact target.
11. Program with CH341A if possible.
12. Verify write.
13. Boot with UART.
14. Test firmware boot.
15. Test TFTP recovery.
16. Document everything.

---

## Do Not Do This

Do not:

- Flash U-Boot casually
- Flash U-Boot without a backup
- Flash U-Boot without CH341A recovery
- Flash U-Boot from an unknown source
- Flash a 16 MB RAM bootloader to a 32 MB RAM board
- Flash a 32 MB RAM bootloader to an unknown board
- Use old forum instructions blindly
- Select bootloader write options by accident
- Power off during U-Boot write
- Replace U-Boot to fix a normal network config problem
- Replace U-Boot to fix a missing web UI
- Replace U-Boot when firmware partition recovery is enough

---

## Short Version

U-Boot is the A5-V11 bootloader.

It is useful because it can:

- Show UART boot logs
- Detect RAM and flash
- Load firmware
- Provide TFTP recovery
- Provide a boot menu

It is dangerous because flashing the wrong U-Boot can hard-brick the router.

Before touching U-Boot:

```text
Back up full flash twice.
Extract U-Boot.
Extract U-Boot environment.
Extract factory partition.
Confirm RAM size.
Confirm flash size.
Have CH341A recovery ready.
```

For normal firmware problems:

```text
Do not replace U-Boot first.
Recover the firmware partition first.
```

If U-Boot still works, protect it.

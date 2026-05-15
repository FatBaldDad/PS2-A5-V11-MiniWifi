# CH341A Programming

## Summary

This document covers using a CH341A SPI flash programmer to back up, read, erase, write, verify, and recover the SPI flash chip used on the A5-V11 mini router.

The CH341A is useful for:

- Backing up the stock flash
- Recovering from bad firmware
- Recovering from a bad U-Boot flash
- Recovering from a bad OpenWrt image
- Migrating from 4 MB flash to 8 MB or 16 MB flash
- Restoring the factory partition
- Testing firmware images outside the router
- Creating known-good recovery images

The CH341A should be treated as a recovery and development tool, not as a shortcut for guessing.

---

## Important Warning

Do not write anything to the flash chip until the original contents have been backed up and verified.

Before writing:

- Read the chip.
- Save the dump.
- Read the chip again.
- Compare the dumps.
- Confirm the dump size.
- Confirm the chip model.
- Confirm the flash size.
- Confirm the board ID.
- Save the factory partition.
- Save the U-Boot partition.
- Save the U-Boot environment.
- Save checksums.

If the original factory partition is lost, Wi-Fi calibration and MAC address data may be lost.

---

## Main Rule

The main rule is:

```text
Read first. Verify first. Write later.
```

Never erase or write the chip until you have at least two matching reads of the original flash.

---

## What The CH341A Is Used For

The CH341A can access the SPI flash chip directly.

This is useful when the router cannot be recovered by:

- Web UI
- SSH
- Telnet
- OpenWrt sysupgrade
- OpenWrt failsafe
- U-Boot TFTP
- UART commands

A CH341A can recover boards that are otherwise locked out, but only if the flash chip and board hardware are still functional.

---

## When To Use CH341A Recovery

Use CH341A programming when:

- The router has no network access.
- The router has no working web UI.
- SSH and telnet are unavailable.
- U-Boot TFTP recovery does not work.
- Firmware partition is corrupted.
- U-Boot is corrupted.
- A wrong image was flashed.
- The flash chip was upgraded.
- The router has a blank flash chip.
- A known-good full flash image must be restored.
- A partition must be extracted or replaced directly.
- The board is stuck before firmware boot.

Do not use CH341A programming as the first recovery method if UART or TFTP recovery still works.

---

## When Not To Use CH341A Yet

Do not immediately use the CH341A if the problem may only be:

- Wrong IP address
- Wrong Ethernet interface
- Full overlay
- Missing SSH
- Missing LuCI
- Bad network config
- Wi-Fi disabled
- USB not mounted
- PS2 loader launched too early
- PS2 power issue
- Bad internal Ethernet wiring

In those cases, UART or OpenWrt failsafe may be safer.

---

## Tools Needed

Basic tools:

- CH341A programmer
- SOIC-8 test clip or flash socket
- 3.3 V-safe adapter or verified programmer
- Dupont wires
- Multimeter
- USB cable
- Good lighting
- Magnification
- Flux
- Soldering iron
- Hot air station, if removing the chip
- Kapton tape
- ESD-safe work area

Software options:

- AsProgrammer
- NeoProgrammer
- flashrom
- IMSProg
- Colibri
- Other SPI programmer software that supports the chip

Recommended:

- Use more than one program if a read looks suspicious.
- Use checksum comparison.
- Verify every write.

---

## Voltage Warning

Most SPI flash chips on the A5-V11 are 3.3 V devices.

Do not apply 5 V to the flash chip.

Before connecting the CH341A:

- Measure the programmer output.
- Confirm VCC is 3.3 V.
- Confirm the data pins are not being driven at unsafe levels.
- Confirm the adapter board is actually 3.3 V-safe.
- Confirm the clip orientation.
- Confirm the router is not powered separately unless intentionally testing in-circuit behavior.

Some common CH341A boards have confusing 3.3 V labels.

Verify with a meter.

---

## Do Not Power The Router And Programmer At The Same Time

For normal SPI flash programming:

```text
Router power disconnected.
CH341A powers the flash chip.
```

Do not connect PS2 power, USB power, or router micro-USB power while the CH341A is connected unless you specifically know what you are doing.

Powering both at the same time can cause:

- Backfeeding
- Programmer damage
- Router damage
- Bad reads
- Bad writes
- Flash corruption
- Overcurrent
- Unstable logic levels

---

## In-Circuit Versus Out-Of-Circuit Programming

There are two main methods.

| Method | Description |
|---|---|
| In-circuit | Clip connects to flash chip while it is still soldered to the board |
| Out-of-circuit | Flash chip is removed and programmed in a socket or adapter |

---

## In-Circuit Programming

In-circuit programming uses a SOIC-8 clip while the chip remains soldered to the A5-V11 board.

Advantages:

- No hot air needed
- Faster for backup
- Less risk of lifting pads
- Useful for quick reads
- Good for first attempts

Disadvantages:

- Board circuitry can interfere
- SoC may load SPI lines
- Reads may be unreliable
- Writes may fail
- Clip contact can be flaky
- Programmer may not supply enough current to the board
- The chip may not identify correctly

In-circuit programming is convenient, but not always reliable.

---

## Out-Of-Circuit Programming

Out-of-circuit programming removes the flash chip and programs it in a socket.

Advantages:

- Most reliable reads
- Most reliable writes
- Fewer signal conflicts
- Easier to use sockets for testing
- Best for flash upgrades
- Best for repeated development

Disadvantages:

- Requires desoldering
- Risk of lifting pads
- Requires correct chip orientation
- Requires careful reinstallation
- Takes more time

For serious recovery or flash upgrades, out-of-circuit programming is preferred.

---

## Recommended Programming Method

Recommended order:

1. Try in-circuit read only.
2. If two reads match, save them.
3. If reads do not match, remove the chip.
4. Program out-of-circuit.
5. Verify the write.
6. Reinstall the chip.
7. Test UART boot.

Do not trust a single in-circuit read.

---

## Flash Chip Identification

Before reading or writing, identify the chip.

Record:

| Item | Value |
|---|---|
| Chip marking |  |
| Manufacturer |  |
| Flash size |  |
| Package | SOIC-8 or other |
| Voltage | 3.3 V |
| Board ID |  |
| Original firmware state |  |

Common original flash size:

```text
4 MB
```

Common upgraded flash sizes:

```text
8 MB
16 MB
```

---

## Common Flash Sizes

| Flash Size | Bytes | Hex |
|---:|---:|---:|
| 4 MB | 4194304 | 0x400000 |
| 8 MB | 8388608 | 0x800000 |
| 16 MB | 16777216 | 0x1000000 |

A full flash dump must match the chip size.

If the file size does not match the chip size, do not write it as a full flash image.

---

## A5-V11 Typical 4 MB Flash Layout

A common 4 MB OpenWrt-style layout is:

| Partition | Offset | Size | Notes |
|---|---:|---:|---|
| U-Boot | 0x000000 | 0x030000 | Bootloader |
| U-Boot Env | 0x030000 | 0x010000 | Bootloader environment |
| Factory | 0x040000 | 0x010000 | Board-specific data |
| Firmware | 0x050000 | 0x3B0000 | Kernel and rootfs |

Important:

```text
The factory partition is board-specific.
Do not overwrite it unless restoring the same board's backup.
```

---

## 16 MB Flash Layout Warning

A 16 MB flash upgrade needs a firmware layout that understands the larger flash.

Do not assume a 4 MB image will automatically use the full 16 MB.

A 16 MB build may need:

- Correct DTS partition layout
- Correct firmware partition size
- Correct image size
- Correct OpenWrt target/profile
- Correct U-Boot support
- Correct factory partition preservation
- Correct full flash assembly

The 16 MB chip still needs the board-specific factory data.

---

## Factory Partition Warning

The factory partition may contain:

- Wi-Fi calibration data
- RF calibration data
- MAC address
- Board-specific values

Losing this data can cause:

- Wi-Fi not working
- Weak Wi-Fi
- Missing MAC address
- Duplicate MAC address
- Driver errors
- Poor RF performance

Always back up the factory partition before writing anything.

---

## U-Boot Warning

U-Boot is the bootloader.

Writing the wrong U-Boot can hard-brick the router.

Do not write U-Boot unless:

- The original U-Boot has been backed up.
- The replacement is confirmed for the board.
- RAM size is confirmed.
- Flash size is confirmed.
- Recovery method is available.
- The risk is accepted.

Some U-Boot files are associated with RAM size.

Common clue:

```text
128 may indicate 16 MB RAM.
256 may indicate 32 MB RAM.
```

Do not use a 16 MB RAM U-Boot on a 32 MB RAM board unless it is specifically known to work.

---

## Image Type Warning

Do not confuse image types.

| File Type | Use |
|---|---|
| Full flash dump | Program entire SPI chip |
| U-Boot image | Program bootloader partition only |
| Factory partition | Restore factory partition only |
| OpenWrt factory image | First install through compatible stock firmware or bootloader method |
| OpenWrt sysupgrade image | Upgrade from existing OpenWrt |
| Raw firmware partition image | Program firmware partition only when layout is known |

A sysupgrade image is not a full flash image.

A factory image is not always a full flash image.

A full flash dump is not the same as a sysupgrade image.

---

## File Naming Convention

Use clear names.

Recommended:

```text
a5v11-board001-stock-4mb-fullflash-read1.bin
a5v11-board001-stock-4mb-fullflash-read2.bin
a5v11-board001-stock-4mb-factory.bin
a5v11-board001-stock-4mb-uboot.bin
a5v11-board001-16mb-openwrt-test-v0.1-fullflash.bin
```

Avoid:

```text
backup.bin
new.bin
test.bin
working.bin
final.bin
router.bin
```

---

## Backup Folder Structure

Recommended private backup structure:

```text
Private-A5-V11-Backups/
├── board-001/
│   ├── full-flash/
│   │   ├── read1.bin
│   │   ├── read2.bin
│   │   └── verified-stock-fullflash.bin
│   ├── partitions/
│   │   ├── u-boot.bin
│   │   ├── u-boot-env.bin
│   │   ├── factory.bin
│   │   └── firmware.bin
│   ├── checksums/
│   │   ├── fullflash.sha256
│   │   └── partitions.sha256
│   └── notes.md
└── board-002/
```

Do not commit private backups to a public repo.

---

## Git Ignore Recommendation

Add private backups and raw flash dumps to `.gitignore`.

Example:

```text
# Private flash backups
Private-A5-V11-Backups/
Backups/
Recovery/Private/
*.fullflash.bin
*-fullflash*.bin
*-stock-dump*.bin
*-factory*.bin
*-calibration*.bin
```

Be careful not to block intentional public metadata files.

---

## CH341A Pinout

Typical SPI flash pinout:

| Flash Pin | Signal |
|---:|---|
| 1 | CS |
| 2 | DO / MISO |
| 3 | WP |
| 4 | GND |
| 5 | DI / MOSI |
| 6 | CLK |
| 7 | HOLD |
| 8 | VCC |

Common SOIC-8 flash orientation:

```text
        _________
CS   1 |•        | 8 VCC
MISO 2 |         | 7 HOLD
WP   3 |         | 6 CLK
GND  4 |_________| 5 MOSI
```

Pin 1 is usually marked by:

- Dot
- Notch
- Beveled edge
- Printed marker
- Board silkscreen

Always confirm pin 1.

---

## SOIC Clip Orientation

Most SOIC clips have a red wire that indicates pin 1.

Before connecting:

- Find pin 1 on the flash chip.
- Find pin 1 on the clip.
- Find pin 1 on the CH341A adapter.
- Confirm the ribbon cable is not reversed.
- Confirm the socket adapter orientation.

Wrong orientation can damage the chip or programmer.

---

## Basic Read Procedure

Use this procedure before any erase or write.

1. Remove power from the A5-V11.
2. Connect SOIC clip or socket.
3. Confirm pin 1 orientation.
4. Confirm 3.3 V.
5. Open programmer software.
6. Detect chip.
7. Read chip.
8. Save as `read1.bin`.
9. Read chip again.
10. Save as `read2.bin`.
11. Compare files.
12. Generate checksum.
13. Save board notes.

Do not continue until reads match.

---

## Read Verification

Two reads should be identical.

Linux:

```text
cmp read1.bin read2.bin
sha256sum read1.bin read2.bin
```

PowerShell:

```text
Get-FileHash .\read1.bin -Algorithm SHA256
Get-FileHash .\read2.bin -Algorithm SHA256
```

If the hashes do not match, the read is not reliable.

Do not use that dump as a backup.

---

## What A Good Read Looks Like

A good full flash read should:

- Match the expected chip size
- Read consistently twice
- Not be all `FF`
- Not be all `00`
- Contain readable strings
- Contain U-Boot data near the start
- Contain factory data around the factory partition offset
- Contain firmware data after the firmware offset

Useful check:

```text
strings fullflash.bin | less
```

Look for:

```text
U-Boot
OpenWrt
Linux
RT5350
A5-V11
```

Not every dump will show every string, but a totally blank-looking file is suspicious.

---

## Bad Read Symptoms

Bad read signs:

- File is all `FF`
- File is all `00`
- File size is wrong
- Chip ID changes each read
- Each read has different checksum
- Programmer reports unknown chip
- Programmer freezes
- Read fails at same address
- Read succeeds too quickly
- Dump contains random noise
- Router board warms up while connected
- Clip must be pressed hard to read

Fix before writing.

---

## Fixing Bad Reads

Try:

- Re-seat SOIC clip.
- Clean chip legs with alcohol.
- Use flux and clean if needed.
- Shorten wires.
- Use a different USB port.
- Use a powered USB hub if needed.
- Try another programmer program.
- Try slower SPI speed if available.
- Remove router power completely.
- Remove flash chip and program out-of-circuit.
- Check for board circuitry loading the SPI bus.
- Verify programmer voltage.

Do not write until reads are stable.

---

## Extracting Partitions From A Full Dump

Use offsets to extract partitions.

For a typical 4 MB layout:

| Partition | Offset | Size |
|---|---:|---:|
| U-Boot | 0x000000 | 0x030000 |
| U-Boot Env | 0x030000 | 0x010000 |
| Factory | 0x040000 | 0x010000 |
| Firmware | 0x050000 | 0x3B0000 |

Linux `dd` examples:

```text
dd if=fullflash.bin of=u-boot.bin bs=1 skip=$((0x000000)) count=$((0x030000))
dd if=fullflash.bin of=u-boot-env.bin bs=1 skip=$((0x030000)) count=$((0x010000))
dd if=fullflash.bin of=factory.bin bs=1 skip=$((0x040000)) count=$((0x010000))
dd if=fullflash.bin of=firmware.bin bs=1 skip=$((0x050000)) count=$((0x3B0000))
```

PowerShell extraction can be done with scripts, but Linux is usually simpler for this work.

---

## Building A 16 MB Full Flash Image

A 16 MB full flash image must be assembled carefully.

Typical concept:

```text
0x000000 - U-Boot
0x030000 - U-Boot environment
0x040000 - Factory partition from same board
0x050000 - Firmware partition sized for 16 MB layout
```

Important:

- Preserve same-board factory data.
- Do not overwrite factory with another board's data.
- Confirm firmware partition size.
- Confirm OpenWrt build expects 16 MB flash.
- Confirm full image is exactly 16 MB.
- Confirm U-Boot can boot the image.
- Confirm recovery method before installing.

---

## Padding A Full Flash Image

A full flash image must be the exact size of the target chip.

| Target Chip | Full Image Size |
|---|---:|
| 4 MB chip | 4194304 bytes |
| 8 MB chip | 8388608 bytes |
| 16 MB chip | 16777216 bytes |

If the image is too small, it may need padding with `0xFF`.

Do not pad blindly unless the layout is understood.

---

## Erase Procedure

Only erase after a verified backup exists.

General process:

1. Confirm correct chip selected.
2. Confirm correct image selected.
3. Confirm image size.
4. Confirm backup exists.
5. Erase chip.
6. Blank check.
7. Write image.
8. Verify image.

If erase fails, stop and troubleshoot.

---

## Write Procedure

General process:

1. Load the intended image.
2. Confirm file size.
3. Confirm target chip size.
4. Confirm chip ID.
5. Erase chip.
6. Blank check.
7. Write image.
8. Verify.
9. Read back again.
10. Compare readback to original image.

The write is not complete until verify passes.

---

## Post-Write Verification

After writing, read the chip back and compare.

Linux:

```text
cmp intended-image.bin readback-after-write.bin
sha256sum intended-image.bin readback-after-write.bin
```

PowerShell:

```text
Get-FileHash .\intended-image.bin -Algorithm SHA256
Get-FileHash .\readback-after-write.bin -Algorithm SHA256
```

If verify fails, do not install the chip.

---

## First Boot After Programming

After programming:

1. Disconnect CH341A.
2. Inspect chip orientation.
3. Inspect solder joints.
4. Check for shorts.
5. Power from a known-good 5 V source.
6. Connect UART.
7. Boot router.
8. Capture complete UART log.
9. Confirm flash chip detected.
10. Confirm partitions detected.
11. Confirm kernel boots.
12. Confirm Ethernet works.
13. Confirm Wi-Fi works if expected.
14. Confirm factory data is valid.

Do not install inside PS2 until bench boot passes.

---

## UART Expected Basics

A healthy boot should show some form of:

- U-Boot banner
- RAM size
- SPI flash detection
- Boot menu or boot countdown
- Kernel load
- Kernel start
- Flash partitions
- OpenWrt or stock firmware boot
- Network init

If UART shows nothing, check:

- UART wiring
- Baud rate
- Flash chip
- U-Boot
- Power

---

## flashrom Examples

Example read command:

```text
flashrom -p ch341a_spi -r read1.bin
flashrom -p ch341a_spi -r read2.bin
```

Example verify by compare:

```text
cmp read1.bin read2.bin
sha256sum read1.bin read2.bin
```

Example write command:

```text
flashrom -p ch341a_spi -w fullflash.bin
```

Example verify command:

```text
flashrom -p ch341a_spi -v fullflash.bin
```

Actual programmer names and command options may vary by system.

---

## Windows Software Notes

Common Windows options include:

- AsProgrammer
- NeoProgrammer
- Colibri
- CH341A Programmer variants

Recommended Windows workflow:

1. Detect chip.
2. Read.
3. Save as read1.
4. Read again.
5. Save as read2.
6. Compare hashes.
7. Save backup.
8. Only then erase/write.
9. Verify after write.
10. Read back and compare.

Do not trust a successful popup alone.

Always read back and compare.

---

## Backup Checklist

Before writing anything:

| Check | Done |
|---|---|
| Board ID assigned |  |
| Chip marking recorded |  |
| Flash size confirmed |  |
| First full read saved |  |
| Second full read saved |  |
| Reads compared |  |
| SHA256 saved |  |
| U-Boot extracted |  |
| U-Boot environment extracted |  |
| Factory partition extracted |  |
| Firmware partition extracted |  |
| Backup copied to safe location |  |
| Notes created |  |

---

## Write Checklist

Before writing:

| Check | Done |
|---|---|
| Correct target chip selected |  |
| Correct voltage confirmed |  |
| Correct image selected |  |
| Image size matches chip size |  |
| Image source documented |  |
| Factory partition preserved |  |
| U-Boot risk understood |  |
| Recovery plan exists |  |
| Backup verified |  |
| Board powered only by programmer |  |
| Clip/socket orientation correct |  |

After writing:

| Check | Done |
|---|---|
| Erase completed |  |
| Blank check passed |  |
| Write completed |  |
| Verify passed |  |
| Readback saved |  |
| Readback matches image |  |
| UART boot captured |  |
| Ethernet tested |  |
| Wi-Fi tested |  |
| Notes updated |  |

---

## Common CH341A Problems

## Problem: Chip Not Detected

Possible causes:

- Clip backwards
- Poor clip contact
- Wrong chip selected
- No 3.3 V
- Router still powered
- Flash chip damaged
- Board loading SPI bus
- Programmer driver issue
- Bad USB cable
- Wrong software

Try:

- Re-seat clip.
- Confirm pin 1.
- Measure VCC at flash chip.
- Try another USB port.
- Try another program.
- Remove chip and use socket.
- Inspect solder joints.

---

## Problem: Reads Are Different Every Time

Possible causes:

- Bad clip contact
- Long wires
- In-circuit interference
- Wrong voltage
- Software bug
- Chip not held correctly
- Board partially powered

Fix:

- Re-seat clip.
- Clean chip legs.
- Shorten wires.
- Try out-of-circuit programming.
- Verify power is off.
- Try slower SPI speed.
- Try different software.

Do not write if reads are inconsistent.

---

## Problem: Dump Is All FF

Possible causes:

- No chip contact
- MISO not connected
- Wrong clip orientation
- Chip not powered
- Wrong chip selection
- Empty chip
- Bad programmer

Check:

- VCC
- GND
- Pin 1
- Clip pressure
- Chip ID
- Another read method

---

## Problem: Dump Is All 00

Possible causes:

- Bad contact
- Shorted data line
- Wrong voltage
- Chip damaged
- Programmer issue
- Board interference

Check:

- Clip orientation
- Shorts
- Chip power
- Use socket programming

---

## Problem: Write Fails

Possible causes:

- Write protect active
- Bad chip contact
- Wrong chip selected
- Bad voltage
- Chip not erased
- In-circuit interference
- Flash chip bad
- Programmer cannot supply stable power

Try:

- Erase first.
- Blank check.
- Re-seat clip.
- Use socket.
- Select exact chip.
- Try another program.
- Replace flash chip.

---

## Problem: Verify Fails

Possible causes:

- Bad write
- Bad readback
- Clip moved
- Chip damaged
- Wrong image size
- Wrong chip selected
- In-circuit interference

Fix:

- Read again.
- Re-seat clip.
- Erase/write/verify again.
- Use out-of-circuit programming.
- Replace chip if failures repeat.

---

## Problem: Router Still Does Not Boot After Verified Write

Possible causes:

- Wrong image type
- Wrong flash layout
- Wrong U-Boot
- Wrong RAM-size bootloader
- Wrong flash-size firmware
- Missing factory data
- Bad soldering after reinstall
- Chip installed backwards
- Power issue
- UART wiring issue
- Hardware damage

Check:

- UART boot log.
- Chip orientation.
- Solder joints.
- Flash size.
- Image size.
- U-Boot partition.
- Factory partition.
- Firmware offset.
- Power rail.

---

## Problem: Router Boots But Wi-Fi Does Not Work

Possible causes:

- Factory partition missing
- Factory partition from wrong board
- RF calibration lost
- Wi-Fi disabled in firmware
- Antenna disconnected
- Wrong firmware build
- Wireless package missing

Check:

- Factory partition restored from same board.
- UART/kernel logs.
- `wifi status`
- `iwinfo`
- Antenna connection.
- RF shield/antenna placement.

---

## Problem: Router Boots But Ethernet Does Not Work

Possible causes:

- Wrong OpenWrt network interface
- `eth0` vs `eth0.1`
- Wrong config
- Bad firmware build
- Ethernet PHY disabled
- Bad internal wiring
- Bad transformer/RJ45
- Power problem

Check through UART:

```text
ip addr
ifconfig
cat /etc/config/network
logread
dmesg | grep eth
```

---

## Problem: Flash Upgrade Shows Only 4 MB

Possible causes:

- Bootloader only detects original size
- Kernel DTS still uses 4 MB layout
- Firmware partition still 4 MB
- Wrong OpenWrt build
- Wrong chip selected during programming
- Bad soldering
- Chip ID not supported

Check:

- U-Boot flash detection
- Kernel flash detection
- OpenWrt partition table
- DTS layout
- Image size
- Chip ID

---

## Problem: Router Hangs After Hard Reboot

Possible causes:

- Power ramp issue
- Reset timing issue
- Capacitors not discharging
- Supervisor IC needed
- USB drive startup load
- Brownout

Possible fixes:

- Wait 5 seconds after removing power.
- Add MAX809TTR or ADM809 supervisor.
- Improve 5 V supply.
- Test without USB drive.
- Add proper capacitance.
- Capture UART boot log.

---

## CH341A Recovery Flow

Use this flow for recovery:

1. Remove router from PS2 if installed.
2. Power router from bench supply and check symptoms.
3. Connect UART and check output.
4. If UART is dead or firmware cannot recover, prepare CH341A.
5. Read current flash before overwriting.
6. Save broken dump for analysis.
7. Compare against backup.
8. Decide whether to restore:
   - Firmware partition only
   - Factory partition only
   - U-Boot only
   - Full flash
9. Program the minimum needed fix.
10. Verify.
11. Boot on bench with UART.
12. Test Ethernet and Wi-Fi.
13. Only then reinstall or continue PS2 testing.

---

## Minimum Recovery Principle

Use the least destructive recovery method.

Preferred order:

| Recovery Target | When To Use |
|---|---|
| Network config reset | Router boots but network is wrong |
| Firmware partition restore | U-Boot works but firmware is bad |
| Factory partition restore | Factory data was corrupted |
| U-Boot restore | Bootloader is corrupted |
| Full flash restore | Multiple partitions are damaged or unknown |

Do not write a full flash image when only the firmware partition is broken.

---

## Full Flash Restore Warning

A full flash restore overwrites everything.

It may overwrite:

- U-Boot
- U-Boot environment
- Factory partition
- MAC address
- Wi-Fi calibration
- RF calibration
- Firmware

Only restore a full flash image if:

- It belongs to the same board, or
- It was intentionally assembled with the correct same-board factory data, and
- The flash size matches exactly, and
- The risk is understood.

---

## Same-Board Rule

Use this rule:

```text
Factory data should come from the same physical board.
```

Do not copy another board's factory partition unless you understand:

- MAC address duplication
- Wi-Fi calibration mismatch
- RF performance issues
- Legal/regulatory concerns
- Debugging confusion

---

## Known-Good Recovery Image

A known-good recovery image should be:

- Built for the exact flash size
- Built for the exact board target
- Tested on bench
- UART verified
- Ethernet verified
- Wi-Fi verified if needed
- Documented
- Checksummed
- Stored with metadata

Metadata should include:

```text
File name:
SHA256:
Board ID:
Flash size:
RAM size:
Firmware source:
Build date:
Image type:
Install method:
Recovery method:
Test result:
Known issues:
```

---

## CH341A Programming Record Template

Use this template for each programming session.

```text
# CH341A Programming Record

## Session Info

Date:
Tester:
Board ID:
Reason for programming:
Programming method:
Software used:
Programmer model:

## Flash Chip

Chip marking:
Detected chip:
Package:
Voltage:
Original size:
Target size:

## Backup

Read 1 file:
Read 2 file:
Read 1 SHA256:
Read 2 SHA256:
Reads match:
U-Boot extracted:
U-Boot env extracted:
Factory extracted:
Firmware extracted:

## Write

Image written:
Image type:
Image size:
Image SHA256:
Erase passed:
Blank check passed:
Write passed:
Verify passed:
Readback file:
Readback matches image:

## Post-Write Test

UART output:
U-Boot detected:
Kernel boots:
OpenWrt boots:
Ethernet works:
Wi-Fi works:
USB works:
Default IP:
Notes:

## Result

Pass/fail:
Known issues:
Next step:
```

---

## Suggested Photos

Take photos of:

- A5-V11 board before removal
- Flash chip marking
- Pin 1 orientation
- SOIC clip attached
- CH341A jumper setting or voltage adapter
- Software detecting chip
- Flash chip removed, if removed
- Flash chip in socket
- Reinstalled flash chip
- UART boot after recovery

Suggested file names:

```text
ch341a-board001-flash-chip.jpg
ch341a-board001-pin1-orientation.jpg
ch341a-board001-soic-clip.jpg
ch341a-board001-chip-detect.jpg
ch341a-board001-verify-pass.jpg
ch341a-board001-uart-boot.jpg
```

---

## Safe Development Workflow For 16 MB Flash Upgrade

Recommended flow:

1. Back up original 4 MB chip.
2. Verify two matching 4 MB reads.
3. Extract factory partition.
4. Extract U-Boot and U-Boot environment.
5. Save checksums.
6. Program a 16 MB chip externally.
7. Include same-board factory data.
8. Use firmware built for 16 MB layout.
9. Verify full 16 MB write.
10. Install 16 MB chip.
11. Boot with UART connected.
12. Confirm U-Boot detects flash.
13. Confirm kernel sees partitions.
14. Confirm OpenWrt boots.
15. Confirm Ethernet.
16. Confirm Wi-Fi.
17. Save new 16 MB full flash dump.
18. Document everything.

---

## Do Not Do This

Avoid these mistakes:

- Do not write before reading.
- Do not trust one backup read.
- Do not ignore mismatched hashes.
- Do not power router and programmer at the same time.
- Do not use 5 V logic on 3.3 V flash.
- Do not reverse the SOIC clip.
- Do not write a sysupgrade image as a full flash image.
- Do not overwrite factory data casually.
- Do not flash random U-Boot files.
- Do not use wrong RAM-size U-Boot.
- Do not assume in-circuit writes are reliable.
- Do not reinstall a chip until verify passes.
- Do not install inside PS2 until bench boot passes.

---

## Short Version

The CH341A is the main hard-recovery tool for the A5-V11.

The safe process is:

```text
Read twice.
Compare.
Save backup.
Extract factory data.
Confirm image type.
Erase.
Write.
Verify.
Read back.
Compare.
Boot with UART.
```

Protect these above everything else:

- U-Boot
- U-Boot environment
- Factory partition
- MAC address
- Wi-Fi calibration
- RF calibration

If UART still works, use it.

If U-Boot still works, avoid rewriting it.

If the factory partition is intact, preserve it.

For 16 MB flash upgrades, build and write an image made for the 16 MB layout, while keeping the original same-board factory data.

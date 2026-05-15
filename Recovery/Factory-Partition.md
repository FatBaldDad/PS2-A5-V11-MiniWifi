# Factory Partition

## Summary

This document covers the A5-V11 factory partition.

The factory partition is one of the most important parts of the A5-V11 flash layout because it may contain board-specific data required for Wi-Fi and network identity.

It should be treated as private, board-specific calibration data.

Do not erase it.

Do not replace it with another board's factory partition unless you fully understand the consequences.

Do not upload personal factory partitions to a public repo.

---

## Main Rule

The main rule is:

```text
Always back up the factory partition before changing firmware or flash chips.
```

The second rule is:

```text
Factory data should come from the same physical board.
```

---

## Why The Factory Partition Matters

The factory partition may contain:

- Wi-Fi calibration data
- RF calibration data
- MAC address data
- Board-specific hardware values
- Wireless EEPROM data
- Device identity data

If this data is missing or wrong, the router may still boot, but Wi-Fi may be broken or unreliable.

---

## Common Symptoms Of Factory Partition Problems

Possible symptoms include:

- Wi-Fi does not appear
- No SSID
- Wi-Fi driver errors
- Wi-Fi will not start
- Wi-Fi range is very poor
- Wi-Fi connects but is unstable
- MAC address is missing
- MAC address is duplicated
- OpenWrt complains about EEPROM data
- OpenWrt complains about calibration data
- Router boots but wireless is unusable
- 16 MB flash upgrade boots but Wi-Fi fails
- Ethernet works but Wi-Fi does not

These symptoms may also have other causes, but factory partition damage should be checked if Wi-Fi breaks after flashing.

---

## Typical A5-V11 Flash Layout

A common 4 MB A5-V11 flash layout is:

| Partition | Offset | Size | Notes |
|---|---:|---:|---|
| U-Boot | `0x000000` | `0x030000` | Bootloader |
| U-Boot Env | `0x030000` | `0x010000` | Bootloader environment |
| Factory | `0x040000` | `0x010000` | Board-specific data |
| Firmware | `0x050000` | `0x3B0000` | Kernel and root filesystem |

The common factory partition location is:

```text
Offset: 0x040000
Size:   0x010000
```

That is 64 KB.

Always confirm the flash layout on the exact board and firmware before writing.

---

## Factory Partition Offset

For the common 4 MB layout:

```text
Factory partition start: 0x040000
Factory partition size:  0x010000
```

Decimal values:

| Value | Decimal |
|---|---:|
| `0x040000` | 262144 |
| `0x010000` | 65536 |

---

## Important Warning

Do not assume every A5-V11 variant has the exact same layout.

Before writing anything, confirm:

- Board marking
- Flash chip size
- Current partition layout
- U-Boot log
- OpenWrt `/proc/mtd`
- Original full flash dump
- Factory partition offset and size

If the layout differs, update the commands before using them.

---

## Factory Partition Is Not Normal Firmware

The factory partition is not the same thing as firmware.

| Item | Purpose |
|---|---|
| Firmware partition | Contains Linux kernel and root filesystem |
| Factory partition | Contains board-specific calibration and identity data |
| U-Boot partition | Contains bootloader |
| U-Boot environment | Contains bootloader settings |

You should not replace the factory partition when updating normal firmware.

---

## Same-Board Rule

Use this rule:

```text
The factory partition restored to a board should come from that same board.
```

Do not casually copy a factory partition from another A5-V11.

Possible problems from using another board's factory data:

- Duplicate MAC address
- Wrong RF calibration
- Poor Wi-Fi range
- Unstable Wi-Fi
- Regulatory mismatch
- Confusing test results
- Two routers with the same network identity

---

## Public Repo Policy

Do not commit personal factory partitions to the public repo.

Factory partitions may contain:

- MAC addresses
- RF calibration data
- Board-specific information

The repo should document:

- What the factory partition is
- Why it matters
- How to back it up
- How to verify it
- How to restore it
- How to preserve it during flash upgrades

The repo should not become a collection of random factory partitions.

---

## Private Backup Policy

Factory partition backups should be stored privately.

Recommended private structure:

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
│   │   └── factory.sha256
│   └── notes.md
```

Use a unique board ID for each physical router.

---

## Recommended File Names

Use clear names.

Good examples:

```text
a5v11-board001-stock-4mb-factory.bin
a5v11-board001-stock-4mb-factory.sha256
a5v11-board001-16mb-migration-factory.bin
```

Avoid vague names:

```text
factory.bin
backup.bin
good.bin
wifi.bin
calibration.bin
```

A generic file name is easy to mix up later.

---

## Backup Before Any Firmware Work

Before flashing OpenWrt, upgrading flash, or changing U-Boot, back up:

- Full flash
- U-Boot
- U-Boot environment
- Factory partition
- Firmware partition

Minimum required backup:

```text
Full flash dump
Factory partition
```

Best backup:

```text
Two matching full flash dumps
Extracted partitions
SHA256 checksums
Board photos
UART boot log
Board notes
```

---

## Backup Method 1: CH341A Full Flash Dump

The safest backup method is to read the entire SPI flash chip with a CH341A or similar programmer.

Recommended process:

1. Disconnect power from the A5-V11.
2. Connect CH341A to the SPI flash.
3. Confirm 3.3 V.
4. Confirm pin 1 orientation.
5. Read the chip.
6. Save as `read1.bin`.
7. Read the chip again.
8. Save as `read2.bin`.
9. Compare both reads.
10. Save checksums.
11. Extract the factory partition.

Do not continue until the reads match.

---

## Verify Full Flash Reads

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

The hashes should match.

If the hashes do not match, the backup is not reliable.

---

## Backup Method 2: Extract Factory Partition From Full Dump

For the common 4 MB layout, extract the factory partition from a full flash dump with:

```text
dd if=verified-stock-fullflash.bin of=a5v11-board001-factory.bin bs=1 skip=$((0x040000)) count=$((0x010000))
```

Verify file size:

```text
ls -l a5v11-board001-factory.bin
```

Expected size:

```text
65536 bytes
```

Generate checksum:

```text
sha256sum a5v11-board001-factory.bin > a5v11-board001-factory.sha256
```

---

## Backup Method 3: OpenWrt `mtd` Read

If OpenWrt is already running and the factory partition is exposed, it may be possible to read it from Linux.

Check partitions:

```text
cat /proc/mtd
```

Example output may show something like:

```text
mtd0: 00030000 00010000 "u-boot"
mtd1: 00010000 00010000 "u-boot-env"
mtd2: 00010000 00010000 "factory"
mtd3: 003b0000 00010000 "firmware"
```

If the factory partition is `mtd2`, backup with:

```text
cat /dev/mtd2 > /tmp/factory.bin
```

Then copy it off the router.

Example using `scp`:

```text
scp root@192.168.1.1:/tmp/factory.bin ./a5v11-board001-factory.bin
```

Then checksum it:

```text
sha256sum a5v11-board001-factory.bin
```

---

## Warning About `mtd` Numbers

Do not assume the factory partition is always `mtd2`.

Always run:

```text
cat /proc/mtd
```

and confirm the partition name.

The `mtd` number can change depending on firmware layout.

---

## Backup Method 4: U-Boot Or UART

Some bootloaders or stock firmware environments may allow reading flash over UART or network, but this is more advanced.

Use this only if:

- You understand the command
- You know the offsets
- You know the sizes
- You can copy the data safely
- You have verified the result

For most users, CH341A or OpenWrt `mtd` read is safer.

---

## What A Factory Partition Backup Should Look Like

A good factory partition backup should:

- Be exactly 64 KB for the common A5-V11 layout
- Not be all `FF`
- Not be all `00`
- Have a stable checksum
- Come from the same board
- Be stored with board notes
- Be copied to more than one safe location

Check file size:

```text
ls -l a5v11-board001-factory.bin
```

Check for obvious blank data:

```text
hexdump -C a5v11-board001-factory.bin | head
hexdump -C a5v11-board001-factory.bin | tail
```

---

## Bad Factory Backup Signs

Bad signs:

- File is all `FF`
- File is all `00`
- File size is not 65536 bytes
- File was extracted from the wrong offset
- File came from another board
- Hash changes between reads
- Full flash dump was not verified
- Backup was made after a bad flash event
- Backup was made after factory data may already have been overwritten

If the backup is suspicious, do not use it blindly.

---

## Factory Partition And 16 MB Flash Upgrades

When upgrading from 4 MB flash to 16 MB flash, the factory partition should still be preserved.

The common concept is:

```text
0x000000 - U-Boot
0x030000 - U-Boot environment
0x040000 - Factory partition from same board
0x050000 - Firmware partition
```

The firmware partition may become larger, but the factory partition should stay at the expected location unless the bootloader and firmware are intentionally changed to use another layout.

---

## 16 MB Migration Rule

For 16 MB migration:

```text
Use the original same-board factory partition.
```

Do not use a random factory partition from another dump.

Do not leave the factory area blank.

Do not overwrite it with firmware.

---

## 16 MB Migration Checklist

Before installing a 16 MB flash chip:

| Check | Done |
|---|---|
| Original 4 MB flash read twice |  |
| Reads match |  |
| Full backup saved |  |
| Factory partition extracted |  |
| Factory partition checksum saved |  |
| U-Boot extracted |  |
| U-Boot environment extracted |  |
| 16 MB firmware layout confirmed |  |
| Factory partition placed at correct offset |  |
| Full 16 MB image is exactly 16777216 bytes |  |
| Full image verified after write |  |
| UART boot tested |  |
| Wi-Fi tested after boot |  |

---

## Restoring Factory Partition

Only restore a factory partition when:

- It belongs to the same board
- The current factory partition is missing or damaged
- You are building a new full flash image
- You are migrating to a larger flash chip
- You know the exact offset and size

---

## Restore Method 1: Restore During Full Image Assembly

This is usually the cleanest method for a flash upgrade.

Build a full flash image where the factory partition is inserted at the correct offset.

Common 4 MB / 16 MB concept:

```text
U-Boot at 0x000000
U-Boot environment at 0x030000
Factory at 0x040000
Firmware at 0x050000
```

Then program the complete image with CH341A and verify.

---

## Restore Method 2: Write Factory Partition With Programmer

If using a programmer or hex editor, write the factory partition only to the factory region.

For common layout:

```text
Offset: 0x040000
Size:   0x010000
```

Be careful.

Writing to the wrong offset can corrupt U-Boot, U-Boot environment, or firmware.

---

## Restore Method 3: OpenWrt `mtd` Write

This is risky and should only be done if the factory partition is exposed and you know exactly what you are doing.

First check:

```text
cat /proc/mtd
```

If the factory partition is definitely exposed as `factory`, use the correct MTD partition.

Example concept only:

```text
mtd write /tmp/factory.bin factory
```

Warning:

Do not run this unless you are certain the file and target are correct.

A bad write can break Wi-Fi calibration or worse.

---

## Factory Partition Verification After Restore

After restoring, boot the router and check:

```text
cat /proc/mtd
dmesg
logread
wifi status
iwinfo
ifconfig
ip addr
```

Test:

- Wi-Fi starts
- Wi-Fi scans
- Wi-Fi connects
- MAC address looks valid
- Ethernet works
- No RF calibration errors appear
- Signal strength is reasonable

---

## MAC Address Check

After restoring factory data, check MAC addresses.

Commands may include:

```text
ifconfig
ip link
cat /sys/class/net/eth0/address
cat /sys/class/net/wlan0/address
```

Interface names may vary.

Record the MAC addresses in private board notes.

Do not publish private MAC addresses in the public repo unless intentionally redacted.

---

## Wi-Fi Check After Factory Restore

Check Wi-Fi status:

```text
wifi status
iwinfo
logread | grep wlan
logread | grep wifi
dmesg | grep rt2
```

Not every command exists on every build.

Basic pass criteria:

- Wireless interface exists
- Wi-Fi can scan
- Wi-Fi can start AP or STA mode
- Signal strength is reasonable
- No EEPROM/calibration errors appear
- MAC address is not blank or duplicated

---

## Factory Partition In Public Documentation

Public documentation should use placeholders.

Good public examples:

```text
a5v11-board001-factory.bin
<your-board-factory.bin>
<same-board-factory-partition>
```

Avoid publishing real values:

```text
Real MAC address
Real private dump
Real factory partition binary
```

---

## Redaction Notes

If posting logs publicly, redact:

- MAC addresses
- SSIDs
- Wi-Fi passwords
- Private IP details if needed
- Serial numbers
- Personal paths
- Any board-specific identity data

Example redaction:

```text
MAC: XX:XX:XX:XX:XX:XX
SSID: <redacted>
```

---

## How Factory Data Can Be Lost

Factory data can be lost by:

- Erasing the full flash chip
- Writing a full image without factory data
- Writing firmware at the wrong offset
- Flashing another board's full dump
- Using a bad 16 MB image
- Using the wrong partition layout
- Running the wrong `mtd write`
- Mistaking factory image for full flash image
- Programmer write to the wrong address
- Accidental erase before backup
- Bad flash chip migration

---

## Factory Partition Protection During Builds

When building OpenWrt, make sure the firmware image does not overlap the factory partition.

The firmware should start after the factory partition.

For the common layout:

```text
Firmware starts at 0x050000
```

That means:

```text
0x000000 - 0x04FFFF is not normal firmware space
```

Do not place kernel/rootfs over the factory region.

---

## Firmware Partition Size Reminder

For a 4 MB flash with firmware starting at `0x050000`:

```text
Total flash:       0x400000
Firmware start:    0x050000
Firmware max size: 0x3B0000
```

For a 16 MB flash with firmware starting at `0x050000`:

```text
Total flash:       0x1000000
Firmware start:    0x050000
Firmware max size: 0xFB0000
```

This is the concept behind expanding firmware space while preserving early partitions.

Always confirm the actual DTS/layout.

---

## Factory Partition And U-Boot

U-Boot may read factory data or use MAC address information depending on board and bootloader configuration.

Do not assume factory data is only used by Linux.

If U-Boot environment or factory data is damaged, boot messages or network recovery may behave differently.

---

## Factory Partition And Wi-Fi Antenna Problems

Poor Wi-Fi is not always a factory partition problem.

Other possible causes:

- Antenna disconnected
- Antenna solder joint broken
- Antenna blocked by PS2 RF shield
- Antenna too close to metal
- Bad Wi-Fi config
- Wrong country/channel settings
- Weak home Wi-Fi signal
- Power instability
- Heat

Check hardware and firmware before assuming the factory data is bad.

---

## Factory Partition And PS2 Internal Builds

For PS2 internal installs, the factory partition matters because Wi-Fi bridge behavior may depend on it.

A board with damaged factory data may:

- Work over Ethernet
- Fail Wi-Fi bridge mode
- Have weak internal Wi-Fi range
- Be hard to diagnose after installation

Always test Wi-Fi before installing inside a PS2.

---

## Factory Partition Test Checklist

After any flash change, test:

| Test | Result |
|---|---|
| Router boots |  |
| Factory partition exists |  |
| MAC address present |  |
| Ethernet works |  |
| Wi-Fi interface exists |  |
| Wi-Fi can scan |  |
| Wi-Fi can connect |  |
| Signal strength reasonable |  |
| No calibration errors |  |
| Factory checksum saved |  |
| UART log saved |  |

---

## Factory Partition Backup Checklist

Before any risky operation:

| Check | Done |
|---|---|
| Board ID assigned |  |
| Board photos taken |  |
| Flash size confirmed |  |
| Full flash read 1 saved |  |
| Full flash read 2 saved |  |
| Full flash reads match |  |
| Factory partition extracted |  |
| Factory partition file size confirmed |  |
| Factory partition checksum saved |  |
| Backup copied to safe location |  |
| Notes updated |  |

---

## Factory Partition Restore Checklist

Before restoring:

| Check | Done |
|---|---|
| Restore file belongs to same board |  |
| File size is 65536 bytes for common layout |  |
| SHA256 matches saved backup |  |
| Target offset confirmed |  |
| Target flash layout confirmed |  |
| Current flash backed up before restore |  |
| Programmer or command method confirmed |  |
| Recovery plan exists |  |

After restoring:

| Check | Done |
|---|---|
| Write verified |  |
| Router boots |  |
| Wi-Fi interface appears |  |
| Wi-Fi scans |  |
| Wi-Fi connects |  |
| MAC address looks valid |  |
| No calibration errors |  |
| New full flash backup saved |  |

---

## Factory Partition Record Template

Use this template in private board notes.

```text
# Factory Partition Record

## Board Info

Board ID:
PCB marking:
SoC:
RAM chip:
RAM size:
Flash chip:
Flash size:
Stock firmware state:

## Factory Partition

Factory offset:
Factory size:
Backup file:
Backup SHA256:
Backup method:
Backup date:
Extracted from full dump:
Full dump SHA256:

## MAC / Identity

Ethernet MAC:
Wi-Fi MAC:
Notes:

## Verification

File size correct:
Not all FF:
Not all 00:
Wi-Fi tested:
Wi-Fi scan works:
Wi-Fi connects:
Signal strength:
Calibration errors:

## Restore History

Restored:
Restore date:
Restore method:
Restored to flash size:
Post-restore Wi-Fi result:
Notes:
```

Keep this record private if it includes MAC addresses.

---

## Example Extraction Notes

Example for board `board-001` using the common layout:

```text
Input full dump:
a5v11-board001-stock-4mb-fullflash.bin

Factory offset:
0x040000

Factory size:
0x010000

Command:
dd if=a5v11-board001-stock-4mb-fullflash.bin of=a5v11-board001-stock-4mb-factory.bin bs=1 skip=$((0x040000)) count=$((0x010000))

Expected output size:
65536 bytes
```

---

## Troubleshooting: Wi-Fi Missing After Flash

Check:

- Did firmware overwrite factory partition?
- Is factory partition still present?
- Was factory data copied from the same board?
- Does `/proc/mtd` show factory?
- Does `dmesg` show calibration errors?
- Does `wifi status` show a radio?
- Is the antenna connected?
- Is the firmware wireless config valid?
- Does Ethernet still work?

---

## Troubleshooting: MAC Address Wrong

Possible causes:

- Factory partition from another board
- Factory partition blank
- U-Boot environment changed
- Firmware using fallback MAC
- OpenWrt config overriding MAC
- Full flash image copied from another unit

Fix:

- Restore same-board factory partition
- Check U-Boot environment
- Check OpenWrt network config
- Check board notes

---

## Troubleshooting: 16 MB Flash Boots But Wi-Fi Fails

Possible causes:

- Factory partition missing
- Factory partition at wrong offset
- Firmware DTS expects factory elsewhere
- Factory data copied incorrectly
- Factory data from another board
- Wireless package missing
- Wi-Fi config missing
- Antenna problem

Check:

```text
cat /proc/mtd
dmesg
logread
wifi status
iwinfo
```

Verify the factory partition was inserted at the expected offset.

---

## Troubleshooting: Factory Backup File Size Wrong

Expected size for common layout:

```text
65536 bytes
```

If wrong, check:

- `dd` skip value
- `dd` count value
- Full dump size
- Flash layout
- Whether `bs=1` was used
- Whether shell math worked correctly
- Whether file was truncated during copy

Do not restore a wrong-size factory file.

---

## Troubleshooting: Factory Backup Is All FF Or All 00

Possible causes:

- Wrong offset
- Bad full flash dump
- Bad programmer read
- Empty or damaged partition
- Wrong flash layout
- Clip contact problem

Fix:

- Re-read full flash
- Compare two reads
- Check offsets
- Check `/proc/mtd` if router still boots
- Try out-of-circuit read
- Check another known-good board only for comparison, not for copying data

---

## Do Not Do This

Avoid these mistakes:

- Do not erase flash before backing up factory data.
- Do not upload factory partitions publicly.
- Do not use another board's factory data casually.
- Do not write firmware over `0x040000`.
- Do not assume factory partition is always `mtd2`.
- Do not restore a factory file with the wrong size.
- Do not restore a factory file with mismatched checksum.
- Do not assume Wi-Fi failure is only software.
- Do not perform 16 MB migration without preserving factory data.
- Do not use a full flash dump from another board as-is.

---

## Recommended Recovery Order For Factory Problems

If factory data may be damaged:

1. Stop flashing.
2. Save the current flash dump.
3. Check whether an original backup exists.
4. Verify the factory backup checksum.
5. Confirm board ID.
6. Confirm offset and size.
7. Restore only the factory partition if possible.
8. Boot with UART connected.
9. Check Wi-Fi logs.
10. Test Wi-Fi scan and connection.
11. Save a new full flash backup after repair.

---

## Short Version

The factory partition is small but critical.

For the common A5-V11 layout:

```text
Factory offset: 0x040000
Factory size:   0x010000
```

It may contain:

- Wi-Fi calibration
- RF calibration
- MAC address
- Board-specific data

Always:

- Back it up before flashing
- Verify the backup
- Keep it private
- Use same-board factory data
- Preserve it during 8 MB or 16 MB flash upgrades
- Test Wi-Fi after any restore or migration

If Wi-Fi breaks after flashing, check the factory partition before assuming the router hardware is bad.

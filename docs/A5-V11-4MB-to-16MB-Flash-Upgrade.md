# A5-V11 4 MB to 16 MB SPI Flash Upgrade Procedure

## 1. Purpose

The stock A5-V11 commonly ships with a 4 MB SPI flash chip, which severely limits firmware options.

The goal of this procedure is to replace the stock 4 MB SPI flash with a 16 MB MX25L12835F.

Safe field-tested flow:

1. Dump the original 4 MB flash.
2. Build a 16 MB padded image from that dump.
3. Program the new 16 MB chip offline.
4. Boot OEM firmware first and confirm stability.
5. Flash OpenWrt only after OEM boot is confirmed.

> [!WARNING]
> Preserve your original dump and factory calibration/MAC data. Losing this data can permanently reduce device function and may complicate recovery.

## 2. Required tools

- A5-V11 router
- Windows PC with Wi-Fi and Ethernet/RJ45
- USB flash drive formatted FAT32
- CH341A or compatible SPI flash programmer
- SOIC clip or soldering tools / hot air station
- 16 MB SPI flash chip: MX25L12835F or compatible 3.3 V 128 Mbit SPI NOR
- AsProgrammer or compatible SPI programming software
- Telnet client enabled in Windows
- Ethernet cable
- Micro USB power cable

## 3. PC network setup

Use Wi-Fi for internet and Ethernet for the local A5-V11 connection at the same time.

Example split:

- Wi-Fi adapter: connected to home internet (for example `192.168.1.x`)
- Ethernet adapter: connected directly to A5-V11
- A5-V11 OEM IP: `192.168.100.1`
- PC Ethernet static IP: `192.168.100.2`
- Subnet mask: `255.255.255.0`
- Gateway/DNS on Ethernet: leave blank

Windows steps:

1. Open **Control Panel → Network Connections**.
2. Right-click the Ethernet adapter.
3. Open **IPv4 settings**.
4. Set static IP to `192.168.100.2` and subnet mask `255.255.255.0`.
5. Leave gateway blank so Wi-Fi remains the internet route.

Test commands:

```sh
ping 192.168.100.1
telnet 192.168.100.1
```

## 4. Connect to factory firmware

1. Power the A5-V11 through micro USB.
2. Connect RJ45 Ethernet from PC to A5-V11.
3. Open browser to `http://192.168.100.1`.
4. Telnet to `192.168.100.1`.
5. Login is usually `admin/admin`.
6. In our tested unit, telnet opened directly into a BusyBox `ash` shell.

## 5. Confirm flash layout

Run:

```sh
cat /proc/mtd
```

Original 4 MB example:

```text
dev:    size   erasesize  name
mtd0: 00400000 00010000 "ALL"
mtd1: 00030000 00010000 "Bootloader"
mtd2: 00010000 00010000 "Config"
mtd3: 00010000 00010000 "Factory"
mtd4: 003b0000 00010000 "Kernel"
```

Notes:

- `mtd0` is the full flash.
- Bootloader, Config, Factory calibration, and Kernel are all contained inside `mtd0`.
- Factory calibration and MAC data should be preserved.

## 6. Mount FAT32 USB drive

Run:

```sh
mount
ls /dev/sd*
ls /media
```

Example successful mount:

```text
/dev/sda1 on /media/sda1 type vfat
```

## 7. Dump the factory flash

Run:

```sh
cat /dev/mtd0 > /media/sda1/a5v11_factory_4mb.bin
sync
ls -l /media/sda1/a5v11_factory_4mb.bin
```

Expected size:

```text
4194304
```

Optional partition backups:

```sh
cat /dev/mtd1 > /media/sda1/a5v11_bootloader.bin
cat /dev/mtd2 > /media/sda1/a5v11_config.bin
cat /dev/mtd3 > /media/sda1/a5v11_factory_calibration.bin
cat /dev/mtd4 > /media/sda1/a5v11_kernel.bin
sync
ls -l /media/sda1
```

These smaller files are backups only. The full 4 MB dump already contains all of them.

Unmount:

```sh
umount /media/sda1
```

## 8. Create a 16 MB padded image

The new 16 MB image must contain the original 4 MB dump at the beginning, with the remaining 12 MB filled with `0xFF`.

Linux example:

```sh
dd if=/dev/zero bs=1M count=16 | tr '\000' '\377' > a5v11_factory_16mb_padded.bin
dd if=a5v11_factory_4mb.bin of=a5v11_factory_16mb_padded.bin conv=notrunc
```

Expected size:

```text
16777216
```

Memory map:

```text
0x000000 - 0x3FFFFF   original 4 MB factory image
0x400000 - 0xFFFFFF   blank FF padding
```

> [!IMPORTANT]
> Only flash `a5v11_factory_16mb_padded.bin` to the new chip. Do not separately flash `bootloader.bin`, `config.bin`, `factory_calibration.bin`, or `kernel.bin`.

## 9. Program the 16 MB chip

Using AsProgrammer:

1. Select **MX25L12835F**, not the old MX25L3206E.
2. Confirm detected size is `16,777,216` bytes.
3. Optionally read blank chip first (mostly `FF` expected).
4. Open `a5v11_factory_16mb_padded.bin`.
5. Erase.
6. Program.
7. Verify.

> [!WARNING]
> If the programmer remains set to **MX25L3206E**, only 4 MB will be addressed. Always select the correct 16 MB chip before programming.

## 10. Install the new chip

1. Remove the original 4 MB SPI flash.
2. Install the programmed MX25L12835F.
3. Inspect for solder bridges and correct orientation.
4. Power on the A5-V11.

## 11. Verify OEM firmware boots

1. `ping 192.168.100.1`
2. Open `http://192.168.100.1`
3. Telnet `admin/admin`
4. Run:

```sh
cat /proc/mtd
```

Successful 16 MB result from tested unit:

```text
dev:    size   erasesize  name
mtd0: 01000000 00010000 "ALL"
mtd1: 00030000 00010000 "Bootloader"
mtd2: 00010000 00010000 "Config"
mtd3: 00010000 00010000 "Factory"
mtd4: 00fb0000 00010000 "Kernel"
```

Interpretation:

- `0x01000000` means OEM now sees the full 16 MB flash.
- Kernel partition expanded to nearly all remaining space.
- This confirms the chip swap and padded image worked.

## 12. Next step: flashing OpenWrt

Once OEM boots correctly on 16 MB flash, upgrade using OEM web interface or `telnet/mtd_write` (firmware dependent).

Example telnet method (firmware-specific):

```sh
mtd_write write /media/sda1/uboot_usb_256_03.img Bootloader
mtd_write write /media/sda1/lede-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin Kernel
reboot
```

`uboot_usb_256_03.img` and `lede-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin` are example filenames only. Use known-good A5-V11 images from your own verified build/output set or trusted release sources documented in this repository (see [`../Firmware/README.md`](../Firmware/README.md)), and confirm they match your board and target flash layout before writing.

> [!WARNING]
> Only flash bootloader and firmware images intended for A5-V11 and compatible with the 16 MB layout. Keep original dumps as recovery images.

## 13. Recovery notes

- `a5v11_factory_4mb.bin` = original factory state.
- `a5v11_factory_16mb_padded.bin` = restore image for upgraded 16 MB chip.
- Separate partition files are useful for repair, comparison, or targeted recovery.
- Preserve Factory calibration and MAC data.

## 14. Tested result

- Stock router booted as 4 MB.
- Original full flash dump completed successfully.
- MX25L12835F blank chip was programmed and verified with the padded 16 MB image.
- Router booted OEM firmware after chip swap.
- `cat /proc/mtd` reported `mtd0: 01000000`, confirming full 16 MB detection.

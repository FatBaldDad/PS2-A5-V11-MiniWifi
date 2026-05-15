# TFTP Recovery

## Summary

This document covers TFTP recovery for the A5-V11 mini router.

TFTP recovery can be used to load or write firmware through the bootloader without using the stock web interface, SSH, telnet, or OpenWrt sysupgrade.

TFTP recovery is useful when:

- The firmware partition is broken
- OpenWrt no longer boots correctly
- The web UI is unavailable
- SSH or telnet is unavailable
- Network configuration is broken
- A known-good firmware image needs to be restored
- UART still works and U-Boot can still be reached

TFTP recovery is not guaranteed on every A5-V11.

Bootloader behavior varies between units.

---

## Main Rule

The main rule is:

```text
Use TFTP only when you know which bootloader you have and which image type it expects.
```

Do not assume every A5-V11 uses the same TFTP recovery method.

---

## Important Warning

TFTP recovery can overwrite firmware.

Depending on the bootloader option used, it may write directly to flash.

Before using TFTP recovery, confirm:

- Board ID
- Flash size
- RAM size
- Bootloader behavior
- Firmware image type
- Target flash layout
- Router IP during recovery
- Host PC IP during recovery
- Required filename
- Whether the method writes to flash or only loads to RAM
- Whether the image is known-good

If the bootloader still works, protect it.

Do not overwrite U-Boot unless you specifically intend to recover or replace the bootloader.

---

## What TFTP Is

TFTP means Trivial File Transfer Protocol.

It is a very simple file transfer protocol often used by bootloaders.

In A5-V11 recovery, TFTP is used to transfer a firmware file from a computer to the router while U-Boot is running.

Basic idea:

```text
PC runs or acts as TFTP file source
A5-V11 bootloader requests or receives firmware
Bootloader loads image
Bootloader may write image to flash
Router reboots into recovered firmware
```

---

## When TFTP Recovery Is Useful

Use TFTP recovery when:

- U-Boot still works
- UART shows a U-Boot menu
- The firmware partition is bad
- The kernel does not boot
- OpenWrt fails before login
- The router is network-locked but bootloader recovery works
- You need to install a known-good sysupgrade image through U-Boot
- You want to avoid removing the SPI flash chip

---

## When TFTP Recovery Will Not Help

TFTP recovery usually will not help if:

- The bootloader is corrupt
- There is no UART output
- The flash chip is not responding
- The SoC is damaged
- The router has no power
- The Ethernet hardware is damaged
- The bootloader has no working TFTP support
- The wrong U-Boot was flashed
- The router cannot reach the TFTP host
- The board is stuck before U-Boot starts

In those cases, use CH341A recovery or hardware troubleshooting.

---

## TFTP Recovery Types

There are several possible TFTP recovery types.

| Type | Description | Risk |
|---|---|---|
| Serial-assisted U-Boot TFTP | Use UART to select U-Boot TFTP option and enter IP/file info | Medium |
| Button-triggered TFTP recovery | Hold reset during power-on and send firmware over TFTP | Medium |
| Bootloader auto-fetch recovery | Bootloader requests a file from a fixed server IP | Medium to High |
| U-Boot command-line TFTP | Manually run TFTP commands from U-Boot prompt | High |
| Bootloader replacement by TFTP | TFTP writes a new U-Boot | Critical |

The safest TFTP method is the one where UART confirms exactly what the bootloader is doing.

---

## Bootloader Variation Warning

A5-V11 units may have different bootloader behavior.

Possible variations:

- U-Boot accepts normal OpenWrt images
- U-Boot rejects non-vendor images
- U-Boot has a serial menu
- U-Boot supports TFTP recovery
- U-Boot does not support button-triggered TFTP recovery
- U-Boot expects a specific filename
- U-Boot expects a specific host IP
- U-Boot expects a specific router IP
- Reset button GPIO may not work with some replacement U-Boot builds
- Some modified U-Boot builds support recovery differently than stock

Do not assume a method works just because it worked on another A5-V11.

---

## Known U-Boot Menu Options

Some A5-V11 bootlogs show a U-Boot menu similar to this:

```text
1: Load system code to SDRAM via TFTP.
2: Load system code then write to Flash via TFTP.
3: Boot system code via Flash (default).
4: Entr boot command line interface.
7: Load Boot Loader code then write to Flash via Serial.
9: Load Boot Loader code then write to Flash via TFTP.
```

Important:

| Option | Meaning | Risk |
|---:|---|---|
| 1 | Load firmware to RAM only | Lower |
| 2 | Load firmware and write to flash | Medium/High |
| 3 | Boot existing firmware from flash | Low |
| 4 | Enter U-Boot command line | Medium/High |
| 7 | Write bootloader through serial | Critical |
| 9 | Write bootloader through TFTP | Critical |

For normal firmware recovery, option `2` may be used when the bootloader supports it and the image is correct.

Do not use option `7` or `9` unless intentionally replacing the bootloader.

---

## Image Type Warning

Use the correct image type.

| Image Type | Use |
|---|---|
| OpenWrt sysupgrade image | Often used with U-Boot TFTP firmware write methods |
| OpenWrt factory image | Usually used from stock web UI or specific first-install methods |
| Raw firmware partition image | Only when offsets/layout are known |
| Full flash image | External SPI programmer only |
| U-Boot image | Bootloader recovery only, critical risk |

Do not send a full flash image through a normal firmware TFTP recovery method unless the bootloader specifically expects a full flash image.

Do not send a U-Boot image when the bootloader is asking for system firmware.

---

## Firmware File Naming

Many TFTP recovery methods expect a simple filename.

Common examples:

```text
firmware.bin
openwrt.bin
```

Use a short filename for TFTP testing.

Recommended:

```text
firmware.bin
```

Avoid filenames with:

- Spaces
- Parentheses
- Long version strings
- Special characters
- Non-ASCII characters

Keep the original full filename in your notes.

---

## Known A5-V11 TFTP Patterns

Different sources and bootloaders describe different TFTP patterns.

Document each pattern separately.

---

## Pattern A: Serial-Assisted U-Boot TFTP

This method uses UART.

Basic idea:

1. Connect UART.
2. Power the router.
3. Interrupt U-Boot.
4. Choose TFTP firmware write option.
5. Enter router IP.
6. Enter TFTP server IP.
7. Enter firmware filename.
8. Bootloader downloads firmware.
9. Bootloader writes firmware to flash.
10. Router reboots.

This is the preferred TFTP recovery method because UART shows what is happening.

---

## Pattern B: Button-Triggered TFTP Upload To Router

Some modified bootloaders may support this method.

Reported concept:

1. Rename known-good sysupgrade image to `firmware.bin`.
2. Hold reset while powering the device.
3. Blue LED flashes.
4. Set PC IP to `192.168.1.2`.
5. TFTP `firmware.bin` to router at `192.168.1.1`.
6. Router accepts file and reboots.

Example TFTP client flow:

```text
tftp 192.168.1.1
tftp> mode binary
tftp> put firmware.bin
```

Important:

This method was documented with a modified bootloader.

It may not work on the stock bootloader.

---

## Pattern C: Bootloader Auto-Fetch From TFTP Server

Some related RT5350 bootloader recovery notes describe a bootloader that tries to fetch a file from a fixed TFTP server.

Reported concept:

- Router recovery IP may be `192.168.1.2`
- Host/server IP may be `192.168.1.55`
- Requested filename may be based on the MAC address label

Example filename concept:

```text
00200c078f54
```

This is not confirmed as universal A5-V11 behavior.

Use Wireshark or UART to confirm what the bootloader is requesting.

---

## Pattern D: U-Boot Command-Line TFTP

Some U-Boot builds may allow manual command-line recovery.

This requires entering the boot command line interface and manually running commands.

This is advanced and dangerous.

Do not use manual U-Boot flash commands unless you understand:

- RAM load address
- Flash erase range
- Flash write range
- Image size
- Firmware offset
- Flash layout
- Boot command
- Recovery method if wrong

---

## Recommended First Method

The recommended first TFTP method is:

```text
Serial-assisted U-Boot TFTP.
```

Why:

- UART confirms bootloader state.
- UART confirms IP prompts.
- UART confirms filename.
- UART shows transfer progress.
- UART shows flash write progress.
- UART shows errors.
- Less guessing.

Button-triggered TFTP without UART should be treated as a fallback method only if the bootloader is known to support it.

---

## Required Hardware

For TFTP recovery, you need:

- A5-V11 router
- 3.3 V USB-to-TTL UART adapter
- Ethernet cable
- PC or laptop with Ethernet
- Known-good firmware image
- Stable 5 V power supply
- Optional network switch
- Optional Wireshark
- Optional CH341A programmer for backup recovery

Recommended:

- Use direct Ethernet connection from PC to A5-V11.
- Use UART for the first attempt.
- Use a known-good external 5 V supply.
- Do not power from the PS2 during recovery.

---

## Required Software

Useful software:

| Tool | Purpose |
|---|---|
| PuTTY | UART terminal on Windows |
| Tera Term | UART terminal and logging on Windows |
| Minicom | UART terminal on Linux |
| screen | Simple UART terminal on Linux/macOS |
| dnsmasq | TFTP server on Linux |
| tftpd-hpa | TFTP server on Linux |
| atftp | TFTP client/server tools |
| tftpd64/tftpd32 | TFTP server/client on Windows |
| Wireshark | Watch TFTP requests and IP behavior |
| sha256sum | Verify firmware checksums |
| PowerShell Get-FileHash | Verify checksums on Windows |

---

## UART Settings

Common A5-V11 UART settings:

| Setting | Value |
|---|---|
| Voltage | 3.3 V TTL |
| Baud | 57600 |
| Data bits | 8 |
| Parity | None |
| Stop bits | 1 |
| Flow control | None |

Connection:

| A5-V11 | USB-TTL Adapter |
|---|---|
| GND | GND |
| TX | RX |
| RX | TX through 470 ohm to 1 k ohm resistor |
| VCC | Leave disconnected |

Do not connect a true RS-232 port directly to the router.

---

## Network Setup For Direct PC Connection

Use a direct Ethernet connection or a simple switch.

Recommended:

```text
PC Ethernet -> A5-V11 Ethernet
```

or:

```text
PC Ethernet -> simple switch -> A5-V11 Ethernet
```

Avoid using your home router for recovery unless you know exactly what the bootloader expects.

Disable Wi-Fi on the PC during recovery if it causes routing confusion.

---

## Host IP Examples

Common host IP setups depend on the bootloader method.

| Method | Router IP | Host PC IP |
|---|---:|---:|
| Button-triggered upload pattern | 192.168.1.1 | 192.168.1.2 |
| Auto-fetch pattern | 192.168.1.2 | 192.168.1.55 |
| Serial-assisted prompt | User enters value | User enters value |

For serial-assisted TFTP, follow the U-Boot prompts.

Do not assume the IPs.

---

## Windows Static IP Setup

Example for button-triggered upload pattern:

| Setting | Value |
|---|---|
| PC IP | 192.168.1.2 |
| Subnet mask | 255.255.255.0 |
| Gateway | Blank or 192.168.1.1 |
| DNS | Blank |

For auto-fetch pattern:

| Setting | Value |
|---|---|
| PC IP | 192.168.1.55 |
| Subnet mask | 255.255.255.0 |
| Gateway | Blank |
| DNS | Blank |

Use the setting required by the bootloader being tested.

---

## Linux Static IP Setup Example

Example using `ip` command:

```text
sudo ip addr flush dev eth0
sudo ip addr add 192.168.1.2/24 dev eth0
sudo ip link set eth0 up
```

For auto-fetch pattern:

```text
sudo ip addr flush dev eth0
sudo ip addr add 192.168.1.55/24 dev eth0
sudo ip link set eth0 up
```

Replace `eth0` with the actual Ethernet interface name.

Check interface name:

```text
ip link
```

---

## Linux TFTP Server With dnsmasq

Create a folder:

```text
mkdir -p ~/a5v11-tftp
```

Copy firmware:

```text
cp openwrt-sysupgrade.bin ~/a5v11-tftp/firmware.bin
```

Start dnsmasq TFTP server:

```text
sudo dnsmasq --port=0 --enable-tftp --tftp-root=$HOME/a5v11-tftp --interface=eth0 --bind-interfaces
```

If `--interface=eth0` does not work, use the correct interface name.

Stop any existing dnsmasq service if it conflicts.

---

## Linux TFTP Server With tftpd-hpa

Install if needed:

```text
sudo apt install tftpd-hpa
```

Example TFTP root:

```text
/srv/tftp
```

Copy firmware:

```text
sudo cp firmware.bin /srv/tftp/firmware.bin
sudo chmod 644 /srv/tftp/firmware.bin
```

Restart service:

```text
sudo systemctl restart tftpd-hpa
```

Check status:

```text
systemctl status tftpd-hpa
```

Configuration may vary by Linux distribution.

---

## Windows TFTP Server

Common Windows tools:

- Tftpd64
- Tftpd32

General setup:

1. Put `firmware.bin` in an easy folder.
2. Open Tftpd64.
3. Set the current directory to the firmware folder.
4. Select the correct Ethernet interface.
5. Set PC static IP to the expected host IP.
6. Disable Windows firewall temporarily if needed.
7. Start recovery process.
8. Watch the log window for requests.

Make sure the correct network adapter is selected.

---

## TFTP Client Upload Method

Some bootloaders expect the PC to send the file to the router.

Example:

```text
tftp 192.168.1.1
tftp> mode binary
tftp> put firmware.bin
```

Important:

```text
Use binary mode.
```

If binary mode is not used, the firmware may be corrupted.

---

## TFTP Server Auto-Fetch Method

Some bootloaders expect the router to request a file from the PC.

In this method:

- PC runs TFTP server
- Firmware file waits in TFTP root
- Router asks for file
- PC sends file automatically

Use Wireshark to see:

- Router IP
- Server IP
- Requested filename
- Whether transfer starts
- Whether transfer completes

---

## Wireshark Use

Wireshark is very useful when the bootloader behavior is unknown.

Capture filter:

```text
tftp or arp or bootp
```

or simple display filter:

```text
tftp
```

Watch for:

- ARP requests
- Router source IP
- Requested server IP
- Filename request
- TFTP error messages
- Transfer start
- Transfer completion

Wireshark can reveal whether the router is waiting for a different IP or filename.

---

## Serial-Assisted TFTP Procedure

Use this procedure when UART works.

1. Connect UART.
2. Connect Ethernet from PC to A5-V11.
3. Set PC static IP or prepare to match U-Boot prompt.
4. Start TFTP server with firmware file.
5. Power on A5-V11.
6. Interrupt U-Boot menu.
7. Choose the firmware TFTP write option.
8. Enter router IP when prompted.
9. Enter server IP when prompted.
10. Enter firmware filename when prompted.
11. Watch transfer progress.
12. Watch flash write progress.
13. Wait for completion.
14. Reboot.
15. Capture UART boot log.
16. Test Ethernet and firmware.

Do not remove power during transfer or flash writing.

---

## Button-Triggered TFTP Procedure

Use this only if the bootloader is known to support it.

1. Rename known-good sysupgrade image to:

```text
firmware.bin
```

2. Set PC static IP:

```text
192.168.1.2
```

3. Connect PC Ethernet to A5-V11.
4. Open TFTP client.
5. Hold A5-V11 reset button.
6. Apply power.
7. Keep holding reset until blue LED flashes or recovery behavior appears.
8. Send firmware to router:

```text
tftp 192.168.1.1
tftp> mode binary
tftp> put firmware.bin
```

9. Wait for transfer to finish.
10. Wait for router to write flash and reboot.
11. Do not remove power early.
12. Test router at expected IP.

This method may not work with stock bootloader.

---

## Auto-Fetch TFTP Procedure

Use this only when Wireshark or UART confirms the router is requesting a file.

1. Set PC to expected server IP.
2. Start TFTP server.
3. Place expected filename in TFTP root.
4. Hold reset or trigger recovery as required.
5. Power router.
6. Watch TFTP server logs.
7. Watch Wireshark.
8. Confirm the router requests the file.
9. Wait for transfer and flash write.
10. Wait for reboot.

If no request appears, the bootloader may not support this method or may use different IPs.

---

## Firmware Image Preparation

Before TFTP:

1. Confirm firmware source.
2. Confirm target board.
3. Confirm flash size.
4. Confirm image type.
5. Confirm checksum.
6. Rename copy to simple filename.
7. Keep original filename in notes.
8. Put file in TFTP root.

Example:

```text
cp openwrt-17.01.7-ramips-rt305x-a5-v11-squashfs-sysupgrade.bin firmware.bin
sha256sum firmware.bin
```

Do not edit the firmware file after checksum.

---

## Known-Good Firmware Requirement

Use a known-good firmware image.

Known-good means:

- Correct target
- Correct subtarget
- Correct flash size
- Correct image type
- Previously tested or from reliable source
- Checksum verified
- Not too large
- Does not overwrite factory data
- Has recovery notes

Do not use TFTP recovery to test random images on your only working board.

---

## File Size Check

Check file size before TFTP.

Linux:

```text
ls -l firmware.bin
```

PowerShell:

```text
Get-Item .\firmware.bin | Select-Object Name,Length
```

Make sure the file is not:

- Zero bytes
- Truncated
- Larger than firmware partition
- A full flash dump by mistake
- A bootloader image by mistake

---

## TFTP Transfer Success Signs

Possible success signs:

- UART shows TFTP transfer progress
- TFTP client shows bytes sent
- TFTP server log shows completed transfer
- Router begins flash erase/write
- Router reboots by itself
- Router boots new firmware
- Router responds at new expected IP

Do not interrupt after transfer if flash writing is still happening.

---

## TFTP Transfer Failure Signs

Possible failure signs:

- Timeout
- No ARP response
- No TFTP request
- Wrong filename requested
- Permission denied
- File not found
- Transfer starts then stops
- Transfer completes but router does not reboot
- UART shows checksum error
- UART shows bad image
- Router still boots old firmware
- Router is now worse

Use UART and Wireshark to determine what happened.

---

## After TFTP Recovery

After recovery:

1. Wait at least 2 minutes if the router appears to be writing or rebooting.
2. Power cycle only after it is safe.
3. Check expected IP.
4. Connect UART.
5. Capture boot log.
6. Confirm firmware version.
7. Confirm Ethernet.
8. Confirm Wi-Fi if needed.
9. Confirm USB if needed.
10. Save notes.

Common possible IPs:

| Firmware State | Possible IP |
|---|---|
| Stock firmware | 192.168.100.1 |
| OpenWrt default | 192.168.1.1 |
| PS2-focused custom firmware | 192.168.1.222 |
| DHCP client mode | Assigned by network |

---

## Do Not Interrupt Flash Writing

After TFTP transfer, the bootloader may erase and write flash.

Do not:

- Pull power
- Press reset
- Disconnect Ethernet if process is still writing
- Close terminal
- Assume transfer completion means flashing is complete

Wait for UART confirmation or router reboot.

If no UART is connected, wait several minutes.

---

## U-Boot Environment Notes

Some U-Boot menus warn about bad CRC and use default environment.

That may be normal on some boards.

However, if U-Boot environment is corrupted or wrong, TFTP recovery may use unexpected defaults.

Record:

- U-Boot version
- Environment warning
- Router IP
- Server IP
- Boot command
- Flash detection
- RAM size

Do not overwrite U-Boot environment unless needed.

---

## TFTP And 16 MB Flash Upgrades

TFTP recovery for 16 MB flash upgrades is more complicated.

Do not assume a 4 MB TFTP recovery image will use the full 16 MB.

A 16 MB recovery image must match:

- Installed flash chip size
- U-Boot flash detection
- OpenWrt partition layout
- Firmware partition size
- DTS/image definition
- Factory partition location
- Firmware start offset

For 16 MB migration, CH341A programming is often safer than TFTP for the first install.

After a proper 16 MB OpenWrt build is installed, sysupgrade or TFTP may be used depending on bootloader support.

---

## TFTP And Factory Partition

Normal firmware TFTP recovery should not overwrite the factory partition.

However, mistakes can still happen if:

- Wrong image type is used
- Wrong U-Boot command is used
- Wrong flash offset is used
- Full flash image is sent
- Bootloader writes more than expected
- Custom layout is wrong

Always back up the factory partition before recovery work.

---

## TFTP And U-Boot Replacement

Some U-Boot menus include options to write the bootloader through TFTP.

This is critical risk.

Do not use bootloader TFTP write options unless:

- The current U-Boot is already bad or must be replaced
- The replacement U-Boot is confirmed for the board
- RAM size is confirmed
- Flash size is confirmed
- Original U-Boot backup exists
- CH341A recovery is available
- You accept the risk

For normal firmware recovery, avoid bootloader write options.

---

## Troubleshooting: No TFTP Request

Possible causes:

- Bootloader does not support TFTP recovery
- Wrong reset timing
- Wrong IP address
- Wrong Ethernet interface selected on PC
- Firewall blocking TFTP
- Ethernet link not up
- Bad cable
- Router not in recovery mode
- PC routing through Wi-Fi instead of Ethernet
- Bootloader expects a different server IP
- Bootloader expects client upload instead of server auto-fetch

Try:

- Use UART to confirm U-Boot menu.
- Use Wireshark to watch ARP/TFTP.
- Disable PC Wi-Fi.
- Use direct Ethernet.
- Try a simple switch between PC and router.
- Try documented IP pairs.
- Try serial-assisted method.

---

## Troubleshooting: TFTP Timeout

Possible causes:

- Wrong router IP
- Wrong PC IP
- Firewall blocking UDP port 69
- TFTP server not running
- Wrong interface selected
- Ethernet link not active
- Router not in TFTP mode
- Bootloader has already timed out

Try:

- Restart recovery process.
- Check link lights.
- Check static IP.
- Check firewall.
- Use Wireshark.
- Use UART.
- Start TFTP command immediately after reset-triggered recovery begins.

---

## Troubleshooting: File Not Found

Possible causes:

- Wrong filename
- File not in TFTP root
- Wrong TFTP root folder
- Case-sensitive filename mismatch
- Router requests MAC-based filename
- Router requests `firmware.bin` but file has another name
- TFTP server lacks permission

Fix:

- Rename file to expected name.
- Put it directly in TFTP root.
- Avoid spaces.
- Check TFTP server logs.
- Use Wireshark to see requested filename.

---

## Troubleshooting: Permission Denied

Possible causes:

- File permissions wrong
- TFTP server root not accessible
- Windows firewall or antivirus blocking
- TFTP server not running as admin/root
- Linux service config wrong

Fix:

```text
chmod 644 firmware.bin
```

or run TFTP server from a simple folder with known permissions.

On Windows, try running Tftpd64 as administrator.

---

## Troubleshooting: Transfer Completes But Router Does Not Boot

Possible causes:

- Wrong image type
- Image too large
- Wrong flash layout
- Wrong target
- Bad checksum
- Bootloader wrote to wrong offset
- Factory/sysupgrade mismatch
- Firmware not compatible with bootloader
- Flash chip write failed
- Power removed too soon

Check UART:

- Did U-Boot accept image?
- Did U-Boot verify checksum?
- Did U-Boot erase flash?
- Did U-Boot write flash?
- Did kernel start?
- Did rootfs mount?

If U-Boot still works, try a known-good firmware image.

If U-Boot does not work, use CH341A.

---

## Troubleshooting: Router Still Boots Old Firmware

Possible causes:

- TFTP loaded to RAM only
- U-Boot option 1 used instead of option 2
- Stock firmware rejected update
- Image written to wrong partition
- Flash write failed
- Router rebooted without writing

Check:

- U-Boot option used
- UART messages
- Firmware version after boot
- Flash write confirmation

If using U-Boot menu, make sure the selected option writes to flash if permanent recovery is intended.

---

## Troubleshooting: No Ethernet Link During Recovery

Possible causes:

- Bad cable
- Wrong port
- Router not powered
- Bootloader Ethernet not initialized
- Internal PS2 wiring issue
- Magnetics bypassed
- Auto-negotiation issue
- PC interface down
- PC using Wi-Fi route

Try:

- Use a known-good external Ethernet cable.
- Use a simple switch between PC and router.
- Test with router outside PS2.
- Check PC interface status.
- Check UART for Ethernet init.
- Do not use internal PS2 wiring for recovery until proven.

---

## Troubleshooting: Windows TFTP Does Not Work

Try:

- Disable Windows firewall temporarily.
- Run Tftpd64 as administrator.
- Select the correct Ethernet interface.
- Set static IP manually.
- Disable Wi-Fi temporarily.
- Place firmware directly in the TFTP root folder.
- Avoid spaces in path and filename.
- Watch Tftpd64 log window.
- Use Wireshark to confirm packets.

---

## Troubleshooting: Linux dnsmasq Does Not Work

Try:

- Confirm interface name.
- Stop existing dnsmasq service.
- Run dnsmasq manually.
- Use `sudo`.
- Check TFTP root path.
- Check file permissions.
- Check firewall.
- Use Wireshark or tcpdump.

Example tcpdump:

```text
sudo tcpdump -i eth0 arp or udp port 69
```

Replace `eth0` with the correct interface.

---

## Recovery Safety Checklist

Before TFTP recovery:

| Check | Done |
|---|---|
| Board ID recorded |  |
| Flash size known |  |
| RAM size known |  |
| Factory partition backed up |  |
| U-Boot backed up if possible |  |
| Firmware image source known |  |
| Firmware image checksum verified |  |
| Image type confirmed |  |
| PC static IP configured |  |
| TFTP server/client ready |  |
| UART connected if possible |  |
| Stable 5 V power used |  |
| PS2 internal wiring avoided for recovery |  |
| CH341A available if recovery fails |  |

---

## TFTP Recovery Record Template

Use this template for each attempt.

```text
# TFTP Recovery Record

## Session Info

Date:
Tester:
Board ID:
Reason for recovery:

## Hardware

RAM chip:
RAM size:
Flash chip:
Flash size:
Power source:
Ethernet setup:
UART connected:

## Bootloader

U-Boot version:
Bootloader type:
Menu available:
Reset-button recovery:
TFTP method used:
U-Boot option selected:

## Network

Router recovery IP:
Host PC IP:
Subnet:
TFTP mode:
TFTP software:
Firewall disabled:
Wireshark used:

## Firmware

Original filename:
Recovery filename:
Image type:
Image size:
SHA256:
Target flash size:
Source:

## Result

TFTP request seen:
Transfer started:
Transfer completed:
Flash erase shown:
Flash write shown:
Router rebooted:
New firmware booted:
Default IP after recovery:
Ethernet tested:
Wi-Fi tested:
Notes:

## Final Status

Pass/fail:
Known issues:
Next step:
```

---

## Suggested Photos And Screenshots

Save:

- UART connection photo
- Ethernet recovery setup photo
- TFTP server folder screenshot
- TFTP software screenshot
- Wireshark capture screenshot
- U-Boot menu screenshot
- Successful transfer screenshot
- First boot after recovery log

Suggested filenames:

```text
tftp-board001-uart-setup.jpg
tftp-board001-ethernet-setup.jpg
tftp-board001-uboot-menu.png
tftp-board001-tftp-transfer.png
tftp-board001-wireshark-request.png
tftp-board001-first-boot-log.txt
```

---

## Recommended Recovery Order

Use recovery methods in this order:

1. Check power.
2. Check UART.
3. Try OpenWrt failsafe if OpenWrt boots far enough.
4. Try serial-assisted U-Boot TFTP if U-Boot works.
5. Try known button-triggered TFTP only if bootloader supports it.
6. Use CH341A to read current flash.
7. Save the broken dump.
8. Restore firmware partition or full flash as needed.
9. Retest on bench.

Do not jump straight to bootloader replacement.

---

## Do Not Do This

Avoid these mistakes:

- Do not TFTP random firmware.
- Do not use the wrong image type.
- Do not send a full flash dump as normal firmware.
- Do not send U-Boot as system firmware.
- Do not use bootloader write options by accident.
- Do not power from PS2 during recovery.
- Do not use internal Ethernet wiring until external recovery works.
- Do not remove power during flash writing.
- Do not assume button-triggered TFTP works on stock U-Boot.
- Do not assume every A5-V11 uses the same IP.
- Do not ignore UART errors.
- Do not overwrite factory data.

---

## Short Version

TFTP recovery can restore firmware when U-Boot still works.

The safest method is:

```text
Connect UART.
Start TFTP server.
Interrupt U-Boot.
Use the firmware TFTP write option.
Send a known-good image.
Wait for flash write and reboot.
Verify with UART.
```

Known common TFTP patterns include:

```text
PC 192.168.1.2 -> router 192.168.1.1, send firmware.bin
```

and some bootloader variants may instead expect:

```text
PC/server 192.168.1.55
router 192.168.1.2
MAC-based filename
```

Do not assume.

Use UART and Wireshark to confirm what the bootloader wants.

If U-Boot is gone or there is no UART output, use CH341A recovery instead.

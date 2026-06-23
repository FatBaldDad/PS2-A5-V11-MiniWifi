# Firmware Build Plan (Safe First Pass)

## 1. Goal
Build a safe first test image for PS2-A5-V11-MiniWifi that packages the current overlay and WebUI plumbing without enabling real service control or risky network automation.

This first firmware should be intentionally minimal, boring, and recoverable.

## 2. Current Progress
The repository already includes the first safe overlay plumbing:

- Browser preview WebUI in docs/webui-preview
- Firmware WebUI copy destination in openwrt-files/www/ps2
- UCI defaults in openwrt-files/etc/config/ps2bridge
- Read-only JSON status script in openwrt-files/usr/bin/ps2bridge-status
- CGI status endpoint in openwrt-files/www/cgi-bin/ps2/status
- Safe init skeleton in openwrt-files/etc/init.d/ps2bridge
- Permission prep script for Ubuntu in scripts/fix-openwrt-permissions.sh

Primary research/build baseline status:

- LEDE Reboot 17.01.7 is now the primary research/build baseline for expanded-flash A5-V11 work.
- OpenWrt 18.06.9 remains a later comparison point, not the first-choice build base.
- OpenWrt 15.05 and 15.05.1 remain historically important for stock A5-V11 profile behavior and 4 MB-era layout.
- OpenWrt 19.07.10 is not a first-choice target because the exact profiles.json scan did not show A5-V11.

Verified so far:

- Ubuntu compile server is fbd@192.168.1.47.
- Repo clone path on Ubuntu is ~/build/PS2-A5-V11-MiniWifi.
- Safe overlay permission script works.
- ps2bridge-status outputs valid JSON.
- LEDE 17.01.7 ramips/rt305x ImageBuilder contains the official A5-V11 profile.
- LEDE 17.01.7 ramips/rt305x ImageBuilder also contains WT1520 4M and WT1520 8M profiles.
- LEDE 17.01.7 ImageBuilder fails on Ubuntu 24.04 directly because it requires Python 2.x.
- Docker 29.1.3 is installed on the compile server, and Ubuntu 18.04 container with Python 2.7.17 runs LEDE 17.01.7 ImageBuilder successfully.
- Plain WT1520-8M ImageBuilder test build completed and artifacts were copied to _artifacts/wt1520-8M-plain/ for research only.
- 19.07.10 profiles.json did not show an A5-V11 profile in the exact profile scan.
- No firmware has been flashed yet.

## 3. Target Hardware
- Device: A5-V11 mini router
- Hardware SoC: RT5350F / Ralink/MediaTek RT5350F
- CPU class: MIPS 24KEc / MIPS 24kc class at 360 MHz
- RAM: 32 MB
- Flash: upgraded 16 MB SPI flash for this project
- Stock flash: 4 MB
- OpenWrt target family: ramips
- OpenWrt legacy subtarget folder: rt305x
- OpenWrt profile: A5-V11 or a5-v11, depending on ImageBuilder version

Do Not Confuse These:
- RT5350F = actual chip on the A5-V11 board.
- rt305x = OpenWrt legacy subtarget folder that includes the A5-V11 profile in older releases.
- A5-V11 = board/profile name.
- The A5-V11 is not physically an RT305x chip.

## 4. Repo Layout
- Windows repository is for editing, planning, and WebUI preview work.
- Ubuntu server is compile-only.
- Active branch for this effort: feature/ps2-webui-appliance.

Primary folders used by this plan:

- docs/webui-preview
- openwrt-files
- scripts

## 5. First Firmware Scope
The first test firmware should only add and validate:

- WebUI files at /www/ps2
- CGI status endpoint at /www/cgi-bin/ps2/status
- ps2bridge UCI config file
- ps2bridge status script (JSON output)
- ps2bridge init.d safe skeleton
- SSH access
- Basic web server support

## 6. Not Included Yet
The following must remain out of scope for the first firmware image:

- SMB service control
- UDPFS service control
- UDPBD service control
- WiFi setup wizard actions
- Firmware upload/update actions
- Real network-changing commands
- Automatic IP changes
- U-Boot updates

## 7. Default Network Plan
Planned default values for first safe image and status reporting:

- A5 management IP: 192.168.1.200
- Netmask: 255.255.255.0
- Gateway: 192.168.1.1
- DNS: 192.168.1.1
- A5 PS2-side IP: 192.168.2.1
- Suggested PS2 IP: 192.168.2.10
- SMB share: PS2SMB
- Storage path: /mnt/ps2
- Preferred mode: UDPFS
- Optional mode: UDPBD

## 8. Safety Rules
- First test firmware must not overwrite U-Boot.
- First test firmware must not touch the factory/calibration partition.
- First test firmware should be sysupgrade-only after OpenWrt is already installed.
- Keep TFTP recovery notes in separate documentation.
- Before any build or flash, confirm we are building for the A5-V11 profile on the ramips/rt305x OpenWrt target path, but remember the hardware is RT5350F.
- Do not use a generic RT305x board profile.
- Do not use RT5350F-OLinuXino as a substitute profile.
- Do not use another RT5350 board profile unless intentionally porting and documenting why.
- The WT1520-8M image is not an A5-V11 16 MB final firmware.
- Do not flash WT1520-8M images to the 16 MB A5-V11 without a recovery plan and flash-layout verification.
- Do not flash a factory image unless starting from the stock/OEM web UI.
- Do not use sysupgrade unless OpenWrt/LEDE is already running and board/layout compatibility is verified.
- Before any flash, compare expected MTD partition layout, bootloader behavior, factory/calibration partition handling, and recovery method.
- Do not assume eth0 vs eth0.1 yet; board variants may differ.
- Keep first build behavior conservative and recoverable.

## 9. Ubuntu Build Server Role
Ubuntu build server responsibilities:

- Compile OpenWrt image artifacts only
- Consume repository overlay content as provided
- Run permission normalization helper before build inputs are packed
- Avoid editing source-of-truth project files directly
- For LEDE 17.01.7 ImageBuilder, use an Ubuntu 18.04 Docker container with Python 2.7 compatibility

Build environment finding:

- LEDE 17.01.7 ImageBuilder fails on Ubuntu 24.04 directly because it requires Python 2.x.
- Do not use FORCE=1 as the normal solution.
- Docker was installed on the Ubuntu compile server (Docker 29.1.3 from Ubuntu docker.io).
- Ubuntu 18.04 Docker container successfully runs LEDE 17.01.7 ImageBuilder with Python 2.7.17.

Windows workstation responsibilities:

- Edit documentation, scripts, and overlay content
- Preview WebUI in browser from docs/webui-preview
- Commit and push branch updates to GitHub

## 10. Future Build Script Plan
No build script is created in this phase.

Planned next step (documentation only):

- Define a reproducible Ubuntu-side build wrapper that:
  - syncs the latest repository branch
  - applies overlay into OpenWrt tree
  - runs scripts/fix-openwrt-permissions.sh
  - runs target profile build for ramips/rt305x using LEDE 17.01.7 baseline first
  - outputs artifact list and checksums

Candidate order for current research phase:

1. LEDE 17.01.7 ramips/rt305x as the primary research baseline.
2. WT1520-8M as a proven Moahdib-style expanded-flash research path.
3. A future custom A5-V11 16 MB profile/layout as the likely final project target.
4. OpenWrt 18.06.9 as a later comparison candidate.
5. OpenWrt 15.05.1 as historical stock A5-V11 reference.
6. OpenWrt 19.07.10 as not first choice.

## 11. Test Checklist Before Flashing
Pre-flash checks for first safe image:

- Confirm target profile is the official A5-V11 profile under ramips/rt305x, and remember hardware SoC is RT5350F.
- Confirm image type is sysupgrade (not bootloader flashing path).
- Confirm overlay contains only intended safe files.
- Confirm /www/ps2 exists in rootfs artifact.
- Confirm /www/cgi-bin/ps2/status is present and executable.
- Confirm /usr/bin/ps2bridge-status is present and executable.
- Confirm /etc/init.d/ps2bridge exists and is executable.
- Confirm /etc/config/ps2bridge contains expected defaults.
- Confirm no scripts attempt live network reconfiguration.
- Confirm expected MTD partition layout and bootloader behavior match flash plan.
- Confirm factory/calibration partition handling and recovery method before any flash.
- Confirm rollback path is documented before device flash.

LEDE 17.01.7 ImageBuilder profile verification currently confirmed:

```text
a5-v11:
  A5-V11
  Packages: kmod-usb-core kmod-usb-ohci kmod-usb2

wt1520-4M:
  Nexx WT1520 (4MB)

wt1520-8M:
  Nexx WT1520 (8MB)
```

Moahdib-style path note:

- Moahdib's known working PS2 SMB approach used LEDE Reboot 17.01.7 with upgraded 8 MB flash A5-V11.
- That approach used WT1520-8M because it is hardware-compatible enough and already has an 8 MB flash layout.
- This is useful evidence for expanded-flash A5-V11 research.
- WT1520-8M is not the final solution for this project's 16 MB flash chip.
- Likely final direction is a custom A5-V11 16 MB profile/layout or a carefully documented port from compatible larger-flash profiles.

## 12a. A5-V11-16M ImageBuilder Test Result

Local ImageBuilder test using LEDE 17.01.7 ramips/rt305x:

Local changes made in ImageBuilder only:
- Copied A5-V11.dts to A5-V11-16M.dts
- Changed model to: A5-V11 (16M)
- Changed firmware partition from reg = <0x50000 0x3b0000>; to reg = <0x50000 0xfb0000>;
- Added local a5-v11-16M profile in target/linux/ramips/image/rt305x.mk:
  - DTS := A5-V11-16M
  - IMAGE_SIZE := 16064k
  - DEVICE_TITLE := A5-V11 (16M research sysupgrade only)
  - DEVICE_PACKAGES := kmod-usb-core kmod-usb-ohci kmod-usb2
- Did not add factory.bin
- Did not use poray-header
- Patched local ImageBuilder metadata files .profiles.mk and .targetinfo

Verified result:
- make info successfully listed:
```text
a5-v11-16M:
    A5-V11 (16M research sysupgrade only)
    Packages: kmod-usb-core kmod-usb-ohci kmod-usb2
```

Build result:
- The ImageBuilder test failed safely with error:
```
No rule to make target '/work/build_dir/target-mipsel_24kc_musl-1.1.16/linux-ramips_rt305x/a5-v11-16M-kernel.bin', needed by '/work/build_dir/target-mipsel_24kc_musl-1.1.16/linux-ramips_rt305x/tmp/lede-17.01.7-ramips-rt305x-a5-v11-16M-squashfs-sysupgrade.bin'
```
- No A5-V11-16M image was generated
- No firmware was flashed

Conclusion:
- LEDE 17.01.7 ImageBuilder can assemble images for already-known/prebuilt profiles
- ImageBuilder alone cannot build a brand-new DTS/profile target because it does not compile missing kernel/DTB artifacts
- This confirmed ImageBuilder cannot compile brand-new DTS targets by itself; full source build is the next likely required path
- Next research path: full source build in Ubuntu 18.04 Docker/container environment with proper A5-V11-16M DTS/profile in source
- Failure note saved on compile server at: openwrt-checks/a5v11-profile-check/imagebuilder-17.01.7/lede-imagebuilder-17.01.7-ramips-rt305x.Linux-x86_64/_artifacts/a5-v11-16M-imagebuilder-failure-note.txt

## 12. MTD Partition Layout and Poray Header Findings

Verified partition layouts from LEDE 17.01.7 DTS files:

A5-V11 stock 4 MB layout:
- u-boot: 0x00000 size 0x30000
- u-boot-env: 0x30000 size 0x10000
- factory: 0x40000 size 0x10000
- firmware: 0x50000 size 0x3b0000

WT1520-8M 8 MB layout (same protected boot/env/factory, expanded firmware):
- u-boot: 0x00000 size 0x30000
- u-boot-env: 0x30000 size 0x10000
- factory: 0x40000 size 0x10000
- firmware: 0x50000 size 0x7b0000

LEDE 17.01.7 16 MB examples (NIXCORE-16M, VOCORE-16M):
- firmware: 0x50000 size 0xfb0000

Future A5-V11-16M DTS guidance:
- Start from A5-V11.dts, not WT1520.dtsi
- Keep A5-V11 board identity, GPIOs, LEDs, USB/root hub GPIO exports, Ethernet behavior, factory EEPROM/MAC location
- Change only the firmware partition to: reg = <0x50000 0xfb0000>;
- Do not base on WT1520.dtsi because it has different board identity, reset GPIO, and network/switch behavior

Image size constants in LEDE 17.01.7:
- ralink_default_fw_size_4M = 3866624
- ralink_default_fw_size_8M = 8060928
- ralink_default_fw_size_16M = 16121856
- NIXCORE-16M and VOCORE-16M use IMAGE_SIZE := 16064k, matching the 0xfb0000 firmware partition
- A future A5-V11-16M profile should likely use IMAGE_SIZE := 16064k or a clearly justified equivalent

Poray header findings from LEDE 17.01.7 and mkporayfw matrix testing:

- LEDE 17.01.7 uses mkporayfw through the poray-header build step
- A5-V11 stock factory image uses: poray-header -B A5-V11 -F 4M
- WT1520-8M factory image uses: poray-header -B WT1520 -F 8M
- mkporayfw options include: -B (board), -H, -F (flash size), -f, -o (output), -i (inspect), -x (extract)
- Matrix testing confirmed mkporayfw accepts 4M and 8M but rejects 16M with error: "unknown flash layout \"16M\""
- Testing also showed:
  - A5-V11 -F 4M and -F 8M produced byte-identical Poray-headered output from the same sysupgrade input
  - WT1520 -F 4M and -F 8M produced byte-identical Poray-headered output from the same sysupgrade input
  - Therefore the -F option may be accepted/validated without creating obvious byte-level layout difference, but do not assume all paths are safe

## 13. Safety Rules for 16 MB Flash Layout

Confirmed constraints:
- Do not attempt poray-header -B A5-V11 -F 16M (mkporayfw rejects 16M)
- A5-V11-16M factory image generation is unresolved
- A5-V11-16M should initially be a custom sysupgrade/raw firmware research target, not factory/OEM-web flash target
- Do not flash WT1520-8M to 16 MB A5-V11 as the final path

Required before any 16 MB hardware flashing:
- Verified full SPI recovery method
- Known-good full flash backup
- Confirmed bootloader behavior
- Confirmed factory/calibration partition preservation
- Confirmed OpenWrt MTD layout after boot
- Serial console available

Likely future A5-V11-16M path:
1. Create A5-V11-16M DTS by copying A5-V11.dts and expanding firmware partition to 0xfb0000
2. Create A5-V11-16M profile in rt305x.mk using A5-V11 board behavior and 16064k image size
3. Initially avoid factory.bin or mark factory.bin as unsafe/unresolved
4. Build and inspect sysupgrade/raw output only
5. Test only after recovery process is documented and verified

## 14. Recovery Notes Placeholder
Recovery details are intentionally tracked separately.

Placeholder references:

- TFTP recovery workflow
- UART console recovery workflow
- SPI programmer recovery workflow
- Known-good image archive and checksums

This document will link to concrete recovery procedures after first image validation is complete.

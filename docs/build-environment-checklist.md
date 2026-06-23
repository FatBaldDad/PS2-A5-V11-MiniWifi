# Build Environment Checklist

## 1. Purpose
This document defines the build environment decision process for the PS2-A5-V11-MiniWifi firmware project.

Primary goal: choose the safest first OpenWrt/LEDE baseline for A5-V11 and produce a recoverable first test image.

Primary research baseline update:

- LEDE Reboot 17.01.7 is now the primary research/build baseline for expanded-flash A5-V11 work.
- OpenWrt 18.06.9 remains a later comparison point, not the first-choice build base.
- OpenWrt 15.05 and 15.05.1 remain historically important for stock A5-V11 profile and 4 MB-era layout.
- OpenWrt 19.07.10 is not a first-choice target because the exact profiles.json scan did not show A5-V11.

## 2. Hardware Target
- Device: A5-V11 mini router
- Hardware SoC: Ralink/MediaTek RT5350F
- CPU class: MIPS 24KEc / MIPS 24kc class at 360 MHz
- RAM: 32 MB
- Flash: upgraded 16 MB SPI flash for this project
- Original flash: 4 MB
- OpenWrt target family: ramips
- OpenWrt legacy subtarget folder: rt305x
- OpenWrt profile: a5-v11 or A5-V11, depending on ImageBuilder version

Do Not Confuse These:
- RT5350F = actual chip on the A5-V11 board.
- rt305x = OpenWrt legacy subtarget folder that includes the A5-V11 profile in older releases.
- A5-V11 = board/profile name.
- The A5-V11 device is not physically an RT305x chip.

## 3. Why Latest OpenWrt Is Not The First Target
Project rule: the first build target must be an older A5-V11-compatible OpenWrt/LEDE base.

Reasoning:
- RT5350F and 4/32-era device classes are legacy-constrained.
- First milestone is safe integration of static WebUI and status plumbing, not modernization.
- Newest branches add risk in profile availability, package drift, and integration unknowns.
- Initial success criteria favor compatibility and recoverability over feature freshness.

## 4. Build Host Role
- Host OS: Ubuntu 24.04 server
- Host role: compile-only
- Repo location on Ubuntu: ~/build/PS2-A5-V11-MiniWifi
- Windows environment remains source editing and WebUI preview workspace

Compile-only means:
- Build and package artifacts on Ubuntu
- Keep editing, documentation, and UI iteration in Windows repo workflow

## 5. Current Repo/Overlay Status
Current safe overlay plumbing is in place:

- openwrt-files/ as overlay root
- openwrt-files/www/ps2 for firmware WebUI files
- openwrt-files/www/cgi-bin/ps2/status for CGI JSON endpoint
- openwrt-files/usr/bin/ps2bridge-status for JSON status output
- openwrt-files/etc/config/ps2bridge for defaults
- openwrt-files/etc/init.d/ps2bridge as safe init skeleton
- scripts/fix-openwrt-permissions.sh to normalize executable permissions before build

## 6. Candidate OpenWrt/LEDE Versions
These are candidates, not final decisions.

1. LEDE 17.01.7 ramips/rt305x (primary research baseline)
    - LEDE 17.01.7 ramips/rt305x ImageBuilder was downloaded and tested.
    - make info confirms:

```text
a5-v11:
     A5-V11
     Packages: kmod-usb-core kmod-usb-ohci kmod-usb2

wt1520-4M:
     Nexx WT1520 (4MB)

wt1520-8M:
     Nexx WT1520 (8MB)
```

    - This confirms 17.01.7 ImageBuilder contains both official A5-V11 profile and WT1520 larger-flash profiles.

2. WT1520-8M as a proven Moahdib-style expanded-flash research path
    - Moahdib's known working PS2 SMB approach used LEDE Reboot 17.01.7 with upgraded 8 MB flash A5-V11.
    - WT1520-8M was used as a hardware-compatible-enough profile with known 8 MB flash layout.
    - This is useful evidence for expanded-flash A5-V11 research.
    - WT1520-8M is not the final solution for this project's 16 MB flash chip.

3. Future custom A5-V11 16 MB profile/layout as likely final project target
    - Expected final direction is either custom A5-V11 16 MB layout or carefully documented port from compatible larger-flash profiles.

4. OpenWrt 18.06.9 as later comparison candidate
    - OpenWrt 18.06.9 ImageBuilder was verified to list:

```text
a5-v11:
     A5-V11
```

    - This confirms the 18.06.9 ramips/rt305x ImageBuilder knows A5-V11 profile.
    - This does not yet prove generated image safety for upgraded 16 MB flash layout.

5. OpenWrt 15.05.1 as historical stock A5-V11 reference
    - Important historical reference for original stock profile behavior and 4 MB-era layout.

6. OpenWrt 19.07.10 as not first choice
    - Exact profiles.json scan did not show A5-V11.

## 7. ImageBuilder vs Full Source Build
Recommended first attempt:
- Use ImageBuilder first if a compatible A5-V11 ramips/rt305x ImageBuilder exists for selected version.
- Use full source build only if ImageBuilder is unavailable or cannot generate required output.

Build environment finding for LEDE 17.01.7 ImageBuilder:

- LEDE 17.01.7 ImageBuilder fails on Ubuntu 24.04 directly because it requires Python 2.x.
- Do not use FORCE=1 as the normal solution.
- Docker was installed on the Ubuntu compile server.
- Verified Docker version on host: Docker 29.1.3 from Ubuntu docker.io package.
- Ubuntu 18.04 Docker container provides Python 2.7 and successfully runs LEDE 17.01.7 ImageBuilder.
- Verified Python inside container: Python 2.7.17.

Successful plain WT1520-8M research build inside container:

```text
make image PROFILE="wt1520-8M"
```

Produced files:

```text
lede-17.01.7-ramips-rt305x-device-wt1520-8m.manifest
lede-17.01.7-ramips-rt305x-wt1520-8M-squashfs-factory.bin
lede-17.01.7-ramips-rt305x-wt1520-8M-squashfs-sysupgrade.bin
```

Research notes:
- Factory and sysupgrade images were about 3.1 MB each.
- Generated files were copied to _artifacts/wt1520-8M-plain/.
- These artifacts are for research only and must not be flashed yet.

Decision logic:
1. Confirm target release and profile support.
2. Confirm ImageBuilder availability for ramips/rt305x.
3. Attempt overlay integration via FILES=openwrt-files.
4. Validate generated sysupgrade artifact and rootfs contents.
5. Escalate to full source build only if ImageBuilder path fails requirements.

## 8. First Build Scope
First firmware goal is a safe test image containing only:

- WebUI files at /www/ps2
- CGI status endpoint at /www/cgi-bin/ps2/status
- ps2bridge config at /etc/config/ps2bridge
- ps2bridge status script at /usr/bin/ps2bridge-status
- ps2bridge init skeleton at /etc/init.d/ps2bridge
- SSH access
- Basic web server support

Before any build or flash, confirm we are building for the A5-V11 profile on the ramips/rt305x OpenWrt target path, but remember the hardware is RT5350F.
- Do not use RT5350F-OLinuXino as a substitute profile.
- Do not use a generic RT5350 board profile unless intentionally porting and documenting why.

Recommended output type:
- sysupgrade image only

## 9. Out of Scope
Explicitly out of scope for the first build:

- Latest OpenWrt
- U-Boot flashing
- Factory/calibration partition changes
- Automatic network reconfiguration
- SMB/UDPFS/UDPBD service activation
- Firmware update WebUI actions

Also out of scope for this phase:
- Factory image generation unless specifically required later
- Any bootloader artifacts
- Flashing research artifacts before board/layout safety checks

## 10. Required Packages For First Image
This list is intentionally minimal for safe-first firmware behavior.

Required functional set:
- BusyBox base utilities
- uhttpd (or equivalent basic OpenWrt web server)
- CGI support compatible with /www/cgi-bin
- UCI runtime tooling
- Dropbear (SSH)

Overlay payload required in rootfs:
- /www/ps2
- /www/cgi-bin/ps2/status
- /usr/bin/ps2bridge-status
- /etc/config/ps2bridge
- /etc/init.d/ps2bridge

## 11. Overlay Verification Checklist
Answer these before accepting a build:

1. Which OpenWrt/LEDE version are we using first?
2. Does that version include an A5-V11 profile?
3. Is the profile under ramips/rt305x?
4. Is ImageBuilder available for that version/target?
5. If ImageBuilder is not enough, do we need full source build?
6. Does output include a squashfs sysupgrade image?
7. Can overlay be injected via FILES=openwrt-files?
8. Does rootfs contain /www/ps2?
9. Does rootfs contain /www/cgi-bin/ps2/status?
10. Does rootfs contain /usr/bin/ps2bridge-status?
11. Are OpenWrt script permissions preserved?
12. Where are build artifacts stored?
13. How are SHA256 checksums generated?
14. How is image integrity verified before flashing?

## 12. Artifact Output Plan
Suggested output folder:
- firmware/output/

Suggested artifact names:
- ps2-a5-v11-miniwifi-VERSION-sysupgrade.bin
- ps2-a5-v11-miniwifi-VERSION-sha256sums.txt
- build-log-VERSION.txt

Artifact handling rules:
- Keep one folder per tested candidate version
- Record build command line and profile in build log
- Always generate SHA256 checksums for produced images

## 13. Pre-Flash Verification Checklist
Before flashing first test image:

- Confirm image is sysupgrade only.
- Confirm no U-Boot or bootloader payloads are involved.
- Confirm no factory/calibration partition operations are part of process.
- Confirm overlay files exist in image rootfs and have executable bits where required.
- Confirm ps2bridge scripts are safe skeleton behavior only.
- Confirm no auto-IP or live network-changing commands are embedded.
- Confirm recovery documentation is available before testing.
- Confirm checksums match expected artifact list.
- Do not flash WT1520-8M images to 16 MB A5-V11 without recovery plan and flash-layout verification.
- Do not flash factory image unless starting from stock/OEM web UI.
- Do not use sysupgrade unless OpenWrt/LEDE is already running and board/layout compatibility is verified.
- Before any flash, compare expected MTD partition layout, bootloader behavior, factory/calibration partition handling, and recovery method.

## 14. Verified So Far
- Ubuntu compile server is fbd@192.168.1.47.
- Repo clone path on Ubuntu is ~/build/PS2-A5-V11-MiniWifi.
- Safe overlay permission script works.
- ps2bridge-status outputs valid JSON.
- LEDE 17.01.7 ImageBuilder contains a5-v11, wt1520-4M, and wt1520-8M profiles.
- LEDE 17.01.7 ImageBuilder runs successfully in Ubuntu 18.04 Docker container with Python 2.7.17.
- Docker version on host is 29.1.3.
- Plain wt1520-8M image build completed and artifacts were saved to _artifacts/wt1520-8M-plain/.
- 18.06.9 ImageBuilder contains the a5-v11 profile.
- 19.07.10 profiles.json did not show an A5-V11 profile in the exact profile scan.
- No firmware has been flashed yet.

## 15. Open Questions
- After LEDE 17.01.7 baseline work, which comparison candidate should be evaluated next: OpenWrt 18.06.9 or historical 15.05.1 reference checks?
- For LEDE 17.01.7 results, should first profile validation on hardware begin with official a5-v11 or controlled WT1520-8M research path first?
- For selected next release, does ImageBuilder provide all needed package and profile support?
- If full source build is required, what is the minimal reproducible build recipe to preserve safety constraints?
- What exact package set is needed to keep first image small, stable, and sufficient for safe validation?

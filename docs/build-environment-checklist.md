# Build Environment Checklist

## 1. Purpose
This document defines the build environment decision process for the PS2-A5-V11-MiniWifi firmware project.

Primary goal: choose the safest first OpenWrt/LEDE baseline for A5-V11 and produce a recoverable first test image.

## 2. Hardware Target
- Device: A5-V11 mini router
- SoC: Ralink/MediaTek RT5350F
- CPU class: MIPS 24KEc / MIPS 24kc class
- Target family: ramips
- Subtarget: rt305x
- RAM: 32 MB
- Flash: upgraded 16 MB SPI flash
- Original flash: 4 MB

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

### Candidate A: LEDE 17.01.7 class
- Known historical usage in A5-V11/UDPBD-related work
- Potentially strongest compatibility baseline for first bring-up
- Tradeoff: very old package/security baseline

### Candidate B: OpenWrt 18.06.9 class
- Middle-ground option between LEDE-era and later OpenWrt
- Requires validation for A5-V11 profile presence under ramips/rt305x
- Requires package and tool compatibility checks

### Candidate C: OpenWrt 19.07.10 class
- Last official generation often used for many 4/32 families
- Potential newest reasonable first candidate
- Requires validation for A5-V11 profile, ImageBuilder availability, and package compatibility

Decision gate for first attempt:
- Select the oldest version that reliably provides A5-V11 profile support and a recoverable sysupgrade path.

## 7. ImageBuilder vs Full Source Build
Recommended first attempt:
- Use ImageBuilder first if a compatible A5-V11 ramips/rt305x ImageBuilder exists for selected version.
- Use full source build only if ImageBuilder is unavailable or cannot generate required output.

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

## 14. Open Questions
- Which candidate version should be trialed first: LEDE 17.01.7, OpenWrt 18.06.9, or OpenWrt 19.07.10?
- Does selected release provide a directly usable A5-V11 profile name, or does it require profile adaptation?
- For selected release, does ImageBuilder provide all needed package and profile support?
- If full source build is required, what is the minimal reproducible build recipe to preserve safety constraints?
- What exact package set is needed to keep first image small, stable, and sufficient for safe validation?

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

## 3. Target Hardware
- Device: A5-V11 mini router
- SoC: RT5350F / Ralink RT5350
- OpenWrt target family: ramips / rt305x
- Flash: 16 MB SPI flash (upgraded)
- RAM: 32 MB

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
- Do not assume eth0 vs eth0.1 yet; board variants may differ.
- Keep first build behavior conservative and recoverable.

## 9. Ubuntu Build Server Role
Ubuntu build server responsibilities:

- Compile OpenWrt image artifacts only
- Consume repository overlay content as provided
- Run permission normalization helper before build inputs are packed
- Avoid editing source-of-truth project files directly

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
  - runs target profile build for ramips/rt305x
  - outputs artifact list and checksums

## 11. Test Checklist Before Flashing
Pre-flash checks for first safe image:

- Confirm target profile is A5-V11-compatible under ramips/rt305x.
- Confirm image type is sysupgrade (not bootloader flashing path).
- Confirm overlay contains only intended safe files.
- Confirm /www/ps2 exists in rootfs artifact.
- Confirm /www/cgi-bin/ps2/status is present and executable.
- Confirm /usr/bin/ps2bridge-status is present and executable.
- Confirm /etc/init.d/ps2bridge exists and is executable.
- Confirm /etc/config/ps2bridge contains expected defaults.
- Confirm no scripts attempt live network reconfiguration.
- Confirm rollback path is documented before device flash.

## 12. Recovery Notes Placeholder
Recovery details are intentionally tracked separately.

Placeholder references:

- TFTP recovery workflow
- UART console recovery workflow
- SPI programmer recovery workflow
- Known-good image archive and checksums

This document will link to concrete recovery procedures after first image validation is complete.

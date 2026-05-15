# Binary Policy

## Summary

This document defines how binary files should be handled in this repo.

The A5-V11 project involves firmware, bootloaders, flash dumps, factory partitions, OpenWrt images, PS2-related tools, and recovery files. Some of these files are useful for testing and recovery, but they can also contain board-specific data, third-party code, unclear licensing, or risky firmware that can brick hardware.

The default policy is:

Do not commit binary files unless there is a clear reason, clear source, clear license status, clear target hardware, and clear risk warning.

Whenever possible, this repo should prefer:

- Build instructions
- Source links
- Config files
- Patches
- Scripts
- Checksums
- Documentation
- Redacted logs

instead of uploading binary firmware files.

## Why This Policy Exists

Binary files can create problems.

Possible issues:

- Unknown source
- Unknown license
- Unknown build configuration
- Hidden board-specific data
- MAC address leakage
- Wi-Fi calibration leakage
- RF calibration leakage
- Unsafe U-Boot files
- Wrong flash-size images
- Wrong RAM-size images
- Binaries that silently brick boards
- Firmware that cannot be reproduced
- Third-party work uploaded without permission
- Copyrighted files accidentally added
- Confusion between full flash dumps and firmware images

This repo should be useful, but it should also be careful.

## Main Rule

The main rule is:

```text
Source, configs, patches, and instructions are preferred.
Binaries are the exception.
```

If a binary cannot be explained, traced, verified, and tested, it should not be committed.

## Definitions

## Binary File

A binary file is any file that is not plain text source, configuration, markdown, script, or documentation.

Examples:

- `.bin`
- `.img`
- `.elf`
- `.hex`
- `.rom`
- `.dat`
- `.fw`
- `.trx`
- `.zip` containing firmware
- `.7z` containing firmware
- `.rar` containing firmware
- Full flash dumps
- Firmware images
- Bootloader images
- Compiled executables
- Compiled PS2 ELF files

## Firmware Image

A file intended to be flashed to the A5-V11.

Examples:

- OpenWrt factory image
- OpenWrt sysupgrade image
- Raw firmware partition image
- Vendor firmware image
- Custom PS2-focused firmware image

## Full Flash Dump

A complete dump of the entire SPI flash chip.

A full flash dump may contain:

- U-Boot
- U-Boot environment
- Factory partition
- MAC address
- Wi-Fi calibration data
- RF calibration data
- Stock firmware
- Board-specific settings

Full flash dumps should normally remain private.

## Factory Partition

A board-specific flash partition that may contain calibration and identity data.

This partition should not be committed publicly unless it has been intentionally cleaned, documented, and approved for reference use.

## U-Boot Image

A bootloader image.

U-Boot files are high risk because flashing the wrong bootloader can hard-brick the router.

## Third-Party Binary

A binary file made by someone else.

Examples:

- Firmware from another GitHub repo
- Firmware from an old forum post
- Bootloader from a blog
- Compiled PS2 loader from another project
- Prebuilt UDPBD or UDPFS binary

Third-party binaries require extra care.

## Allowed Without Special Review

These file types are generally allowed:

- Markdown documentation
- Plain text notes
- Redacted UART logs
- Redacted boot logs
- OpenWrt `.config` files
- OpenWrt config snippets
- Shell scripts
- Python scripts
- Build scripts
- Patch files
- Device tree source snippets
- Source code written for this repo
- BOM files
- CSV test results
- Checksums
- Links to upstream binary releases

## Allowed With Caution

These may be allowed if properly documented:

- Public firmware release binaries created by this repo
- Public test images created by this repo
- Checksummed known-good upstream binaries with permission/license clarity
- Small compiled helper tools with source included
- Bootloader images only if source, target, and risk are fully documented
- Example binary files that are legally redistributable and not board-specific

## Not Allowed By Default

Do not commit these by default:

- Full flash dumps
- Factory partitions
- Personal board backups
- Unknown vendor firmware
- Unknown U-Boot files
- Random binaries from forums
- Random firmware archives
- Files containing MAC addresses
- Files containing RF calibration data
- Files containing Wi-Fi credentials
- Files containing private IP/network info
- Copyrighted PS2 game files
- PS2 BIOS files
- Commercial software
- Decompiled proprietary firmware without permission
- Third-party firmware with unclear redistribution rights

## Absolute No-Go Files

These should not be committed to this repo:

- PS2 BIOS files
- Game ISOs
- Game ROMs
- Commercial software
- Copyrighted game assets
- Private keys
- Wi-Fi passwords
- Personal full flash dumps
- Customer board flash dumps
- Unredacted logs containing private data
- Anything that the repo does not have permission to redistribute

## Preferred Way To Reference Third-Party Binaries

Instead of uploading a third-party binary, link to the original source.

Preferred format:

```text
Project:
Author:
Original URL:
Release page:
Version:
File name:
SHA256:
License:
Notes:
```

This keeps credit with the original author and avoids turning this repo into a mirror of files it may not have permission to host.

## When A Binary May Be Included

A binary may be included only if all of the following are true:

- The source is known.
- The license allows redistribution.
- The target hardware is known.
- The flash size is known.
- The RAM size is known.
- The install method is documented.
- The recovery method is documented.
- The risk level is documented.
- The binary has a checksum.
- The binary has been tested or is clearly marked untested.
- The binary does not contain private board-specific data.
- The binary does not contain copyrighted PS2 software.
- The binary is useful enough to justify inclusion.

## Required Metadata For Included Binaries

Every included binary must have a matching metadata file.

Example:

```text
firmware-name.bin
firmware-name.md
firmware-name.sha256
```

The `.md` metadata file must include:

```text
File name:
File type:
Project:
Author:
Source URL:
License:
Version:
Date:
SHA256:
Target board:
Target SoC:
Target RAM:
Target flash size:
Image type:
Install method:
Recovery method:
Tested board IDs:
Status:
Risk level:
Known issues:
Notes:
```

## Required Checksum

Every included binary must have a SHA256 checksum.

Example:

```text
sha256sum firmware-name.bin > firmware-name.sha256
```

The checksum file should be committed with the binary.

Example checksum file format:

```text
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  firmware-name.bin
```

## Binary Status Labels

Use these labels for all included binaries.

| Label | Meaning |
|---|---|
| Reference Only | Included only for historical or comparison purposes |
| Untested | Not tested yet |
| Bench Tested | Tested outside a PS2 |
| Boots | Boots on A5-V11 hardware |
| Ethernet Works | Ethernet tested |
| Wi-Fi Works | Wi-Fi tested |
| USB Works | USB tested |
| PS2 Bench Tested | Tested externally with a PS2 |
| PS2 Internal Tested | Tested inside a PS2 |
| Broken | Known not to work |
| Risky | Can brick or has major uncertainty |
| Deprecated | Kept only for old reference |
| Recommended | Preferred tested release |

## Risk Levels

Use these risk levels.

| Risk Level | Meaning |
|---|---|
| Low | Should not modify bootloader or factory data |
| Medium | Can make router unreachable but recoverable by UART or sysupgrade |
| High | Can require SPI programmer recovery |
| Critical | Can destroy bootloader, factory data, or cause hard brick |

Examples:

| Binary Type | Typical Risk |
|---|---|
| Sysupgrade image for known OpenWrt install | Medium |
| Factory image from stock firmware | High |
| Raw firmware partition image | High |
| Full flash image | Critical |
| U-Boot image | Critical |
| Unknown third-party firmware | Critical |

## Firmware Image Type Rules

Firmware images must be clearly identified.

| Image Type | Meaning |
|---|---|
| factory.bin | First install from stock firmware or vendor update method |
| sysupgrade.bin | Upgrade from existing OpenWrt |
| firmware-partition.bin | Raw firmware partition only |
| full-flash.bin | Complete SPI flash image for external programmer only |
| u-boot.bin | Bootloader only |
| factory-partition.bin | Board-specific calibration data, normally private |

Do not mix these up.

A sysupgrade image is not a full flash image.

A full flash image is not a sysupgrade image.

A U-Boot image is not normal firmware.

## File Naming Rules

Binary file names should be descriptive.

Recommended format:

```text
project-board-flashsize-purpose-version-status.bin
```

Examples:

```text
a5-v11-4mb-openwrt-17-01-7-bridge-test-v0.1-sysupgrade.bin
a5-v11-16mb-ps2-udpbd-dev-v0.1-firmware-partition.bin
a5-v11-16mb-recovery-v0.1-sysupgrade.bin
```

Avoid vague names:

```text
firmware.bin
test.bin
new.bin
working.bin
final.bin
router.bin
```

`firmware.bin` may be used temporarily during TFTP or flashing steps, but the stored repo file should have a descriptive name.

## Version Naming

Use simple version labels.

Examples:

```text
v0.1
v0.2
v0.3-test
v0.4-ps2-bench
v1.0-release
```

Avoid calling anything `final` unless the project has a real release process.

## Folder Placement

If binaries are included later, use a clearly marked folder.

Suggested structure:

```text
Firmware/
├── Releases/
│   ├── README.md
│   ├── v0.1/
│   │   ├── firmware.bin
│   │   ├── firmware.md
│   │   └── firmware.sha256
│   └── v0.2/
├── Reference-Binaries/
│   ├── README.md
│   └── source-name/
└── Quarantine/
    └── README.md
```

## Releases Folder

Use this only for firmware produced by this repo and intentionally released.

Each release must include:

- Firmware binary, if allowed
- Metadata file
- SHA256 checksum
- Build configuration
- Source commit or branch
- Install instructions
- Recovery instructions
- Test status
- Known issues
- Risk warning

## Reference-Binaries Folder

Use this only for third-party binaries that are legally allowed to be redistributed and are useful for reference.

Prefer linking instead of uploading.

If included, every file must have:

- Original source
- Original author
- License
- Checksum
- Reason for inclusion
- Test status
- Clear credit

## Quarantine Folder

The quarantine folder is for local/private analysis only.

Do not commit questionable binaries.

Possible local use:

- Unknown stock firmware
- Unknown bootloader
- Unknown flash dump
- User-provided test image
- Damaged board dump
- Binary under review

If using a quarantine folder locally, add a `.gitignore` rule so files are not accidentally committed.

Example:

```text
Firmware/Quarantine/*
!Firmware/Quarantine/README.md
```

## Git Ignore Recommendations

Add rules to avoid accidental commits of sensitive binaries.

Suggested `.gitignore` entries:

```text
# Private flash dumps
*.fullflash.bin
*-full-flash*.bin
*-stock-dump*.bin
*-factory*.bin
*-calibration*.bin

# Private backups
Backups/
Private/
Quarantine/
Firmware/Quarantine/*

# Programmer temporary files
*.bak
*.tmp

# Archives that may contain binaries
*.zip
*.7z
*.rar
*.tar
*.gz
```

Be careful with broad rules if the repo intentionally stores release archives later.

## Full Flash Dump Policy

Full flash dumps should normally not be committed.

Reasons:

- They may contain MAC addresses.
- They may contain Wi-Fi calibration data.
- They may contain RF calibration data.
- They may contain vendor firmware.
- They may contain board-specific settings.
- They may be legally unclear.
- They can confuse users into flashing the wrong full image.

Instead, document how to create and verify a full flash dump.

## Factory Partition Policy

Factory partitions should normally not be committed.

Reasons:

- They are board-specific.
- They may contain calibration data.
- They may contain MAC address data.
- They may cause duplicate MAC addresses if reused.
- They may break Wi-Fi if copied to the wrong board.

Allowed public content:

- Explanation of what the factory partition is
- Offset and size notes
- Extraction commands
- Verification commands
- Redacted examples
- Placeholder filenames

Not allowed by default:

- Actual personal factory partition files

## U-Boot Policy

U-Boot binaries are high risk.

Do not include or recommend U-Boot binaries unless:

- The source is known.
- The target board is known.
- The RAM size is known.
- The flash size is known.
- The binary has been tested.
- The original U-Boot backup is required before use.
- External programmer recovery is documented.
- The risk is clearly marked Critical.

U-Boot flashing should never be treated as a casual firmware update.

## OpenWrt Binary Policy

For OpenWrt firmware, preferred content is:

- Build config
- Build commands
- Files overlay
- Patches
- Package list
- Source branch or tag
- Checksums for reproducible releases
- Test notes

Binaries may be included only for intentional releases.

Each OpenWrt binary must state:

- OpenWrt version
- Target
- Subtarget
- Device/profile
- Flash size
- RAM size
- Image type
- Install method
- Recovery method
- Default IP
- Login behavior
- Included services
- Known risks

## PS2 Binary Policy

This repo should be careful with PS2-related binaries.

Do not include:

- Game ISOs
- BIOS files
- Copyrighted PS2 software
- Commercial software
- Unlicensed files

For homebrew tools, prefer linking to upstream releases.

If a PS2 homebrew binary is included, it must have:

- Source project
- Author credit
- License or redistribution permission
- Version
- SHA256 checksum
- Purpose
- Reason for inclusion

Examples of files that should usually be linked instead of mirrored:

- OPL builds
- wLaunchELF builds
- UDPBD-capable OPL builds
- Neutrino builds
- PS2 homebrew packages

## UDPBD / UDPFS Binary Policy

UDPBD and UDPFS binaries must be handled carefully.

Preferred approach:

- Link to upstream project
- Document version
- Document source
- Document build method
- Document checksum
- Document how to install into firmware
- Document PS2-side matching version

If a server binary is included, it must state:

- Source
- Version
- Architecture
- Target OS
- License
- Build method
- SHA256
- Tested firmware
- Tested PS2 loader
- Known issues

## Architecture Labeling

Every binary must clearly state architecture.

Possible values:

| Architecture | Example Use |
|---|---|
| mipsel | A5-V11 Linux userspace binary |
| mips | Big-endian MIPS, not normally A5-V11 |
| mips24kc | OpenWrt target CPU family |
| x86_64 | PC helper tool |
| Windows x64 | PC helper executable |
| PS2 EE | PlayStation 2 Emotion Engine ELF |
| Unknown | Do not release until identified |

The A5-V11 RT5350F OpenWrt userspace is typically little-endian MIPS.

Do not upload a binary unless the architecture is known.

## License Requirements

Every binary must have license notes.

Possible license status:

| Status | Meaning |
|---|---|
| Open-source license known | Redistribution likely allowed under terms |
| Public release, license unclear | Link only unless permission is clear |
| Unknown source | Do not commit |
| Personal dump | Do not commit |
| Proprietary vendor firmware | Do not commit unless redistribution is clearly allowed |
| Copyrighted PS2 content | Do not commit |

If the license is unclear, link to the original source instead of hosting the file.

## Credit Requirements

Every third-party binary reference must credit the original creator.

Credit should include:

- Author or project name
- Original project URL
- Release URL
- Version
- Notes about modifications
- Whether the file was mirrored or only linked

Do not rename other people's work as original work.

Do not remove upstream credits.

## Reproducibility Requirement

For binaries created by this repo, include enough information to rebuild them.

Required:

- Source branch or tag
- OpenWrt version
- Build host notes
- `.config`
- Package list
- Files overlay
- Patches
- Build command
- Output filename
- SHA256 checksum

A binary without build instructions should be treated as incomplete.

## Testing Requirement

A binary release must include test status.

Minimum test fields:

```text
Boot tested:
UART log captured:
Ethernet tested:
Wi-Fi tested:
USB tested:
Overlay free checked:
RAM usage checked:
Reboot tested:
Recovery tested:
PS2 tested:
Known issues:
```

If something is not tested, say so.

Do not imply a binary is safe when it has not been tested.

## Recovery Requirement

Every firmware binary must include a recovery method.

Examples:

- OpenWrt sysupgrade
- OpenWrt failsafe
- UART console
- U-Boot TFTP
- CH341A full flash restore
- Replacement flash chip

At minimum, include:

```text
Recommended recovery method:
Required tools:
Known-good backup needed:
Risk level:
```

A risky binary with no recovery plan should not be published.

## Board-Specific Data Review

Before committing any binary, check whether it contains board-specific data.

Look for:

- MAC address
- Wi-Fi calibration
- RF calibration
- U-Boot environment
- Serial number
- Private IP addresses
- Wi-Fi SSID
- Wi-Fi password
- Hostnames
- Usernames
- SSH keys
- API keys
- Personal paths

If any are present, do not commit the file publicly.

## Log Review

Logs are not usually binary files, but they can still contain sensitive data.

Review logs for:

- MAC addresses
- SSIDs
- IP addresses
- Hostnames
- File paths
- Passwords
- Private keys
- Customer info

Redact before committing.

## Hex Review Suggestions

For binary review, use a hex editor or strings scan.

Example:

```text
strings firmware.bin | less
```

Search for:

```text
password
passwd
ssid
key
mac
192.168
root
admin
```

This does not prove a binary is safe, but it can catch obvious private data.

## Checksum Commands

Generate SHA256:

```text
sha256sum firmware.bin > firmware.bin.sha256
```

Verify SHA256:

```text
sha256sum -c firmware.bin.sha256
```

Windows PowerShell:

```text
Get-FileHash .\firmware.bin -Algorithm SHA256
```

## File Size Checks

Always record file size.

Linux:

```text
ls -l firmware.bin
```

PowerShell:

```text
Get-Item .\firmware.bin | Select-Object Name,Length
```

Expected full flash sizes:

| Flash Size | Bytes | Hex |
|---:|---:|---:|
| 4 MB | 4194304 | 0x400000 |
| 8 MB | 8388608 | 0x800000 |
| 16 MB | 16777216 | 0x1000000 |

If a full flash image does not match the chip size, do not use it.

## Metadata Template

Use this for every included binary.

```text
# Binary Metadata

## File

File name:
File size:
SHA256:
File type:
Image type:

## Source

Project:
Author:
Source URL:
Release URL:
License:
Original file name:
Original checksum:

## Target

Target device:
Board marking:
SoC:
RAM size:
Flash size:
OpenWrt target:
OpenWrt subtarget:
Architecture:

## Purpose

Purpose:
Role:
PS2 use case:

## Install

Install method:
Required existing firmware:
Required bootloader:
Required tools:
Default IP:
Default login:

## Recovery

Recovery method:
UART required:
SPI programmer recommended:
Known-good backup required:

## Test Status

Status:
Tested board IDs:
Boot tested:
Ethernet tested:
Wi-Fi tested:
USB tested:
PS2 tested:
Internal PS2 tested:

## Risks

Risk level:
Known issues:
Can overwrite factory data:
Can overwrite U-Boot:
Can brick router:

## Notes

Notes:
```

## Binary Review Checklist

Before committing a binary:

| Check | Done |
|---|---|
| Source is known |  |
| License is known |  |
| Author credited |  |
| File purpose is clear |  |
| Architecture is known |  |
| Target board is known |  |
| Target flash size is known |  |
| Target RAM size is known |  |
| Image type is known |  |
| Install method is documented |  |
| Recovery method is documented |  |
| SHA256 checksum created |  |
| File size recorded |  |
| Private data checked |  |
| Factory data absent or intentionally handled |  |
| U-Boot risk checked |  |
| Test status documented |  |
| Risk level assigned |  |
| Metadata file included |  |

## Release Checklist

Before creating a firmware release:

| Check | Done |
|---|---|
| Build is reproducible |  |
| `.config` is included |  |
| Files overlay is included |  |
| Patches are included |  |
| Build instructions are included |  |
| Binary checksum is included |  |
| Firmware metadata is included |  |
| Default IP documented |  |
| Login behavior documented |  |
| Flash size documented |  |
| RAM size documented |  |
| Install method documented |  |
| Recovery method documented |  |
| UART log saved |  |
| Ethernet tested |  |
| Wi-Fi tested |  |
| USB tested if included |  |
| PS2 tested if PS2-focused |  |
| Known issues listed |  |
| Credits included |  |
| License notes included |  |

## Example Good Release Entry

```text
File name:
a5-v11-16mb-ps2-bridge-v0.1-sysupgrade.bin

Status:
Bench Tested

Purpose:
Minimal PS2 Wi-Fi bridge firmware

Source:
OpenWrt 17.01.7 source tree with repo patches

Target:
A5-V11, RT5350F, 32 MB RAM, 16 MB flash

Image type:
sysupgrade

Install method:
OpenWrt sysupgrade only

Recovery:
UART and CH341A full flash backup

Default IP:
192.168.1.222

Tested:
Board-001, Ethernet, Wi-Fi, UART, reboot

Risk:
Medium

Notes:
Not PS2 internal tested yet.
```

## Example Bad Release Entry

Do not do this:

```text
firmware.bin
works for me
flash it with programmer
```

Problems:

- No source
- No checksum
- No flash size
- No RAM size
- No image type
- No install method
- No recovery method
- No test status
- No risk warning
- No credits
- No license notes

## Handling User-Provided Binaries

If someone submits a binary:

1. Do not commit it immediately.
2. Ask for source and license.
3. Ask for target board.
4. Ask for flash size and RAM size.
5. Ask for install method.
6. Ask for recovery method.
7. Ask for test status.
8. Check for private data.
9. Put it through the review checklist.
10. Prefer linking to their release instead of hosting it.

## Handling Your Own Test Binaries

For personal experiments:

- Keep test binaries local.
- Store them in a private folder.
- Add them to `.gitignore`.
- Keep notes and checksums.
- Commit the configs and patches instead.
- Only release a binary after it is tested and documented.

## Handling Stock Firmware Dumps

Stock firmware dumps are useful for research, but they should normally stay private.

Allowed public documentation:

- Firmware version
- Web UI screenshots with private data removed
- Telnet output with private data removed
- UART boot log with private data removed
- Partition layout
- Hash of private dump, if useful for personal tracking
- Notes about behavior

Not allowed by default:

- Full stock flash dump
- Factory partition
- Vendor binary firmware with unclear license

## Handling Damaged Flash Dumps

Damaged flash dumps can be useful for analysis.

Keep them private unless:

- They contain no private or board-specific data
- They are useful for public documentation
- They have been reviewed
- They are clearly marked as damaged
- They are not presented as flashable firmware

## Handling Firmware From Old Links

Many A5-V11 links are old.

If a firmware file comes from an old blog, forum, or dead mirror:

- Do not commit it blindly.
- Record where it came from.
- Record who made it if known.
- Check license if possible.
- Generate checksum.
- Test only on sacrificial hardware.
- Prefer documenting the link and instructions.
- Mark as Reference Only if included.

## Handling Compressed Archives

Compressed archives can hide binary files.

Do not commit archives unless needed.

If an archive is included, document:

- Contents
- Source
- License
- SHA256
- Why an archive is needed
- Whether any files inside are board-specific
- Whether any files inside are third-party

Prefer extracting text files and documenting binaries separately.

## Git LFS Note

If large binaries are ever intentionally included, Git LFS may be considered.

However, this repo should avoid becoming a binary storage repo.

Use Git LFS only for intentional releases or large reference files with clear permission.

## Public Versus Private Data

Use this rule:

```text
Public repo = instructions, configs, patches, scripts, clean releases.
Private archive = board dumps, factory partitions, personal backups.
```

## Recommended Private Archive Structure

Example private archive:

```text
Private-A5-V11-Backups/
├── board-001/
│   ├── full-flash/
│   ├── partitions/
│   ├── checksums/
│   └── notes.md
├── board-002/
│   ├── full-flash/
│   ├── partitions/
│   ├── checksums/
│   └── notes.md
└── README.md
```

Do not commit this private archive to the public repo.

## Recommended Public Documentation Structure

Example public repo structure:

```text
Firmware/
├── Binary-Policy.md
├── Build-Environment.md
├── OpenWrt-17.01.7/
│   ├── README.md
│   ├── configs/
│   ├── files/
│   ├── patches/
│   └── notes/
└── Releases/
    └── README.md
```

## Recovery Image Warning

A recovery image should not overwrite board-specific factory data unless explicitly designed to do so.

Preferred recovery approach:

- Preserve early partitions from the user's own board.
- Restore firmware partition only when possible.
- Restore factory partition from the same board.
- Use full flash restore only when the image belongs to that exact board or has been carefully assembled.

## Full Flash Image Warning Label

Any full flash image, if ever included privately or publicly, must have a warning like this:

```text
WARNING:
This is a full flash image.
It may overwrite U-Boot, U-Boot environment, factory data, MAC address, RF calibration, and firmware.
Do not flash this to another board unless you understand the risks.
Use an external SPI programmer only.
```

## U-Boot Warning Label

Any U-Boot binary reference must include:

```text
WARNING:
This is a bootloader image.
Flashing the wrong U-Boot can hard-brick the A5-V11.
Confirm RAM size, flash size, board revision, and recovery method before use.
Back up the original U-Boot first.
```

## Factory Partition Warning Label

Any factory partition reference must include:

```text
WARNING:
The factory partition is board-specific.
It may contain MAC address, Wi-Fi calibration, and RF calibration data.
Do not copy factory data from another board unless you understand the consequences.
```

## Sysupgrade Warning Label

Any sysupgrade image must include:

```text
WARNING:
This image is for sysupgrade from an existing OpenWrt install.
Do not program it as a full flash image.
Do not use it from stock firmware unless specifically documented.
```

## Factory Image Warning Label

Any factory image must include:

```text
WARNING:
This image is intended for first install through a compatible stock firmware or bootloader method.
Stock firmware behavior varies between A5-V11 units.
Verify recovery options before flashing.
```

## Commit Message Suggestions

When adding firmware metadata or release files, use clear commit messages.

Examples:

```text
Add binary policy for firmware files
Add metadata template for A5-V11 firmware releases
Add checksum notes for firmware releases
Add PS2 bridge firmware build config
Add OpenWrt 17.01.7 files overlay for UDPBD test
```

Avoid vague messages:

```text
add files
firmware stuff
new bin
test
```

## Maintainer Rule

Before accepting any binary into the repo, ask:

```text
Can this be rebuilt from source or documented instead?
```

If yes, do that.

If no, ask:

```text
Is hosting this binary legal, useful, safe, credited, checksummed, and clearly documented?
```

If not, do not include it.

## Short Version

This repo should not become a dumping ground for firmware files.

The safe policy is:

- Prefer source, configs, patches, scripts, and instructions.
- Keep board-specific flash dumps private.
- Keep factory partitions private.
- Do not upload unknown binaries.
- Do not upload copyrighted PS2 files.
- Do not upload U-Boot files without extreme caution.
- Include checksums and metadata for every allowed binary.
- Clearly document target board, flash size, install method, recovery method, and risk.
- Credit upstream authors.
- When unsure, link to the original source instead of hosting the file.

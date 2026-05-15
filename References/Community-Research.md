# Community Research

## Summary

This document tracks community research, external references, historical notes, tutorials, forum posts, GitHub projects, archived pages, and other public information related to the A5-V11 mini router.

The A5-V11 project is heavily based on work already done by other people.

This repo should not pretend that the information started here.

The goal is to collect, organize, verify, preserve, and credit useful A5-V11 information in one place, especially for PlayStation 2 use.

---

## Purpose

The purpose of this file is to document:

- Where A5-V11 information came from
- Who originally discovered or published key information
- Which sources are confirmed
- Which sources are unverified
- Which guides are outdated
- Which information applies to stock boards
- Which information applies to modified boards
- Which information applies to PS2 use
- Which information needs more testing
- Which claims conflict with other sources

This file should help prevent the repo from becoming a pile of copied notes with no source history.

---

## Main Rule

The main rule is:

```text
Credit the original source whenever possible.
```

The second rule is:

```text
Do not treat community notes as confirmed until they are tested or cross-checked.
```

Community research is valuable, but A5-V11 hardware and firmware can vary.

A method that worked for one person may not work on every board.

---

## Research Philosophy

This repo should use community research in a careful way.

Good research behavior:

- Credit original authors
- Link to original sources
- Save source dates
- Preserve context
- Mark unverified claims
- Test claims when possible
- Record hardware variants
- Record firmware versions
- Record bootloader behavior
- Record flash size and RAM size
- Avoid rewriting history
- Avoid claiming ownership of other people’s work

Bad research behavior:

- Copying work without credit
- Reposting binaries without license clarity
- Treating old guides as universally true
- Ignoring board variants
- Mixing stock firmware and OpenWrt notes
- Mixing 4 MB and 16 MB flash notes
- Mixing UDPBD and UDPFS notes
- Using another board’s factory data
- Presenting untested claims as confirmed

---

## Why Community Research Matters

The A5-V11 is a cheap legacy mini router with many scattered sources of information.

Useful information may be found in:

- OpenWrt wiki pages
- Old blog posts
- GitHub repositories
- Archived webpages
- Forum posts
- Discord discussions
- YouTube comments
- Router teardown posts
- Firmware build notes
- Personal testing notes
- UART boot logs
- Flash dumps
- Photos of board variants

No single source explains everything.

This repo should become a clean index and verification layer for that scattered research.

---

## Primary Research Areas

Community research for this repo should focus on:

- Board identification
- Stock firmware behavior
- Stock bootloader behavior
- UART pinout and baud rate
- Flash layout
- Factory partition handling
- OpenWrt support
- LEDE/OpenWrt legacy builds
- Flash upgrades
- U-Boot recovery
- TFTP recovery
- CH341A recovery
- Wi-Fi antenna modifications
- Power improvements
- Capacitor modifications
- Supervisor IC modifications
- USB storage support
- SMB1/OPL support
- UDPBD support
- UDPFS support
- PS2 integration
- Internal mounting
- Thermal behavior
- Known issues and brick symptoms

---

## Source Categories

Use these categories when documenting sources.

| Category | Description |
|---|---|
| Official project documentation | Documentation from the original software or hardware project |
| OpenWrt documentation | OpenWrt wiki, forum, build system, device pages |
| GitHub repository | Source code, README files, issues, releases, commits |
| Blog post | Personal or technical blog writeup |
| Forum post | Community discussion or guide |
| Discord discussion | Chat-based research or developer discussion |
| Video | YouTube or other video tutorial |
| Datasheet | Component manufacturer documentation |
| Boot log | UART or system log from a real board |
| Photo evidence | Board photos, markings, routing, component IDs |
| Personal test result | Testing performed for this repo |
| Archived source | Wayback Machine or saved copy of a dead page |
| Unknown source | Source not fully identified yet |

---

## Source Reliability Levels

Use these reliability levels.

| Level | Meaning |
|---|---|
| Confirmed | Tested and verified by this repo |
| Strong Reference | Reliable source and matches other evidence |
| Useful Reference | Helpful but not fully tested |
| Historical | Useful for history, may be outdated |
| Unverified | Not tested yet |
| Conflicting | Conflicts with another source |
| Deprecated | Superseded by better information |
| Broken Link | Source no longer available |
| Needs Archive | Should be archived or saved |
| Do Not Use Blindly | Risky or incomplete information |

---

## Claim Status Labels

Use these labels for individual claims.

| Label | Meaning |
|---|---|
| Verified | Confirmed by testing |
| Cross-Checked | Matches at least two independent sources |
| Plausible | Makes sense but not tested |
| Unverified | Not confirmed |
| Board-Specific | Only applies to one board or revision |
| Firmware-Specific | Only applies to one firmware version |
| Bootloader-Specific | Only applies to one U-Boot version |
| Flash-Size-Specific | Depends on 4 MB, 8 MB, or 16 MB flash |
| PS2-Specific | Applies specifically to PS2 integration |
| Risky | Could brick or damage hardware |
| Incorrect | Tested and found wrong |
| Needs Retest | Old result or uncertain conditions |

---

## Attribution Policy

Always credit sources.

At minimum, record:

- Source title
- Author or username
- Platform
- Original URL
- Date published, if known
- Date accessed
- Summary of what the source contributes
- Whether the information was tested
- Whether the information was modified
- Whether the source includes binaries
- Whether license terms are known

---

## Source Entry Template

Use this template for each source.

```text
# Source Entry

## Basic Info

Title:
Author / Username:
Platform:
Original URL:
Archive URL:
Date published:
Date accessed:
Language:
Source type:

## What It Covers

Topics:
Hardware covered:
Firmware covered:
Flash size:
RAM size:
Bootloader:
PS2 relevance:

## Key Information

Summary:
Important details:
Commands:
Files mentioned:
Images or diagrams:
Warnings:

## Verification

Status:
Tested by this repo:
Test date:
Test board ID:
Result:
Conflicts:
Notes:

## Credit

Credit line:
License notes:
Redistribution notes:
```

---

## Community Credit Format

Use a simple credit format.

Example:

```text
Credit:
This note is based on community research by <author/username> from <source/platform>.
Original source: <URL>
```

For multiple sources:

```text
Credit:
This section combines information from the OpenWrt A5-V11 page, Gorgylka's A5-V11 UDPBD notes, Scargill's A5-V11 blog testing, and additional bench testing performed for this repo.
```

---

## Known Important Source Types

This repo should track information from sources such as:

- OpenWrt A5-V11 wiki notes
- A5-V11 OpenWrt forum posts
- Scargill A5-V11 blog notes
- Gorgylka A5-V11 UDPBD work
- Sudonull A5-V11 tutorial notes
- LEDE/OpenWrt build references
- RT5350F documentation
- Winbond flash datasheets
- RAM chip datasheets
- U-Boot notes
- PS2 OPL UDPBD discussions
- PS2 UDPFS and Neutrino discussions
- Personal UART boot logs
- Personal flash dump analysis
- Personal PS2 integration tests

This list can grow as more sources are found.

---

## Do Not Mirror Everything

This repo should not blindly mirror every file found online.

Prefer:

- Links
- Summaries
- Metadata
- Checksums
- Build instructions
- Patches
- Config files
- Notes
- Source credit

Avoid mirroring:

- Unknown binaries
- Random firmware files
- U-Boot images with unclear license
- Full flash dumps
- Factory partitions
- Personal board backups
- Copyrighted files
- PS2 BIOS files
- Game files

---

## Binary Source Warning

Community sources may include binary firmware files.

Do not upload those binaries into this repo unless:

- The source is known
- The license allows redistribution
- The target board is known
- The flash size is known
- The RAM size is known
- The image type is known
- The risk is documented
- A checksum is included
- The file is useful enough to justify inclusion

When in doubt, link to the original source instead.

---

## Factory Partition Warning

Do not collect or publish random factory partitions.

Factory partitions may contain:

- MAC addresses
- Wi-Fi calibration data
- RF calibration data
- Board-specific values

This repo should explain how to back up and preserve factory data, not distribute other people’s factory partitions.

---

## U-Boot Source Warning

U-Boot files are high risk.

A community source may mention a U-Boot file such as:

```text
uboot_usb_256_03.img
```

or similar files.

Before using any U-Boot file, confirm:

- Source
- Target SoC
- Target board
- Target RAM size
- Target flash size
- Bootloader features
- Recovery method
- Checksum
- Test status

Do not flash U-Boot from an old guide blindly.

---

## 128 / 256 U-Boot Naming Warning

Some community notes use U-Boot filenames with `128` or `256`.

A common warning is:

```text
128 may indicate 16 MB RAM.
256 may indicate 32 MB RAM.
```

This must be verified per source.

Do not assume the filename is self-explanatory.

Always confirm the actual RAM chip and boot log.

---

## Language And Translation Notes

Some useful A5-V11 sources are not in English.

When using translated sources:

- Save the original source language
- Save the translated meaning
- Avoid over-interpreting machine translation
- Preserve technical terms
- Cross-check commands and offsets
- Mark translation uncertainty

Translation mistakes can cause serious firmware errors.

---

## Archived Pages

Some A5-V11 sources may disappear.

For important pages:

- Save the original URL
- Save an archive URL if available
- Record date accessed
- Record page title
- Record author
- Save only allowed content
- Do not rehost copyrighted material without permission

Use archive links for preservation, but keep credit to the original source.

---

## Dead Link Handling

If a source link is dead:

1. Mark it as `Broken Link`.
2. Search for an archived copy.
3. Search for mirrors.
4. Search for quoted references in other posts.
5. Record what was found.
6. Do not invent missing details.
7. Mark information as unverified if the original cannot be checked.

Template:

```text
Original URL:
Current status: Broken Link
Archive found: Yes or no
Archive URL:
Information recovered:
Information still missing:
```

---

## Quoting Policy

Use short quotes only when needed.

Prefer paraphrasing and summarizing.

If quoting:

- Keep quote short
- Use blockquote formatting
- Credit the source
- Include URL
- Include date accessed
- Do not quote large sections of copyrighted material

Example:

```text
> Short quoted sentence from source.

Credit:
Author, source title, URL, accessed date.
```

---

## Discord And Chat Research

Discord and chat logs can contain useful technical history, but they need careful handling.

When documenting Discord research:

- Preserve usernames only when appropriate
- Credit people when they contributed technical work
- Avoid exposing private information
- Avoid reposting private conversations without permission
- Separate raw logs from summarized research
- Mark claims as unverified until tested
- Keep context around technical claims

If the discussion was public and relevant, summarize the technical point and credit the contributor.

---

## Forum Research

Forum posts are often valuable but can be outdated.

When using forum posts:

- Record forum name
- Record thread title
- Record post author
- Record post date
- Record URL
- Record whether images/files still exist
- Note if the advice is old
- Cross-check before using risky commands

Forum posts are references, not final truth.

---

## Blog Research

Blog posts can include practical experience and warnings.

When using blog posts:

- Record author
- Record post title
- Record date
- Record URL
- Record what hardware was tested
- Record whether the post was updated
- Separate opinion from measured results
- Cross-check commands before using them

---

## GitHub Research

GitHub repositories can provide:

- Source code
- Build scripts
- README notes
- Issue discussions
- Release binaries
- Commit history
- Configuration files
- Patches

When documenting GitHub sources, record:

- Repository owner
- Repository name
- URL
- Commit hash or release version
- License
- Files referenced
- Whether the repo is active or archived
- Whether binaries are included
- Whether source is buildable

Use commit hashes when possible.

---

## GitHub Source Template

```text
# GitHub Source

Repository:
Owner:
URL:
License:
Branch:
Commit:
Release:
Files referenced:
Purpose:
Build status:
Test status:
Notes:
```

---

## Datasheet Research

Datasheets should be used for component-level facts.

Examples:

- RT5350F SoC
- SPI flash chips
- RAM chips
- Supervisor ICs
- Voltage regulators
- Ethernet magnetics
- USB connectors
- Capacitors

Record:

- Manufacturer
- Part number
- Datasheet URL
- Revision/date
- Key specs used
- Package
- Voltage
- Pinout
- Notes

---

## Datasheet Source Template

```text
# Datasheet Source

Part number:
Manufacturer:
Description:
Datasheet URL:
Revision:
Date:
Package:
Voltage:
Key specs used:
Notes:
```

---

## Personal Testing Versus Community Claims

Separate community claims from personal test results.

Good:

```text
Community claim:
Some guides state that the A5-V11 can use TFTP recovery from U-Boot.

Repo test result:
Board-001 shows U-Boot menu option 2 for loading system code and writing to flash through TFTP.
```

Bad:

```text
All A5-V11 routers have TFTP recovery.
```

Avoid universal claims unless many boards have been tested.

---

## Verification Levels

Use this verification table.

| Verification Level | Description |
|---|---|
| Level 0 | Source found, not reviewed |
| Level 1 | Source read and summarized |
| Level 2 | Source matches at least one other source |
| Level 3 | Tested on one A5-V11 board |
| Level 4 | Tested on multiple A5-V11 boards |
| Level 5 | Tested on PS2 integration setup |
| Level 6 | Tested inside closed-shell PS2 build |
| Level 7 | Long-run tested and recommended |

---

## Claim Verification Template

```text
# Claim Verification

Claim:
Source:
Source type:
Risk level:
Applies to:
Board tested:
Firmware tested:
Flash size:
RAM size:
Test method:
Result:
Verification level:
Notes:
```

---

## Handling Conflicting Information

Community sources may disagree.

When sources conflict:

1. Do not pick one blindly.
2. Record both claims.
3. Identify hardware differences.
4. Identify firmware differences.
5. Identify flash size differences.
6. Identify bootloader differences.
7. Test if possible.
8. Mark the result clearly.

Example:

```text
Conflict:
One source says TFTP recovery uses router IP 192.168.1.1 and PC IP 192.168.1.2.
Another source suggests a bootloader auto-fetch pattern using PC IP 192.168.1.55.

Resolution:
Treat this as bootloader-specific until tested on each board.
Use UART and Wireshark to confirm behavior.
```

---

## Hardware Variant Notes

The A5-V11 may have variants.

Record:

- PCB markings
- RAM chip
- Flash chip
- Antenna style
- Button layout
- LED behavior
- Ethernet jack type
- USB connector type
- Bootloader version
- Stock firmware behavior

Do not assume one board represents all boards.

---

## Hardware Variant Template

```text
# Hardware Variant Record

Board ID:
PCB marking:
SoC:
RAM chip:
RAM size:
Flash chip:
Flash size:
Ethernet jack:
USB port:
micro-USB:
Antenna:
Buttons:
LEDs:
Stock firmware:
U-Boot version:
Notes:
```

---

## Firmware Variant Notes

Different A5-V11 firmware versions may behave differently.

Record:

- Stock firmware version
- Stock IP
- Login credentials
- Web UI behavior
- Telnet availability
- SSH availability
- Firmware update behavior
- TFTP behavior
- U-Boot behavior
- OpenWrt version
- Package set
- Default network config

---

## Firmware Variant Template

```text
# Firmware Variant Record

Firmware name:
Source:
Version:
Image type:
Flash size:
RAM requirement:
Default IP:
Login:
Web UI:
Telnet:
SSH:
UART:
TFTP:
USB:
Wi-Fi:
Ethernet:
Known issues:
Notes:
```

---

## PS2-Specific Research Notes

For PS2 use, community research should separate:

- General A5-V11 router behavior
- PS2 FTP behavior
- OPL SMB behavior
- UDPBD behavior
- UDPFS behavior
- Neutrino behavior
- NHDDL behavior
- Internal mounting behavior
- PS2 power behavior
- PS2 boot timing behavior

Do not assume a router feature is useful for PS2 until tested with the actual PS2 loader.

---

## PS2 Research Template

```text
# PS2 Research Source

Source:
Author:
URL:
PS2 model:
Loader:
Loader version:
A5-V11 firmware:
Network mode:
Storage:
Filesystem:
Claim:
Tested by repo:
Result:
Notes:
```

---

## UDPBD Research Notes

UDPBD information must record exact versions.

Record:

- Router firmware
- UDPBD server binary
- Architecture
- OPL UDPBD build
- USB filesystem
- USB hotplug behavior
- Boot timing
- Required delay
- Whether USB must be inserted before boot
- PS2 model
- Result

UDPBD is version-sensitive.

Do not mix UDPBD notes with normal SMB or UDPFS notes.

---

## UDPFS Research Notes

UDPFS information must be documented separately from UDPBD.

Record:

- UDPFS server version
- PS2-side loader
- Loader version
- Network mode
- Storage path
- Firmware build
- Flash size
- Result
- Known issues

Do not assume UDPFS behavior matches UDPBD.

---

## SMB Research Notes

SMB research should record:

- SMB server type
- Samba version
- SMB protocol level
- NT1/SMB1 settings
- Guest access
- Username/password behavior
- OPL version
- Share name
- Folder layout
- Performance
- A5-V11 RAM use
- Flash size

SMB can be heavy for the A5-V11.

Mark RAM and flash limitations clearly.

---

## OpenWrt Research Notes

OpenWrt research should record:

- OpenWrt version
- Target
- Subtarget
- Device profile
- Build method
- Config file
- Package list
- Flash size
- RAM size
- Image type
- Default IP
- UART behavior
- Recovery method

OpenWrt version matters.

A guide written for one branch may not apply cleanly to another.

---

## OpenWrt Source Template

```text
# OpenWrt Research Source

OpenWrt version:
Target:
Subtarget:
Device:
Source URL:
Author:
Date:
Build method:
Image type:
Flash size:
RAM size:
Packages:
Known issues:
Test status:
Notes:
```

---

## Risk Levels For Research Claims

Use these risk levels.

| Risk | Meaning |
|---|---|
| Low | Documentation only or safe observation |
| Medium | Config change that can lock out network |
| High | Firmware flashing or partition write |
| Critical | U-Boot, factory data, full flash, hardware modification |

Examples:

| Claim | Risk |
|---|---|
| Default IP address | Low |
| UART baud rate | Low |
| OpenWrt network interface name | Medium |
| Sysupgrade procedure | High |
| Factory partition restore | Critical |
| U-Boot replacement | Critical |
| Flash chip upgrade | Critical |

---

## Research Table

Use this table for high-level source tracking.

| Source ID | Title | Author | Type | Status | Main Topic | URL |
|---|---|---|---|---|---|---|
| SRC-001 |  |  |  |  |  |  |
| SRC-002 |  |  |  |  |  |  |
| SRC-003 |  |  |  |  |  |  |
| SRC-004 |  |  |  |  |  |  |

---

## Claim Table

Use this table to track important claims.

| Claim ID | Claim | Source ID | Status | Risk | Tested | Notes |
|---|---|---|---|---|---|---|
| CLM-001 |  |  |  |  |  |  |
| CLM-002 |  |  |  |  |  |  |
| CLM-003 |  |  |  |  |  |  |
| CLM-004 |  |  |  |  |  |  |

---

## Test Evidence Table

Use this table to connect research claims to actual tests.

| Test ID | Claim ID | Board ID | Firmware | Result | Notes |
|---|---|---|---|---|---|
| TST-001 |  |  |  |  |  |
| TST-002 |  |  |  |  |  |
| TST-003 |  |  |  |  |  |

---

## Recommended Source IDs

Use source IDs to keep notes organized.

Suggested format:

```text
SRC-001
SRC-002
SRC-003
```

For claims:

```text
CLM-001
CLM-002
CLM-003
```

For tests:

```text
TST-001
TST-002
TST-003
```

This makes it easier to link sources, claims, and test results.

---

## Research Workflow

Recommended workflow:

1. Find source.
2. Save source title and URL.
3. Identify author.
4. Record date accessed.
5. Summarize what it says.
6. Identify risky claims.
7. Identify files or commands mentioned.
8. Check for license issues.
9. Check for board-specific assumptions.
10. Cross-check with other sources.
11. Test on bench if safe.
12. Record result.
13. Update docs with attribution.
14. Mark unresolved claims clearly.

---

## Testing Before Documentation

For risky claims, test before making them sound final.

Risky claims include:

- Flash layout
- Firmware image type
- TFTP recovery method
- U-Boot replacement
- 16 MB flash upgrade
- Factory partition restore
- PS2 power source
- Internal Ethernet wiring
- SMB1 configuration
- UDPBD behavior
- UDPFS behavior

If not tested, mark as unverified.

---

## Handling Old Guides

Old guides can still be useful.

However, old guides may contain:

- Dead links
- Outdated firmware
- Unsupported OpenWrt branches
- Old bootloader files
- Missing warnings
- Different board variants
- Different RAM sizes
- Different flash sizes
- Commands that assume a specific environment

When using an old guide, add a note:

```text
This guide is historical. Verify all commands, offsets, filenames, and image types before use.
```

---

## Handling Images And Diagrams From Sources

Do not copy images from other sources into the repo unless permission is clear.

Preferred approach:

- Link to original image source
- Describe what the image shows
- Create your own photo or diagram
- Credit the original source if it inspired the diagram

If using your own images, label them clearly.

---

## Handling Commands From Sources

Commands from old guides can be dangerous.

Before using a command, identify:

- What device it writes to
- What partition it targets
- What file it uses
- Whether it erases flash
- Whether it writes U-Boot
- Whether it writes factory data
- Whether it assumes 4 MB flash
- Whether it assumes a specific U-Boot

Mark dangerous commands with warnings.

---

## Command Review Template

```text
# Command Review

Command:
Source:
Purpose:
Writes flash:
Partition affected:
Risk level:
Assumptions:
Tested:
Result:
Safer alternative:
Notes:
```

---

## Example Dangerous Command Review

```text
Command:
mtd_write write /mnt/uboot_usb_256_03.img Bootloader

Purpose:
Write replacement U-Boot from stock firmware shell.

Risk:
Critical.

Assumptions:
Correct U-Boot file.
Correct RAM size.
Correct board.
Stable power.
CH341A recovery available.

Status:
Do not use blindly.
```

---

## Research Notes Folder

Suggested folder structure:

```text
References/
├── Community-Research.md
├── Datasheets/
├── Research-Links.md
├── Source-Notes/
│   ├── SRC-001-openwrt-a5-v11.md
│   ├── SRC-002-scargill-a5-v11.md
│   ├── SRC-003-gorgylka-a5-v11.md
│   └── SRC-004-sudonull-a5-v11.md
├── Claim-Tracking/
│   ├── Claims.md
│   └── Conflicts.md
└── Archived-Notes/
    └── README.md
```

---

## Source Note File Naming

Use simple file names.

Examples:

```text
SRC-001-openwrt-a5-v11.md
SRC-002-scargill-a5-v11.md
SRC-003-gorgylka-udpbd.md
SRC-004-sudonull-a5-v11.md
SRC-005-rt5350f-datasheet.md
```

---

## Research Link Format

Use this format for links.

```text
- Title:
  - Author:
  - URL:
  - Archive:
  - Date accessed:
  - Status:
  - Notes:
```

---

## Example Research Link Entry

```text
- Title: A5-V11 OpenWrt Wiki
  - Author: OpenWrt community
  - URL: <original URL>
  - Archive: <archive URL if available>
  - Date accessed: YYYY-MM-DD
  - Status: Strong Reference
  - Notes: Useful for hardware overview, flash layout, UART, OpenWrt support, and recovery notes.
```

---

## Credits Section Policy

Every major document that uses outside research should have a credit section or source note.

Example:

```text
## Credits

This document was built from personal testing and community research, including OpenWrt A5-V11 notes, A5-V11 blog posts, GitHub repositories, and PS2 homebrew community discussions.
```

If a specific source strongly influenced a section, credit it directly.

---

## Ownership And Respect

This repo should respect community work.

Do:

- Credit people
- Link to their work
- Keep their names attached to their discoveries
- Clearly mark your own testing
- Clearly mark modifications
- Ask permission before mirroring files when needed

Do not:

- Strip credits
- Rename someone else’s work as your own
- Rehost binaries without permission
- Copy full guides without permission
- Present community discoveries as original

---

## Public Repo Safety

This repo should avoid publishing:

- Private flash dumps
- Factory partitions
- Personal MAC addresses
- Wi-Fi passwords
- Private IP details
- Game files
- PS2 BIOS files
- Commercial software
- Private chat logs without permission
- Unknown binaries
- Customer data

Community research should be useful without exposing private or copyrighted material.

---

## Recommended Disclaimer

Use this general disclaimer when needed:

```text
This repo collects and tests community information about the A5-V11 mini router. Some notes are based on older sources, specific board variants, or experimental firmware. Verify your board, flash size, RAM size, and recovery method before flashing or modifying hardware.
```

---

## Maintenance Tasks

Periodic maintenance:

- Check old links
- Add archive links
- Update source statuses
- Mark broken links
- Update tested claims
- Add new UART logs
- Add new board variants
- Add new firmware test results
- Add new PS2 compatibility results
- Remove or clarify outdated claims
- Improve credits

---

## Do Not Do This

Avoid these mistakes:

- Do not copy community work without credit.
- Do not host unknown firmware binaries.
- Do not host personal factory partitions.
- Do not host PS2 BIOS or game files.
- Do not treat old guides as universally correct.
- Do not flash U-Boot from a source without checking RAM size.
- Do not mix UDPBD and UDPFS notes.
- Do not mix 4 MB and 16 MB flash instructions.
- Do not claim a method works on all boards after one test.
- Do not publish private Discord logs without permission.
- Do not remove author names from community discoveries.

---

## Short Version

This repo is built on community research.

Use this file to track:

- Sources
- Authors
- Links
- Claims
- Test results
- Conflicts
- Warnings
- Credits

The safest approach is:

```text
Credit sources.
Verify claims.
Document board differences.
Mark untested information.
Do not rehost risky binaries.
Protect factory data.
Preserve community history honestly.
```

The goal is not to take credit for other people’s work.

The goal is to organize, test, preserve, and extend it for A5-V11 and PS2 use.

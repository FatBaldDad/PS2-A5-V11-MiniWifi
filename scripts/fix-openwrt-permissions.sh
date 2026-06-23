#!/bin/sh

# Prepare OpenWrt overlay files before building firmware.
# This script is intentionally limited to file permission and line-ending fixes.

set -eu

repo_root="$(pwd)"

required_files='
openwrt-files/etc/init.d/ps2bridge
openwrt-files/usr/bin/ps2bridge-status
openwrt-files/www/cgi-bin/ps2/status
'

printf '%s\n' '[INFO] Preparing OpenWrt overlay files...'

case "$repo_root" in
    *PS2-A5-V11-MiniWifi)
        ;;
    *)
        printf '%s\n' '[ERROR] Run this script from the PS2-A5-V11-MiniWifi repo root.' >&2
        exit 2
        ;;
esac

missing_files=0

for file_path in $required_files; do
    if [ ! -f "$file_path" ]; then
        printf '%s\n' "[ERROR] Required file is missing: $file_path" >&2
        missing_files=1
    fi
done

if [ "$missing_files" -ne 0 ]; then
    exit 1
fi

if command -v dos2unix >/dev/null 2>&1; then
    printf '%s\n' '[INFO] Normalizing line endings with dos2unix...'
    for file_path in $required_files; do
        dos2unix "$file_path" >/dev/null 2>&1 || true
    done
else
    printf '%s\n' '[INFO] dos2unix not found; skipping line-ending normalization.'
fi

printf '%s\n' '[INFO] Making OpenWrt overlay files executable...'
chmod +x openwrt-files/etc/init.d/ps2bridge
chmod +x openwrt-files/usr/bin/ps2bridge-status
chmod +x openwrt-files/www/cgi-bin/ps2/status

printf '%s\n' '[SUCCESS] OpenWrt overlay files are ready.'
exit 0
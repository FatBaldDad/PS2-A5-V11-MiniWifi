# Sync static WebUI assets from docs/webui-preview into the OpenWrt overlay path.
# This script copies only index.html, css, and js to openwrt-files/www/ps2.
# It intentionally does not copy README.md or mock-api content.

[CmdletBinding()]
param ()

$ErrorActionPreference = "Stop"

try {
    $repoRoot = Split-Path -Path $PSScriptRoot -Parent
    $sourceDir = Join-Path -Path $repoRoot -ChildPath "docs/webui-preview"
    $targetDir = Join-Path -Path $repoRoot -ChildPath "openwrt-files/www/ps2"

    Write-Host "[INFO] Starting WebUI sync..."
    Write-Host "[INFO] Source: $sourceDir"
    Write-Host "[INFO] Target: $targetDir"

    if (-not (Test-Path -Path $sourceDir -PathType Container)) {
        throw "Source directory not found: $sourceDir"
    }

    # Ensure the OpenWrt overlay target directory exists.
    if (-not (Test-Path -Path $targetDir -PathType Container)) {
        Write-Host "[INFO] Creating target directory..."
        New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
    }

    $requiredItems = @("index.html", "css", "js")

    foreach ($item in $requiredItems) {
        $sourcePath = Join-Path -Path $sourceDir -ChildPath $item

        if (-not (Test-Path -Path $sourcePath)) {
            throw "Required source item is missing: $sourcePath"
        }

        Write-Host "[INFO] Copying $item..."
        Copy-Item -Path $sourcePath -Destination $targetDir -Recurse -Force
    }

    Write-Host "[INFO] Skipped by design: README.md and mock-api"
    Write-Host "[SUCCESS] WebUI sync completed."
    exit 0
}
catch {
    Write-Error "[ERROR] WebUI sync failed: $($_.Exception.Message)"
    exit 1
}

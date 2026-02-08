<#
.SYNOPSIS
    Publishes the Copilot Brain instruction files to the global VS Code prompts location.

.DESCRIPTION
    Copies instruction files from this repository to %APPDATA%\Code\User\prompts\
    so they apply to ALL VS Code workspaces, not just this repository.

.PARAMETER Force
    Overwrite existing files without prompting.

.EXAMPLE
    .\publish-brain.ps1
    .\publish-brain.ps1 -Force
#>

param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"

# Source and destination paths
$SourceDir = Join-Path $PSScriptRoot ".github\instructions"
$DestDir = Join-Path $env:APPDATA "Code\User\prompts"

Write-Host "Publishing Skyrim Modding Copilot Brain to global location..." -ForegroundColor Cyan
Write-Host "Source: $SourceDir" -ForegroundColor Gray
Write-Host "Destination: $DestDir" -ForegroundColor Gray
Write-Host ""

# Create destination directory if it doesn't exist
if (-not (Test-Path $DestDir)) {
    Write-Host "Creating prompts directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
}

# Get all instruction files
$Files = Get-ChildItem -Path $SourceDir -Filter "*.instructions.md" -Recurse

if ($Files.Count -eq 0) {
    Write-Host "No instruction files found in $SourceDir" -ForegroundColor Red
    exit 1
}

Write-Host "Found $($Files.Count) instruction files:" -ForegroundColor Green

foreach ($File in $Files) {
    $DestPath = Join-Path $DestDir $File.Name
    $Exists = Test-Path $DestPath
    
    if ($Exists -and -not $Force) {
        $Response = Read-Host "  $($File.Name) exists. Overwrite? (Y/n)"
        if ($Response -eq "n" -or $Response -eq "N") {
            Write-Host "  Skipped: $($File.Name)" -ForegroundColor Yellow
            continue
        }
    }
    
    Copy-Item -Path $File.FullName -Destination $DestPath -Force
    $Status = if ($Exists) { "Updated" } else { "Created" }
    Write-Host "  $Status`: $($File.Name)" -ForegroundColor Green
}

# Also copy the main copilot-instructions.md if it exists
$MainFile = Join-Path $PSScriptRoot ".github\copilot-instructions.md"
if (Test-Path $MainFile) {
    $DestPath = Join-Path $DestDir "copilot-instructions.md"
    $Exists = Test-Path $DestPath
    
    if ($Exists -and -not $Force) {
        $Response = Read-Host "  copilot-instructions.md exists. Overwrite? (Y/n)"
        if ($Response -ne "n" -and $Response -ne "N") {
            Copy-Item -Path $MainFile -Destination $DestPath -Force
            Write-Host "  Updated: copilot-instructions.md" -ForegroundColor Green
        } else {
            Write-Host "  Skipped: copilot-instructions.md" -ForegroundColor Yellow
        }
    } else {
        Copy-Item -Path $MainFile -Destination $DestPath -Force
        $Status = if ($Exists) { "Updated" } else { "Created" }
        Write-Host "  $Status`: copilot-instructions.md" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "Done! Brain published to: $DestDir" -ForegroundColor Cyan
Write-Host "These instructions will now apply to ALL VS Code workspaces." -ForegroundColor Gray

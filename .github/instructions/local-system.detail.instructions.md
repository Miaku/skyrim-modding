---
name: "local-system-detail"
description: "Local system detection paths, Skyrim installs, Vortex configuration, and installed mods\nKeywords: system, install, path, version, Vortex, mod list, installed, detect, local, staging, deployment, load order, SKSE, profile"
---

# Local System Reference

> **Path Volatility Warning**: Drive letters and install paths below were detected as of Feb 2026.
> They may change if a game is reinstalled to a different drive, Steam libraries are reorganized,
> or Vortex staging folders are reconfigured. When a hardcoded path fails, use the
> **Dynamic Path Discovery** section at the bottom to re-detect current locations.

## Skyrim Installations

### Skyrim VR
| Property | Value |
|----------|-------|
| Install Path | `D:\SteamLibrary\steamapps\common\SkyrimVR` |
| Executable | `SkyrimVR.exe` |
| Runtime Version | **1.4.15.0** |
| Steam App ID | 611670 |
| Steam Library | `D:\SteamLibrary` |
| SKSE | SKSEVR 2.0.12 (`sksevr_1_4_15.dll`) |
| Data Folder | `D:\SteamLibrary\steamapps\common\SkyrimVR\Data` |

### Skyrim SE (Anniversary Edition)
| Property | Value |
|----------|-------|
| Install Path | `C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition` |
| Executable | `SkyrimSE.exe` |
| Runtime Version | **1.6.1170.0** (AE) |
| Steam App ID | 489830 |
| Steam Library | `C:\Program Files (x86)\Steam` |
| SKSE | SKSE64 2.2.6 (`skse64_1_6_1170.dll`) |
| Data Folder | `C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\Data` |
| Creation Club | Yes — full AE content (70+ CC plugins in load order) |

## Vortex Mod Manager

### Application
| Property | Value |
|----------|-------|
| Install Path | `C:\Program Files\Black Tree Gaming Ltd\Vortex` |
| Version | 1.15.2 |
| Config / State | `%APPDATA%\Vortex` (Roaming) |
| Cache / Electron | `%LOCALAPPDATA%\Vortex` (Local) |

### Data Locations

| Data Type | Path | Notes |
|-----------|------|-------|
| Per-game profiles | `%APPDATA%\Vortex\{gameId}\profiles\` | INIs, plugins.txt, loadorder.txt |
| Per-game masterlist | `%APPDATA%\Vortex\{gameId}\masterlist\` | LOOT masterlist |
| State database | `%APPDATA%\Vortex\state.v2\` | LevelDB — mod metadata, settings |
| VR mod staging | `D:\Vortex Mods\skyrimvr\` | Staging folder (user-configured, may move) |
| SE mod staging | `%APPDATA%\Vortex\skyrimse\mods\` | Staging folder (default location) |
| Downloads | `%APPDATA%\Vortex\downloads\` | Downloaded archives |

> **Note**: `%APPDATA%\Vortex` paths are stable (tied to Windows user profile). Game install paths
> and the VR staging folder on `D:` are more likely to change.

### Deployment Manifests (Best Data Source)
Vortex writes JSON manifests to each game's install directory listing every deployed file and its source mod. These are the **most reliable** way to determine what's actually active:

| Game | Manifest Path | File Count |
|------|--------------|------------|
| VR (root) | `D:\SteamLibrary\steamapps\common\SkyrimVR\vortex.deployment.dinput.json` | 571 files |
| VR (Data) | `D:\SteamLibrary\steamapps\common\SkyrimVR\Data\vortex.deployment.json` | 16,192 files |
| SE (root) | `...\Skyrim Special Edition\vortex.deployment.dinput.json` | 536 files |
| SE (Data) | `...\\Skyrim Special Edition\\Data\\vortex.deployment.json` | 16,690 files |

### Detection Strategy (Efficiency Ranking)
1. **Deployment manifests** (fastest, most accurate) — JSON files in game directory, lists every deployed file + source mod
2. **Staging folders** — directory names contain mod name + Nexus ID + version + timestamp
3. **Profile plugins.txt / loadorder.txt** — shows enabled plugins and load order
4. **State LevelDB** — comprehensive but requires LevelDB parsing; overkill for most queries

### Vortex Profile IDs

| Game | Profile ID | Profile Path |
|------|-----------|-------------|
| Skyrim VR | `HJe4qMiHWx` | `%APPDATA%\Vortex\skyrimvr\profiles\HJe4qMiHWx\` |
| Skyrim SE | `rkfJlyujJl` | `%APPDATA%\Vortex\skyrimse\profiles\rkfJlyujJl\` |

## Installed Mods — Skyrim VR

### Plugin Load Order
```
Skyrim.esm
Update.esm
Dawnguard.esm
HearthFires.esm
Dragonborn.esm
SkyrimVR.esm
SkyUI_SE.esp
SMIM-SE-Merged-All.esp
SeranaDialogAddon.esp
Ashe - Fire and Blood.esp
Dr_Bandolier.esp
CBBE.esp
RaceMenuMorphsCBBE.esp
Ashe and Serana Banter Patch.esp
Skyrim Flora Overhaul.esp
vrik.esp
higgs_vr.esp
FabulousFollowersAIO.esp
```

### Mod Catalog (59 mods — see vr-baseline.detail.instructions.md for full list)

> The VR mod catalog has grown significantly. Refer to `vr-baseline.detail.instructions.md` for the
> authoritative, categorized list of all 59 deployed mods (57 data + 2 root).

**Key categories**:
- Engine/Root: SKSEVR, VR ESL Support
- Frameworks (12): VR Address Library 0.199.0, VRTools, Engine Fixes VR, CrashLogger + PDB, ConsoleUtilSSE NG, Base Object Swapper, Animation Queue Fix, JContainers VR 4.2.11, PapyrusUtil VR 3.6b, po3 Tweaks, Fuz Ro D'oh 1.7
- VR Core: VRIK, HIGGS, PLANCK
- Body/Character: CBBE, BodySlide, RaceMenu VR 0.4.14, XPMSSE
- Physics/SMP: Faster HDT-SMP, XML VR, Vanilla hair remake SMP + NPCs
- Animation: FNIS, Nemesis
- Performance: eFPS, Grass FPS Booster
- Visuals: SMIM, Skyrim Flora Overhaul, Better Dynamic Snow, Faithful Faces, Icy Mesh Remaster, Terrain Helper
- Mesh Patching: PGPatcher 0.9.9
- Graphics/CS (13): Community Shaders 1.4.11 + 12 shader add-ons (Cloud Shadows, Grass Collision, Grass Lighting, Hair Specular, Sky Sync, Skylighting, SSS, Terrain Blending, Terrain Variation, Upscaling, Vanilla Hair Flow Maps, Wetness Effects)
- NPC/Followers: SDA, Ashe 1.3.3, Fabulous Followers
- Gameplay: Alternate Perspective, Bandolier

**Added since previous snapshot**: Cloud Shadows, Hair Specular, Sky Sync, Skylighting, Terrain Blending, Terrain Variation, Upscaling, Vanilla Hair Flow Maps, Terrain Helper, PGPatcher. Screen Space GI removed.

## Installed Mods — Skyrim SE (AE)

### Plugin Load Order
```
Skyrim.esm
Update.esm
Dawnguard.esm / HearthFires.esm / Dragonborn.esm
[70+ Creation Club ESMs/ESLs]
_ResourcePack.esl
unofficial skyrim special edition patch.esp
SkyUI_SE.esp
No NPC Greetings.esp
```

### Mod Catalog (64 mods — see ae-baseline.detail.instructions.md for full list)

> The AE mod catalog has grown significantly. Refer to `ae-baseline.detail.instructions.md` for the
> authoritative, categorized list of all 64 deployed mods (62 data + 2 root).

**Key categories**:
- Engine/Frameworks: SKSE64, Engine Fixes AIO, Address Library, po3 Tweaks, Base Object Swapper, BEES, + more
- Stability: CrashLogger, SrtCrashFix, SMP-NPC Fix, Animation Queue Fix, Hostility Fix
- Performance: eFPS, Grass FPS Booster, NVIDIA Reflex
- Body/Physics: CBBE, BodySlide, RaceMenu, XPMSSE, Faster HDT-SMP, Vanilla Hair Remake SMP
- Landscape/Flora: Cathedral 3D, Vanaheimr Landscapes CPM, Freak's Floral Fields, ERM, Better Dynamic Snow, + more
- **Graphics (13 mods)**: Community Shaders + 12 shader add-ons (SSGI, Skylighting, SSS, Cloud Shadows, Terrain Blending, Terrain Variation, Wetness Effects, Upscaling, Grass Collision, Hair Specular, Vanilla Hair Flow Maps, Sky Sync)
- NPC/Followers: SDA, Ashe, Faithful Faces, Fabulous Followers
- Gameplay: Alternate Perspective, PGPatcher

## VS Code MCP Configuration

| Property | Value |
|----------|-------|
| Config Path | `C:\Users\admin\AppData\Roaming\Code\User\mcp.json` |
| Playwright MCP | `@playwright/mcp@latest` via npx |
| Browser | Firefox (no user-data-dir needed) |

> **Note**: Previously used Chrome with `--user-data-dir` pointing to the user's Chrome profile
> for login persistence. Switched to Firefox due to Chrome hanging on Playwright startup.
> If Firefox has issues, can switch back to `"--browser", "chrome"` with the user-data-dir arg.

## Quick Detection Commands

### Get VR Version
```powershell
(Get-Item "D:\SteamLibrary\steamapps\common\SkyrimVR\SkyrimVR.exe").VersionInfo.FileVersion
```

### Get SE Version
```powershell
(Get-Item "C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\SkyrimSE.exe").VersionInfo.FileVersion
```

### List VR Deployed Mods
```powershell
$d = Get-Content "D:\SteamLibrary\steamapps\common\SkyrimVR\Data\vortex.deployment.json" -Raw | ConvertFrom-Json
$d.files | ForEach-Object { $_.source.Split('\')[0] } | Sort-Object -Unique
```

### List SE Deployed Mods
```powershell
$d = Get-Content "C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\Data\vortex.deployment.json" -Raw | ConvertFrom-Json
$d.files | ForEach-Object { $_.source.Split('\')[0] } | Sort-Object -Unique
```

### Read VR Load Order
```powershell
Get-Content "$env:APPDATA\Vortex\skyrimvr\profiles\HJe4qMiHWx\loadorder.txt"
```

### Read SE Load Order
```powershell
Get-Content "$env:APPDATA\Vortex\skyrimse\profiles\rkfJlyujJl\loadorder.txt"
```

## Steam Library Paths
| Library | Path | Games |
|---------|------|-------|
| Primary | `C:\Program Files (x86)\Steam` | Skyrim SE/AE, many others |
| Secondary | `D:\SteamLibrary` | Skyrim VR, Blade & Sorcery, BG3, Elden Ring, others |

## Dynamic Path Discovery

If any hardcoded path above is stale, use these commands to re-detect:

### Find All Steam Libraries
```powershell
# Parse Steam's libraryfolders.vdf for all library paths
$vdf = Get-Content "C:\Program Files (x86)\Steam\steamapps\libraryfolders.vdf" -Raw
[regex]::Matches($vdf, '"path"\s+"([^"]+)"') | ForEach-Object { $_.Groups[1].Value -replace '\\\\', '\' }
```

### Find Skyrim VR Install
```powershell
# Search all Steam libraries for SkyrimVR
$vdf = Get-Content "C:\Program Files (x86)\Steam\steamapps\libraryfolders.vdf" -Raw
$libs = [regex]::Matches($vdf, '"path"\s+"([^"]+)"') | ForEach-Object { $_.Groups[1].Value -replace '\\\\', '\' }
foreach ($lib in $libs) {
    $p = Join-Path $lib "steamapps\common\SkyrimVR\SkyrimVR.exe"
    if (Test-Path $p) { Write-Host "VR: $p — $((Get-Item $p).VersionInfo.FileVersion)"; break }
}
```

### Find Skyrim SE Install
```powershell
foreach ($lib in $libs) {
    $p = Join-Path $lib "steamapps\common\Skyrim Special Edition\SkyrimSE.exe"
    if (Test-Path $p) { Write-Host "SE: $p — $((Get-Item $p).VersionInfo.FileVersion)"; break }
}
```

### Find Vortex Staging Folders
```powershell
# Staging paths are stored in Vortex's state DB, but can also be found by checking:
# 1. Default: %APPDATA%\Vortex\{gameId}\mods\
# 2. Custom: look for vortex.deployment.json in game Data folders — trace source paths
$games = @('skyrimvr', 'skyrimse')
foreach ($g in $games) {
    $default = Join-Path $env:APPDATA "Vortex\$g\mods"
    if (Test-Path $default) { Write-Host "$g staging (default): $default" }
}
# Also check common custom locations
@('D:\Vortex Mods', 'E:\Vortex Mods') | ForEach-Object {
    if (Test-Path $_) { Get-ChildItem $_ -Directory | ForEach-Object { Write-Host "Custom staging: $($_.FullName)" } }
}
```

### Refresh Mod Lists After Path Change
```powershell
# After re-detection, re-read deployment manifests at the new game path:
# $gamePath = <detected path>
# $d = Get-Content "$gamePath\Data\vortex.deployment.json" -Raw | ConvertFrom-Json
# $d.files | ForEach-Object { $_.source.Split('\')[0] } | Sort-Object -Unique
```

## Pending Mod Installs — Dependency Analysis

### RaceMenu for VR (Nexus ID 19080)

**Install procedure**: Two-file install from the same mod page.
1. Install **Main file**: "RaceMenu Anniversary Edition v0-4-19-16" (8.2MB, file_id=465102)
   - This contains the ESP, scripts, and assets
2. Install **Optional file**: "RaceMenu VR 0.4.14" (571KB, file_id=154909)
   - This contains `skee64.dll` compiled for SKSEVR (VR runtime 1.4.15)
   - After installing, **delete** `skee64.dll` and `skee64.ini` from the main file (the VR file replaces them)

**Nexus-listed dependencies**: None ("no known dependencies other than the base game")

**Actual runtime dependencies**:
| Dependency | Required | Status in VR Baseline |
|-----------|----------|----------------------|
| SKSEVR 2.0.12+ | **Yes** (hard req) | Installed (2.0.12) |
| SkyUI VR | Recommended (MCM) | Installed (1.2.2) |
| CBBE (for body morphs) | Optional | Installed (2.0.3) |
| BodySlide (for body morphs) | Optional | Installed (5.7.1) |
| UIExtensions | Optional (face part selection UI) | **NOT installed** |
| VR Address Library | Recommended | Installed (0.195.0) |

**Dependency gap**: `UIExtensions` (Nexus 17561) is NOT in the VR baseline.
- UIExtensions provides enhanced face-part selection UI in RaceMenu
- Not a hard requirement — RaceMenu works without it, just fewer UI features
- Note: UIExtensions has a known VR compatibility issue — verify VR-specific version exists

**VR-specific notes**:
- The VR optional file (0.4.14) is older than the AE main file (0.4.19.16) — this is expected
- VR DLL version lags behind because SKSEVR runtime is frozen at 1.4.15
- The main file's scripts/ESP are forward-compatible; only the DLL needs to be VR-specific
- Some RaceMenu features are non-functional in VR (marked in mod description)

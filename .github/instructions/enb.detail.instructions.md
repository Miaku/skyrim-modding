---
name: "enb-detail"
description: "ENB installation, configuration, and preset management for Skyrim\nKeywords: ENB, enbseries, enblocal, enbdev, d3d11, graphics, preset, Boris, post-processing, shader, ENB Helper, weather, visual, screenshot, Community Shaders, CS"
---

# ENB & Community Shaders — Graphics Post-Processing

## ENB vs Community Shaders

> **Key Decision**: ENB and Community Shaders serve the same purpose (post-processing graphics
> injection) and are **mutually exclusive** — do NOT install both simultaneously.

| Aspect | ENB (ENBSeries) | Community Shaders |
|--------|-----------------|-------------------|
| Author | Boris Vorontsov | Community (Nexus 86492) |
| Install method | Manual copy to game root | Mod manager (SKSE plugin) |
| Hook mechanism | `d3d11.dll` replacement | SKSE plugin DLL |
| Preset system | INI + shader files | JSON configs + modular shader plugins |
| Open source | No | Yes |
| SE/AE support | Yes | Yes |
| VR support | Separate binary (lags behind) | **No** — SE/AE only |
| Performance | Heavier (full pipeline hook) | Generally lighter |
| Ecosystem | Mature, huge preset library | Growing, modular features |
| Feature plugins | All-in-one | Separate Nexus mods (LightLimitFix, etc.) |
| Update model | Boris releases when ready | Community-driven, frequent updates |

### When to Choose Which

- **Community Shaders** (recommended for SE/AE): Modern, open-source, lighter, integrates with
  mod manager, actively maintained by community. Best for new setups.
- **ENB**: Mature ecosystem with massive preset library. Choose if you want a specific ENB preset
  look that Community Shaders can't replicate yet.
- **VR**: ENB is the only option (Community Shaders has no VR support).

### Our Setup

- **AE**: Using **Community Shaders v1.4.11** (Nexus 86492). ENB was installed and removed.
- **VR**: ENB is the only graphics injection option if desired.

---

## Community Shaders (SE/AE)

Community Shaders is an **SKSE plugin** that replaces ENB for SE/AE. It installs through your mod
manager like any other mod — no manual file copying required.

### Installation

1. Install via Vortex/MO2 from [Nexus 86492](https://www.nexusmods.com/skyrimspecialedition/mods/86492)
2. Requires: SKSE, Address Library
3. Optional feature plugins (also installed via mod manager):
   - **Light Limit Fix** — removes Skyrim's light limit
   - **Extended Materials** — parallax, complex material support
   - **Dynamic Cubemaps** — real-time cubemap reflections
   - **Terrain Shadows** — improved terrain shadow rendering
   - **Water Effects** — enhanced water shaders
   - **Inverse Square Lighting** — physically-based light falloff

### Files It Deploys

- `Data\SKSE\Plugins\CommunityShaders.dll` — core SKSE plugin
- `Data\Shaders\*` — shader override files (Features, Common, etc.)

---

## ENB (ENBSeries)

### What is ENB?

ENB (ENBSeries) is a **third-party graphics injector** by Boris Vorontsov that hooks into the game's
DirectX pipeline via `d3d11.dll`. It enables advanced post-processing: ambient occlusion, detailed
shadows, color grading, depth of field, bloom, lens effects, and more. ENB is **not** installed
through mod managers — it goes directly into the game root directory.

## Download Sources

| Edition | Download Page | Notes |
|---------|--------------|-------|
| **SE / AE** | http://enbdev.com/download_mod_tesskyrimse.htm | Single binary covers both SE and AE |
| **VR** | http://enbdev.com/download_mod_tesskyrimvr.htm | **Separate binary** — VR version lags behind SE/AE |

> **CRITICAL**: SE/AE and VR use **different ENB binaries**. They are NOT interchangeable.
> Always download from the correct page. The Install Isolation rule applies — never cross-copy
> ENB DLLs between AE and VR installs.

### Version Identification

The download folder name encodes the version: `enbseries_skyrimse_v0504` = v0.504 for SE/AE.
You can also verify via the DLL:

```powershell
(Get-Item "path\to\d3d11.dll").VersionInfo | Select FileVersion, FileDescription
# FileVersion: 0, 5, 0, 4
# FileDescription: ENBSeries for TES Skyrim SE   ← confirms SE/AE build
# FileDescription: ENBSeries for TES Skyrim VR   ← confirms VR build
```

## Installation (Same Process for SE/AE and VR)

### Step 1: Extract the Download

ENB downloads contain two subfolders:
- **`WrapperVersion\`** — the standard install method (recommended)
- `InjectorVersion\` — alternative for edge-case compatibility (rarely needed)

Always use `WrapperVersion`.

### Step 2: Copy Files to Game Root

Copy the **entire contents** of `WrapperVersion\` into the game's root directory (where
`SkyrimSE.exe` or `SkyrimVR.exe` lives):

| Source (inside WrapperVersion) | Destination (game root) |
|-------------------------------|------------------------|
| `d3d11.dll` | Game root — **the core ENB binary** |
| `d3dcompiler_46e.dll` | Game root — DirectX compiler |
| `enblocal.ini` | Game root — local/performance config |
| `enbseries.ini` | Game root — visual/shader config |
| `enbseries\` folder | Game root — shader files |
| `Data\` folder | Merge into existing `Data\` — ENB textures |
| `*.fx`, `*.bmp`, `*.dds` files | Game root — effect and texture files |

**PowerShell quick-install** (adjust paths):
```powershell
$src = "C:\path\to\enbseries_skyrimse_v0504\WrapperVersion"
$dst = "C:\path\to\Skyrim Special Edition"
Get-ChildItem $src -File | ForEach-Object { Copy-Item $_.FullName -Destination $dst -Force }
Copy-Item (Join-Path $src "enbseries") -Destination $dst -Recurse -Force
Copy-Item (Join-Path $src "Data\*") -Destination (Join-Path $dst "Data") -Recurse -Force
```

### Step 3: Verify Installation

```powershell
$gameDir = "C:\path\to\Skyrim Special Edition"
@("d3d11.dll","d3dcompiler_46e.dll","enblocal.ini","enbseries.ini","enbseries") |
  ForEach-Object { $p = Join-Path $gameDir $_; if (Test-Path $p) { "OK: $_" } else { "MISSING: $_" } }
```

All five should show `OK`.

## ENB Presets

The base ENB binaries alone provide minimal visual changes. Most users install a **preset** on top
that configures the shaders for a specific look.

### Installing a Preset

1. Install the ENB base binaries first (above)
2. Download a preset (usually from Nexus Mods)
3. Copy the preset files into the game root — they typically overwrite `enbseries.ini` and add/replace files in `enbseries\`
4. Read the preset's instructions — many require specific weather mods or other dependencies

### Popular Presets (SE/AE)

| Preset | Nexus ID | Style |
|--------|----------|-------|
| Rudy ENB | Various | Cinematic, rich colors |
| Silent Horizons | 21543 | Fantasy, vibrant |
| Pi-CHO ENB | 35082 | Performance-friendly |
| Cabbage ENB | 67594 | Lightweight, natural |
| NAT.ENB III | 27141 | Natural atmospheric |

### VR Preset Considerations

- Use presets specifically tagged for VR or confirmed compatible
- VR is more performance-sensitive — prefer lightweight presets
- Disable or reduce depth of field (causes discomfort in VR)
- Ambient occlusion is the biggest VR performance hit

## ENB Helper SE

Many multi-weather presets require **ENB Helper** to detect the current weather and swap shader
settings automatically.

| Edition | Mod | Nexus ID |
|---------|-----|----------|
| SE / AE | ENB Helper SE | 23174 |
| VR | ENB Helper VR | — (check Nexus for VR port) |

Install via mod manager (it's an SKSE plugin: `enbhelperse.dll` / `enbhelper.dll`).

## Key Configuration (enblocal.ini)

| Setting | Section | Purpose | Recommended |
|---------|---------|---------|-------------|
| `VideoMemorySizeMb` | `[MEMORY]` | VRAM budget | Set to your GPU VRAM (e.g., 8192 for 8 GB) |
| `EnableFPSLimit` | `[LIMITER]` | Frame limiter | `true` — smoother than v-sync |
| `FPSLimit` | `[LIMITER]` | Target FPS | `60.0` (SE/AE) or `90.0` (VR for 90 Hz) |
| `EnableVSync` | `[ENGINE]` | V-sync control | `false` — use ENB limiter instead |
| `AddDisplaySuperSamplingResolution` | `[WINDOW]` | Resolution scaling | `false` unless needed |
| `FixGameBugs` | `[FIX]` | Boris's engine fixes | `true` |
| `FixParallaxBugs` | `[FIX]` | Parallax texture fixes | `true` |

## In-Game Controls

| Key | Action |
|-----|--------|
| `Shift+Enter` | Open ENB GUI editor (configure shaders live) |
| `Shift+F12` | Toggle ENB on/off (quick comparison) |
| `F12` | Screenshot (saved to game root as `enbseries_skyrimse_XXXX.bmp`) |
| `Shift+PrtScn` | Screenshot without ENB UI overlay |

## Uninstalling ENB

Delete these from the game root:
- `d3d11.dll`, `d3dcompiler_46e.dll`
- `enblocal.ini`, `enbseries.ini`
- `enbseries\` folder
- All `enb*.fx`, `enb*.bmp`, `enb*.dds` files
- `enbcache\` folder (if present)

> **Tip**: Keeping a list of files you copied during install makes cleanup easier.

## Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| Game won't launch / black screen | Conflicting overlay (Steam, Discord, GeForce) | Disable overlays; check `enblocal.ini` compatibility settings |
| Extreme FPS drop | VRAM budget too low or preset too heavy | Increase `VideoMemorySizeMb`; try lighter preset |
| Purple/missing textures | Preset needs weather mod not installed | Install the required weather mod (Cathedral, Obsidian, etc.) |
| ENB GUI doesn't open | Wrong key combo or d3d11.dll not loading | Verify `d3d11.dll` is in game root; try `Shift+Enter` |
| Crash on startup | ENB version incompatible with game version | Re-download correct binary from enbdev.com |
| VR: one eye darker than other | ENB effect not stereo-aware | Disable problematic effect in ENB GUI or use VR-safe preset |
| "d3d11.dll is not designed to run on Windows" | Wrong binary (32-bit vs 64-bit or wrong game) | Re-download from correct enbdev.com page |

## Edition Compatibility Matrix

| Feature | SE (1.5.97) | AE (1.6.x) | VR (1.4.15) |
|---------|-------------|-------------|-------------|
| ENB binary source | `tesskyrimse` page | `tesskyrimse` page (same) | `tesskyrimvr` page |
| Binary interchangeable? | SE ↔ AE: **Yes** | SE ↔ AE: **Yes** | VR ↔ SE/AE: **NO** |
| ENB Helper | Nexus 23174 | Nexus 23174 | Separate VR port |
| Typical version | v0.504+ | v0.504+ | Often several versions behind |
| Performance impact | Moderate | Moderate | Heavy (double render) |

## Cross-References

- **Tool overview**: `tools.instructions.md`
- **VR-specific modding**: `vr-modding.detail.instructions.md`
- **Local system paths**: `local-system.detail.instructions.md`
- **Mod dependencies**: `mod-dependencies.detail.instructions.md`

---
name: "ae-baseline-snapshot"
description: "Skyrim AE mod baseline snapshot — known stable configuration\nKeywords: baseline, snapshot, AE, Anniversary Edition, stable, working, preferred, mod list, load order, known good"
---

# Skyrim AE — Baseline Snapshot

> **Captured**: February 8, 2026 (updated: Vanaheimr Landscapes + Freak's Floral Fields session)
> **Status**: Known stable, working AE setup with SMP hair physics + Community Shaders + CPM landscape overhaul + grass flora
> **Source**: Vortex deployment manifests + profile plugins.txt

## Runtime & Install

| Property | Value |
|----------|-------|
| Runtime Version | **1.6.1170.0** (Anniversary Edition) |
| Install Path | `C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition` |
| SKSE | SKSE64 2.2.6 (`skse64_1_6_1170.dll`) |
| Steam App ID | 489830 |
| Creation Club | Full AE content (74 CC plugins) |
| Mod Manager | Vortex 1.15.2 |
| Vortex Profile | `rkfJlyujJl` |
| Staging Path | `%APPDATA%\Vortex\skyrimse\mods\` |
| Graphics | Community Shaders v1.4.11 (Nexus 86492) — ENB removed |

## Plugin Load Order (85 in loadorder.txt + deployed ESPs)

```
# Base game masters
Skyrim.esm
Update.esm
Dawnguard.esm
HearthFires.esm
Dragonborn.esm

# Creation Club content (74 plugins — all AE bundled)
ccasvsse001-almsivi.esm ... ccafdsse001-dwesanctuary.esm
_ResourcePack.esl

# User mod plugins (from plugins.txt — Vortex-managed)
*unofficial skyrim special edition patch.esp
*SkyUI_SE.esp
*FSMPM - The FSMP MCM.esp      # Faster HDT-SMP MCM menu
*Mantella.esp                   # ⚠ Ghost entry — NOT deployed
*UIExtensions.esp               # ⚠ Ghost entry — NOT deployed
*No NPC Greetings.esp
```

### Deployed Plugin Files (37 ESPs/ESMs/ESLs from mods)

```
# Patches & Fixes
unofficial skyrim special edition patch.esp
Better Dynamic Snow SE - DisableRefs.esm
Better Dynamic Snow SE.esp
IcyFixes.esp
Falskaar - Landscape Texture Revert.esl

# UI & Frameworks
SkyUI_SE.esp
FSMPM - The FSMP MCM.esp

# Body & Character
CBBE.esp
RaceMenu.esp
RaceMenuPlugin.esp
RaceMenuMorphsCBBE.esp
XPMSE.esp

# NPC / Followers
Faithful Faces.esp
Faithful Faces0.esp
SeranaDialogAddon.esp
SDA CC Umbra Patch.esp
Ashe - Fire and Blood.esp
Ashe - SMP_Hair.esp
Ashe and Serana Banter Patch.esp
FabulousFollowersAIO.esp

# Animation
FNIS.esp

# Landscape & Visuals
SMIM-SE-Merged-All.esp
Cathedral - 3D FallForest Grass.esp
Cathedral - 3D Pine & Reach Grass.esp
Cathedral - 3D Tundra Grass.esp
Grass FPS Booster.esp
TerrainHelper.esp
Vanaheimr Landscapes.esp
Freak's Floral Fields.esp
Freak's Floral Fields-  Realistic Pine.esp
Freak's Floral Fields- Realistic Tundra.esp
Freak's Floral Fields- Realistic Rift.esp
Freak's Floral Fields- Mixed Reach.esp
Freak's Floral Fields- Volcanic Wasteland.esp

# Gameplay
Occ_Skyrim_Tamriel.esp          # eFPS occlusion
No NPC Greetings.esp
AlternatePerspective.esp
```

## Deployed Mods (50 data + 2 root = 52 deployed)

### Engine / Root-Level
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| SKSE64 | 30379 | 2.2.6 | 542 root-level files |
| Engine Fixes (All-In-One) | 17230 | 7.0.19 | AE 1.6.1170+ engine bug fixes (root-level) |

### Frameworks & Libraries
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Address Library for SKSE (AE) | 32444 | 11 | All-in-one AE address database |
| Base Object Swapper | 60805 | 3.4.1 | Runtime base object replacement framework |
| ConsoleUtilSSE NG | 76649 | 1.5.1 | Console command utility for SKSE |
| JContainers SE | 16495 | 4.2.9 | JSON / data structure storage for Papyrus |
| PapyrusUtil AE SE | 13048 | 4.6 | Scripting utility functions |
| powerofthree's Tweaks | 51073 | 1.1.5.1 | Engine-level tweaks and fixes |
| BEES - Backported Extended ESL Support | 106441 | 1.2 | Extends ESL support for AE |
| Fuz Ro D'oh | 15109 | 2.5 | Silent dialogue lip-sync |

### Stability & Crash Fixes
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| CrashLogger | 59818 | 1.19.1 | Crash dump logger |
| SMP-NPC Crash Fix | 91616 | 1 | HDT-SMP NPC crash prevention |
| SrtCrashFix AE | 31146 | 0.4.1 | Stack trace crash fix |
| Animation Queue Fix | 82395 | 1.0.1 | Prevents animation queue overflow |
| World Encounter Hostility Fix | 91403 | 0.4 | Performance version |

### Performance
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| eFPS - Exterior FPS Boost | 54907 | 2.4.2 | Occlusion culling for exteriors |
| Grass FPS Booster | 20082 | 7.9.2 | Grass rendering optimization |
| NVIDIA Reflex Support | 74498 | 1.1.2 | Reduces input latency on NVIDIA GPUs |

### UI
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| SkyUI | 12604 | 5.2 SE | MCM framework + UI overhaul |
| Complete Widescreen Fix | 1778 | 3.9.1 | Widescreen/ultrawide fix for vanilla + SkyUI 5.2 |

### Patches & Bug Fixes
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| USSEP | 266 | 4.3.6c | Deployed version (also has 4.3.4a in staging) |
| No NPC Greetings | 1044 | 2.0a | Deprecated FOMOD installer |

### Body & Character
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| CBBE | 198 | 2.0.3 | Body replacer |
| BodySlide and Outfit Studio | 201 | 5.7.1 | Body/outfit editing tool |
| RaceMenu (AE) | 19080 | 0.4.19.16 | Anniversary Edition build |
| XP32 Maximum Skeleton (XPMSSE) | 1988 | 5.06 | Extended skeleton — required for SMP physics |

### Physics (Hair / Cloth)
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Faster HDT-SMP | 57339 | 2.5.1 | SMP physics engine (`hdtSMP64.dll`) + MCM |
| Vanilla Hair Remake SMP | 63979 | 1.0.3 | 568 SMP-enabled hair meshes |

### Animation
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| FNIS Behavior SE | 3038 | 7.6 | Animation framework (legacy) |
| Nemesis Unlimited Behavior Engine | 60033 | 0.84 beta | Animation framework (modern) |

### Visuals — Landscape & Flora
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| SMIM SE | 659 | 2.08 | Static mesh improvement |
| Faithful Faces - NPC Overhaul | 114342 | 1.3.5 | NPC face texture overhaul |
| Cathedral - 3D Landscapes | 80687 | 16.41 | Landscape texture + mesh overhaul (base layer) |
| DrJacopo's 3D Grass Library | 80687 | 16.53 | 3D grass meshes (companion to Cathedral) |
| Vanaheimr Landscapes - AIO - CPM | 145439 | 5.5 | 4K landscape textures with Complex Parallax Material — overlays Cathedral |
| Freak's Floral Fields | 125349 | 3.1 | Grass/flora overhaul — region-specific grass plugins |
| ERM - Enhanced Rocks and Mountains | 121336 | 1.1.1 | Rock and mountain texture overhaul |
| Better Dynamic Snow SE | 9121 | 3.6.0 | Improved snow rendering |
| Grass Lighting | 86502 | 2.0.0 | CS grass shader — fixes grass lighting to match surroundings |
| Icy Mesh Remaster - IcyFixes | 73381 | 3.35 | Mesh fixes via Base Object Swapper |
| Icy Mesh Remaster - Meshes | 73381 | 3.35 | Corrected NIF meshes for icy objects |
| Terrain Helper | 143149 | 1.0.0 | Terrain blending helper for landscape mods (CS/ENB) |
| Falskaar - Landscape Texture Fix | 139242 | 1.0 | Fixes Falskaar landscape to use correct textures |

### Graphics Post-Processing
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Community Shaders | 86492 | 1.4.11 | SKSE-based graphics injection — replaces ENB |

### NPC / Followers / Dialogue
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Serana Dialogue Add-On | 32161 | 4.3.0 | Expanded Serana dialogue |
| SDA Patch Hub SE | 70782 | 2.9.6 | SDA compatibility patches |
| Ashe - Crystal Heart SE | 135085 | 1.3.3 | Custom follower |
| Ashe and Serana Banter Patch | 167123 | 1.0.6 | Banter between Ashe & Serana |
| Fabulous Followers SE | 57284 | 1.05 | Follower management |

### Gameplay / Tools
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Alternate Perspective | 50307 | 4.1.0 | Alternate start mod |
| FonixData File (Mantella) | 40971 | 1.0 | Lip-sync data for AI voice |
| PGPatcher | 120946 | 0.9.9 | Dynamic mesh/texture patcher — patches NIFs for parallax, CM, and PBR shader flags. Re-run after adding texture/landscape mods. |

### Staged but NOT Deployed
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Actor Limit Fix (AE) | 32349 | 6 | In staging, 0 deployed files |
| Bug Fixes SSE (AE) | 33261 | 7 | In staging, 0 deployed files |

### Ghost Entries (plugins.txt only, not deployed)

| Plugin | Notes |
|--------|-------|
| `Mantella.esp` | Listed in plugins.txt but no files deployed — likely removed/disabled without cleanup |
| `UIExtensions.esp` | Same — ghost entry in load order |

## File Deployment Summary

| Target | File Count |
|--------|-----------|
| Root (SKSE DLLs, etc.) | 542 files |
| Data folder | 16,597 files |
| **Total deployed** | **17,139 files** |

## Category Breakdown

| Category | Count | Mods |
|----------|-------|------|
| Engine | 2 | SKSE64, Engine Fixes AIO |
| Frameworks | 8 | Address Library, Base Object Swapper, BEES, ConsoleUtil, JContainers, PapyrusUtil, po3 Tweaks, Fuz Ro D'oh |
| Stability | 5 | CrashLogger, SMP-NPC Fix, SrtCrashFix, Animation Queue Fix, Hostility Fix |
| Performance | 3 | eFPS, Grass FPS Booster, NVIDIA Reflex |
| UI | 2 | SkyUI, Complete Widescreen Fix |
| Patches | 2 | USSEP, No NPC Greetings |
| Body / Character | 4 | CBBE, BodySlide, RaceMenu, XPMSSE |
| Physics | 2 | Faster HDT-SMP, Vanilla Hair Remake SMP |
| Animation | 2 | FNIS, Nemesis |
| Visuals / Landscape | 13 | SMIM, Faithful Faces, Cathedral 3D, 3D Grass Library, Vanaheimr Landscapes CPM, Freak's Floral Fields, ERM, Better Dynamic Snow, Grass Lighting, Icy Mesh Remaster (x2), Terrain Helper, Falskaar Texture Fix |
| Graphics | 1 | Community Shaders |
| NPC / Followers | 5 | SDA, SDA Patch Hub, Ashe, Ashe-Serana Banter, Fabulous Followers |
| Gameplay / Tools | 3 | Alternate Perspective, FonixData, PGPatcher |
| **Total deployed** | **52** | (50 data + 2 root; +2 ghost plugins) |

## Dependency Chains (Inferred)

### Hair Physics Chain
The SMP hair physics stack has a deep dependency chain — every link is required:

```
SKSE64 (30379)
└── Address Library (32444)
    └── XP32 Maximum Skeleton - XPMSSE (1988)
        └── Faster HDT-SMP (57339)            ← physics engine (hdtSMP64.dll)
            ├── SMP-NPC Crash Fix (91616)      ← prevents NPC SMP crashes
            ├── SkyUI (12604)                  ← required for FSMP MCM menu
            └── Vanilla Hair Remake SMP (63979) ← SMP-enabled hair meshes
```

**Why each link matters:**
- **SKSE64** → engine hooks required for all SKSE plugins
- **Address Library** → maps runtime addresses; Faster HDT-SMP's DLL depends on it
- **XPMSSE** → extended skeleton with SMP bone nodes; without these bones, physics has nothing to simulate
- **Faster HDT-SMP** → the actual SMP physics engine (`hdtSMP64.dll`); provides Skinned Mesh Physics simulation
- **SMP-NPC Crash Fix** → without this, SMP physics on NPCs causes CTDs in populated areas
- **SkyUI** → Faster HDT-SMP bundles an MCM plugin (`FSMPM - The FSMP MCM.esp`) for tuning physics quality
- **Vanilla Hair Remake SMP** → replaces vanilla hair NIFs with SMP-rigged versions that reference XPMSSE's SMP bones

### Body / Character Chain
```
SKSE64 (30379)
└── Address Library (32444)
    ├── RaceMenu (19080)
    │   └── CBBE (198)
    │       └── BodySlide (201)
    └── XP32 Maximum Skeleton (1988)
        └── [feeds into Hair Physics chain above]
```

### Stability Chain
```
SKSE64 (30379)
└── Address Library (32444)
    ├── CrashLogger (59818)
    ├── SrtCrashFix AE (31146)
    ├── Animation Queue Fix (82395)
    ├── SMP-NPC Crash Fix (91616)
    └── World Encounter Hostility Fix (91403)
```

### Landscape / CPM Chain
The landscape visual stack layers textures + meshes + shaders:

```
Community Shaders (86492)              ← renderer that supports parallax/CM effects
├── Grass Lighting (86502)             ← CS grass shader plugin
├── Terrain Helper (143149)            ← terrain blending for CS
└── PGPatcher (120946)                 ← patches mesh shader flags for CM/parallax
    ├── Cathedral - 3D Landscapes (80687/16.41)   ← base landscape meshes
    │   └── DrJacopo's 3D Grass Library (80687/16.53) ← 3D grass meshes
    ├── Vanaheimr Landscapes (145439)  ← 4K CPM landscape textures (overlays Cathedral)
    │   └── requires: Community Shaders OR ENB (for CM rendering)
    │   └── requires: Terrain Helper (terrain blending)
    │   └── recommended: PGPatcher (dynamic CM flag patching)
    ├── ERM - Enhanced Rocks and Mountains (121336)
    ├── Better Dynamic Snow SE (9121)
    └── Icy Mesh Remaster (73381)
        └── requires: Base Object Swapper (60805)
```

**Vanaheimr Landscapes (145439) — Dependencies:**
- **Community Shaders** (86492) OR ENB — required to render Complex Parallax Material effects
- **Terrain Helper** (143149) — required for correct terrain blending
- **PGPatcher** (120946) — recommended for dynamic CM shader flag patching; Vanaheimr ships CPM textures (`_m.dds`)
- **Cathedral 3D Landscapes** (80687) — Vanaheimr overlays Cathedral's base meshes with its own 4K CPM textures
- **BEES** (106441) — recommended for extended ESL support
- Ships `Vanaheimr Landscapes.esp` + `Vanaheimr_SWAP.ini` (Base Object Swapper config)

### Grass / Flora Chain
```
Community Shaders (86492)
├── Grass Lighting (86502)             ← makes grass match surrounding light
└── Freak's Floral Fields (125349)     ← region-specific grass replacer
    ├── requires: Cathedral - 3D Landscapes (80687) ← base grass meshes
    │   └── DrJacopo's 3D Grass Library (80687)     ← 3D grass mesh library
    ├── requires: Community Shaders Grass Shader     ← CS sub-feature for grass rendering
    └── Grass FPS Booster (20082)      ← recommended for performance
```

**Freak's Floral Fields (125349) — Dependencies:**
- **Cathedral - 3D Landscapes** (80687) — hard requirement; provides the base 3D grass meshes FFF references
- **DrJacopo's 3D Grass Library** (80687) — companion to Cathedral; FFF uses these grass mesh assets
- **Community Shaders** (86492) with **Grass Shader** — required; FFF is designed for CS grass rendering
- **Grass Lighting** (86502) — recommended CS plugin for correct grass illumination
- Ships 6 ESPs: main + 5 region plugins (Realistic Pine, Realistic Tundra, Realistic Rift, Mixed Reach, Volcanic Wasteland)
- Ships `Freak's Floral Fields.ini` for configuration

## Notes

- **Mantella** and **UIExtensions** are ghost entries in plugins.txt — they appear enabled but have no deployed files. Consider purging them from the load order via Vortex.
- Two USSEP versions exist in staging (4.3.4a and 4.3.6c); only 4.3.6c is deployed.
- **Actor Limit Fix** and **Bug Fixes SSE** are staged but have 0 deployed files — Vortex may have disabled them, or they failed to deploy.
- Both **FNIS** and **Nemesis** are installed — Nemesis supersedes FNIS for most use cases. FNIS may be a leftover.
- **Alternate Perspective** (Nexus 50307) is the alternate start mod — replaces the vanilla Helgen intro.

## What This Baseline Represents

This is the **known-good AE foundation** with:
- Full Creation Club content (74 CC plugins, AE 1.6.1170)
- Essential frameworks (SKSE, Address Library, PapyrusUtil, JContainers, po3 Tweaks, Base Object Swapper, BEES)
- **Engine Fixes AIO** (root-level engine bug fixes)
- **Working SMP hair physics** (Faster HDT-SMP + Vanilla Hair Remake + XPMSSE + crash fixes)
- Body framework (CBBE + BodySlide + RaceMenu + XPMSSE)
- Animation tooling (FNIS + Nemesis)
- Stability stack (CrashLogger, SrtCrashFix, Animation Queue Fix, SMP-NPC Fix)
- Performance mods (eFPS, Grass FPS Booster, NVIDIA Reflex)
- Bug fixes (USSEP)
- **Full CPM landscape overhaul** (Vanaheimr Landscapes 4K CPM → Cathedral 3D Landscapes → ERM → Better Dynamic Snow → Terrain Helper → Icy Mesh Remaster → PGPatcher)
- **Grass/flora overhaul** (Freak's Floral Fields + Cathedral 3D Grass + DrJacopo's 3D Grass Library + Grass Lighting + Grass FPS Booster)
- NPC enhancements (Serana Dialogue Add-On, Faithful Faces, custom followers)
- Alternate start (Alternate Perspective)
- Ultrawide display support (Complete Widescreen Fix)
- **Community Shaders v1.4.11** (Nexus 86492) — replaced ENB; provides CM/parallax/grass shader rendering

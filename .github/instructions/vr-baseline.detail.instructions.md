---
name: "vr-baseline-snapshot"
description: "Preferred VR mod baseline snapshot — known stable configuration\nKeywords: baseline, snapshot, VR, stable, working, preferred, mod list, load order, known good"
---

# Skyrim VR — Preferred Baseline Snapshot

> **Captured**: February 8, 2026 (updated: full Community Shaders stack — 12 shader add-ons confirmed in VR)
> **Status**: Known stable VR setup with Community Shaders + 12 CS shader add-ons, SMP hair physics, PGPatcher mesh patching, expanded frameworks
> **Source**: Vortex deployment manifests + profile plugins.txt

## Plugin Load Order (12 active plugins)

```
# Base game masters (always loaded)
Skyrim.esm
Update.esm
Dawnguard.esm
HearthFires.esm
Dragonborn.esm
SkyrimVR.esm

# Mod plugins (Vortex-managed)
*SkyUI_SE.esp
*SMIM-SE-Merged-All.esp
*SeranaDialogAddon.esp
*Ashe - Fire and Blood.esp
*Dr_Bandolier.esp
*CBBE.esp
*RaceMenuMorphsCBBE.esp
*Ashe and Serana Banter Patch.esp
*Skyrim Flora Overhaul.esp
*vrik.esp
*higgs_vr.esp
*FabulousFollowersAIO.esp
```

> **Note**: USSEP has been **removed** (v4.3.6c required CC masters not available in VR).
> Address Library SE (32444) dead weight has been cleaned up.

## Deployed Mods (59 total — 57 data + 2 root)

### Root-Level Mods (SKSE / Engine)
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| SKSEVR | 30457 | 2.0.12 | VR script extender |
| Skyrim VR ESL Support | 106712 | 1.2 | ESL flag support in VR |

### Frameworks & Libraries
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| VR Address Library | 58101 | 0.199.0 | VR-specific address mappings (alpha). **Upgraded from 0.195.0** to fix missing address 12785 needed by Community Shaders. |
| SkyrimVRTools | 27782 | 2.3 BETA | VR controller API framework |
| Engine Fixes VR | 62089 | 1.26 | VR engine bug fixes. **⚠ 2-PART INSTALL**: Part 1 installs normally via Vortex (DLL to Data/SKSE/Plugins). Part 2 must be **manually unzipped to the Skyrim VR root folder** (`SkyrimVR/` not `SkyrimVR/Data/`) — it contains `EngineFixes.toml` and root-level files that Vortex won't place correctly. |
| CrashLogger | 59818 | 1.19.1 | Crash dump analysis |
| SkyrimVR PDB | 59818 | 2024-07-21 | Debug symbols for CrashLogger VR analysis |
| ConsoleUtilSSE NG | 76649 | 1.5.1 | Console utility SKSE plugin — confirmed working in VR |
| Base Object Swapper | 60805 | 3.4.1 | Object swapper framework — confirmed working in VR. Required by Icy Mesh Remaster IcyFixes.esp. |
| Animation Queue Fix | 82395 | 1.0.1 | Fixes animation queue overflow — confirmed working in VR |
| JContainers VR | 16495 | **4.2.11** | VR build — JSON/data structures for Papyrus. **Note**: AE uses 4.2.9 from main page; VR uses 4.2.11 from VR-specific files section. |
| PapyrusUtil VR | 13048 | **3.6b** | VR build — scripting utilities. **Note**: AE uses v4.6; VR must use **3.6b** (last VR-compatible build). Newer versions target AE runtime only. |
| powerofthree's Tweaks | 51073 | 1.1.5.1 | Engine tweaks — VR DLL from optional files |
| Fuz Ro D'oh | 15109 | **1.7** | Silent dialogue lip-sync. **⚠ VERSION CRITICAL**: AE uses v2.5; VR must use **v1.7** (last VR-compatible build). v2.x targets AE SKSE runtime and will crash in VR. |

### VR Core
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| VRIK Player Avatar | 23416 | 0.8.5 | Visible VR body, gestures, holsters |
| HIGGS | 43930 | 1.10.10 | Hand interaction, gravity gloves |
| PLANCK | 66025 | 0.7.1 | Physics-based melee combat |

### UI
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| SkyUI VR | — | 1.2.2 | GitHub fork (Odie/skyui-vr), not Nexus |

### Body & Character
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| CBBE | 198 | 2.0.3 | Body replacer — cross-edition |
| BodySlide and Outfit Studio | 201 | 5.7.1 | Body/outfit editor — cross-edition |
| RaceMenu SE | 19080 | **0.4.14** | Main file (ESP + scripts + assets). **⚠ VERSION CRITICAL**: Must use v0.4.14 main file, NOT the latest AE release (0.4.19.16). The v0.4.14 main file is the last version whose scripts/ESP are compatible with SKSEVR. |
| RaceMenu VR | 19080 | **0.4.14** | VR DLL overlay (`skee64.dll` compiled for SKSEVR 1.4.15). Install on top of the v0.4.14 main file to replace the SE DLL. |
| XP32 Maximum Skeleton (XPMSSE) | 1988 | 5.06 | Extended skeleton with SMP bone nodes — cross-edition |

### Physics / SMP
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Faster HDT-SMP | 57339 | 2.5.1 | SMP physics performance optimization — confirmed working in VR (previously thought AE-only) |
| XML VR | 57339 | 1.0 | HDT-SMP XML configuration for VR |
| Vanilla hair remake SMP | 63979 | 1.0.3 | SMP-enabled hair meshes replacing vanilla hair — cross-edition |
| Vanilla hair remake SMP - NPCs | 63979 | 1.0.1 | NPC-specific SMP hair patches — cross-edition |

### Animation
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| FNIS Behavior SE | 3038 | 7.6 | Legacy animation framework — cross-edition |
| Nemesis | 60033 | 0.84 beta | Modern animation framework — cross-edition |

### Performance
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| eFPS | 54907 | 2.4.2 | Occlusion culling — ESP + meshes, no DLL |
| Grass FPS Booster | 20082 | 7.9.2 | Grass rendering optimization — cross-edition |

### Visuals
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| SMIM SE | 659 | 2.08 | Static mesh improvement — cross-edition |
| Skyrim Flora Overhaul | 2154 | 2.74a | Flora/grass overhaul |
| Better Dynamic Snow SE | 9121 | 3.6.0 | Improved snow — ESP + meshes, cross-edition |
| Faithful Faces | 114342 | 1.3.5 | NPC face overhaul — textures + ESP, cross-edition |
| Icy Mesh Remaster (Meshes) | 73381 | 3.35 | Mesh fixes and improvements — cross-edition |
| Icy Mesh Remaster (IcyFixes) | 73381 | 3.35 | Object swapper config ESP — requires Base Object Swapper |
| Terrain Helper | 143149 | 1.0.0 | Terrain blending helper for landscape mods (CS/ENB) |

### Mesh Patching
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| PGPatcher | 120946 | 0.9.9 | Offline mesh patcher — patches NIFs for parallax, CM, and PBR based on installed textures. Re-run after adding/removing texture mods. |

### Graphics / Community Shaders
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Community Shaders | 86492 | 1.4.11 | **Core CS framework — confirmed working in VR.** Same AE DLL works in VR (not a separate VR build). Required VR Address Library 0.199.0+ for address 12785. |
| Cloud Shadows | 139185 | 1.2.0 | CS add-on — dynamic cloud shadow projection on terrain |
| Grass Collision | 87816 | 3.0.2 | CS add-on — grass reacts to player/NPC movement |
| Grass Lighting | 86502 | 2.0.0 | CS add-on — fixes grass lighting to match surroundings |
| Hair Specular | 149011 | 1.0.3 | CS add-on — improved hair specular highlights |
| Sky Sync | 153543 | 1.0.0 | CS add-on — synchronizes sky/weather shading |
| Skylighting | 139352 | 1.2.3 | CS add-on — ambient sky occlusion and directional skylighting |
| Subsurface Scattering | 114114 | 3.0.1 | CS add-on — SSS for skin/foliage/wax |
| Terrain Blending | 157076 | 1.0.1 | CS add-on — smooth blending between terrain and placed objects |
| Terrain Variation | 148123 | 1.0.1 | CS add-on — adds variation to terrain textures to reduce tiling |
| Upscaling | 156952 | 1.1.2 | CS add-on — upscaling/sharpening filter. **⚠ VR note**: monitor for conflicts with VR reprojection; stable so far. |
| Vanilla Hair Flow Maps | 149011 | 1.0 | CS add-on — flow map textures for vanilla hair |
| Wetness Effects | 112739 | 3.0.0 | CS add-on — rain/water wetness on surfaces |

### NPC / Followers / Dialogue
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Serana Dialogue Add-On | 32161 | 4.3.0 | Expanded Serana dialogue — cross-edition |
| SDA Patch Hub SE | 70782 | 2.9.6 | SDA compatibility patches — cross-edition |
| Ashe - Crystal Heart SE | 135085 | 1.3.3 | Custom follower (updated from 1.3.0) |
| Ashe and Serana Banter Patch | 167123 | 1.0.6 | Banter patch (updated from 1.0.4) |
| Fabulous Followers SE | 57284 | 1.05 | Follower management — cross-edition |

### Gameplay
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Alternate Perspective | 50307 | 4.1.0 | Alternate start — check if VR DLL portion works or just ESP/scripts |

### Equipment
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Bandolier Bags and Pouches | 2417 | 1.2 | Extra carry capacity — cross-edition |

### File Deployment Summary
| Target | File Count |
|--------|-----------|
| Root (SKSE DLLs, etc.) | 571 files |
| Data folder | 16,192 files |
| **Total deployed** | **16,763 files** |

## Category Breakdown

| Category | Count | Mods |
|----------|-------|------|
| Engine / Root | 2 | SKSEVR, VR ESL Support |
| Frameworks | 12 | VR Address Library, VRTools, Engine Fixes VR, CrashLogger, SkyrimVR PDB, ConsoleUtilSSE NG, Base Object Swapper, Animation Queue Fix, JContainers VR, PapyrusUtil VR, po3 Tweaks, Fuz Ro D'oh |
| VR Core | 3 | VRIK, HIGGS, PLANCK |
| UI | 1 | SkyUI VR |
| Body / Character | 5 | CBBE, BodySlide, RaceMenu SE, RaceMenu VR, XPMSSE |
| Physics / SMP | 4 | Faster HDT-SMP, XML VR, Vanilla hair remake SMP, Vanilla hair remake SMP - NPCs |
| Animation | 2 | FNIS, Nemesis |
| Performance | 2 | eFPS, Grass FPS Booster |
| Visuals | 7 | SMIM, Flora Overhaul, Better Dynamic Snow, Faithful Faces, Icy Mesh Remaster (Meshes), Icy Mesh Remaster (IcyFixes), Terrain Helper |
| Mesh Patching | 1 | PGPatcher |
| Graphics / CS | 13 | Community Shaders, Cloud Shadows, Grass Collision, Grass Lighting, Hair Specular, Sky Sync, Skylighting, Subsurface Scattering, Terrain Blending, Terrain Variation, Upscaling, Vanilla Hair Flow Maps, Wetness Effects |
| NPC / Followers | 5 | SDA, SDA Patch Hub, Ashe, Ashe-Serana Banter, Fabulous Followers |
| Gameplay | 1 | Alternate Perspective |
| Equipment | 1 | Bandolier |
| **Total** | **59** | (57 data + 2 root) |

## VR-Specific Version Requirements (Tribal Knowledge)

> **Critical**: Many SKSE-dependent mods have older VR-compatible versions that differ from
> the latest AE release. The VR versions are pinned to SKSEVR runtime 1.4.15 and will NOT
> receive updates since the VR runtime is frozen. Always use the versions listed below.

| Mod | AE Version | VR Version | Why |
|-----|-----------|------------|-----|
| **RaceMenu** | 0.4.19.16 (main file) | **0.4.14** (main file AND VR DLL) | Both the main file AND the VR DLL must be v0.4.14. The latest AE main file (0.4.19.16) is NOT compatible — its scripts/ESP target newer SKSE APIs. Use the **v0.4.14 main file** from older files on the mod page, then overlay the **VR 0.4.14 DLL** on top. |
| **Fuz Ro D'oh** | 2.5 | **1.7** | v2.x is AE-only (compiled against AE SKSE runtime). VR must use **v1.7** — the last version compiled for the older runtime. v2.x will crash SKSEVR at load. |
| **PapyrusUtil** | 4.6 (AE SE) | **3.6b** (VR) | PapyrusUtil VR is a separate download on the same mod page (13048). v4.x targets AE; v3.6b is the last VR-compatible build. |
| **JContainers** | 4.2.9 (SE) | **4.2.11** (VR) | JContainers VR is a separate mod page build (16495). The VR version is actually slightly newer (4.2.11 vs 4.2.9) — maintained independently. |
| **SKSE** | 2.2.6 (AE) | **2.0.12** (SKSEVR) | Completely separate builds — different Nexus pages (30379 vs 30457). |
| **Address Library** | v11 (32444) | **0.199.0** (58101) | Completely separate mods — SE/AE IDs don't map to VR addresses. **Must be 0.199.0+** for Community Shaders (address 12785). |
| **Engine Fixes** | 7.0.19 AIO (17230) | **1.26** (62089) | Separate VR mod page with VR-specific fixes. |
| **SkyUI** | 5.2 SE (12604) | **1.2.2** (GitHub) | VR fork from GitHub — not on Nexus. |
| **Faster HDT-SMP** | 2.5.1 (57339) | **2.5.1** (57339) | Same mod works in VR — no separate VR build needed. Previously HDT-SMP VR (30872) was recommended but Faster HDT-SMP is a drop-in replacement. |
| **Community Shaders** | 1.4.11 (86492) | **1.4.11** (86492) | Same DLL works in VR — not a separate VR build. Requires VR Address Library **0.199.0+** (address 12785 missing in older versions). |
| **CS shader add-ons** | 12 add-ons (86492 ecosystem) | **12 add-ons** (all confirmed) | Cloud Shadows, Grass Collision, Grass Lighting, Hair Specular, Sky Sync, Skylighting, SSS, Terrain Blending, Terrain Variation, Upscaling, Vanilla Hair Flow Maps, Wetness Effects — all same builds as AE. |
| **ConsoleUtilSSE NG** | 1.5.1 (76649) | **1.5.1** (76649) | Same build works in VR — confirmed Feb 2026. |
| **Base Object Swapper** | 3.4.1 (60805) | **3.4.1** (60805) | Same build works in VR — confirmed Feb 2026. |
| **Animation Queue Fix** | 1.0.1 (82395) | **1.0.1** (82395) | Same build works in VR — confirmed Feb 2026. |

## What This Baseline Represents

This is the **known-good VR foundation** with:
- Full VR interaction stack (VRIK body + HIGGS hands + PLANCK combat)
- Essential frameworks (SKSEVR, VR Address Library 0.199.0, Engine Fixes VR, CrashLogger + PDB)
- **Expanded framework layer** (JContainers VR, PapyrusUtil VR, po3 Tweaks, ConsoleUtilSSE NG, Base Object Swapper, Animation Queue Fix, Fuz Ro D'oh)
- **Community Shaders** (v1.4.11 — same AE DLL confirmed working in VR with updated Address Library)
- **12 CS shader add-ons confirmed** (Cloud Shadows, Grass Collision, Grass Lighting, Hair Specular, Sky Sync, Skylighting, SSS, Terrain Blending, Terrain Variation, Upscaling, Vanilla Hair Flow Maps, Wetness Effects)
- **PGPatcher** (v0.9.9 — offline mesh patching for parallax/CM/PBR)
- **Character creation** (RaceMenu VR 0.4.14 dual-file install + XPMSSE skeleton)
- **SMP hair physics** (Faster HDT-SMP + Vanilla hair remake SMP + NPC patches — full chain working)
- Visual improvements (SMIM, Flora Overhaul, Better Dynamic Snow, Faithful Faces, Icy Mesh Remaster, Terrain Helper)
- Performance mods (eFPS occlusion + Grass FPS Booster)
- Animation frameworks (FNIS + Nemesis)
- Body framework (CBBE + BodySlide + RaceMenu + XPMSSE)
- NPC companions (Serana enhanced, Ashe follower — both updated to latest)
- Alternate start (Alternate Perspective)
- **USSEP removed** (v4.3.6c incompatible; no 4.2.5b installed yet)

## AE Parity Gap Analysis

> **Reference**: See `mod-dependencies.detail.instructions.md` → "AE ↔ VR Cross-Compatibility Mapping" for the complete mapping table.
> **Updated**: February 8, 2026 (post parity push)

### Current Parity Score

- **52 of 64** AE mods are now matched in VR (**81%**, up from 67%)
- AE baseline has 64 mods with 12 CS shader add-ons
- Community Shaders confirmed working in VR (same AE DLL, needs VR Address Library 0.199.0+)
- **12 of 12** CS shader add-ons confirmed working in VR (full parity with AE CS stack, minus Screen Space GI which was removed from both)
- **~6** additional AE mods are directly portable (ESP/mesh/texture only)
- **3** are not applicable to VR (widescreen fix, NVIDIA Reflex, SrtCrashFix AE)

### Resolved Since Last Snapshot

| Item | Resolution |
|------|-----------|
| ~~USSEP 4.3.6c not loaded~~ | **Removed entirely** — CC masters not available in VR |
| ~~Address Library SE (32444) dead weight~~ | **Cleaned up** — removed |
| ~~Ashe 1.3.0 / Banter 1.0.4 outdated~~ | **Updated** to 1.3.3 / 1.0.6 |
| ~~JContainers VR build unknown~~ | **Confirmed**: v4.2.11 from VR files section |
| ~~PapyrusUtil VR build unknown~~ | **Confirmed**: v3.6b (VR-specific, older than AE's 4.6) |
| ~~Fuz Ro D'oh VR build unknown~~ | **Confirmed**: v1.7 (VR-specific, NOT v2.5) |
| ~~RaceMenu VR install unclear~~ | **Confirmed**: Use v0.4.14 main + v0.4.14 VR DLL (NOT latest AE main) |
| ~~po3 Tweaks VR build unknown~~ | **Confirmed**: VR DLL in optional files, same version |
| ~~Alternate Perspective VR unknown~~ | **Installed**: v4.1.0 — needs further testing || ~~Faster HDT-SMP AE-only~~ | **Corrected**: Works in VR — not AE-exclusive as previously thought |
| ~~Community Shaders VR unknown~~ | **Working**: CS v1.4.11 (same AE DLL) works in VR with VR Address Library 0.199.0+. Address 12785 was missing in 0.195.0. |
| ~~Grass Lighting untested~~ | **Working**: v2.0.0 confirmed in VR |
| ~~Grass Collision untested~~ | **Working**: v3.0.2 confirmed in VR |
| ~~Subsurface Scattering untested~~ | **Working**: v3.0.1 confirmed in VR |
| ~~Wetness Effects untested~~ | **Working**: v3.0.0 confirmed in VR |
| ~~Base Object Swapper VR unknown~~ | **Working**: v3.4.1 confirmed in VR |
| ~~Animation Queue Fix VR unknown~~ | **Working**: v1.0.1 confirmed in VR |
| ~~Faithful Faces not installed~~ | **Installed**: v1.3.5 |
| ~~Icy Mesh Remaster not installed~~ | **Installed**: v3.35 (meshes + IcyFixes ESP with BOS) |
| ~~VR Address Library 0.195.0~~ | **Upgraded**: 0.199.0 (fixes address 12785 for CS) |
| ~~Cloud Shadows disabled~~ | **Working**: v1.2.0 confirmed in VR — previously had INI load failure, now functional |
| ~~Skylighting untested~~ | **Working**: v1.2.3 confirmed in VR |
| ~~Hair Specular untested~~ | **Working**: v1.0.3 confirmed in VR |
| ~~Vanilla Hair Flow Maps untested~~ | **Working**: v1.0 confirmed in VR |
| ~~Sky Sync untested~~ | **Working**: v1.0.0 confirmed in VR |
| ~~Terrain Blending untested~~ | **Working**: v1.0.1 confirmed in VR |
| ~~Terrain Variation untested~~ | **Working**: v1.0.1 confirmed in VR |
| ~~Upscaling untested~~ | **Working**: v1.1.2 confirmed in VR — no conflicts with VR reprojection so far |
| ~~Screen Space GI installed~~ | **Removed** — dropped from the shader stack |
| ~~PGPatcher not installed~~ | **Installed**: v0.9.9 — offline mesh patcher |
| ~~Terrain Helper not installed~~ | **Installed**: v1.0.0 |
### Known Issues in Current VR Baseline

1. **No USSEP** — removed, but no replacement (4.2.5b) installed yet. Bug fixes are absent.
2. **SMP-NPC Crash Fix (91616) not deployed** — SMP hair physics are working without it currently. Monitor for NPC SMP-related crashes; re-add if instability appears.
3. **Skyrim Flora Overhaul** may conflict with Cathedral 3D Landscapes if the latter is added later — plan to disable SFO when moving to the Cathedral landscape stack.
4. **Screen Space GI removed** — dropped from the shader stack (was v4.0.1). If indirect lighting is missed, can try re-adding.
5. **Upscaling in VR** — v1.1.2 stable so far, but monitor for potential conflicts with SteamVR/OpenComposite reprojection.

### Remaining Parity Additions (Tiered)

#### Tier 1 — Safe, Direct Install (No DLL)
ESP/texture/mesh only — install directly into VR:

| Mod | Nexus ID | Impact | Notes |
|-----|----------|--------|-------|
| USSEP 4.2.5b | 266 | Bug fixes | Last version without CC deps — find in old files |
| No NPC Greetings | 1044 | QoL | ESP only |
| Cathedral 3D Landscapes | 80687 | Landscape | Base mesh/texture layer (replace SFO's landscape role) |
| DrJacopo's 3D Grass | 80687 | Grass | Companion to Cathedral |
| Vanaheimr Landscapes CPM | 145439 | Landscape 4K | CPM landscape textures (CS now working) |
| Freak's Floral Fields | 125349 | Grass/flora | Region grass (CS grass shader now working) |
| ERM | 121336 | Rock textures | Direct install |
| PGPatcher | 120946 | Mesh patching | Offline tool — run after texture mods |
| FonixData | 40971 | Lip-sync | Lip-sync data files |

#### Tier 2 — Known VR Builds
| Mod | Nexus ID | Impact | Notes |
|-----|----------|--------|-------|
| ~~Community Shaders (VR)~~ | ~~86492~~ | ~~Graphics engine~~ | **INSTALLED** — v1.4.11 (same AE DLL works in VR) |
| ~~HDT-SMP VR~~ | ~~30872~~ | ~~Hair/cloth physics~~ | **Superseded** — Faster HDT-SMP (57339) works in VR directly |
| ~~Vanilla Hair Remake SMP~~ | ~~63979~~ | ~~SMP hair meshes~~ | **INSTALLED** — v1.0.3 base + v1.0.1 NPCs |
| SMP-NPC Crash Fix | 91616 | Stability | Optional — SMP working without it; add if NPC crashes appear |

#### Tier 3 — CS Shader Add-ons (All Confirmed in VR ✅)
All 12 CS shader add-ons are now confirmed working in VR. No remaining untested shaders.

~~Previously untested: Skylighting, Cloud Shadows, Terrain Blending, Terrain Variation, Vanilla Hair Flow Maps, Hair Specular, Sky Sync, Upscaling — all confirmed Feb 2026.~~

#### Tier 4 — Still Needs Verification
| Mod | Nexus ID | What to Check |
|-----|----------|---------------|
| ~~Base Object Swapper~~ | ~~60805~~ | **CONFIRMED** — v3.4.1 works in VR. Now installed. |
| ~~ConsoleUtilSSE NG~~ | ~~76649~~ | **CONFIRMED** — v1.5.1 works in VR. Now installed. |
| ~~Animation Queue Fix~~ | ~~82395~~ | **CONFIRMED** — v1.0.1 works in VR. Now installed. |

### Permanent AE/VR Divergence

| AE Feature | Why | VR Alternative |
|-----------|-----|----------------|
| SrtCrashFix AE | AE-specific stack trace fix | No VR equivalent needed |
| NVIDIA Reflex | AE-specific DLL | Not applicable to VR render pipeline |
| Complete Widescreen Fix | Flat-screen UI | Not applicable to VR headset |
| Creation Club (74 plugins) | No CC in VR | **Never** copy from AE install |

| BEES | AE-specific ESL extension | Use VR ESL Support (106712) instead |

### Target State Comparison

| Scenario | Parity with AE | Mods |
|----------|---------------|------|
| **Current VR baseline** | **~81%** | 59 mods |
| + Tier 1 (landscape/flora/fixes) | ~92% | ~65 mods |

### VR SMP Hair Physics Chain (Confirmed Working)

```
SKSEVR (30457)                                   ✅
└── VR Address Library (58101)                    ✅
    └── XP32 Maximum Skeleton - XPMSSE (1988)     ✅
        └── Faster HDT-SMP (57339) v2.5.1         ✅ (works in VR — no need for HDT-SMP VR 30872)
            ├── Vanilla Hair Remake SMP (63979)    ✅ v1.0.3
            ├── Vanilla Hair Remake SMP NPCs       ✅ v1.0.1
            ├── ConsoleUtilSSE NG (76649)          ✅ v1.5.1
            └── SMP-NPC Crash Fix (91616)          ⚠ NOT installed — stable without it so far
```

> **Key finding**: Faster HDT-SMP (57339) works in VR despite being previously classified as AE-only.
> This eliminates the need for the older HDT-SMP VR (30872) build.

### Target State (After Remaining Tiers)

With Tier 1 installed (landscape/flora overhaul), VR would reach:
- **~92% parity** with AE baseline (up from 81%)
- **~65 mods** total
- Full CPM landscape overhaul (Vanaheimr + Cathedral 3D + PGPatcher + CS)
- Full grass/flora overhaul (Freak's Floral Fields — Grass Lighting already installed)
- SMP hair physics already working ✅
- Community Shaders already working ✅
- **All 12 CS shader add-ons confirmed** ✅
- PGPatcher mesh patching already working ✅

## Restoration Instructions

If the setup needs to be restored to this baseline:
1. Disable all mods in Vortex for Skyrim VR profile
2. Re-enable only the 59 mods listed above (57 data + 2 root)
3. Verify load order matches the 12-plugin list above
4. Ensure VR Address Library is **0.199.0+** (required for Community Shaders)
5. Deploy via Vortex and verify file counts: root=571, data=16,192, total=16,763

## Cross-References

- **AE baseline snapshot**: `ae-baseline.detail.instructions.md`
- **Mod dependencies & VR version mapping**: `mod-dependencies.detail.instructions.md`
- **Local system paths**: `local-system.detail.instructions.md`
- **VR modding guide**: `vr-modding.detail.instructions.md`
- **Nexus navigation**: `nexus-mods.detail.instructions.md`

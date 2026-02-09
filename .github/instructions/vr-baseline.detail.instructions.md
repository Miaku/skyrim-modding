---
name: "vr-baseline-snapshot"
description: "Preferred VR mod baseline snapshot — known stable configuration\nKeywords: baseline, snapshot, VR, stable, working, preferred, mod list, load order, known good"
---

# Skyrim VR — Preferred Baseline Snapshot

> **Captured**: February 8, 2026
> **Status**: Known stable, fully working VR setup
> **Source**: Vortex deployment manifests + profile plugins.txt

## Plugin Load Order (13 active plugins)

```
# Base game masters (always loaded)
Skyrim.esm
Update.esm
Dawnguard.esm
HearthFires.esm
Dragonborn.esm
SkyrimVR.esm

# Mod plugins (Vortex-managed)
# *unofficial skyrim special edition patch.esp  ← NOT LOADED: v4.3.6c requires CC masters missing in VR
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

## Deployed Mods (24 total)

### Root-Level Mods (SKSE / Engine)
| Mod | Staging Folder | Version |
|-----|----------------|---------|
| SKSEVR | `Skyrim Script Extender for VR (SKSEVR)-30457-2-0-12-...` | 2.0.12 |
| Skyrim VR ESL Support | `Skyrim VR ESL-106712-1-2-...` | 1.2 |

### Data-Level Mods (20 unique staging folders)
| Mod | Nexus ID | Version | Category |
|-----|----------|---------|----------|
| VRIK Player Avatar | 23416 | 0.8.5 | VR Core |
| HIGGS | 43930 | 1.10.10 | VR Core |
| PLANCK | 66025 | 0.7.1 | VR Core |
| SkyUI VR | — | 1.2.2 | UI |
| Unofficial Skyrim SE Patch | 266 | 4.3.6c | Patch | **⚠ NOT LOADED** — requires CC masters (fish, survival, curios, saints & seducers, resource pack) absent in VR. Needs downgrade to 4.2.5b or removal. |
| VR Address Library | 58101 | 0.195.0 | Framework |
| SkyrimVRTools | 27782 | 2.3 BETA | Framework |
| Engine Fixes VR (Part 1) | 62089 | 1.26 | Framework |
| Engine Fixes VR (Part 2) | 62089 | 1.26 | Framework |
| CrashLogger | 59818 | 1.19.1 | Framework |
| SMP-NPC Crash Fix | 91616 | 1 | Framework |
| SMIM SE | 659 | 2.08 | Visuals |
| Skyrim Flora Overhaul | 2154 | 2.74a | Visuals |
| CBBE | 198 | 2.0.3 | Body |
| BodySlide and Outfit Studio | 201 | 5.7.1 | Body |
| RaceMenuMorphsCBBE | — | — | Body |
| Serana Dialogue Add-On | 32161 | 4.3.0 | NPC / Dialogue |
| SDA Patch Hub SE | 70782 | 2.9.6 | NPC / Dialogue |
| Ashe - Crystal Heart SE | 135085 | 1.3.0 | NPC / Follower |
| Ashe and Serana Banter Patch | 167123 | 1.0.4 | NPC / Follower |
| Fabulous Followers SE | 57284 | 1.05 | NPC / Follower |
| Bandolier Bags and Pouches | 2417 | 1.2 | Equipment |

### File Deployment Summary
| Target | File Count |
|--------|-----------|
| Root (SKSE DLLs, etc.) | 571 files |
| Data folder | 4,946 files |
| **Total deployed** | **5,517 files** |

## Category Breakdown

| Category | Count | Mods |
|----------|-------|------|
| VR Core | 3 | VRIK, HIGGS, PLANCK |
| Framework | 7 | SKSEVR, ESL Support, VR Address Library, VRTools, Engine Fixes (2), CrashLogger, SMP Fix |
| UI | 1 | SkyUI VR |
| Patch | 1 | USSEP |
| Visuals | 2 | SMIM, Flora Overhaul |
| Body | 3 | CBBE, BodySlide, RaceMenuMorphsCBBE |
| NPC / Dialogue | 2 | Serana Dialogue Add-On, SDA Patch Hub |
| NPC / Follower | 3 | Ashe, Ashe-Serana Banter Patch, Fabulous Followers |
| Equipment | 1 | Bandolier |

## What This Baseline Represents

This is the **known-good VR foundation** with:
- Full VR interaction stack (VRIK body + HIGGS hands + PLANCK combat)
- Essential frameworks (SKSE, Address Library, Engine Fixes, Crash Logger)
- Visual improvements (SMIM meshes, Flora Overhaul)
- Body framework (CBBE + BodySlide)
- NPC companions (Serana enhanced, Ashe follower)
- Stability patches (USSEP, SMP crash fix, Engine Fixes)

## AE Parity Gap Analysis

> **Reference**: See `mod-dependencies.detail.instructions.md` → "AE ↔ VR Cross-Compatibility Mapping" for the complete mapping table.
> **Updated**: February 8, 2026

### Current Parity Score

- **18 of 52** AE mods are already matched in VR (35%)
- **14 additional** are directly portable (ESP/mesh/texture only)
- **3 more** have known VR builds available
- **7** need VR build verification on Nexus
- **7** cannot be ported (Community Shaders ecosystem + AE-specific DLLs)
- **3** are not applicable to VR

### Known Issues in Current VR Baseline

1. **USSEP 4.3.6c is staged but NOT LOADED** — requires CC masters (`ccbgssse001-fish.esm`, `ccqdrsse001-survivalmode.esl`, `ccbgssse037-curios.esl`, `ccbgssse025-advdsgs.esm`, `_ResourcePack.esl`) that don't exist in VR. **Action**: Replace with USSEP **4.2.5b** or remove entirely.
2. **Address Library for SKSE (32444) v2 is deployed** alongside VR Address Library (58101). The SE/AE version is dead weight in VR — harmless but should be cleaned up.
3. **Ashe follower (1.3.0) and Banter Patch (1.0.4)** are behind AE versions (1.3.3 / 1.0.6). Safe to update — ESP + assets only.

### Planned Parity Additions (Tiered)

#### Tier 1 — Safe, Direct Install (No DLL)
These mods are ESP/texture/mesh only and can be installed directly into VR:

| Mod | Nexus ID | Impact | Notes |
|-----|----------|--------|-------|
| USSEP 4.2.5b | 266 | Bug fixes | Downgrade from 4.3.6c |
| XPMSSE | 1988 | Skeleton | Required for SMP physics; enables hair/cloth physics chain |
| No NPC Greetings | 1044 | QoL | ESP only |
| Faithful Faces | 114342 | NPC visuals | Face texture overhaul |
| Cathedral 3D Landscapes | 80687 | Landscape | Base landscape mesh/texture layer (replaces Skyrim Flora Overhaul's landscape role) |
| DrJacopo's 3D Grass | 80687 | Grass | Companion to Cathedral |
| ERM | 121336 | Rock textures | Direct install |
| Better Dynamic Snow SE | 9121 | Snow visuals | ESP + meshes |
| eFPS | 54907 | Performance | Occlusion culling — significant FPS boost in VR |
| Grass FPS Booster | 20082 | Performance | Grass optimization — critical for VR perf |

#### Tier 2 — Known VR Builds
| Mod | Nexus ID | Impact | Notes |
|-----|----------|--------|-------|
| RaceMenu VR | 19080 | Character creation | Main file + VR DLL (file_id=154909) |
| po3 Tweaks VR | 51073 | Engine tweaks | Main file + VR optional DLL |
| HDT-SMP VR | 30872 | Hair/cloth physics | VR SMP engine (different mod from Faster HDT-SMP) |
| Vanilla Hair Remake SMP | 63979 | SMP hair meshes | Requires HDT-SMP VR + XPMSSE |

#### Tier 3 — Needs Verification
| Mod | Nexus ID | What to Check |
|-----|----------|---------------|
| Base Object Swapper | 60805 | Nexus optional files for VR DLL |
| ConsoleUtilSSE NG | 76649 | Nexus optional files for VR DLL |
| JContainers SE | 16495 | Nexus optional files for VR DLL |
| PapyrusUtil | 13048 | Nexus optional files for VR DLL |
| Fuz Ro D'oh | 15109 | Nexus optional files for VR DLL |
| Animation Queue Fix | 82395 | Nexus optional files for VR DLL |
| Alternate Perspective | 50307 | Nexus optional files for VR DLL |

### Permanent AE/VR Divergence

These AE features **cannot** be replicated in VR and represent accepted divergence:

| AE Feature | Why | VR Alternative |
|-----------|-----|----------------|
| Community Shaders (CPM, parallax, grass shaders) | No VR SKSE port; complex rendering hooks | ENB VR (partial, but VR perf cost) or accept vanilla rendering |
| Freak's Floral Fields | Hard requires CS grass shader | Keep Skyrim Flora Overhaul (current VR grass) |
| Vanaheimr CPM effects | CPM depth/parallax needs CS | Install textures for flat color upgrade, accept no depth effects |
| PGPatcher mesh patching | CS-dependent shader flag patching | Skip — VR meshes use vanilla flags |
| Grass Lighting + Terrain Helper | CS sub-plugins | Skip — VR grass/terrain uses vanilla lighting |
| NVIDIA Reflex | AE-specific DLL | Not applicable to VR render pipeline |
| Creation Club content (74 plugins) | VR has no CC support | Skip — do NOT copy from AE install |

### SMP Physics Chain (VR Version)

The VR equivalent of the AE SMP hair physics chain:

```
SKSEVR (30457)
└── VR Address Library (58101)
    └── XP32 Maximum Skeleton - XPMSSE (1988)  ← TO ADD
        └── HDT-SMP for Skyrim VR (30872)      ← TO ADD (VR SMP engine)
            ├── SMP-NPC Crash Fix (91616)       ← already installed
            ├── SkyUI VR                        ← already installed
            └── Vanilla Hair Remake SMP (63979)  ← TO ADD
```

### Target State (After Tier 1 + Tier 2 Additions)

If all Tier 1 and Tier 2 mods are installed, VR baseline would grow from **24 → ~38 mods** with:
- **~68% parity** with AE baseline (up from 35%)
- Working SMP hair physics (VR equivalent chain)
- Character creation overhaul (RaceMenu VR)
- Full landscape visual upgrade (Cathedral 3D — without CPM depth effects)
- Significant VR performance improvements (eFPS + Grass FPS Booster)
- Proper bug fixes (USSEP 4.2.5b loading correctly)

## Restoration Instructions

If the setup needs to be restored to this baseline:
1. Disable all mods in Vortex for Skyrim VR profile
2. Re-enable only the 24 mods listed above
3. Verify load order matches the plugin list above
4. Deploy via Vortex and verify file counts match

## Cross-References

- **Local system paths**: `local-system.detail.instructions.md`
- **VR modding guide**: `vr-modding.detail.instructions.md`
- **Nexus navigation**: `nexus-mods.detail.instructions.md`

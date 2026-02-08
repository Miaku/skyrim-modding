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
*unofficial skyrim special edition patch.esp
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
| Unofficial Skyrim SE Patch | 266 | 4.3.6c | Patch |
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

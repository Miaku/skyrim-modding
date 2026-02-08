---
name: "ae-baseline-snapshot"
description: "Skyrim AE mod baseline snapshot — known stable configuration\nKeywords: baseline, snapshot, AE, Anniversary Edition, stable, working, preferred, mod list, load order, known good"
---

# Skyrim AE — Baseline Snapshot

> **Captured**: February 8, 2026
> **Status**: Known stable, working AE setup
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

## Plugin Load Order (80 active plugins)

```
# Base game masters
Skyrim.esm
Update.esm
Dawnguard.esm
HearthFires.esm
Dragonborn.esm

# Creation Club content (74 plugins — all AE bundled)
ccasvsse001-almsivi.esm
ccbgssse001-fish.esm
ccbgssse002-exoticarrows.esl
ccbgssse003-zombies.esl
ccbgssse004-ruinsedge.esl
ccbgssse005-goldbrand.esl
ccbgssse006-stendarshammer.esl
ccbgssse007-chrysamere.esl
ccbgssse010-petdwarvenarmoredmudcrab.esl
ccbgssse011-hrsarmrelvn.esl
ccbgssse012-hrsarmrstl.esl
ccbgssse014-spellpack01.esl
ccbgssse019-staffofsheogorath.esl
ccbgssse020-graycowl.esl
ccbgssse021-lordsmail.esl
ccmtysse001-knightsofthenine.esl
ccqdrsse001-survivalmode.esl
cctwbsse001-puzzledungeon.esm
cceejsse001-hstead.esm
ccqdrsse002-firewood.esl
ccbgssse018-shadowrend.esl
ccbgssse035-petnhound.esl
ccfsvsse001-backpacks.esl
cceejsse002-tower.esl
ccedhsse001-norjewel.esl
ccvsvsse002-pets.esl
ccbgssse037-curios.esl
ccbgssse034-mntuni.esl
ccbgssse045-hasedoki.esl
ccbgssse008-wraithguard.esl
ccbgssse036-petbwolf.esl
ccffbsse001-imperialdragon.esl
ccmtysse002-ve.esl
ccbgssse043-crosselv.esl
ccvsvsse001-winter.esl
cceejsse003-hollow.esl
ccbgssse016-umbra.esm
ccbgssse031-advcyrus.esm
ccbgssse038-bowofshadows.esl
ccbgssse040-advobgobs.esl
ccbgssse050-ba_daedric.esl
ccbgssse052-ba_iron.esl
ccbgssse054-ba_orcish.esl
ccbgssse058-ba_steel.esl
ccbgssse059-ba_dragonplate.esl
ccbgssse061-ba_dwarven.esl
ccpewsse002-armsofchaos.esl
ccbgssse041-netchleather.esl
ccedhsse002-splkntset.esl
ccbgssse064-ba_elven.esl
ccbgssse063-ba_ebony.esl
ccbgssse062-ba_dwarvenmail.esl
ccbgssse060-ba_dragonscale.esl
ccbgssse056-ba_silver.esl
ccbgssse055-ba_orcishscaled.esl
ccbgssse053-ba_leather.esl
ccbgssse051-ba_daedricmail.esl
ccbgssse057-ba_stalhrim.esl
ccbgssse066-staves.esl
ccbgssse067-daedinv.esm
ccbgssse068-bloodfall.esl
ccbgssse069-contest.esl
ccvsvsse003-necroarts.esl
ccvsvsse004-beafarmer.esl
ccbgssse025-advdsgs.esm
ccffbsse002-crossbowpack.esl
ccbgssse013-dawnfang.esl
ccrmssse001-necrohouse.esl
ccedhsse003-redguard.esl
cceejsse004-hall.esl
cceejsse005-cave.esm
cckrtsse001_altar.esl
cccbhsse001-gaunt.esl
ccafdsse001-dwesanctuary.esm
_ResourcePack.esl

# User mod plugins
*unofficial skyrim special edition patch.esp
*SkyUI_SE.esp
*Mantella.esp           # ⚠ In plugins.txt but NOT deployed — ghost entry
*UIExtensions.esp       # ⚠ In plugins.txt but NOT deployed — ghost entry
*No NPC Greetings.esp
```

## Deployed Mods (27 staging folders)

### Engine / Root-Level
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| SKSE64 | 30379 | 2.2.6 | 535 root-level files |

### Frameworks & Libraries
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Address Library for SKSE (AE) | 32444 | 11 | All-in-one AE address database |
| ConsoleUtilSSE NG | 76649 | 1.5.1 | Console command utility for SKSE |
| JContainers SE | 16495 | 4.2.9 | JSON / data structure storage for Papyrus |
| PapyrusUtil AE SE | 13048 | 4.6 | Scripting utility functions |
| Fuz Ro D'oh | 15109 | 2.5 | Silent dialogue lip-sync |
| CrashLogger | 59818 | 1.19.1 | Crash dump logger |
| SMP-NPC Crash Fix | 91616 | 1 | HDT-SMP NPC crash prevention |
| World Encounter Hostility Fix | 91403 | 0.4 | Performance version |

### UI
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| SkyUI | 12604 | 5.2 SE | MCM framework + UI overhaul |

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
| XP32 Maximum Skeleton (XPMSSE) | 1988 | 5.06 | Extended skeleton for animations |

### Animation
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| FNIS Behavior SE | 3038 | 7.6 | Animation framework (legacy) |
| Nemesis Unlimited Behavior Engine | 60033 | 0.84 beta | Animation framework (modern) |

### Visuals
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| SMIM SE | 659 | 2.08 | Static mesh improvement |

### NPC / Followers / Dialogue
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Serana Dialogue Add-On | 32161 | 4.3.0 | Expanded Serana dialogue |
| SDA Patch Hub SE | 70782 | 2.9.6 | SDA compatibility patches |
| Ashe - Crystal Heart SE | 135085 | 1.3.3 | Custom follower |
| Ashe and Serana Banter Patch | 167123 | 1.0.6 | Banter between Ashe & Serana |
| Fabulous Followers SE | 57284 | 1.05 | Follower management |

### Gameplay / AI
| Mod | Nexus ID | Version | Notes |
|-----|----------|---------|-------|
| Alternate Perspective | 50307 | 4.1.0 | Alternate start mod |
| FonixData File (Mantella) | 40971 | 1.0 | Lip-sync data for AI voice |

### Ghost Entries (plugins.txt only, not deployed)

| Plugin | Notes |
|--------|-------|
| `Mantella.esp` | Listed in plugins.txt but no files deployed — likely removed/disabled without cleanup |
| `UIExtensions.esp` | Same — ghost entry in load order |

## File Deployment Summary

| Target | File Count |
|--------|-----------|
| Root (SKSE DLLs, etc.) | 535 files |
| Data folder | 13,909 files |
| **Total deployed** | **14,444 files** |

## Category Breakdown

| Category | Count | Mods |
|----------|-------|------|
| Engine | 1 | SKSE64 |
| Frameworks | 8 | Address Library, ConsoleUtil, JContainers, PapyrusUtil, Fuz Ro D'oh, CrashLogger, SMP Fix, Hostility Fix |
| UI | 1 | SkyUI |
| Patches | 2 | USSEP, No NPC Greetings |
| Body / Character | 4 | CBBE, BodySlide, RaceMenu, XPMSSE |
| Animation | 2 | FNIS, Nemesis |
| Visuals | 1 | SMIM |
| NPC / Followers | 4 | Serana Dialogue Add-On, SDA Patch Hub, Ashe, Ashe-Serana Banter |
| Gameplay / AI | 2 | Alternate Perspective, FonixData |
| **Total unique mods** | **25** | (+ SKSE = 26 deployed, 27 staging folders incl. old USSEP) |

## Notes

- **Mantella** and **UIExtensions** are ghost entries in plugins.txt — they appear enabled but have no deployed files. Consider purging them from the load order via Vortex.
- Two USSEP versions exist in staging (4.3.4a and 4.3.6c); only 4.3.6c is deployed.
- Both **FNIS** and **Nemesis** are installed — Nemesis supersedes FNIS for most use cases. FNIS may be a leftover.
- **Alternate Perspective** (Nexus 50307) is the alternate start mod — replaces the vanilla Helgen intro.

## What This Baseline Represents

This is the **known-good AE foundation** with:
- Full Creation Club content (74 CC plugins, AE 1.6.1170)
- Essential frameworks (SKSE, Address Library, PapyrusUtil, JContainers)
- Body framework (CBBE + BodySlide + RaceMenu + XPMSSE)
- Animation tooling (FNIS + Nemesis)
- Bug fixes (USSEP, crash logger, SMP fix)
- NPC enhancements (Serana Dialogue Add-On, custom followers)
- Alternate start (Alternate Perspective)

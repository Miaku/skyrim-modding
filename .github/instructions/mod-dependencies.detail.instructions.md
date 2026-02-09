---
name: "mod-dependencies-detail"
description: "Tribal knowledge for mod dependencies, edition-specific variants, cross-compatibility mapping, and install patterns\nKeywords: dependency, dependencies, requirement, required, compatible, compatibility, install, version, variant, VR version, SE version, AE version, which version, do I need both, replace, equivalent, alternative, parity, cross-compatibility, analog, mapping, port, VR port, VR equivalent, VR build"
---

# Mod Dependencies & Edition-Specific Knowledge

> **Purpose**: This file captures hard-won tribal knowledge about which mods need which
> dependencies, which files are edition-specific, and common "gotchas" when installing
> mods across Skyrim SE, AE, and VR.

## Edition-Specific Library Mods

### Address Library — The Critical Split

| Mod | Nexus ID | For Edition | Author | Status |
|-----|----------|-------------|--------|--------|
| Address Library for SKSE Plugins | 32444 | SE (1.5.x) / AE (1.6.x) | meh321 | Stable, complete |
| VR Address Library for SKSEVR | 58101 | VR (1.4.15) | alandtse | Alpha, crowdsourced |

**Key facts:**
- These are **mutually exclusive by edition** — SE/AE users install 32444, VR users install 58101
- They are **NOT interchangeable** — the address ID databases are completely different
- VR Address Library maps stable numeric IDs → VR runtime addresses (just like the SE version does for SE)
- The SE version is split internally: SE 1.5.x and AE 1.6.x use different ID→address mappings
  (the IDs won't match across SE/AE either; the AE header is `versionlibdb.h` vs SE's `versiondb.h`)
- VR Address Library is **alpha** with incomplete coverage (~3,884 verified mappings as of last release)
- If an SKSE plugin says "requires Address Library" and has a VR build, it means VR Address Library

**Do VR users need BOTH?**
- **No.** VR users only need **VR Address Library (58101)**
- The regular Address Library (32444) does nothing in VR — wrong runtime addresses
- However, some VR users may have 32444 installed as a leftover from copying SE mod lists;
  it won't cause crashes but it's dead weight

> **Current VR baseline**: VR Address Library 0.195.0 is installed.
> Regular Address Library v2 is also deployed (likely harmless leftover — could be cleaned up).

### SKSE — Three Separate Builds

| Build | Nexus ID | Runtime | DLL Name |
|-------|----------|---------|----------|
| SKSE64 (SE) | 30379 | 1.5.97 | `skse64_1_5_97.dll` |
| SKSE64 (AE) | 30379 | 1.6.x | `skse64_1_6_xxxx.dll` |
| SKSEVR | 30457 | 1.4.15 | `sksevr_1_4_15.dll` |

- SKSE SE and AE share a Nexus page but have **different DLLs per runtime version**
- SKSEVR has its own Nexus page entirely
- **Never mix SKSE builds** — wrong DLL = crash at startup

### SkyUI — Forked for VR

| Variant | Source | Notes |
|---------|--------|-------|
| SkyUI SE (Nexus 12604) | Nexus Mods | For SE/AE, provides MCM framework |
| SkyUI VR | [GitHub releases](https://github.com/Odie/skyui-vr/releases) | Forked for VR, NOT on Nexus |

- SkyUI VR is distributed via GitHub, not Nexus Mods
- It provides the same MCM framework but patched for VR menus
- Many mods list "SkyUI" as a dependency — in VR, this means SkyUI VR

## Common Dual-File Install Patterns

Some mods ship a single main file for SE/AE plus a separate VR overlay. The pattern:

1. Install the **Main file** (contains ESP, scripts, assets — works across editions)
2. Install the **Optional/VR file** (contains VR-compiled DLL that replaces the SE DLL)
3. Let the VR file overwrite the SE DLL, or manually delete the SE DLL after install

### RaceMenu (Nexus 19080)

| File | Section | Size | Purpose |
|------|---------|------|---------|
| RaceMenu Anniversary Edition v0-4-19-16 | Main files | 8.2MB | ESP + scripts + assets + AE DLL |
| RaceMenu v0-4-14 | Old files / Main files | ~8MB | **VR-compatible** main file (ESP + scripts + assets) |
| RaceMenu VR 0.4.14 | Optional files | 571KB | VR-compiled `skee64.dll` |

**Install for VR:**
1. Install **v0.4.14 main file** (NOT the latest AE v0.4.19.16 — the newer scripts/ESP target AE SKSE APIs)
2. Install VR overlay (file_id=154909) — overwrites `skee64.dll` with VR-compiled version
3. Both files must be v0.4.14 — the main file and VR DLL are version-matched

**⚠ VERSION CRITICAL**: The AE main file (v0.4.19.16) is NOT compatible with VR. Its scripts
and ESP reference SKSE APIs that only exist in AE's SKSE64 2.2.x. You must use the **v0.4.14
main file** from the mod page's older files, then layer the VR DLL on top.

**Why the version match?** Unlike most dual-file mods where only the DLL is edition-locked,
RaceMenu's ESP and Papyrus scripts also evolved alongside the AE SKSE API. The v0.4.14
main file is the last version where scripts + ESP + VR DLL all align.

**Mod manager download URLs:**
- Main: `https://www.nexusmods.com/skyrimspecialedition/mods/19080?tab=files&file_id=465102&nmm=1`
- VR:   `https://www.nexusmods.com/skyrimspecialedition/mods/19080?tab=files&file_id=154909&nmm=1`

**Runtime dependencies:**
| Dependency | Required | VR Baseline Status |
|-----------|----------|-------------------|
| SKSEVR 2.0.12+ | Hard requirement | Installed |
| SkyUI VR | Recommended (MCM) | Installed |
| CBBE | Optional (body morphs) | Installed |
| BodySlide | Optional (body morphs) | Installed |
| UIExtensions (17561) | Optional (face part UI) | **Not installed** — verify VR compat |
| VR Address Library | Recommended | Installed |

## Dependency Resolution Rules

### Rule 1: SKSE Plugin DLLs Are Edition-Locked
Any mod that includes a `.dll` in `Data/SKSE/Plugins/` **must** match the game edition:
- SE DLL → only works on SE runtime 1.5.97
- AE DLL → only works on AE runtime 1.6.x (specific version matters!)
- VR DLL → only works on VR runtime 1.4.15

If a mod has no VR DLL, the SKSE plugin portion **will not work in VR**. The ESP/scripts may
still work if they don't depend on the DLL's functionality.

### Rule 2: ESP/ESM/ESL Files Are Cross-Edition
Plugin files (ESP/ESM/ESL) work across all editions **unless** they:
- Require a master that doesn't exist in VR (e.g., Creation Club content)
- Use Papyrus functions that only exist in a specific SKSE version's extensions

> **⚠ Install Isolation**: When a mod's ESP requires AE-only masters (CC content),
> the fix for VR is to **downgrade or skip the mod** — NEVER copy CC files from the AE install
> into VR. The AE and VR installs must stay completely separate to avoid cross-contamination.

### Rule 3: Check Optional Files for VR
On Nexus Mods, VR-specific files are almost always in the **Optional files** section.
The Main file is typically for the latest SE/AE version. VR users need both.

### Rule 4: "Requires Address Library" Means Different Things
- For SE/AE mods: Install Address Library for SKSE Plugins (32444)
- For VR mods: Install VR Address Library for SKSEVR (58101)
- These are **never both needed** for the same edition

### Rule 5: Version Lag is Normal for VR — But Sometimes Both Files Must Match
VR variants of mods are often several versions behind SE/AE. This is expected because:
- VR runtime is frozen at 1.4.15 (no Bethesda updates)
- VR mod ports require manual address mapping (crowdsourced, incomplete)
- Fewer VR mod authors = slower update cycle

**⚠ Important exception**: Some mods require BOTH the main file AND the VR DLL to be the
same older version. The typical pattern is "latest main file + older VR DLL" but this does NOT
work for mods where the ESP/scripts also changed alongside SKSE API updates. Known cases:
- **RaceMenu**: Must use v0.4.14 main + v0.4.14 VR DLL (NOT latest AE main)
- **Fuz Ro D'oh**: Must use v1.7 entirely (v2.x is AE-only, no dual-file pattern)

### Rule 6: VR Has Its Own Mod Page Versions for Some Libraries
Some utility libraries have completely separate VR builds with different version numbers:
- **PapyrusUtil**: AE v4.6 → VR **v3.6b** (same Nexus page 13048, different file)
- **JContainers**: SE v4.2.9 → VR **v4.2.11** (same Nexus page 16495, VR section)

## Mods with Known VR Complications

| Mod | Issue | Workaround |
|-----|-------|------------|
| **USSEP (≥4.2.6)** | Requires 5 CC masters not present in VR: `ccbgssse001-fish.esm`, `ccqdrsse001-survivalmode.esl`, `ccbgssse037-curios.esl`, `ccbgssse025-advdsgs.esm`, `_ResourcePack.esl` | Use USSEP **4.2.5b** (last version without CC deps) or skip entirely. **Do NOT copy CC files from AE** — see Install Isolation rule. |
| **RaceMenu** | Both main file AND VR DLL must be v0.4.14 | Do NOT use latest AE main file (0.4.19.16) — its scripts target AE SKSE APIs. Use v0.4.14 main + v0.4.14 VR DLL. See install pattern above. |
| **Fuz Ro D'oh** | v2.x is AE-only (SKSE AE runtime) | Use v**1.7** — the last VR-compatible version. v2.x will crash SKSEVR at load. No dual-file pattern; the entire mod must be the older version. |
| **PapyrusUtil** | v4.x is AE-only | Use **PapyrusUtil VR v3.6b** from the VR files section on Nexus 13048. |
| **JContainers** | SE/AE version differs from VR | Use **JContainers VR v4.2.11** from VR files section on Nexus 16495. |
| ENB | VR-specific binary required; ENB and Community Shaders are **mutually exclusive** | Community Shaders (86492) is preferred for both SE/AE and VR. ENB only if you want a specific preset look. |
| .NET Script Framework | No VR build exists | Use CrashLogger VR (59818) instead |
| SSE Engine Fixes | Separate VR build | Use Engine Fixes VR (62089) |
| powerofthree's Tweaks | Separate VR DLL in optional files | Install main + VR optional DLL — **confirmed working** |
| Scrambled Bugs | SE/AE only, no VR port | No workaround — skip for VR |
| Base Object Swapper | Needs VR-compiled DLL | Check if VR build exists |
| Keyword Item Distributor | Needs VR-compiled DLL | Check if VR build exists |

## Complex Dependency Chains

> **Purpose**: These chains document which mods require which other mods to function.
> When installing any mod in a chain, install **all** its ancestors first. When
> removing a mod, check nothing below it in the chain depends on it.

### SMP Hair / Cloth Physics (SE/AE)

Full chain for getting Skinned Mesh Physics (hair, capes, etc.) working:

```
SKSE64 (30379)                              ← engine hooks for all SKSE plugins
└── Address Library (32444)                 ← runtime address mapping for SKSE DLLs
    └── XP32 Maximum Skeleton - XPMSSE (1988) ← extended skeleton with SMP bone nodes
        └── Faster HDT-SMP (57339)          ← SMP physics engine (hdtSMP64.dll)
            ├── SMP-NPC Crash Fix (91616)   ← prevents CTDs when NPCs have SMP
            ├── SkyUI (12604)               ← required for FSMP MCM settings menu
            └── [SMP content mods]:
                ├── Vanilla Hair Remake SMP (63979) ← SMP-rigged vanilla hair replacer
                ├── HDT-SMP cloaks/capes    ← any SMP-enabled cloak mod
                └── KS Hairdos SMP, etc.    ← any SMP hair pack
```

**Why each link is required:**
| Mod | What breaks without it |
|-----|----------------------|
| SKSE64 | No SKSE plugins load at all |
| Address Library | Faster HDT-SMP DLL can't resolve runtime addresses → crash |
| XPMSSE | No SMP bone nodes in skeleton → physics has nothing to simulate, hair is static |
| Faster HDT-SMP | No physics engine → SMP meshes render but don't move |
| SMP-NPC Crash Fix | NPCs with SMP hair/armor cause CTDs in populated areas |
| SkyUI | FSMP MCM menu won't load (non-fatal but you lose physics tuning) |
| SMP content mod | Nothing to simulate — you need at least one SMP-rigged mesh |

**VR Note:** Faster HDT-SMP (57339) v2.5.1 is **confirmed working in VR** as of Feb 2026.
The same chain applies in VR with VR equivalents (SKSEVR, VR Address Library).
The older [HDT-SMP for Skyrim VR](https://www.nexusmods.com/skyrimspecialedition/mods/30872)
is no longer required — Faster HDT-SMP is a drop-in replacement.

### Body / Character Customization (SE/AE)

```
SKSE64 (30379)
└── Address Library (32444)
    ├── RaceMenu (19080)                    ← character creation overhaul
    │   ├── CBBE (198)                      ← body mesh replacer (optional but standard)
    │   │   └── BodySlide (201)             ← body/outfit shape editing (optional)
    │   └── UIExtensions (17561)            ← face part picker UI (optional)
    └── XP32 Maximum Skeleton (1988)        ← extended skeleton for body physics
        └── [feeds into SMP chain above]
```

**Notes:**
- RaceMenu _works_ without CBBE but many presets assume CBBE body
- BodySlide needs CBBE installed first to generate body meshes
- XPMSSE is shared between the body chain and the SMP physics chain

### Stability Stack (SE/AE)

All independent — no dependencies between them, but all require the SKSE + Address Library base:

```
SKSE64 (30379)
└── Address Library (32444)
    ├── CrashLogger (59818)                 ← crash dump analysis
    ├── SrtCrashFix AE (31146)              ← stack trace crash fix
    ├── Animation Queue Fix (82395)         ← animation queue overflow fix
    ├── SMP-NPC Crash Fix (91616)           ← SMP-specific NPC crash fix
    └── World Encounter Hostility Fix (91403) ← encounter hostility perf fix
```

### Animation Framework (SE/AE)

```
SKSE64 (30379)
├── FNIS Behavior SE (3038)                 ← legacy animation framework
│   └── [many older animation mods]
└── Nemesis Unlimited Behavior Engine (60033) ← modern replacement for FNIS
    └── [most newer animation mods]
```

**Note:** FNIS and Nemesis serve the same purpose but can coexist. Nemesis includes a
FNIS compatibility dummy. Most new mods target Nemesis; FNIS is only needed for legacy
animation mods that haven't been updated.

### Serana Dialogue Add-On (SE/AE/VR)

```
USSEP (266)                                 ← SDA references USSEP-fixed records
├── Serana Dialogue Add-On (32161)
│   └── SDA Patch Hub SE (70782)            ← patches for SDA + other mod conflicts
│       └── Ashe and Serana Banter Patch (167123) ← if Ashe follower installed
└── Fuz Ro D'oh (15109)                     ← silent dialogue lip-sync for unvoiced lines
```

## AE ↔ VR Cross-Compatibility Mapping

> **Purpose**: Maps every mod in the AE baseline to its VR analog, port status, and blockers.
> Use this table to assess VR parity with the AE setup and plan VR mod installations.
> **Updated**: February 8, 2026 (based on AE baseline v1.6.1170 and VR baseline 1.4.15)

### Legend

| Status | Meaning |
|--------|---------|
| **MATCHED** | Already in VR baseline (same or equivalent mod) |
| **PORTABLE** | Can install directly — ESP/meshes/textures only, no DLL needed |
| **VR BUILD EXISTS** | SKSE DLL required, but a known VR build is available |
| **VR BUILD UNKNOWN** | SKSE DLL required, VR build existence needs verification |
| **NO VR PORT** | Cannot work in VR — depends on engine features unavailable in VR |
| **N/A IN VR** | Not applicable to VR (e.g., widescreen fixes, flat-screen-only features) |
| **VR EXCLUSIVE** | VR-only mod with no AE counterpart needed |

### Engine / Root-Level

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| SKSE64 2.2.6 | 30379 | SKSEVR 2.0.12 | 30457 | **MATCHED** | Different Nexus pages, different DLLs |
| Engine Fixes AIO 7.0.19 | 17230 | Engine Fixes VR 1.26 | 62089 | **MATCHED** | Separate VR build (2-part install) |

### Frameworks & Libraries

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| Address Library v11 | 32444 | VR Address Library 0.195.0 | 58101 | **MATCHED** | Mutually exclusive by edition; VR version is alpha with ~3,884 mappings |
| Base Object Swapper 3.4.1 | 60805 | Base Object Swapper VR | 60805 | **VR BUILD UNKNOWN** | Check optional files for VR DLL; needed by Icy Mesh Remaster |
| ConsoleUtilSSE NG 1.5.1 | 76649 | ConsoleUtilSSE VR | 76649 | **VR BUILD UNKNOWN** | Check optional files; many mods soft-depend on this |
| JContainers SE 4.2.9 | 16495 | JContainers VR **4.2.11** | 16495 | **MATCHED** | VR build confirmed — v4.2.11 from VR files section. Independently maintained, slightly newer than SE build. |
| PapyrusUtil AE 4.6 | 13048 | PapyrusUtil VR **3.6b** | 13048 | **MATCHED** | VR build confirmed — **must use v3.6b** (VR files section). v4.x is AE-only. |
| powerofthree's Tweaks 1.1.5.1 | 51073 | po3 Tweaks VR | 51073 | **MATCHED** | VR DLL in optional files — confirmed working |
| BEES 1.2 | 106441 | Skyrim VR ESL Support 1.2 | 106712 | **MATCHED** | Different mods solving same problem (ESL support) for different editions |
| Fuz Ro D'oh 2.5 | 15109 | Fuz Ro D'oh **1.7** | 15109 | **MATCHED** | **⚠ VERSION CRITICAL**: VR must use **v1.7** (NOT v2.5). v2.x targets AE SKSE runtime, will crash SKSEVR. Old files section on Nexus. |

### Stability & Crash Fixes

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| CrashLogger 1.19.1 | 59818 | CrashLogger VR | 59818 | **MATCHED** | Same Nexus page, VR build exists |
| SMP-NPC Crash Fix 1 | 91616 | SMP-NPC Crash Fix 1 | 91616 | **MATCHED** | ESP-only, works across editions |
| SrtCrashFix AE 0.4.1 | 31146 | — | — | **NO VR PORT** | AE-specific stack trace fix; VR has different crash patterns |
| Animation Queue Fix 1.0.1 | 82395 | Animation Queue Fix VR | 82395 | **VR BUILD UNKNOWN** | Check optional files; SKSE DLL needed |
| World Encounter Hostility Fix 0.4 | 91403 | World Encounter Hostility Fix | 91403 | **VR BUILD UNKNOWN** | Performance version; check if DLL or ESP-only |

### Performance

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| eFPS 2.4.2 | 54907 | eFPS 2.4.2 | 54907 | **MATCHED** | ESP + occlusion meshes only, no DLL; installed in VR |
| Grass FPS Booster 7.9.2 | 20082 | Grass FPS Booster 7.9.2 | 20082 | **MATCHED** | ESP + grass config; installed in VR |
| NVIDIA Reflex 1.1.2 | 74498 | — | — | **NO VR PORT** | AE-specific SKSE DLL for NVIDIA Reflex; not applicable to VR rendering pipeline |

### UI

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| SkyUI 5.2 SE | 12604 | SkyUI VR 1.2.2 | GitHub | **MATCHED** | VR fork from GitHub (Odie/skyui-vr), not Nexus |
| Complete Widescreen Fix 3.9.1 | 1778 | — | — | **N/A IN VR** | VR uses headset displays, not widescreen monitors |

### Patches & Bug Fixes

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| USSEP 4.3.6c | 266 | ~~USSEP~~ **removed** | 266 | **REMOVED** | v4.3.6c requires CC masters; removed from VR baseline. Re-add as v4.2.5b when found. |
| No NPC Greetings 2.0a | 1044 | No NPC Greetings | 1044 | **PORTABLE** | ESP-only, no DLL; install directly |

### Body & Character

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| CBBE 2.0.3 | 198 | CBBE 2.0.3 | 198 | **MATCHED** | Meshes/textures, cross-edition |
| BodySlide 5.7.1 | 201 | BodySlide 5.7.1 | 201 | **MATCHED** | Tool + meshes, cross-edition |
| RaceMenu AE 0.4.19.16 | 19080 | RaceMenu VR **0.4.14** | 19080 | **MATCHED** | **⚠ VERSION CRITICAL**: Both main file AND VR DLL must be v0.4.14. Do NOT use AE main file (0.4.19.16) — its scripts target AE SKSE APIs. Install v0.4.14 main + v0.4.14 VR DLL. |
| XPMSSE 5.06 | 1988 | XPMSSE 5.06 | 1988 | **MATCHED** | ESP + skeleton meshes, no DLL; installed in VR. Required for SMP physics bone nodes. |

### Physics (Hair / Cloth)

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| Faster HDT-SMP 2.5.1 | 57339 | Faster HDT-SMP 2.5.1 | 57339 | **MATCHED** | **Confirmed working in VR** (Feb 2026). Same mod, same version — no separate VR build needed. Previously thought AE-only; HDT-SMP VR (30872) is no longer required. |
| Vanilla Hair Remake SMP 1.0.3 | 63979 | Vanilla Hair Remake SMP 1.0.3 | 63979 | **MATCHED** | SMP hair meshes are cross-edition; installed in VR with Faster HDT-SMP + XPMSSE. NPC addon (v1.0.1) also installed. |

### Animation

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| FNIS 7.6 | 3038 | FNIS 7.6 | 3038 | **MATCHED** | ESP + animation files; installed in VR |
| Nemesis 0.84 beta | 60033 | Nemesis 0.84 beta | 60033 | **MATCHED** | Animation framework; installed in VR |

### Visuals — Landscape & Flora

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| SMIM SE 2.08 | 659 | SMIM SE 2.08 | 659 | **MATCHED** | Meshes/textures, cross-edition |
| Faithful Faces 1.3.5 | 114342 | Faithful Faces | 114342 | **PORTABLE** | ESP + NPC face textures; no DLL |
| Cathedral 3D Landscapes 16.41 | 80687 | Cathedral 3D Landscapes | 80687 | **PORTABLE** | Meshes + textures; base landscape layer works without CS |
| DrJacopo's 3D Grass Library 16.53 | 80687 | DrJacopo's 3D Grass Library | 80687 | **PORTABLE** | 3D grass mesh library; companion to Cathedral |
| Vanaheimr Landscapes CPM 5.5 | 145439 | Vanaheimr Landscapes CPM | 145439 | **PORTABLE** | Textures + ESP, no DLL. **With Community Shaders in VR**: full CPM/parallax effects render correctly — same as AE. Run PGPatcher to set shader flags on meshes. Requires CS + Terrain Helper. |
| Freak's Floral Fields 3.1 | 125349 | Freak's Floral Fields | 125349 | **PORTABLE** | Requires Community Shaders grass shader — **which now works in VR**. Install directly; same region ESPs as AE. Requires Cathedral 3D Landscapes + DrJacopo's 3D Grass Library. |
| ERM 1.1.1 | 121336 | ERM | 121336 | **PORTABLE** | Rock/mountain textures; no DLL, no CS dependency. If ERM ships `_p.dds` parallax textures, CS + PGPatcher enables parallax rendering in VR. |
| Better Dynamic Snow SE 3.6.0 | 9121 | Better Dynamic Snow SE 3.6.0 | 9121 | **MATCHED** | ESP + snow meshes; installed in VR |
| Grass Lighting 2.0.0 | 86502 | Grass Lighting | 86502 | **PORTABLE** | Community Shaders plugin — **works in VR with CS**. Install directly via mod manager. |
| Icy Mesh Remaster 3.35 | 73381 | Icy Mesh Remaster | 73381 | **PORTABLE** (partial) | Mesh fixes work directly; `IcyFixes.esp` (Base Object Swapper config) needs BOS VR DLL. Install meshes only if BOS unavailable. |
| Terrain Helper 1.0.0 | 143149 | Terrain Helper | 143149 | **PORTABLE** | Terrain blending helper for CS. **Works in VR with Community Shaders**. Install directly. |
| Falskaar Landscape Fix 1.0 | 139242 | Falskaar Landscape Fix | 139242 | **PORTABLE** | ESL plugin; cross-edition (only relevant if Falskaar is installed) |

### Graphics Post-Processing

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| Community Shaders 1.4.11 | 86492 | Community Shaders (VR build) | 86492 | **VR BUILD EXISTS** | Same Nexus page — VR build available in files tab. **Screen Space GI (130375) confirmed working in VR as CS add-on.** Not yet installed as base framework in VR — SSGI may bundle a VR CS build, or work standalone. Needs further verification. |

### NPC / Followers / Dialogue

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| Serana Dialogue Add-On 4.3.0 | 32161 | Serana DA 4.3.0 | 32161 | **MATCHED** | ESP + voice files; cross-edition |
| SDA Patch Hub 2.9.6 | 70782 | SDA Patch Hub 2.9.6 | 70782 | **MATCHED** | ESP patches; cross-edition |
| Ashe 1.3.3 | 135085 | Ashe 1.3.3 | 135085 | **MATCHED** | Updated to 1.3.3 in VR |
| Ashe-Serana Banter 1.0.6 | 167123 | Ashe-Serana Banter 1.0.6 | 167123 | **MATCHED** | Updated to 1.0.6 in VR |
| Fabulous Followers 1.05 | 57284 | Fabulous Followers 1.05 | 57284 | **MATCHED** | ESP; cross-edition |

### Gameplay / Tools

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| Alternate Perspective 4.1.0 | 50307 | Alternate Perspective 4.1.0 | 50307 | **MATCHED** (testing) | Installed in VR — appears to work. May be ESP/scripts only or may have VR-compatible DLL. Further testing needed. |
| FonixData (Mantella) 1.0 | 40971 | FonixData | 40971 | **PORTABLE** | Lip-sync data files; no DLL |
| PGPatcher 0.9.9 | 120946 | PGPatcher | 120946 | **PORTABLE** | PGPatcher is an **offline tool** (not an SKSE plugin) — it patches NIF mesh shader flags at rest. Runs outside the game; output works in any edition. **With Community Shaders in VR**: all PGPatcher output is fully functional — parallax, CM/CPM, and PBR flags are all rendered by CS. Run PGPatcher after installing texture mods, copy output to VR Data folder. |

### VR-Exclusive Mods (no AE counterpart needed)

| VR Mod | Nexus ID | Purpose | AE Equivalent |
|--------|----------|---------|---------------|
| VRIK Player Avatar 0.8.5 | 23416 | Visible VR body, gestures, holsters | N/A — flat-screen has natural player body |
| HIGGS 1.10.10 | 43930 | Hand interaction, gravity gloves | N/A — flat-screen uses standard activate |
| PLANCK 0.7.1 | 66025 | Physics-based melee combat | N/A — flat-screen combat is animation-based |
| SkyrimVRTools 2.3 BETA | 27782 | VR controller API framework | N/A — no controllers in flat-screen |
| Bandolier 1.2 | 2417 | Bags/pouches (extra carry) | Not in AE baseline but could be added |

### Parity Summary

| Status | Count | Percentage |
|--------|-------|------------|
| **MATCHED** | 32 | 50% |
| **PORTABLE** (install directly) | 12 | 19% |
| **VR BUILD EXISTS** (known) | 2 | 3% |
| **VR BUILD UNKNOWN** (needs check) | 2 | 3% |
| **REMOVED** (needs replacement) | 1 | 2% |
| **N/A IN VR** | 3 | 5% |
| **NO VR PORT** | 0 | 0% |
| **CS shader add-ons** (untested in VR) | 11 | 17% |
| **Total AE mods** | **64** | 100% (rounding) |

> **Key insight**: With SMP hair physics working, 32 of 64 AE mods are now confirmed in VR (50%, up from 28/64).
> Faster HDT-SMP, Vanilla Hair Remake SMP (+ NPCs), and ConsoleUtilSSE NG are all confirmed working.
> Screen Space GI remains the only CS shader add-on confirmed in VR.
> 11 CS shader add-ons remain untested.

### Critical Parity Blockers (Remaining)

1. **No USSEP in VR** — v4.3.6c was removed (CC deps). Need to find and install **4.2.5b** from old files.
2. ~~**SMP physics engine**~~ — **RESOLVED**: Faster HDT-SMP (57339) works directly in VR. HDT-SMP VR (30872) is no longer needed.
3. **Community Shaders base** — Screen Space GI is working, but CS itself may not be explicitly installed. Need to verify.
4. **11 CS shader add-ons** — Need VR build testing (Skylighting, SSS, Wetness, Cloud Shadows, Terrain Blending/Variation, Grass Collision, Hair Specular, Hair Flow Maps, Sky Sync, Upscaling).
5. **2 mods need VR build verification** — Base Object Swapper, Animation Queue Fix.

### Recommended VR Additions (Priority Order)

Mods that can be added to VR baseline to close the parity gap, ordered by impact and safety:

#### Tier 1 — Safe, High Impact (ESP/mesh/texture only)
| Mod | Nexus ID | Action |
|-----|----------|--------|
| USSEP 4.2.5b | 266 | **Replace** current 4.3.6c with 4.2.5b (or remove entirely) |
| XPMSSE | 1988 | Install directly — skeleton meshes, no DLL |
| No NPC Greetings | 1044 | Install directly — ESP only |
| Faithful Faces | 114342 | Install directly — ESP + textures |
| Cathedral 3D Landscapes | 80687 | Install directly — meshes + textures |
| DrJacopo's 3D Grass Library | 80687 | Install directly — companion to Cathedral |
| Vanaheimr Landscapes CPM | 145439 | Install directly — 4K CPM landscape textures (requires CS) |
| Freak's Floral Fields | 125349 | Install directly — region grass ESPs (requires CS grass shader) |
| ERM | 121336 | Install directly — rock/mountain textures |
| Better Dynamic Snow SE | 9121 | Install directly — ESP + meshes |
| Grass Lighting | 86502 | Install directly — CS grass shader plugin |
| Terrain Helper | 143149 | Install directly — CS terrain blending |
| eFPS | 54907 | Install directly — occlusion ESP + meshes |
| Grass FPS Booster | 20082 | Install directly — ESP + grass config |
| PGPatcher | 120946 | Run offline — patch mesh shader flags for CS |
| FonixData | 40971 | Install directly — lip-sync data |

#### Tier 2 — Known VR Builds, Moderate Complexity
| Mod | Nexus ID | Action |
|-----|----------|--------|
| Community Shaders (VR) | 86492 | Install VR build from Nexus files tab — **high priority**, enables Tier 1 landscape/grass mods |
| ~~RaceMenu (VR)~~ | ~~19080~~ | **INSTALLED** — dual-file install complete |
| ~~po3 Tweaks (VR)~~ | ~~51073~~ | **INSTALLED** |
| ~~Faster HDT-SMP~~ | ~~57339~~ | **INSTALLED** — works in VR directly (no need for HDT-SMP VR 30872) |
| ~~Vanilla Hair Remake SMP~~ | ~~63979~~ | **INSTALLED** — base + NPC addon |

#### Tier 3 — Needs VR Build Verification
| Mod | Nexus ID | Action |
|-----|----------|--------|
| Base Object Swapper | 60805 | Check Nexus optional files for VR DLL |
| ~~ConsoleUtilSSE NG~~ | ~~76649~~ | **INSTALLED** — v1.5.1 confirmed working in VR |
| JContainers SE | 16495 | Check Nexus optional files for VR DLL |
| PapyrusUtil | 13048 | Check Nexus optional files for VR DLL |
| Fuz Ro D'oh | 15109 | Check Nexus optional files for VR DLL |
| Animation Queue Fix | 82395 | Check Nexus optional files for VR DLL |
| Alternate Perspective | 50307 | Check Nexus optional files for VR DLL |

#### Tier 4 — Cannot Port (Accept Divergence)
| AE Mod | Reason | VR Workaround |
|--------|--------|---------------|
| SrtCrashFix AE | AE-specific stack trace fix | No VR equivalent needed (different crash patterns) |
| NVIDIA Reflex | AE SKSE DLL | Not applicable to VR rendering |
| Complete Widescreen Fix | Flat-screen UI | Not applicable to VR headset display |

### Version Update Opportunities

All VR mods are now at latest compatible versions. No pending updates.

> **Version pinning reminder**: VR versions of SKSE-dependent mods are permanently pinned.
> RaceMenu (0.4.14), Fuz Ro D'oh (1.7), PapyrusUtil VR (3.6b) will NOT receive updates
> unless SKSEVR runtime itself is updated (extremely unlikely).
> See `vr-baseline.detail.instructions.md` → "VR-Specific Version Requirements" for the
> complete version mapping table.

## Cross-References

- **VR modding guide**: `vr-modding.detail.instructions.md`
- **VR baseline snapshot**: `vr-baseline.detail.instructions.md`
- **AE baseline snapshot**: `ae-baseline.detail.instructions.md`
- **Local system & installed mods**: `local-system.detail.instructions.md`
- **Nexus Mods navigation**: `nexus-mods.detail.instructions.md`
- **Plugin development**: `plugin-development.instructions.md`

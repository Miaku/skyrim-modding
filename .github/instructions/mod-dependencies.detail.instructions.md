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
| RaceMenu VR 0.4.14 | Optional files | 571KB | VR-compiled `skee64.dll` |

**Install for VR:**
1. Install main file (file_id=465102)
2. Install VR overlay (file_id=154909) — overwrites `skee64.dll`
3. Delete `skee64.dll` and `skee64.ini` from the main file if mod manager warns about conflicts

**Why the version mismatch?** VR DLL (0.4.14) lags behind AE (0.4.19.16) because:
- SKSEVR runtime (1.4.15) is frozen — no new updates
- The DLL must be compiled against SKSEVR, which requires separate maintenance
- The ESP/scripts are forward-compatible; only the native DLL is edition-locked

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

### Rule 5: Version Lag is Normal for VR
VR variants of mods are often several versions behind SE/AE. This is expected because:
- VR runtime is frozen at 1.4.15 (no Bethesda updates)
- VR mod ports require manual address mapping (crowdsourced, incomplete)
- Fewer VR mod authors = slower update cycle

## Mods with Known VR Complications

| Mod | Issue | Workaround |
|-----|-------|------------|
| **USSEP (≥4.2.6)** | Requires 5 CC masters not present in VR: `ccbgssse001-fish.esm`, `ccqdrsse001-survivalmode.esl`, `ccbgssse037-curios.esl`, `ccbgssse025-advdsgs.esm`, `_ResourcePack.esl` | Use USSEP **4.2.5b** (last version without CC deps) or skip entirely. **Do NOT copy CC files from AE** — see Install Isolation rule. |
| RaceMenu | Dual-file install, VR DLL lags behind | See install pattern above |
| ENB | VR-specific binary required; **not needed for SE/AE if using Community Shaders** | Use VR ENB build from enbdev.com. For SE/AE, prefer Community Shaders (86492) instead |
| .NET Script Framework | No VR build exists | Use CrashLogger VR (59818) instead |
| SSE Engine Fixes | Separate VR build | Use Engine Fixes VR (62089) |
| powerofthree's Tweaks | Separate VR DLL in optional files | Check optional files section |
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

**VR Note:** Faster HDT-SMP has no VR build. For VR SMP physics, use the original
[HDT-SMP for Skyrim VR](https://www.nexusmods.com/skyrimspecialedition/mods/30872)
or check if a VR-compiled fork exists. The same chain structure applies but with VR equivalents.

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
| JContainers SE 4.2.9 | 16495 | JContainers VR | 16495 | **VR BUILD UNKNOWN** | Check optional files; needed by some follower/quest mods |
| PapyrusUtil AE 4.6 | 13048 | PapyrusUtil VR | 13048 | **VR BUILD UNKNOWN** | Check optional files; widely used scripting utility |
| powerofthree's Tweaks 1.1.5.1 | 51073 | po3 Tweaks VR | 51073 | **VR BUILD EXISTS** | VR DLL in optional files (documented in mod-dependencies) |
| BEES 1.2 | 106441 | Skyrim VR ESL Support 1.2 | 106712 | **MATCHED** | Different mods solving same problem (ESL support) for different editions |
| Fuz Ro D'oh 2.5 | 15109 | Fuz Ro D'oh VR | 15109 | **VR BUILD UNKNOWN** | Check optional files; needed for silent dialogue lip-sync (Serana DA uses it) |

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
| eFPS 2.4.2 | 54907 | eFPS | 54907 | **PORTABLE** | ESP + occlusion meshes only, no DLL; should work directly in VR |
| Grass FPS Booster 7.9.2 | 20082 | Grass FPS Booster | 20082 | **PORTABLE** | ESP + grass config; texture/mesh mod, no DLL |
| NVIDIA Reflex 1.1.2 | 74498 | — | — | **NO VR PORT** | AE-specific SKSE DLL for NVIDIA Reflex; not applicable to VR rendering pipeline |

### UI

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| SkyUI 5.2 SE | 12604 | SkyUI VR 1.2.2 | GitHub | **MATCHED** | VR fork from GitHub (Odie/skyui-vr), not Nexus |
| Complete Widescreen Fix 3.9.1 | 1778 | — | — | **N/A IN VR** | VR uses headset displays, not widescreen monitors |

### Patches & Bug Fixes

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| USSEP 4.3.6c | 266 | USSEP **4.2.5b** | 266 | **PORTABLE** (downgrade required) | VR has 4.3.6c staged but **NOT LOADED** — requires CC masters. Must downgrade to **4.2.5b** (last version without CC deps). Do NOT copy CC files from AE. |
| No NPC Greetings 2.0a | 1044 | No NPC Greetings | 1044 | **PORTABLE** | ESP-only, no DLL; install directly |

### Body & Character

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| CBBE 2.0.3 | 198 | CBBE 2.0.3 | 198 | **MATCHED** | Meshes/textures, cross-edition |
| BodySlide 5.7.1 | 201 | BodySlide 5.7.1 | 201 | **MATCHED** | Tool + meshes, cross-edition |
| RaceMenu AE 0.4.19.16 | 19080 | RaceMenu VR 0.4.14 | 19080 | **VR BUILD EXISTS** | Dual-file install: main file (ESP/scripts) + VR optional DLL (file_id=154909). VR DLL lags behind AE — expected. See mod-dependencies install pattern. |
| XPMSSE 5.06 | 1988 | XPMSSE | 1988 | **PORTABLE** | ESP + skeleton meshes, no DLL; install directly. Required for SMP physics bone nodes. |

### Physics (Hair / Cloth)

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| Faster HDT-SMP 2.5.1 | 57339 | HDT-SMP for Skyrim VR | 30872 | **VR BUILD EXISTS** (different mod) | Faster HDT-SMP has NO VR port. Use the original HDT-SMP VR build (Nexus 30872) instead. Fewer features but functional SMP physics in VR. |
| Vanilla Hair Remake SMP 1.0.3 | 63979 | Vanilla Hair Remake SMP | 63979 | **PORTABLE** (with SMP engine) | SMP hair meshes are cross-edition; but need a VR SMP engine (HDT-SMP VR 30872) + XPMSSE skeleton to function. Without SMP engine, hair renders but won't animate. |

### Animation

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| FNIS 7.6 | 3038 | FNIS | 3038 | **PORTABLE** | ESP + animation files; FNIS output is cross-edition. Run FNIS from a flat-screen context, copy output to VR. |
| Nemesis 0.84 beta | 60033 | Nemesis | 60033 | **PORTABLE** | Same as FNIS — animation engine output is cross-edition. Nemesis itself is a tool, not a runtime DLL. |

### Visuals — Landscape & Flora

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| SMIM SE 2.08 | 659 | SMIM SE 2.08 | 659 | **MATCHED** | Meshes/textures, cross-edition |
| Faithful Faces 1.3.5 | 114342 | Faithful Faces | 114342 | **PORTABLE** | ESP + NPC face textures; no DLL |
| Cathedral 3D Landscapes 16.41 | 80687 | Cathedral 3D Landscapes | 80687 | **PORTABLE** | Meshes + textures; base landscape layer works without CS |
| DrJacopo's 3D Grass Library 16.53 | 80687 | DrJacopo's 3D Grass Library | 80687 | **PORTABLE** | 3D grass mesh library; companion to Cathedral |
| Vanaheimr Landscapes CPM 5.5 | 145439 | Vanaheimr Landscapes | 145439 | **PORTABLE** (partial with ENB VR) | **With ENB VR**: parallax `_p.dds` textures render correctly (ENB `FixParallaxBugs=true`). Run PGPatcher to set parallax flags on meshes. **Without ENB VR or CS**: textures still install as a flat color/normal upgrade over vanilla. **CM/CPM `_m.dds` effects** (metallic, roughness, depth) remain CS-only — ENB VR cannot render these. Install parallax variant if available, or accept partial effects. |
| Freak's Floral Fields 3.1 | 125349 | — | — | **NO VR PORT** | **Hard requires Community Shaders grass shader** for rendering. ENB VR does not include a grass shader equivalent. Without CS, grass will not display correctly. Skip for VR — keep Skyrim Flora Overhaul or other VR-compatible grass. |
| ERM 1.1.1 | 121336 | ERM | 121336 | **PORTABLE** | Rock/mountain textures; no DLL, no CS dependency. If ERM ships `_p.dds` parallax textures, ENB VR + PGPatcher can enable parallax rendering. |
| Better Dynamic Snow SE 3.6.0 | 9121 | Better Dynamic Snow SE | 9121 | **PORTABLE** | ESP + snow meshes; cross-edition |
| Grass Lighting 2.0.0 | 86502 | — | — | **NO VR PORT** | CS-only grass shader plugin. ENB VR's ambient occlusion and lighting improvements provide a *partial* alternative (indirect light on all objects, not grass-specific). |
| Icy Mesh Remaster 3.35 | 73381 | Icy Mesh Remaster | 73381 | **PORTABLE** (partial) | Mesh fixes work directly; `IcyFixes.esp` (Base Object Swapper config) needs BOS VR DLL. Install meshes only if BOS unavailable. |
| Terrain Helper 1.0.0 | 143149 | Terrain Helper + ENB VR | 143149 | **PORTABLE** (with ENB VR) | Terrain Helper works with both CS *and* ENB for terrain blending. **With ENB VR installed, Terrain Helper becomes functional** — provides terrain blending data that ENB's terrain fix uses. |
| Falskaar Landscape Fix 1.0 | 139242 | Falskaar Landscape Fix | 139242 | **PORTABLE** | ESL plugin; cross-edition (only relevant if Falskaar is installed) |

### Graphics Post-Processing

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| Community Shaders 1.4.11 | 86492 | **ENB VR** | enbdev.com | **VR BUILD EXISTS** (partial equivalent) | ENB VR from `enbdev.com/download_mod_tesskyrimvr.htm` is a **partial replacement** for CS. See "ENB VR Parity Recovery" section below for feature-by-feature comparison. **Recovers**: post-processing (AO, DOF, bloom, color), parallax rendering, terrain fixes. **Does NOT recover**: CM/CPM, PBR, grass shaders. Performance cost is higher than CS (~15-25% GPU overhead in VR's double-render pipeline) — choose a lightweight preset. |

### NPC / Followers / Dialogue

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| Serana Dialogue Add-On 4.3.0 | 32161 | Serana DA 4.3.0 | 32161 | **MATCHED** | ESP + voice files; cross-edition |
| SDA Patch Hub 2.9.6 | 70782 | SDA Patch Hub 2.9.6 | 70782 | **MATCHED** | ESP patches; cross-edition |
| Ashe 1.3.3 | 135085 | Ashe 1.3.0 | 135085 | **MATCHED** (update available) | VR is v1.3.0 → update to 1.3.3 (ESP + assets, no DLL) |
| Ashe-Serana Banter 1.0.6 | 167123 | Ashe-Serana Banter 1.0.4 | 167123 | **MATCHED** (update available) | VR is v1.0.4 → update to 1.0.6 (ESP only) |
| Fabulous Followers 1.05 | 57284 | Fabulous Followers 1.05 | 57284 | **MATCHED** | ESP; cross-edition |

### Gameplay / Tools

| AE Mod | Nexus ID | VR Analog | VR Nexus ID | Status | Notes |
|--------|----------|-----------|-------------|--------|-------|
| Alternate Perspective 4.1.0 | 50307 | Alternate Perspective | 50307 | **VR BUILD UNKNOWN** | Has SKSE DLL component; check if VR build exists in optional files. ESP/scripts may work alone. |
| FonixData (Mantella) 1.0 | 40971 | FonixData | 40971 | **PORTABLE** | Lip-sync data files; no DLL |
| PGPatcher 0.9.9 | 120946 | PGPatcher | 120946 | **PORTABLE** (with ENB VR) | PGPatcher is an **offline tool** (not an SKSE plugin) — it patches NIF mesh shader flags at rest. It runs outside the game and its output works in any edition. **With ENB VR**: PGPatcher parallax flag patching is fully useful — ENB renders parallax. **Without ENB VR**: parallax flags are set but no renderer honors them. **CM/PBR flags** remain CS-only regardless of ENB. Run PGPatcher after installing texture mods, copy output to VR Data folder. |

### VR-Exclusive Mods (no AE counterpart needed)

| VR Mod | Nexus ID | Purpose | AE Equivalent |
|--------|----------|---------|---------------|
| VRIK Player Avatar 0.8.5 | 23416 | Visible VR body, gestures, holsters | N/A — flat-screen has natural player body |
| HIGGS 1.10.10 | 43930 | Hand interaction, gravity gloves | N/A — flat-screen uses standard activate |
| PLANCK 0.7.1 | 66025 | Physics-based melee combat | N/A — flat-screen combat is animation-based |
| SkyrimVRTools 2.3 BETA | 27782 | VR controller API framework | N/A — no controllers in flat-screen |
| Bandolier 1.2 | 2417 | Bags/pouches (extra carry) | Not in AE baseline but could be added |

### Parity Summary (Without ENB VR)

| Status | Count | Percentage |
|--------|-------|------------|
| **MATCHED** | 18 | 35% |
| **PORTABLE** (install directly) | 14 | 27% |
| **VR BUILD EXISTS** (known) | 3 | 6% |
| **VR BUILD UNKNOWN** (needs check) | 7 | 13% |
| **NO VR PORT** | 7 | 13% |
| **N/A IN VR** | 3 | 6% |
| **Total AE mods** | **52** | 100% |

### Parity Summary (With ENB VR Installed)

| Status | Count | Percentage | Change |
|--------|-------|------------|--------|
| **MATCHED** | 18 | 35% | — |
| **PORTABLE** (install directly) | 14 | 27% | — |
| **VR BUILD EXISTS** (known) | 4 | 8% | +1 (CS → ENB VR) |
| **VR BUILD UNKNOWN** (needs check) | 7 | 13% | — |
| **NO VR PORT** | 4 | 8% | -3 (PGPatcher, Terrain Helper, Vanaheimr parallax recovered) |
| **N/A IN VR** | 3 | 6% | — |
| **Partially recovered** | 2 | 4% | Vanaheimr parallax (not CM), Grass Lighting (ENB AO partial) |
| **Total AE mods** | **52** | 100% | |

### ENB VR Parity Recovery

Installing ENB VR recovers or partially recovers these previously-blocked features:

| Feature | Without ENB VR | With ENB VR | Recovery Level |
|---------|----------------|-------------|----------------|
| Post-processing (AO, DOF, bloom, color) | None | Full | **Full** |
| Parallax rendering (`_p.dds`) | Not rendered | Rendered via `FixParallaxBugs=true` | **Full** |
| PGPatcher parallax patching | Useless (no renderer) | Functional (ENB renders parallax flags) | **Full** |
| Terrain Helper blending | Non-functional | Functional (ENB uses terrain data) | **Full** |
| Vanaheimr parallax textures | Flat only | Parallax depth on surfaces | **Partial** (parallax yes, CM no) |
| Vanaheimr CM/CPM effects (`_m.dds`) | Not rendered | Not rendered | **None** — CS-only |
| Freak's Floral Fields grass | Non-functional | Non-functional | **None** — CS grass shader only |
| Grass Lighting (CS plugin) | No grass lighting | ENB AO/indirect lighting on all geometry | **Partial** (not grass-specific) |
| PBR rendering | Not possible | Not possible | **None** — CS-only |

### ENB VR Performance Considerations

- VR renders **two viewports** — ENB cost is roughly doubled vs flat SE
- Expect **15-25% GPU overhead** depending on preset
- **Disable depth of field** — causes motion sickness in VR
- **Reduce ambient occlusion quality** — biggest single ENB perf hit
- Use a **lightweight VR-tested preset** (Pi-CHO, Cabbage-style)
- Set `FPSLimit=90.0` (or your headset's refresh rate) in `enblocal.ini`
- VR target is 90 FPS minimum; if ENB drops below, disable heaviest effects first

### Critical Parity Blockers (Remaining After ENB VR)

1. **Complex Material / CPM rendering** — CS-exclusive; ENB cannot render `_m.dds` metallic/roughness maps. Vanaheimr's advanced depth effects remain flat. No workaround.
2. **CS Grass Shader** — CS-exclusive; blocks Freak's Floral Fields entirely. Keep Skyrim Flora Overhaul for VR grass. No workaround.
3. **PBR rendering** — CS-exclusive; no ENB equivalent. Affects future PBR texture mods.
4. **USSEP version mismatch** — VR needs downgrade from 4.3.6c to 4.2.5b. Not ENB-related.
5. **SMP physics engine** — Faster HDT-SMP has no VR build; must use older HDT-SMP VR (30872). Not ENB-related.

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
| ERM | 121336 | Install directly — rock/mountain textures |
| Better Dynamic Snow SE | 9121 | Install directly — ESP + meshes |
| eFPS | 54907 | Install directly — occlusion ESP + meshes |
| Grass FPS Booster | 20082 | Install directly — ESP + grass config |
| FonixData | 40971 | Install directly — lip-sync data |

#### Tier 2 — Known VR Builds, Moderate Complexity
| Mod | Nexus ID | Action |
|-----|----------|--------|
| RaceMenu (VR) | 19080 | Dual-file install: main + VR DLL (file_id=154909) |
| po3 Tweaks (VR) | 51073 | Install main + VR optional DLL |
| HDT-SMP VR | 30872 | Install VR SMP engine (replaces Faster HDT-SMP) |
| Vanilla Hair Remake SMP | 63979 | Install after HDT-SMP VR + XPMSSE are in place |

#### Tier 3 — Needs VR Build Verification
| Mod | Nexus ID | Action |
|-----|----------|--------|
| Base Object Swapper | 60805 | Check Nexus optional files for VR DLL |
| ConsoleUtilSSE NG | 76649 | Check Nexus optional files for VR DLL |
| JContainers SE | 16495 | Check Nexus optional files for VR DLL |
| PapyrusUtil | 13048 | Check Nexus optional files for VR DLL |
| Fuz Ro D'oh | 15109 | Check Nexus optional files for VR DLL |
| Animation Queue Fix | 82395 | Check Nexus optional files for VR DLL |
| Alternate Perspective | 50307 | Check Nexus optional files for VR DLL |

#### Tier 4 — Cannot Port (Accept Divergence)
| AE Mod | Reason | VR Workaround |
|--------|--------|---------------|
| Freak's Floral Fields | Requires CS grass shader (ENB has no equivalent) | Use Skyrim Flora Overhaul (already installed) or other VR-compatible grass |
| Grass Lighting | CS plugin (ENB AO is partial substitute) | ENB ambient occlusion covers general indirect lighting |
| Vanaheimr CM effects | CS renders CPM `_m.dds`; ENB cannot | Install textures — parallax works with ENB, CM stays flat |
| SrtCrashFix AE | AE-specific | No VR equivalent needed (different crash patterns) |
| NVIDIA Reflex | AE SKSE DLL | Not applicable to VR rendering |
| Complete Widescreen Fix | Flat-screen UI | Not applicable to VR headset display |

#### Tier 5 — Recoverable with ENB VR
These were previously "NO VR PORT" but become functional when ENB VR is installed:

| Mod | Nexus ID | What ENB VR Enables |
|-----|----------|---------------------|
| PGPatcher (parallax patching) | 120946 | Run offline, output parallax-flagged NIFs → ENB renders them via `FixParallaxBugs=true` |
| Terrain Helper | 143149 | ENB uses terrain blending data for biome transitions |
| Vanaheimr Landscapes (parallax) | 145439 | `_p.dds` parallax textures render correctly under ENB VR |
| Community Shaders → ENB VR | enbdev.com | Post-processing: AO, DOF, bloom, color grading, weather presets |

### Version Update Opportunities

Mods already in VR baseline that can be updated to match AE versions:

| Mod | VR Version | AE Version | Action |
|-----|-----------|------------|--------|
| Ashe - Crystal Heart | 1.3.0 | 1.3.3 | Update — ESP + assets, no DLL |
| Ashe-Serana Banter | 1.0.4 | 1.0.6 | Update — ESP only |

## Cross-References

- **VR modding guide**: `vr-modding.detail.instructions.md`
- **VR baseline snapshot**: `vr-baseline.detail.instructions.md`
- **AE baseline snapshot**: `ae-baseline.detail.instructions.md`
- **Local system & installed mods**: `local-system.detail.instructions.md`
- **Nexus Mods navigation**: `nexus-mods.detail.instructions.md`
- **Plugin development**: `plugin-development.instructions.md`

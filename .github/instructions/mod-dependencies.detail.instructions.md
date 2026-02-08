---
name: "mod-dependencies-detail"
description: "Tribal knowledge for mod dependencies, edition-specific variants, and install patterns\nKeywords: dependency, dependencies, requirement, required, compatible, compatibility, install, version, variant, VR version, SE version, AE version, which version, do I need both, replace, equivalent, alternative"
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

## Cross-References

- **VR modding guide**: `vr-modding.detail.instructions.md`
- **VR baseline snapshot**: `vr-baseline.detail.instructions.md`
- **Local system & installed mods**: `local-system.detail.instructions.md`
- **Nexus Mods navigation**: `nexus-mods.detail.instructions.md`
- **Plugin development**: `plugin-development.instructions.md`

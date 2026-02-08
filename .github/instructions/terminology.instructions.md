---
name: "terminology"
description: "Skyrim modding terminology and abbreviations\nKeywords: terminology, glossary, abbreviation, acronym, definition, what is, what does, meaning"
applyTo: "**"
---

# Skyrim Modding Terminology

## Edition Abbreviations

| Abbreviation | Meaning | Notes |
|-------------|---------|-------|
| **SE** | Special Edition | 64-bit remaster (2016), base for most modern mods |
| **AE** | Anniversary Edition | SE update (Nov 2021) with Creation Club content; includes runtime updates |
| **VR** | Skyrim VR | VR port based on SE 1.4.15; limited runtime updates |
| **LE** / **Oldrim** | Legendary Edition | 32-bit original; largely legacy, not a focus here |
| **GOG** | GOG version | DRM-free SE/AE; some tool differences vs Steam |

## Common Modding Terms

| Term | Definition |
|------|-----------|
| **ESP / ESM / ESL** | Plugin file formats — master, light, and standard plugins |
| **Form ID** | Unique 8-digit hex identifier for every record in a plugin |
| **Load Order** | Sequence in which plugins are loaded; determines conflict winners |
| **SKSE** | Skyrim Script Extender — extends Papyrus scripting and engine hooks |
| **xEdit** / **SSEEdit** | Community tool for viewing/editing plugin records |
| **MO2** | Mod Organizer 2 — virtual filesystem mod manager |
| **LOOT** | Load Order Optimisation Tool — automated sorting |
| **Papyrus** | Skyrim's native scripting language |
| **NIF** | NetImmerse File — 3D mesh format used by Skyrim |
| **DDS** | DirectDraw Surface — texture format |
| **BSA / BA2** | Bethesda archive formats for bundling assets |
| **BAIN** | BAsh INstaller — archive packaging standard |
| **FOMOD** | Mod installer format with XML-driven options |
| **CK** | Creation Kit — Bethesda's official modding tool |
| **Navmesh** | Navigation mesh — pathfinding data for NPCs |
| **LOD** | Level of Detail — distant object rendering system |
| **ENB** | Third-party graphics injector by Boris Vorontsov |
| **SkyUI** | Popular UI overhaul mod; provides MCM framework |
| **MCM** | Mod Configuration Menu — in-game settings via SkyUI |
| **SPID** | Spell Perk Item Distributor — keyword-based distribution framework |
| **DAR / OAR** | Dynamic Animation Replacer / Open Animation Replacer |
| **PGPatcher** | Dynamic mesh/texture patcher (Nexus 120946) — patches NIFs for parallax, CM, and PBR |
| **Parallax** | Shader technique using height maps (`_p.dds`) to add depth to flat surfaces |
| **CM** / **CPM** | Complex Material / Complex Parallax Material — advanced shader using multi-layer `_m.dds` maps for metallic/roughness effects |
| **PBR** | Physically Based Rendering — realistic lighting model; requires Community Shaders + PGPatcher |
| **ITM** | Identical To Master — unintentional duplicate record |
| **UDR** | Undeleted and Disabled Reference — a cleaning target |
| **Conflict Resolution Patch** | Plugin that resolves record-level conflicts between mods |

## Version-Specific Terms

| Term | Context |
|------|---------|
| **Address Library** | Maps runtime memory addresses across SE/AE versions for SKSE plugins |
| **downgrade patcher** | Reverts AE runtime to SE 1.5.97 for mod compatibility |
| **SKSEVR** | VR-specific SKSE build |
| **opencomposite** | Translates SteamVR calls to OpenXR for VR performance |
| **VRIK** | VR mod providing a visible player body and gesture controls |
| **HIGGS** | VR hand interaction and gravity gloves mod |
| **Planck** | VR physics-based melee combat mod |

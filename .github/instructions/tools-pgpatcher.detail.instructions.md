---
name: "tools-pgpatcher-detail"
description: "PGPatcher mesh/texture patching workflows for parallax, complex materials, and PBR\nKeywords: PGPatcher, ParallaxGen, parallax, complex material, CPM, CM, PBR, mesh patching, NIF, shader, texture, landscape, _p.dds, _m.dds, Community Shaders, pre-patched"
---

# PGPatcher (ParallaxGen) — Mesh & Texture Patching

> **Nexus**: [120946](https://www.nexusmods.com/skyrimspecialedition/mods/120946)
> **GitHub**: [hakasapl/PGPatcher](https://github.com/hakasapl/PGPatcher)
> **Current AE Baseline**: v0.9.9

## What PGPatcher Does

PGPatcher dynamically patches NIF mesh files to set the correct **shader flags** so Skyrim's renderer (via Community Shaders or ENB) uses advanced texture features. It operates on three shader types:

| Shader Type | Texture Suffix | What It Does | PGPatcher Role |
|-------------|---------------|--------------|----------------|
| **Parallax** | `_p.dds` (height map) | Adds depth/displacement to flat surfaces | Sets parallax shader flag on NIFs that have matching `_p.dds` |
| **Complex Material (CM/CPM)** | `_m.dds` (multi-layer map) | Metallic, roughness, AO, subsurface — richer material rendering | Sets complex material shader flag on NIFs with matching `_m.dds` |
| **PBR** | Various PBR maps | Physically based rendering — full realistic lighting model | **Required** — PBR textures cannot work without PGPatcher |

### How It Works

1. Scans your load order's Data folder for texture files (`_p.dds`, `_m.dds`, PBR maps)
2. Identifies which NIF meshes reference those textures
3. Patches the NIF shader flags to enable the appropriate rendering mode
4. Outputs patched meshes that override the originals (like a Synthesis patcher for meshes)
5. **Also removes** stale shader flags from meshes that were pre-patched for textures you don't have

## When Do You Need PGPatcher?

| Scenario | PGPatcher Required? | Why |
|----------|---------------------|-----|
| Mod ships **PBR textures** | **Yes — mandatory** | Game engine has no native PBR; mesh flags must be patched |
| Mod ships **CM/CPM textures only** (no pre-patched NIFs) | **Yes — required** | Meshes need CM shader flag set to use `_m.dds` maps |
| Mod ships **CM textures + pre-patched NIFs** | **No, but recommended** | Pre-patched NIFs work out of the box, but PGPatcher handles conflicts better |
| Mod ships **parallax textures only** (no pre-patched NIFs) | **Yes — required** | Meshes need parallax shader flag set to use `_p.dds` maps |
| Mod ships **parallax textures + pre-patched NIFs** | **No, but recommended** | Same as CM — pre-patched works, but PGPatcher resolves load order conflicts |
| Mod ships **only diffuse/normal textures** (no `_p`/`_m`/PBR) | **No** | Nothing to patch — standard rendering |

### The "Pre-Patched Meshes" Question

Many mod authors used to ship **pre-patched NIFs** with shader flags already set. This works but has problems:

- **Conflict risk**: If two mods edit the same mesh, only one wins — the loser's shader flags are lost
- **Stale flags**: If you remove a texture mod, pre-patched meshes may reference textures that no longer exist, causing visual glitches (purple textures, broken shaders)
- **Load order sensitivity**: Pre-patched meshes are static; they can't adapt to your actual texture winners

PGPatcher solves all of these by dynamically patching based on **what textures actually exist** in your final load order. Modern mods increasingly ship textures only and expect PGPatcher to handle the mesh patching.

**How to tell if a mod needs PGPatcher**: Check the Nexus description. Look for:
- "Requires PGPatcher" or "Requires ParallaxGen"
- "No pre-patched meshes included"
- "CPM/CM textures" or "PBR textures" without mention of included meshes

If the description says "pre-patched meshes included" or "works out of the box", PGPatcher is optional (but still recommended).

## Running PGPatcher

### When to Run

- **After** all mesh and texture mods are installed and ordered
- **Before** DynDOLOD (if generating LODs)
- **Re-run** whenever you add, remove, or reorder texture/landscape mods

### Workflow (Vortex)

1. Install all texture and mesh mods, deploy
2. Run PGPatcher from the mod manager (or standalone)
3. PGPatcher scans your Data folder and outputs patched NIFs
4. Deploy the PGPatcher output (it creates a mod-like output folder)

### Workflow (MO2)

1. Install all texture and mesh mods
2. Add PGPatcher as an executable in MO2
3. Run through MO2 so it sees the virtual filesystem
4. PGPatcher output goes into Overwrite (or a designated output mod)
5. Enable the output mod at the bottom of your mod order

## Interaction with Community Shaders

Community Shaders (Nexus 86492) is the **renderer** that actually uses the shader flags PGPatcher sets. The relationship:

- **Community Shaders** = the graphics engine that renders parallax/CM/PBR effects
- **PGPatcher** = the tool that tells meshes to *use* those effects

You need both:
- Community Shaders without PGPatcher = renderer is ready but meshes don't request the effects (unless pre-patched)
- PGPatcher without Community Shaders = meshes request effects the renderer can't provide (visual bugs)

For ENB users: ENB has its own parallax implementation, but CM and PBR still need Community Shaders features.

## Common Landscape Mod Patterns

| Mod Type | Typical Contents | PGPatcher Needed? |
|----------|-----------------|-------------------|
| Texture-only landscape overhaul with CM | `_m.dds` maps, no NIFs | Yes |
| Full landscape overhaul (meshes + textures + CM) | Pre-patched NIFs + `_m.dds` | Optional but recommended |
| PBR landscape pack | PBR texture maps | Yes — mandatory |
| Vanilla-style texture replacer | Diffuse + normal only | No |

## Troubleshooting

| Issue | Cause | Fix |
|-------|-------|-----|
| Purple/missing textures after install | Pre-patched mesh references textures from wrong mod | Run PGPatcher to re-patch based on actual load order |
| No parallax/CM visible despite textures | Mesh shader flags not set | Run PGPatcher |
| Parallax/CM on surfaces that shouldn't have it | Stale pre-patched flags from removed mod | Run PGPatcher (v0.9+ removes stale flags) |
| CTD in exterior cells | Corrupted NIF from conflicting patches | Re-run PGPatcher; check for mesh conflicts in mod manager |

## Cross-References

- **Community Shaders / ENB**: `enb.detail.instructions.md`
- **Tool selection**: `tools.instructions.md`
- **AE baseline (PGPatcher version)**: `ae-baseline.detail.instructions.md`
- **Mod conflict resolution**: `conflict-resolution.detail.instructions.md`

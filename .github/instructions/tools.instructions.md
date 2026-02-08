---
name: "tools"
description: "Skyrim modding tool workflows and best practices"
applyTo: "**"
---

# Modding Tools

## Tool Selection Matrix

| Task | Primary Tool | Alternatives |
|------|-------------|-------------|
| Mod management | MO2 | Vortex |
| Plugin editing | xEdit (SSEEdit) | Creation Kit |
| World building / quests | Creation Kit | — |
| Load order sorting | LOOT | Manual in MO2 |
| Plugin cleaning | xEdit Quick Auto Clean | — |
| Mesh editing | NifSkope, Blender + nif plugin | Outfit Studio |
| Texture work | Paint.NET, GIMP, Photoshop | — |
| Body meshes | Outfit Studio (BodySlide) | Blender |
| Animation | Havok Content Tools, Nemesis, Pandora | — |
| BSA packing | Cathedral Assets Optimizer, BSArch | — |
| Installer creation | FOMOD Creator, manual XML | BAIN wizard |
| Conflict visualization | xEdit, MO2 conflict tab | Wrye Bash |
| Script compilation | Creation Kit, Champollion (decompile) | Caprica (compiler) |
| LOD generation | xLODGen, DynDOLOD | TexGen |
| Mesh/texture patching | PGPatcher (120946) | Manual NIF editing |
| Downgrading AE → SE | Best of Both Worlds, Downgrade Patcher | — |
| Graphics injection | Community Shaders (86492) | ENB (enbdev.com), ReShade |

## MO2 Essentials

- Always use MO2's virtual filesystem — never install mods directly into the Data folder
- Use **profiles** to maintain separate setups (e.g., VR vs SE playthroughs)
- Check the **Conflicts** tab to identify file-level overwrites
- Use **separators** to organize mods by category

## xEdit Quick Rules

1. Never edit master files (Skyrim.esm, Update.esm, etc.) unless you know exactly what you're doing
2. Always make a **conflict resolution patch** rather than editing existing plugins
3. Use Quick Auto Clean on plugins before including them in a load order
4. Use the **Compare Selected** function to resolve multi-mod conflicts

## PGPatcher Quick Rules

1. PGPatcher (aka ParallaxGen) dynamically patches NIF meshes to enable **parallax**, **complex material (CM)**, and **PBR** shader flags based on textures in your load order
2. Run it **after all texture/mesh mods are installed** — it acts like Synthesis for meshes
3. Mods with **pre-patched meshes** work without PGPatcher, but PGPatcher is preferred because it resolves conflicts dynamically
4. PGPatcher also **removes** stale parallax/CM flags from meshes where no matching texture exists
5. **Required** for PBR texture mods; **recommended** for CM/parallax mods; **optional** if a mod ships pre-patched NIFs
6. Re-run PGPatcher whenever you add/remove texture or landscape mods

## Cross-References

- **Detailed MO2 workflows**: `tools-mo2.detail.instructions.md`
- **xEdit deep reference**: `tools-xedit.detail.instructions.md`
- **Creation Kit guide**: `tools-ck.detail.instructions.md`
- **ENB installation & config**: `enb.detail.instructions.md`
- **PGPatcher / mesh patching**: `tools-pgpatcher.detail.instructions.md`

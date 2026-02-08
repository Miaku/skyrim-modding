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
| Downgrading AE → SE | Best of Both Worlds, Downgrade Patcher | — |

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

## Cross-References

- **Detailed MO2 workflows**: `tools-mo2.detail.instructions.md`
- **xEdit deep reference**: `tools-xedit.detail.instructions.md`
- **Creation Kit guide**: `tools-ck.detail.instructions.md`

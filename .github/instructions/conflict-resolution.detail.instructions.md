---
name: "conflict-resolution-detail"
description: "Strategies for resolving mod conflicts in Skyrim load orders\nKeywords: conflict, resolution, patch, compatibility, load order, overwrite, override, leveled list, merge, bashed patch, smashed patch, synthesis, zEdit, forward"
---

# Conflict Resolution Strategies

## Types of Conflicts

### File-Level Conflicts (MO2 Left Pane)
- Two mods provide the same file (mesh, texture, script)
- Resolved by **mod priority order** — last wins
- Mostly harmless for textures/meshes (aesthetic choice)
- **Critical** for scripts — wrong version can break functionality

### Record-Level Conflicts (Plugin Load Order)
- Two plugins modify the same record (NPC, cell, leveled list, etc.)
- Resolved by **load order** — last plugin wins entirely for that record
- Often requires a **conflict resolution patch** to merge changes

## Conflict Detection

### In MO2
1. Check **Conflicts** tab on each mod (double-click mod)
2. Look for lightning bolt icons in mod list
3. Red/green indicators show winning/losing files

### In xEdit
1. Load full load order
2. Apply filter: **Show Conflicts**
3. Color coding:
   - **Red background**: conflicting values between overrides
   - **Yellow**: override differs from master
   - **Green**: no conflict (identical or single override)

## Resolution Methods

### Manual Patch (xEdit)
**Best for**: Complex conflicts, NPC edits, quest changes
1. Identify conflicting records in xEdit
2. Create new ESP
3. Copy winning record as override into patch
4. Forward desired values from each mod
5. Repeat for all conflicts

### Bashed Patch (Wrye Bash)
**Best for**: Leveled lists, outfit/inventory merges
- Automatically merges leveled list additions from multiple mods
- Handles race, NPC stat, and name tweaks
- Should be near end of load order
- Limited to specific record types it knows how to merge

### Smashed Patch (Mator Smash)
**Best for**: Broad automated conflict resolution
- More aggressive merging than Bashed Patch
- Handles more record types (keywords, factions, perks, etc.)
- Uses **smash settings** to control merge behavior per record type
- Can replace Bashed Patch in many cases

### Synthesis (Patcher Framework)
**Best for**: Rule-based, repeatable patching
- C# patcher framework — runs code to generate patches
- Community patchers available (e.g., SPID generation, keyword distribution)
- Deterministic and version-controllable
- Can target specific mod combinations programmatically

## Leveled List Merging

Leveled lists (items, NPCs, spells) are the most common conflict:

| Scenario | Problem | Solution |
|----------|---------|----------|
| Two mods add items to same list | Only last mod's entries appear | Bashed/Smashed Patch |
| Mod replaces entire list | Other mod's additions lost | Manual patch or Smash |
| Mod removes items from list | Bashed Patch may re-add them | Manual patch with intent |

## Conflict Priority Guidelines

| Conflict Type | Urgency | Resolution |
|---------------|---------|-----------|
| Leveled lists | High — content silently lost | Bashed/Smashed Patch |
| NPC appearance | Medium — visual glitch | Manual patch or let one win |
| NPC AI/behavior | High — can break quests | Manual patch in xEdit |
| Cell/worldspace | High — navmesh/visual issues | Manual patch, careful testing |
| Keywords/factions | Medium — can affect gameplay | Smashed Patch or manual |
| GMST (game settings) | Low — usually intentional | Let preferred mod win |

## Edition-Specific Notes

### AE Conflicts
- AE Creation Club content adds masters some mods may conflict with
- `ccBGSSSE001-Fish.esm` and similar files may conflict with water/food mods
- Downgrading to SE 1.5.97 can avoid these but limits available mods

### VR Conflicts
- VR mods may provide VR-specific overrides that must win over SE versions
- Controller-related records don't exist in SE — no conflict, but verify presence
- Some UI records need VR-specific patches (SkyUI VR vs regular SkyUI)

---
name: "tools-ck-detail"
description: "Creation Kit guide for Skyrim world building and quest design\nKeywords: Creation Kit, CK, render window, cell, worldspace, quest, dialogue, NPC, navmesh, landscape, reference, marker, enable parent, condition, quest stage, scene, package, AI"
---

# Creation Kit Guide

## Setup

### SE/AE Creation Kit
- Install via Steam (free) or Bethesda.net launcher
- Requires `CreationKit.ini` tweaks for multi-master loading:
```ini
[General]
bAllowMultipleMasterLoads=1
bAllowMultipleMasterFiles=1

[Archive]
SResourceArchiveList2=Skyrim - Voices_en0.bsa, Skyrim - Textures0.bsa, Skyrim - Textures1.bsa, ...
```

### VR Note
There is no VR-specific Creation Kit. Use the SE/AE CK and test in VR.

## Core Concepts

### Object Window Hierarchy
```
Object Window
├── Actors
│   ├── Actor (NPC records)
│   └── TalkingActivator
├── Items
│   ├── Armor, Weapon, Ammo, Potion, etc.
│   └── LeveledItem
├── World Objects
│   ├── Static, MovableStatic, Activator
│   └── Container, Door, Light
├── Character
│   ├── Quest, Package, Perk
│   └── Faction, Race, Class
└── Miscellaneous
    ├── FormList, Keyword, Global
    └── SoundDescriptor, MusicType
```

## Quest Design

### Quest Structure
```
Quest
├── Quest Stages (numbered: 10, 20, 30...)
│   └── Log Entries (player journal text)
├── Quest Objectives (numbered: 10, 20...)
│   └── Objective Targets (markers)
├── Quest Aliases
│   ├── Reference Aliases (NPCs, objects)
│   └── Location Aliases
├── Scenes (NPC dialogue sequences)
└── Quest Fragments (Papyrus)
```

### Stage Numbering Convention
- **10, 20, 30...** — Main progression stages (leave gaps for insertion)
- **100+** — Completion / cleanup stages
- **200+** — Failure states
- Use `SetStage(questname, stageNumber)` in console to test

### Dialogue
1. Create a **Quest** with dialogue branch
2. Add **Topic** entries under the branch
3. Each topic has **Info** records with:
   - Response text
   - Voice audio file
   - Conditions (who can say this, when)
   - Script fragments (what happens when said)
4. Use **Scenes** for NPC-to-NPC dialogue

## NPC Creation

### Essential Records
| Record | Purpose |
|--------|---------|
| Actor (NPC_) | The NPC record itself |
| Race | Determines appearance model, abilities |
| Class | Skill weights for leveling |
| Faction | Relationships, vendor status |
| AI Package | Daily schedule, combat behavior |
| Outfit | Default equipment |
| Voice Type | Determines available dialogue |

### AI Packages (Priority Order)
1. **Combat** — How they fight
2. **Dialogue** — Conversation parameters
3. **Travel** — Patrol / sandbox schedules
4. **Eat / Sleep** — Needs-based activities

## Navmesh

### Rules
- Every walkable surface in an interior cell needs navmesh
- Exterior navmesh must connect between cells at borders
- Use **Find Cover Edges** after completing navmesh
- Preferred triangles should be ~256 units on a side
- Mark water triangles with the Water flag
- Door triangles need the **Door** marker linked

### Common Issues
| Issue | Fix |
|-------|-----|
| NPCs can't pathfind | Missing navmesh in area |
| NPCs walk through walls | Navmesh extends outside cell bounds |
| NPCs stuck at doors | Door triangle not linked to door ref |
| NPCs fall through floor | Navmesh too far below/above floor geometry |

## Worldspace and Cells

### Interior Cells
- Fully enclosed, independent navmesh
- Linked to exterior via **door markers**
- Lighting is fully controlled (no sun)

### Exterior Cells
- Part of a **Worldspace** (e.g., Tamriel)
- 4096×4096 unit grid cells
- Share navmesh borders with adjacent cells
- LOD generated separately

## Packaging CK Work

1. Save your plugin in CK → produces `.esp` in Data folder
2. Package loose assets (meshes, textures, scripts, sounds)
3. Optionally pack into BSA using BSArch or Cathedral Assets Optimizer
4. Create FOMOD installer for user-facing options

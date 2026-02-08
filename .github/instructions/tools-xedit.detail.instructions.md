---
name: "tools-xedit-detail"
description: "xEdit (SSEEdit) deep reference for plugin analysis and conflict resolution\nKeywords: xEdit, SSEEdit, TES5Edit, FO4Edit, plugin, record, conflict, patch, cleaning, ITM, UDR, FormID, master, override, filter, compare, forward"
---

# xEdit Deep Reference

## Launching xEdit

| Edition | Executable | Notes |
|---------|-----------|-------|
| SE | SSEEdit.exe | Also called xEdit when renamed |
| AE | SSEEdit.exe (same) | Works with AE plugins |
| VR | SSEEdit.exe with `-vrmode` | Or rename to `SkyrimVREdit.exe` |

### Useful Command-Line Flags

```
-quickautoclean         Auto-clean a plugin (ITM + UDR removal)
-autoload               Load all plugins immediately
-vrmode                 Enable VR mode (VR data path)
-D:"path\to\data"       Override Data directory
-I:"path\to\ini"        Override INI path
```

## Record Structure

Every Skyrim record follows this hierarchy:
```
Plugin.esp
└── Group (GRUP)
    └── Record (e.g., NPC_, WEAP, ARMO)
        └── Subrecord (e.g., FULL - Name, DATA - Stats)
```

## Conflict Resolution Workflow

### Step 1: Identify Conflicts
1. Load all plugins in xEdit
2. Right-click → **Apply Filter to show Conflicts**
3. Records with red/yellow backgrounds have conflicts

### Step 2: Analyze
- **Green**: No conflict (single override or identical)
- **Yellow**: Override exists but values differ
- **Red**: Critical conflict — multiple mods change the same subrecord

### Step 3: Resolve
1. Create a new ESP: right-click in left pane → "Add new file"
2. For each conflicting record:
   - Right-click winning record → **Copy as override into** → your patch
   - Forward desired values from each contributing mod
3. Save your patch

### Forwarding Records
"Forwarding" means copying a specific subrecord value from one plugin's version of a record into your patch. Example:
- Mod A changes NPC armor
- Mod B changes NPC AI
- Your patch forwards BOTH changes into one record

## Cleaning Plugins

### Quick Auto Clean
1. Close xEdit if open
2. Run: `SSEEdit.exe -quickautoclean "MyPlugin.esp"`
3. This removes:
   - **ITM** (Identical To Master) — accidental duplicate records
   - **UDR** (Undeleted and Disabled References) — broken deleted refs

### Manual Cleaning
1. Load plugin + masters only
2. Right-click plugin → **Remove "Identical to Master" records**
3. Right-click plugin → **Undelete and Disable References**
4. Check results, save

### Plugins to NEVER Clean
- Skyrim.esm
- Update.esm
- Dawnguard.esm / HearthFires.esm / Dragonborn.esm
- Unofficial Skyrim Special Edition Patch.esp

## Useful xEdit Scripts

| Script | Purpose |
|--------|---------|
| `Apply Filter to show Conflicts` | Highlights all conflicting records |
| `Report Masters` | Lists all masters a plugin depends on |
| `Check for Errors` | Validates record structure |
| `Export stats to CSV` | Extracts weapon/armor stats to spreadsheet |
| `Dump LOOT masterlist` | Exports load order metadata |

## Batch Operations

### Copy Multiple Records
1. Select records in right pane (Ctrl+Click)
2. Right-click → **Copy as override into** → target plugin
3. All selected records are copied at once

### Find and Replace
1. Apply a filter first to narrow scope
2. Right-click column header → **Find and Replace**
3. Operates on the visible (filtered) records only

## FormID Reference

| Component | Example | Meaning |
|-----------|---------|---------|
| Load order prefix | `01` | Second plugin in load order |
| Record ID | `01AB1234` | Full FormID with load order |
| Local FormID | `000ABC` | ID within the plugin (light plugins: 0x800-0xFFF) |

When a plugin is ESL-flagged:
- FormIDs use range `FExxx800` - `FExxxFFF` in memory
- `xxx` = light plugin index (0-4095)

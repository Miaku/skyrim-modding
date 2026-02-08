---
name: "tools-mo2-detail"
description: "Mod Organizer 2 advanced workflows and configuration\nKeywords: MO2, Mod Organizer, virtual filesystem, profile, USVFS, overwrite, priority, separator, download, install, conflict, mod order, left pane, right pane"
---

# Mod Organizer 2 Advanced Workflows

## MO2 Architecture

MO2 uses a **virtual filesystem (USVFS)** to overlay mod files onto the Data directory without modifying it. This means:
- Each mod lives in its own folder under `MO2/mods/`
- File conflicts are resolved by **mod priority** (left pane order)
- The actual Data folder stays clean
- Different **profiles** can have entirely different mod/plugin configurations

## Profile Management

### When to Use Profiles
- **VR vs Flat**: Separate VR and SE/AE setups
- **Testing**: Isolate experimental mod combinations
- **Playthroughs**: Different character builds with different mods

### Profile Settings
Each profile stores independently:
- Enabled/disabled mods (left pane)
- Plugin load order (right pane)
- INI files (if "Use profile-specific INI" is checked)
- Save games (if "Use profile-specific saves" is checked)

## Conflict Resolution in MO2

### Left Pane (Mod Order / File Conflicts)
- Lower priority number = loaded first = loses conflicts
- Higher priority number = loaded later = wins conflicts
- **Lightning bolt icon**: mod has file conflicts
- **Green +**: mod is winning all its conflicts
- **Red -**: mod is losing some conflicts
- Double-click mod → **Conflicts** tab to see winners/losers

### Right Pane (Plugin Load Order)
- Controls record-level conflicts (ESP/ESM)
- LOOT can auto-sort this
- Manual adjustments for patches that must load after specific plugins

## Essential MO2 Features

### Overwrite Folder
- Located at bottom of mod list
- Catches all files generated at runtime (SKSE logs, BodySlide output, etc.)
- **Best practice**: Regularly move Overwrite contents into named mods
- Right-click Overwrite → "Create Mod" to package its contents

### Executables Configuration
All tools must be launched through MO2 to see the virtual filesystem:
- xEdit, LOOT, FNIS/Nemesis, BodySlide, Creation Kit
- Add via: Tools → Executables → Add

### BSA Handling
- MO2 extracts BSA-packed mods to loose files automatically (if configured)
- Loose files always override BSA files at the same priority
- Enable "Manage Archives" in profile settings for fine control

## MO2 for VR

### Setup
1. Create a new MO2 instance pointed at `Skyrim VR/` install directory
2. Or use a single MO2 instance with separate profiles (advanced)
3. Set executable: `SkyrimVR.exe` (and `sksevr_loader.exe` for SKSE)
4. INI path: `Documents/My Games/Skyrim VR/`

### VR-Specific Considerations
- Some mods need different files for VR — use MO2's "Mod-specific data" feature
- SKSEVR DLLs go in `Data/SKSE/Plugins/` as usual
- opencomposite DLL goes in the game root, not Data

## Troubleshooting MO2

| Problem | Cause | Fix |
|---------|-------|-----|
| Mods don't appear in-game | Tool not launched via MO2 | Always launch game through MO2 |
| "Failed to start" error | Antivirus blocking USVFS | Add MO2 folder to exclusions |
| Overwrite keeps filling up | Generated files not organized | Create mods from Overwrite contents |
| Plugin count exceeds 254 | Too many full ESPs | ESL-flag eligible plugins |
| Can't see VR plugins | Wrong instance/profile | Verify MO2 instance points to VR directory |

---
name: "plugin-development"
description: "Skyrim plugin development standards for ESP, ESM, ESL files"
applyTo: "**"
---

# Plugin Development Standards

## Plugin Types

| Type | Extension | Max Records | Use Case |
|------|-----------|-------------|----------|
| Master | .esm | 2,048 Form IDs per block | Large frameworks, dependencies |
| Standard | .esp | Full Form ID range | General mods |
| Light | .esl / .esp+ESL flag | 2,048 (0x800-0xFFF) | Small patches, tweaks |

## Plugin Best Practices

1. **Use ESL-flagged ESPs** whenever possible to save plugin slots (limit: 254 full plugins)
2. **Compact Form IDs** before ESL-flagging — IDs must fit in the 0x800-0xFFF range
3. **Never delete references** — disable them instead (set Initially Disabled flag) to prevent UDR issues
4. **Forward UPF/USSEP fixes** — always use Unofficial Patch records as your base
5. **Document masters** — every required master must be clearly stated

## Record Conflict Rules

- Last plugin in load order wins for any given record
- Use xEdit to identify conflicts and build resolution patches
- **Rule of One**: Only one plugin can "own" a record at runtime
- Group-level overrides (CELL, WRLD) require extra caution

## Edition Compatibility

| Feature | SE (1.5.97) | AE (1.6.x) | VR (1.4.15) |
|---------|-------------|-------------|-------------|
| ESL support | Yes | Yes | Yes (with caveats) |
| .esl extension | Yes | Yes | Partial — prefer ESP+flag |
| Creation Club content | No (unless backported) | Included | No |
| Max plugin slots | 254 + 4096 light | 254 + 4096 light | 254 + 4096 light |

## Naming Conventions

- Plugin names: `ModName - Description.esp` (use hyphens, not underscores)
- Patches: `ModName - PatchTarget Patch.esp`
- Translations: `ModName_LANG.txt`

## Cross-References

- **Scripting standards**: `scripting.instructions.md`
- **xEdit workflows**: `tools-xedit.detail.instructions.md`
- **FOMOD packaging**: `packaging.detail.instructions.md`

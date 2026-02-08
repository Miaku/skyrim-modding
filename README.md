# Skyrim Modding Copilot Brain

A GitHub Copilot Brain — a collection of instruction files that customize Copilot's behavior for Skyrim modding across **VR**, **AE** (Anniversary Edition), and **SE** (Special Edition).

## What is a Copilot Brain?

A Copilot Brain uses instruction files to give GitHub Copilot persistent knowledge about your modding workflows, tool conventions, and edition-specific quirks. It follows a **two-tier strategy**:

| Strategy | When Loaded | Use Case |
|----------|-------------|----------|
| **Always-On** | Every session | Core identity, tool selection, key terminology |
| **Lazy-Load** | When keywords match | Deep references, troubleshooting, advanced workflows |

## Structure

```
.github/
├── copilot-instructions.md                        # Entry point (always-on)
└── instructions/
    ├── terminology.instructions.md                # Modding glossary (always-on)
    ├── tools.instructions.md                      # Tool selection matrix (always-on)
    ├── plugin-development.instructions.md         # ESP/ESM/ESL standards (always-on)
    ├── scripting.instructions.md                  # Papyrus & SKSE guidelines (always-on)
    ├── brain-meta.detail.instructions.md          # Brain maintenance guide (lazy-load)
    ├── vr-modding.detail.instructions.md          # VR-specific modding (lazy-load)
    ├── skse-development.detail.instructions.md    # SKSE C++ plugins (lazy-load)
    ├── papyrus.detail.instructions.md             # Papyrus patterns (lazy-load)
    ├── tools-xedit.detail.instructions.md         # xEdit deep reference (lazy-load)
    ├── tools-mo2.detail.instructions.md           # MO2 advanced workflows (lazy-load)
    ├── tools-ck.detail.instructions.md            # Creation Kit guide (lazy-load)
    ├── packaging.detail.instructions.md           # FOMOD/BAIN packaging (lazy-load)
    └── conflict-resolution.detail.instructions.md # Conflict resolution (lazy-load)
```

## How It Works

1. **Always-on files** (with `applyTo: "**"`) load in every Copilot session
2. **Detail files** load only when you mention keywords from their description
3. Cross-references connect always-on files to their detail files

## Coverage

| Domain | Always-On | Detail Files |
|--------|-----------|-------------|
| Terminology & glossary | `terminology` | — |
| Tools (MO2, xEdit, CK) | `tools` | `tools-mo2`, `tools-xedit`, `tools-ck` |
| Plugin development | `plugin-development` | `packaging`, `conflict-resolution` |
| Scripting | `scripting` | `papyrus`, `skse-development` |
| VR modding | — | `vr-modding` |
| Brain maintenance | — | `brain-meta` |

## File Naming Convention

| Type | Pattern | Example |
|------|---------|---------|
| Always-On | `topic.instructions.md` | `tools.instructions.md` |
| Lazy-Load | `topic.detail.instructions.md` | `vr-modding.detail.instructions.md` |

## Adding New Instructions

1. Decide: always-on (essential every session) or lazy-load (reference material)
2. Create file with proper naming convention in `.github/instructions/`
3. Add YAML frontmatter:

```yaml
---
name: "unique-name"
description: "Brief description\nKeywords: keyword1, keyword2"
applyTo: "**"  # Only for always-on files
---
```

4. Add cross-reference in parent always-on file if creating a detail file

## Size Guidelines

- **Always-on files**: ~80-120 lines (~1,000 tokens)
- **Detail files**: No limit — be comprehensive

## Publishing Globally

To apply this brain to all VS Code workspaces (not just this repo):

```powershell
.\publish-brain.ps1        # Interactive
.\publish-brain.ps1 -Force # Overwrite without prompting
```

## Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [VS Code Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization)
- [Nexus Mods - Skyrim SE](https://www.nexusmods.com/skyrimspecialedition)
- [Nexus Mods - Skyrim VR](https://www.nexusmods.com/skyrimspecialedition/?gsearch=vr)
- [UESP Wiki - Modding](https://en.uesp.net/wiki/Skyrim_Mod:Modding)
- [Creation Kit Wiki](https://www.creationkit.com/)

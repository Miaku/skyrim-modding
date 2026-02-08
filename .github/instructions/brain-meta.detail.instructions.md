---
name: "brain-meta-detail"
description: "Guide for maintaining and extending this Copilot Brain\nKeywords: brain, instruction, meta, update brain, add instruction, modify brain, copilot brain, maintain"
---

# Brain Maintenance Guide

## When to Update the Brain

| Trigger | Action |
|---------|--------|
| New modding tool discovered | Add to `tools.instructions.md` or create detail file |
| Edition-specific behavior confirmed | Update relevant always-on file |
| New workflow pattern established | Create or update instruction file |
| Terminology confusion encountered | Add to `terminology.instructions.md` |
| Brain file exceeds ~120 lines | Split into always-on + detail pair |

## Creating a New Instruction File

### Always-On File Template

```yaml
---
name: "topic-name"
description: "Brief description of what this file covers"
applyTo: "**"
---
```

- Keep under ~120 lines
- Use tables for quick reference
- End with `## Cross-References` linking to detail files

### Detail File Template

```yaml
---
name: "topic-name-detail"
description: "Expanded reference for topic\nKeywords: keyword1, keyword2, keyword3"
---
```

- No line limit — be comprehensive
- Include code examples, troubleshooting, deep dives
- Keywords must match terms users would naturally say

## File Naming Rules

| Type | Pattern | Example |
|------|---------|---------|
| Always-On | `topic.instructions.md` | `tools.instructions.md` |
| Lazy-Load | `topic.detail.instructions.md` | `tools-xedit.detail.instructions.md` |

## Size Guidelines

- **Always-on**: ~80-120 lines (~1,000 tokens) — loaded every session
- **Detail files**: No hard limit, but consider splitting at 300+ lines
- **Total always-on budget**: Keep combined always-on files under ~500 lines

## Current Brain Inventory

### Always-On Files
- `terminology.instructions.md` — Glossary and abbreviations
- `tools.instructions.md` — Tool selection and quick rules
- `plugin-development.instructions.md` — ESP/ESM/ESL standards
- `scripting.instructions.md` — Papyrus and SKSE guidelines

### Detail Files
- `brain-meta.detail.instructions.md` — This file (brain maintenance)
- `vr-modding.detail.instructions.md` — VR-specific modding guide
- `skse-development.detail.instructions.md` — SKSE C++ plugin development
- `papyrus.detail.instructions.md` — Papyrus scripting patterns
- `tools-xedit.detail.instructions.md` — xEdit deep reference
- `tools-mo2.detail.instructions.md` — MO2 advanced workflows
- `tools-ck.detail.instructions.md` — Creation Kit guide
- `packaging.detail.instructions.md` — FOMOD/BAIN packaging
- `conflict-resolution.detail.instructions.md` — Conflict resolution strategies

## Quality Checklist

Before committing a brain file:
- [ ] YAML frontmatter is valid (name, description, applyTo if always-on)
- [ ] Keywords in description match natural user queries (detail files)
- [ ] Tables are properly formatted
- [ ] Cross-references point to real files
- [ ] File is in `.github/instructions/` directory
- [ ] Always-on file is under ~120 lines

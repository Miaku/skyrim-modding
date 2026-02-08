---
name: "scripting"
description: "Papyrus scripting and SKSE plugin standards for Skyrim"
applyTo: "**"
---

# Scripting Standards

## Papyrus Guidelines

- **Always use properties** over hard-coded Form IDs — keeps scripts portable
- **Avoid polling** (OnUpdate with short intervals) — use events and magic effects instead
- **Latent functions** (Wait, utility calls) can only run on one thread per script instance
- **RegisterForSingleUpdate** is preferred over RegisterForUpdate for one-shot timers
- **Limit array sizes** — Papyrus arrays cap at 128 elements (use SKSE for larger)

## Script Structure Template

```papyrus
ScriptName MyMod_ScriptName extends ObjectReference
{Brief description of what this script does.}

; --- Properties ---
GlobalVariable Property MyMod_Setting Auto
Keyword Property MyMod_Keyword Auto

; --- Events ---
Event OnInit()
    ; Initialization logic
EndEvent

Event OnActivate(ObjectReference akActionRef)
    ; Activation logic
EndEvent
```

## SKSE Plugin Guidance

| Topic | Recommendation |
|-------|---------------|
| Language | C++ (CommonLibSSE / CommonLibVR) |
| Build system | CMake + vcpkg |
| Address resolution | Use Address Library for cross-version support |
| VR compat | Use CommonLibVR fork or unified CommonLib with VR markers |
| Logging | Use spdlog via CommonLib's logger |
| Config | Use `.ini` or `.toml` parsed at plugin load |

## Edition Differences

| Feature | SE | AE | VR |
|---------|----|----|-----|
| SKSE version | 2.0.x (runtime 1.5.97) | 2.1.x+ (runtime 1.6.x) | SKSEVR (runtime 1.4.15) |
| CommonLib | CommonLibSSE | CommonLibSSE-NG | CommonLibVR |
| Address Library | v1 (all-in-one) | v2 (per-version) | VR Address Library |
| API stability | Stable (frozen) | Updating with patches | Stable (frozen) |

## Cross-References

- **Plugin file standards**: `plugin-development.instructions.md`
- **C++ SKSE deep dive**: `skse-development.detail.instructions.md`
- **Papyrus patterns**: `papyrus.detail.instructions.md`

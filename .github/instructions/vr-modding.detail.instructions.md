---
name: "vr-modding-detail"
description: "Skyrim VR-specific modding guide and compatibility notes\nKeywords: VR, Skyrim VR, SKSEVR, virtual reality, VR mod, VRIK, HIGGS, opencomposite, VR compatibility, VR performance, VR controller, VR headset, roomscale"
---

# Skyrim VR Modding Guide

## VR Runtime Overview

Skyrim VR is based on **SE runtime 1.4.15** — an older SE build. This means:
- Many SE mods work in VR, but not all
- SKSE plugins must be compiled against SKSEVR / CommonLibVR
- Address Library mappings differ from SE/AE
- No official Creation Club content support

## Essential VR Frameworks

| Mod | Purpose | Notes |
|-----|---------|-------|
| SKSEVR | Script extender for VR | Required for most script-heavy mods |
| VR Address Library | Address mappings for VR runtime | Equivalent of Address Library for SE |
| SkyUI VR | UI framework + MCM | Forked from SkyUI for VR |
| VRIK | Visible player body, gestures, holsters | Core VR experience mod |
| HIGGS | Hand interaction, gravity gloves, physics grabbing | Transforms object interaction |
| Planck | Physics-based melee combat | Weapon collision with NPCs |
| Be Seated | Sitting/sleeping interactions for VR | Uses VRIK's gesture system |
| Spell Wheel VR | Radial menu for spells/items | Alternative to favorites menu |

## VR Compatibility Tiers

| Tier | Description | Examples |
|------|-------------|---------|
| **Native VR** | Built specifically for VR | VRIK, HIGGS, Planck |
| **Works as-is** | SE mods that just work in VR | Most texture/mesh replacers, many ESPs |
| **Needs patching** | Requires minor edits or VR-specific patch | Some UI mods, some SKSE plugins |
| **Incompatible** | Cannot work in VR without major rework | SE SKSE DLLs, mods using AE-only features |

## Porting SE Mods to VR

### Texture / Mesh Mods
- Almost always work directly — just install as-is
- Ensure meshes don't use features unavailable in VR (rare)

### ESP/ESM Plugins
- Generally work directly if they don't require SKSE plugins
- Check for Creation Club master dependencies (not available in VR)

### SKSE Plugins (DLLs)
1. Source code must be recompiled against CommonLibVR
2. Address offsets differ — must use VR Address Library
3. Some SKSE APIs are unavailable or behave differently in VR
4. Test thoroughly — VR has unique memory layout quirks

### Papyrus Scripts
- Work identically to SE in most cases
- UI-related scripts may need VR-aware alternatives
- Input detection differs (VR controllers vs keyboard/gamepad)

## VR-Specific INI Settings

```ini
[VR]
fMeleeHideCrosshairDistance=0.0
bUseFurCrosshair=0
fActivatePickLength=250.0

[VRUI]
fHUDCompassScale=0.5
fStatusMenuScaleX=0.5
fStatusMenuScaleY=0.5

[VRInput]
fBowHoldOffsetY=8.0
fDirectMovementMaxMovementSpeedThreshold=0.25
```

## Performance Optimization

### VR-Specific Concerns
- VR renders two viewports — roughly double the GPU cost of flat SE
- Target 90 FPS minimum (headset-dependent: 80-120 Hz)
- **opencomposite** bypasses SteamVR overhead for OpenXR headsets
- Reprojection/ASW is acceptable as fallback but not ideal

### Recommended INI Tweaks for Performance

| Setting | Location | Recommended |
|---------|----------|-------------|
| `bDynamicResolution` | SkyrimVR.ini [Display] | 0 (disable, use OpenXR toolkit instead) |
| `iShadowMapResolution` | SkyrimPrefs.ini [Display] | 2048 (down from 4096) |
| `fLODFadeOutMultObjects` | SkyrimPrefs.ini [LOD] | 8.0 (reduce from 15) |
| `bTreesReceiveShadows` | SkyrimPrefs.ini [Trees] | 0 |

### LOD in VR
- DynDOLOD works in VR — use the VR-specific output option
- xLODGen terrain LOD works identically to SE
- TexGen textures are compatible as-is

## VR Controller Mapping

| VR Action | Default Binding | Notes |
|-----------|----------------|-------|
| Activate | Trigger | HIGGS overrides this for grabbing |
| Menu | B/Y button | |
| Shout/Power | Grip + trigger | VRIK can remap this to gestures |
| Sprint | Stick click | |
| Favorites | Long press B/Y | Spell Wheel VR replaces this |

## Troubleshooting VR Issues

| Problem | Likely Cause | Fix |
|---------|-------------|-----|
| Crash at logo | SKSE DLL compiled for SE, not VR | Use SKSEVR-compatible version |
| Black screen on load | ENB incompatibility | Use VR-compatible ENB preset or disable |
| Controllers not tracked | SteamVR/OpenXR conflict | Use opencomposite for OpenXR headsets |
| Menus not visible | UI mod not VR-aware | Use VR-specific UI mods (SkyUI VR) |
| Low FPS | Double-render overhead | Follow performance optimization section |
| Hands clip through objects | Missing HIGGS or collision patch | Install HIGGS + collision mods |

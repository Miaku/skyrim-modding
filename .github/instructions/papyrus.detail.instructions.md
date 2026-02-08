---
name: "papyrus-detail"
description: "Papyrus scripting patterns, best practices, and troubleshooting\nKeywords: Papyrus, script, scripting, psc, pex, compile, event, function, property, condition, quest, magic effect, alias, fragment"
---

# Papyrus Scripting Reference

## Script Types and Inheritance

| Base Type | Use Case | Common Events |
|-----------|----------|---------------|
| `ObjectReference` | Placed objects, activators, containers | OnActivate, OnLoad, OnCellAttach |
| `Actor` | NPCs, creatures, the player | OnDeath, OnHit, OnCombatStateChanged |
| `Quest` | Quest logic, persistent systems | OnInit, OnStageSet |
| `ActiveMagicEffect` | Spell/enchantment effects | OnEffectStart, OnEffectFinish |
| `ReferenceAlias` | Quest-assigned references | OnInit, OnLoad, OnDeath |
| `MagicEffect` | Magic effect definitions | OnEffectStart, OnEffectFinish |
| `Perk` | Perk entry points | (Entry point functions) |

## Common Patterns

### Delayed Initialization
```papyrus
Event OnInit()
    RegisterForSingleUpdate(0.5)  ; Let game finish loading
EndEvent

Event OnUpdate()
    ; Safe to initialize here
    InitializeMyMod()
EndEvent
```

### Safe Actor Processing
```papyrus
Function ProcessActor(Actor akTarget)
    If akTarget == None
        Return
    EndIf
    If akTarget.IsDead()
        Return
    EndIf
    If akTarget.Is3DLoaded() == false
        Return
    EndIf
    ; Safe to proceed
EndFunction
```

### Keyword-Based Distribution (Complement to SPID)
```papyrus
Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
    If akBaseObject.HasKeyword(MyMod_ArmorKeyword)
        ; Apply effect
    EndIf
EndEvent
```

### Cloak Spell Pattern (Area Scanner)
```papyrus
ScriptName MyMod_CloakEffect extends ActiveMagicEffect
{Attach to a cloak spell to scan nearby actors.}

Event OnEffectStart(Actor akTarget, Actor akCaster)
    ; akTarget is each actor hit by the cloak
    If akTarget != akCaster
        ProcessNearbyActor(akTarget)
    EndIf
EndEvent
```

### MCM Integration (SkyUI)
```papyrus
ScriptName MyMod_MCM extends SKI_ConfigBase

int Function GetVersion()
    Return 1
EndFunction

Event OnConfigInit()
    Pages = new string[2]
    Pages[0] = "General"
    Pages[1] = "Advanced"
EndEvent

Event OnPageReset(string page)
    If page == "General"
        SetCursorFillMode(TOP_TO_BOTTOM)
        AddToggleOptionST("FeatureToggle", "Enable Feature", MyMod_FeatureEnabled.GetValue())
    EndIf
EndEvent

State FeatureToggle
    Event OnSelectST()
        MyMod_FeatureEnabled.SetValue(1.0 - MyMod_FeatureEnabled.GetValue())
        SetToggleOptionValueST(MyMod_FeatureEnabled.GetValue() as bool)
    EndEvent
EndState
```

## Compilation

### Creation Kit Compiler
- Source: `Data/Scripts/Source/` (SE) or `Data/Source/Scripts/` (LE layout)
- Output: `Data/Scripts/` (.pex files)
- Flags file: `TESV_Papyrus_Flags.flg`

### Caprica (Standalone Compiler)
```bash
Caprica.exe "MyScript.psc" -i="Data/Scripts/Source" -o="Data/Scripts" -f="TESV_Papyrus_Flags.flg"
```

### Champollion (Decompiler)
```bash
Champollion.exe "MyScript.pex" -p -o="output_folder"
```

## Performance Guidelines

| Practice | Why |
|----------|-----|
| Avoid `OnUpdate` with intervals < 1.0s | Papyrus VM has limited throughput |
| Use SKSE events over polling | Native events are zero-cost until fired |
| Cache expensive lookups | `Game.GetPlayer()` is cheap, but `FindClosestActor...` is not |
| Prefer FormlList + HasForm over string comparisons | String operations are slow in Papyrus |
| Keep script count low on each reference | Each script instance adds VM overhead |
| Use `GotoState("Done")` to disable events | Cheaper than repeatedly checking booleans |

## Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| Script not running | Missing property fill | Check CK — all properties must be filled |
| Property is None at runtime | Form not in load order | Verify master dependencies |
| OnInit fires multiple times | Script attached to respawning ref | Guard with a `bInitialized` bool |
| Latent function stall | Two latent functions on same stack | Ensure sequential latent calls |
| Papyrus log spam | Infinite loop or rapid event | Check `Papyrus.0.log` for stack dumps |
| Compile error: unknown type | Missing import / source file | Add source to import path |

---
name: "packaging-detail"
description: "FOMOD and BAIN installer creation for Skyrim mod distribution\nKeywords: FOMOD, BAIN, installer, package, distribute, mod page, Nexus, archive, zip, 7z, ModuleConfig, info.xml, options, conditional, flag"
---

# Mod Packaging and Distribution

## FOMOD Installer

### Structure
```
MyMod/
├── fomod/
│   ├── info.xml              # Mod metadata
│   └── ModuleConfig.xml      # Installer wizard definition
├── 00 Core/                  # Required files
│   └── ...
├── 01 Optional Textures 2K/  # Optional files
│   └── ...
└── 02 Optional Textures 4K/
    └── ...
```

### info.xml Template
```xml
<?xml version="1.0" encoding="UTF-8"?>
<fomod>
    <Name>My Mod Name</Name>
    <Author>AuthorName</Author>
    <Version>1.0.0</Version>
    <Website>https://www.nexusmods.com/skyrimspecialedition/mods/XXXXX</Website>
    <Description>Brief mod description.</Description>
</fomod>
```

### ModuleConfig.xml Template
```xml
<?xml version="1.0" encoding="UTF-8"?>
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:noNamespaceSchemaLocation="http://qconsulting.ca/fo3/ModConfig5.0.xsd">

    <moduleName>My Mod Name</moduleName>

    <requiredInstallFiles>
        <folder source="00 Core" destination="" priority="0"/>
    </requiredInstallFiles>

    <installSteps order="Explicit">
        <installStep name="Texture Quality">
            <optionalFileGroups order="Explicit">
                <group name="Choose texture resolution" type="SelectExactlyOne">
                    <plugins order="Explicit">
                        <plugin name="2K Textures">
                            <description>Recommended for most systems.</description>
                            <image path="fomod/images/2k_preview.png"/>
                            <files>
                                <folder source="01 Optional Textures 2K" destination="" priority="1"/>
                            </files>
                            <typeDescriptor>
                                <type name="Recommended"/>
                            </typeDescriptor>
                        </plugin>
                        <plugin name="4K Textures">
                            <description>High quality. Requires more VRAM.</description>
                            <files>
                                <folder source="02 Optional Textures 4K" destination="" priority="1"/>
                            </files>
                            <typeDescriptor>
                                <type name="Optional"/>
                            </typeDescriptor>
                        </plugin>
                    </plugins>
                </group>
            </optionalFileGroups>
        </installStep>
    </installSteps>
</config>
```

### Group Types
| Type | Behavior |
|------|----------|
| `SelectExactlyOne` | User must pick one option |
| `SelectAtMostOne` | User can pick one or none |
| `SelectAtLeastOne` | User must pick at least one |
| `SelectAny` | Checkboxes, pick any combination |
| `SelectAll` | All options installed (informational) |

### Conditional Installs (Flag-Based)
```xml
<plugin name="VR Patch">
    <conditionFlags>
        <flag name="isVR">On</flag>
    </conditionFlags>
    <files>
        <folder source="03 VR Patch" destination="" priority="2"/>
    </files>
</plugin>
```

## BAIN Installer

### Structure
BAIN packages use a numbered folder convention:
```
MyMod-BAIN.7z
├── 000 Core/
│   └── Data/
│       └── ...
├── 010 Optional HD Textures/
│   └── Data/
│       └── ...
└── 020 VR Compatibility/
    └── Data/
        └── ...
```

- Folders prefixed with numbers for ordering
- Each subfolder contains a `Data/` tree
- Users select which numbered folders to install

### BAIN Wizard (Optional)
A `wizard.txt` at archive root provides guided installation:
```
SelectOne "Texture Quality",\
    |"2K (Recommended)","Standard quality",\
    |"4K","High quality for powerful systems"
Case "2K (Recommended)"
    SelectSubPackage "010 Optional HD Textures"
Case "4K"
    SelectSubPackage "020 Optional 4K Textures"
EndSelect
```

## Distribution Checklist

- [ ] Plugin is cleaned (no ITMs/UDRs)
- [ ] ESP is ESL-flagged if under 2048 new records
- [ ] All masters are documented in mod description
- [ ] FOMOD tested in both MO2 and Vortex
- [ ] Loose files organized correctly (meshes/, textures/, scripts/, etc.)
- [ ] BSA packed if distributing large asset sets
- [ ] VR compatibility noted on mod page
- [ ] Version tagged and changelog maintained
- [ ] Screenshots and description written for Nexus

---
name: "nexus-mods-detail"
description: "Nexus Mods website navigation, ad avoidance, and automation patterns\nKeywords: Nexus, nexusmods, download, mod page, search, browse, mod manager download, manual download, files tab, Vortex download, NMM, premium, ad, advertisement"
---

# Nexus Mods Navigation Guide

> **Last verified**: February 2026 via Playwright browser automation.

## Site Structure

### URL Patterns

| Page | URL Pattern | Example |
|------|-------------|---------|
| Game hub | `nexusmods.com/games/{game}/` | `nexusmods.com/games/skyrimspecialedition` |
| Mod search | `nexusmods.com/games/{game}/mods?keyword={query}` | `...mods?keyword=RaceMenu` |
| Mod page | `nexusmods.com/skyrimspecialedition/mods/{id}` | `.../mods/19080` |
| Files tab | `...mods/{id}?tab=files` | `.../mods/19080?tab=files` |
| Description | `...mods/{id}?tab=description` | |
| Mod manager DL | `...mods/{id}?tab=files&file_id={fid}&nmm=1` | Triggers Vortex/MO2 handler |
| Manual DL | `...mods/{id}?tab=files&file_id={fid}` | Direct download page |
| Old search (redirect) | `nexusmods.com/skyrimspecialedition/search/?gsearch={q}&gsearchtype=mods` | Redirects to new search |

### Game IDs (important for API/URL construction)

| Game | Slug | Numeric ID |
|------|------|-----------|
| Skyrim SE/AE | `skyrimspecialedition` | 1704 |
| Skyrim VR | `skyrimspecialedition` (shared!) | 1704 |
| Skyrim LE | `skyrim` | 110 |

> **Critical**: Skyrim VR does NOT have its own Nexus Mods game page. VR mods are hosted
> on the SE Nexus page. VR-specific files are typically in the **Optional files** section.

### Page Navigation Elements

| Element | Location | Purpose |
|---------|----------|---------|
| Top nav bar | Banner at top | Games, Mods, Collections, Media, Community, Support |
| Search button | Top-right | Opens search overlay (keyboard shortcut: `/`) |
| Game filter | Left of nav | Shows active game; "Clear game filter" resets |
| Breadcrumbs | Below ad banner | Games > Game > Mods > Category > Mod name |
| Mod tabs | Below gallery | Description, Files, Images, Videos, Posts, Forum, Logs, Stats |
| Login/Register | Top-right corner | Required for downloads |

### Mod Page Layout (Description Tab)

| Section | Content |
|---------|---------|
| Header | Mod name, endorsement/download counts, version, author |
| Gallery | Image carousel with thumbnail strip |
| Metadata sidebar | Last updated, original upload, created by, uploaded by, virus scan |
| Tags | Chargen, Lore-Friendly, language tags, etc. |
| Collapsible sections | Requirements, Permissions/credits, Translations, Changelogs, Donations, Collections |
| Main description | Mod author's description text (freeform HTML) |

### Files Tab Layout

Files are grouped into sections:

| Section | Purpose |
|---------|---------|
| **Main files** | Primary downloads — the "standard" file to get |
| **Optional files** | Supplementary files — patches, VR DLLs, extras |
| **Miscellaneous files** | Dev tools, modders resources, optional assets |
| **Old files** | Previous versions (archived) |

Each file entry shows:
- File name, upload date, file size, unique/total downloads, version
- **"Mod manager download"** button → triggers `nxm://` protocol handler (Vortex/MO2)
- **"Manual download"** button → goes to download page
- VirusTotal scan link
- "Preview file contents" expander

### Search / Filter Page

| Filter | Location | Notes |
|--------|----------|-------|
| Category checkboxes | Left sidebar | Body/Face/Hair, Utilities, VR, etc. |
| Tags (Include/Exclude) | Left sidebar | Combobox with "Show Tags" button |
| Search parameters | Left sidebar | Title, Description, Author, Uploader text boxes |
| Language support | Left sidebar | English, Mandarin, etc. with counts |
| Content options | Left sidebar | Hide/Show adult, Vortex support, updated only |
| File size / Downloads / Endorsements | Left sidebar | Min/max range filters |
| Sort controls | Above results | Time range, Sort by, Direction, Items per page |

## Ad Identification & Avoidance

> **CRITICAL**: Never click on ads. Never interact with ad elements. The following patterns
> identify ad content that must be completely ignored during automation.

### Ad Locations on Nexus Mods

| Position | Identifier / Pattern | Type |
|----------|---------------------|------|
| **Top banner** | `iframe` inside `generic > generic` below `banner` | Rotating display ad (carousel with numbered dots 0,1,2,3) |
| **Below top banner** | `generic` containing Playwire attribution link (`//playwire.com?utm_source=pw_ad_container`) + `img` | Video ad with countdown timer |
| **Video ad overlay** | `generic "Advertisement"` label + `iframe` with video player | Pre-roll/mid-roll video ad |
| **Right sidebar** (premium upsell) | Links to `next.nexusmods.com/premium` | Not a third-party ad, but a site promo |
| **Mod author Patreon** | Link to `patreon.com/bePatron?u=...` within description | Author donation link (not site ad) |
| **"Buy now" game link** | Link to `instant-gaming.com` with `igr=nexusmods` | Game purchase affiliate link on game hub |
| **"Make mods. Earn rewards."** | Left sidebar on search pages, links to `/about/mod-author-benefits` | Site promo banner |

### Ad Element Signatures (for Playwright avoidance)

```yaml
# Banner ad iframe — contains ad carousel with "About this Ad", "Report", "Opt Out" buttons
- iframe containing:
  - link "0", link "1", link "2", link "3"  # carousel dots
  - "About this Ad" paragraph
  - button "Report"
  - button "Opt Out Do not sell my personal information"
  - button "Why this Ad? ⓘ"
  - button "Seen this ad multiple times"
  - button "Not interested in this ad"
  - button "Ad covered content"
  - button "Already bought this"
  - "Threat Alert" / "Image Finder Plus" / similar extension ads

# Video ad container
- generic containing:
  - Playwire attribution: link with /url containing "playwire.com?utm_source=pw_ad_container"
  - Countdown timer: generic with text like "0:13", "0:15", "0:19", "0:45"
  - generic "Advertisement" label
  - Nested iframes with video player

# Game purchase affiliate
- link with /url containing "instant-gaming.com" and "igr=nexusmods"
```

### Safe Automation Rules

1. **Never click** any element inside an `iframe` that contains "About this Ad" or Playwire attribution
2. **Never click** elements with countdown timers (e.g., "0:13", "0:15")
3. **Never click** links to `instant-gaming.com`
4. **Skip** any `generic "Advertisement"` regions entirely
5. **Ignore** all Playwire-attributed containers (`playwire.com?utm_source=`)
6. **Focus only on** the `generic` tree under `ref=e182` (or similar) which contains the actual mod content

## Authentication Notes

- Downloads require login — browser shows "You have to be logged in to download files"
- **Mod manager download** (`&nmm=1`) triggers the `nxm://` protocol even without login on some pages
- Premium users get direct download links; free users go through a 5-second countdown page
- API key authentication available for programmatic access

## Automation Best Practices

1. Navigate **directly** to mod pages by ID when known (avoid searching)
2. Use the **Files tab URL** directly: `...mods/{id}?tab=files`
3. For VR mods, always check the **Optional files** section
4. The search URL pattern auto-redirects: old format → new `/games/{game}/mods?keyword=` format
5. Wait for page load before interacting — Nexus uses heavy JS rendering
6. Ad iframes load asynchronously — they may shift page layout after initial render

## Known Mod IDs (Quick Reference)

| Mod | Nexus ID | Game |
|-----|----------|------|
| RaceMenu | 19080 | skyrimspecialedition |
| SKSE64 | 30379 | skyrimspecialedition |
| SKSEVR | 30457 | skyrimspecialedition |
| SkyUI SE | 12604 | skyrimspecialedition |
| USSEP | 266 | skyrimspecialedition |
| VRIK | 23416 | skyrimspecialedition |
| HIGGS | 43930 | skyrimspecialedition |
| PLANCK | 66025 | skyrimspecialedition |
| CBBE | 198 | skyrimspecialedition |
| BodySlide | 201 | skyrimspecialedition |
| Address Library | 32444 | skyrimspecialedition |
| VR Address Library | 58101 | skyrimspecialedition |
| Engine Fixes VR | 62089 | skyrimspecialedition |

## Cross-References

- **Local system & installed mods**: `local-system.detail.instructions.md`
- **Tool workflows**: `tools.instructions.md`
- **VR modding**: `vr-modding.detail.instructions.md`

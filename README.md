# HandyNotes: Ritual Sites

HandyNotes: Ritual Sites is a small World of Warcraft Retail 12.0.5 addon that adds dedicated HandyNotes markers for the Daggerspine Point and Broken Throne Ritual Site maps.

## Features

- Shows markers only on Ritual Site maps `2594` and `2585`.
- Marks Daggerspine Point seaweed, soggy nest, and void-touched lynx thicket locations.
- Marks Broken Throne reward points for the Void Eagle, Chubs, and Warbear Mother collectibles.
- Marks Broken Throne challenge unlock points for Malevolent Boons obelisks and the Tainted Bone Pile.
- Adds a world map filter button on the Ritual Site map using the same map button column style used by modern HandyNotes plugins.
- Lets you toggle marker categories independently:
  - Washed-up seaweed and soggy nest
  - Void-touched lynx thickets
  - Broken Throne rewards
  - Broken Throne challenge unlocks
- Left-click a marker to set the built-in game waypoint.
- Right-click a marker to add a TomTom waypoint when TomTom is installed.
- Supports Game language, English, Simplified Chinese, and Russian language options.

## Requirements

- World of Warcraft Retail 12.0.5
- HandyNotes
- TomTom is optional

## Installation

Extract the addon folder as:

```text
World of Warcraft/_retail_/Interface/AddOns/HandyNotes_RitualSites
```

The folder must contain `HandyNotes_RitualSites.toc` directly inside it.

## Release

GitHub Actions uses `BigWigsMods/packager@v2` when a `v*` tag is pushed.

For CurseForge upload, configure this repository secret:

- `CF_API_KEY`

The CurseForge project ID is stored in `HandyNotes_RitualSites.toc`.

Then push a tag such as:

```bash
git tag v1.2.0
git push origin v1.2.0
```

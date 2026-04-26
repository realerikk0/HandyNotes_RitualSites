# HandyNotes: Ritual Sites

HandyNotes: Ritual Sites is a small World of Warcraft Retail 12.0.5 addon that adds dedicated HandyNotes markers for the Daggerspine Point Ritual Site map.

## Features

- Shows markers only on Ritual Site map `2594`.
- Marks 8 `冲上岸的海藻` locations.
- Marks the `湿漉漉的窝` at `30.03, 63.12`.
- Marks 9 `沙沙响的隐秘草丛` locations for the void-touched lynx collectible.
- Left-click a marker to set the built-in game waypoint.
- Right-click a marker to add a TomTom waypoint when TomTom is installed.

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

For CurseForge upload, configure these repository secrets after the CurseForge project exists:

- `CF_API_KEY`
- `CF_PROJECT_ID`

Then push a tag such as:

```bash
git tag v1.0.0
git push origin v1.0.0
```


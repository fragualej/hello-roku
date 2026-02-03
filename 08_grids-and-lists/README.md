# 08 - Grids and Lists

Sample app demonstrating Roku SceneGraph grid and list components with BrighterScript.

## Components Covered

| Component | Description |
|-----------|-------------|
| **MarkupGrid** | Simple 2D grid with fixed item sizes and built-in navigation |
| **RowList** | Multiple horizontal rows with vertical scrolling (Netflix-style) |
| **TargetList** | Horizontal list with custom focus sizing using TargetSet |
| **TargetGroup** | 2D grid with custom positions using multiple TargetLists |
| **ZoomRowList** | Rows with automatic zoom effect on focused items |

## Features

- BaseView/BaseItem component inheritance for shared Constants
- Custom focus sizing (16:9 focused, 9:16 unfocused) for TargetList/TargetGroup
- LabelList menu for selecting between examples
- BrighterScript with namespace-based constants

## Setup

```bash
npm install
npm run build
```

Configure your Roku device IP in `.env` (copy from `.env.example`).

## Links

- [Main README](../README.md)
- [TargetList Documentation](https://developer.roku.com/docs/references/scenegraph/layout-group-nodes/targetlist.md)
- [ZoomRowList Documentation](https://developer.roku.com/docs/references/scenegraph/layout-group-nodes/zoomrowlist.md)
- [RowList Documentation](https://developer.roku.com/docs/references/scenegraph/list-and-grid-nodes/rowlist.md)
- [MarkupGrid Documentation](https://developer.roku.com/docs/references/scenegraph/list-and-grid-nodes/markupgrid.md)

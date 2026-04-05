## [2.1.0] - 05 April 2026

### 🚀 New Features
- **Markdown Parsing**: Added `SketchyParagraph.parse()` automated constructor to support mapping annotations using lightweight markdown wrappers (`==highlight==`, `__underline__`, `~~strikethrough~~`, `((circle))`, `[[rectangle]]`).
- **Static Rendering**: Introduced `isAnimated` property globally and locally. Pass `false` to suppress drawing animations and instantly paint sketchy vectors upfront without waiting for start delays.

### ⚡ Performance
- **Zero-Footprint Global Randomness Generation**: Eliminated runtime array allocation bottle-necks. Created an internal singleton `SketchyRandomPool` globally reducing widget memory load when computing organic wiggly offsets by mapping them simultaneously.

## [2.0.3] - 18 May 2025

Reducing SDK version to make it work with old versions.

## [2.0.2] - 18 May 2025

Update Flutter version from 3.7.2 to 3.8.0

## [2.0.1] - 18 February 2025

Make improvment in documentations.

## [2.0.0] - 18 February 2025

### 🚀 New Features

- **Added Support for Plain & Organic Animations**
  - **Plain Mode**: Straight-line animations for a clean effect.
  - **Organic Mode**: Hand-drawn, wavy animations for a natural feel.

### 🛠 Improvements

- **Refactored API for Simplicity**
  - Unified `SketchyModel` to handle both headings and paragraphs.
  - Reduced required parameters for `SketchySentance`.
- **Enhanced Readability in Docs**
  - Improved `README.md` with clearer usage examples.
  - Added code examples for both **Plain** & **Organic** modes.

## [1.0.1] - 16 February 2025

Make improvment in documentations.

## [1.0.0] - 15 February 2025

- **Performance:** Significantly improved performance by optimizing the repainting strategy. The `SketchyText` widget now only repaints the necessary portions of the text, leading to smoother animations and a more responsive user experience, especially for longer paragraphs and frequent updates.

- **Simplified Usage:**
  - Removed the `startDelay` property. The package now automatically manages animation timing internally based on the order of `SketchySentance` objects.
  - Provided default values for all properties in `SketchySentance`. This simplifies common use cases and allows for more concise code.

## [0.1.0] - 7 February 2025

implemented changes to the sketchy model, renaming highlightColor to sketchyColor and highlightType to sketchyType.
Increased the rectangle box width and adjusted the offset for complete word/sentence coverage.
Added a click listener to the animated text.

## [0.0.3] - 6 February 2025

Resolve the gif image issue in the README.

## [0.0.2] - 5 February 2025s

Make improvment in documentations.

## [0.0.1] - 5 February 2025

Initial release, should be polished

## [2.0.0+1] - 18 February 2025

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

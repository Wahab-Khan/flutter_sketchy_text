# 🎨 Flutter Sketchy Text

**Flutter Sketchy Text** is a dynamic and flexible package that brings human-like, hand-drawn text annotations right into your Flutter applications. Highlight, underline, circle, or strike through specific words and phrases inside paragraphs to create lively, engaging text elements!

📌 **Live Demo:**  
[Abdul Wahab Khan](https://wahab-khan.github.io/Abdul-Wahab-Khan/)

---

## ✨ Features

- ✍️ **Sketchy Annotations** – Support for Highlights, Underlines, Strikethroughs, Circles, and Rectangles.
- 🎨 **Two Unique Styles** – Switch seamlessly between `organic` (hand-drawn/wavy) and `plain` (geometric/straight) line plotting modes.
- 🚀 **Performant & Lightweight** – Uses extremely low memory overhead through a global static offset generation pool. Render hundreds of sketchy texts without dropping frames.
- ⚡ **Instant Markdown Parsing** – Don't want to define big Lists? Use `SketchyParagraph.parse()` to evaluate Markdown tags right from raw strings!
- 🖼️ **Optional Static Rendering** – Set `isAnimated: false` to skip drawing animations and load your dynamic sketchy shapes instantly.
- 👉 **Interactive** – Bind `onTap` callbacks securely to the highlighted parts of your sentences to trigger user actions.

---

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_sketchy_text: latest_version
```

---

## 🛠️ Usage Examples

### 1️⃣ Automatic Markdown Parsing (Best DX)
Don't want to type out a list of objects? Use the `parse` factory constructor! You can inject custom colors and styles mapping directly to specific characters:
- `==highlight==`
- `__underline__`
- `~~strikethrough~~`
- `((circle))`
- `[[rectangle]]`

```dart
SketchyParagraph.parse(
  "This is ==highlighted==, this is __underlined__, and this is ~~striked out~~.\\nAlso, you can have ((circles)) and [[rectangles]]!",
  highlightColor: Colors.yellow.withValues(alpha: 0.4),
  underlineColor: Colors.blue,
  strikethroughColor: Colors.red,
  circleColor: Colors.purple,
  rectangleColor: Colors.green,
  animationMode: SketchyAnimationMode.organic,
);
```

---

### 2️⃣ Structured Sketchy Paragraph
If you prefer explicit control and want to intercept clicks on particular sentence chunks, you can configure your arrays precisely:

```dart
SketchyParagraph(
  paragraph: "Flutter makes UI development incredibly fun!",
  animationMode: SketchyAnimationMode.organic, // Set either organic or plain globally
  highlights: [
    SketchySentance(
      text: "Flutter",
      sketchyColor: Colors.blue,
      sketchyType: SketchyType.underline,
      onTap: () {
         print("Flutter was tapped!");
      },
    ),
    SketchySentance(
      text: "fun!",
      sketchyColor: Colors.amber,
      sketchyType: SketchyType.rectangle,
    ),
  ],
)
```

---

### 3️⃣ Instant Static Rendering (No Animations)
Want to render the beautiful sketchy boundaries *without* forcing the user to wait for the drawing animation? 

Simply add `isAnimated: false` at the paragraph level (this will force all children instantly to 100% completion).
```dart
SketchyParagraph(
  paragraph: "This bounding box loaded instantly!",
  isAnimated: false, // Forces all strokes to render fully instantly
  highlights: [
    SketchySentance(
      text: "instantly!",
      sketchyType: SketchyType.circle,
    ),
  ],
)
```

---

## 📸 Previews

### Organic Hand-drawn Mode
_Showcases the hand-drawn, wavy lines for a natural, human-sketch appearance._

<img src="https://github.com/Wahab-Khan/flutter_sketchy_text/raw/main/assets/animation_modes.gif" width="400" />

### Sketchy Types
_Showcases the 5 uniquely supported shapes_

<img src="https://github.com/Wahab-Khan/flutter_sketchy_text/raw/main/assets/animation_types.gif" width="400" />

| **Sketchy Type**  | **Preview**                                                                                                   |
| ----------------- | ------------------------------------------------------------------------------------------------------------- |
| **Highlight**     | <img src="https://github.com/Wahab-Khan/flutter_sketchy_text/raw/main/assets/highlight.gif" width="200" />     |
| **Underline**     | <img src="https://github.com/Wahab-Khan/flutter_sketchy_text/raw/main/assets/underline.gif" width="200" />     |
| **Strikethrough** | <img src="https://github.com/Wahab-Khan/flutter_sketchy_text/raw/main/assets/strikethrough.gif" width="200" /> |
| **Circle**        | <img src="https://github.com/Wahab-Khan/flutter_sketchy_text/raw/main/assets/circle.gif" width="200" />        |
| **Rectangle**     | <img src="https://github.com/Wahab-Khan/flutter_sketchy_text/raw/main/assets/rectangle.gif" width="200" />     |

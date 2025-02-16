# **Flutter Sketchy Text 🎨✍️**

Flutter Sketchy Text is a **fun and dynamic** package that brings a **human-like, hand-drawn text animation** to your Flutter apps. It provides effects like **highlighting, underlining, circling, strikethrough, and more** to create lively and engaging text animations.

📌 **Live Demo:**  
[Abdul Wahab Khan](https://wahab-khan.github.io/Abdul-Wahab-Khan/)

---

## **📸 Example Preview**

![Demo](https://github.com/Wahab-Khan/flutter_sketchy_text/raw/main/assets/demo.gif)

---

## **✨ Features**

✔️ **Sketchy Text Effects** – Highlight, Underline, Strikethrough, Circle, and Rectangle animations.  
✔️ **Smooth Hand-Drawn Look** – Mimics human-like drawing with organic strokes.  
✔️ **Customizable** – Adjust animation speed, colors, and delays.  
✔️ **Lightweight & Easy to Use** – Simple API for quick integration.  
✔️ **Supports Plain & Organic Modes** – Choose between a **precise straight-line** effect or a **natural hand-drawn** style.

---

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## 📦 Installation

Add the package to your pubspec.yaml:

```dependencies:
  flutter_sketchy_text: latest_version
```

Run the command:

`flutter pub get`

Add the package to your pubspec.yaml:

```dependencies:
  flutter_sketchy_text: latest_version
```

## 🚀 Usage

1️⃣ Create a Sketchy Paragraph

Define your text and specify which words to animate:

```
import 'package:flutter_sketchy_text/model/sketchy.dart';

/// Define text animations with SketchyModel
final paragraphModel = SketchyModel(
  paragraph: """
## 📝 Introduction
In a world full of possibilities, creativity unlocks new ideas.
You can apply **highlighted text**, **underlined concepts**,
**circled techniques**, **strikethrough effects**,
or **rectangled challenges** to animate words dynamically.

## ❓ Why It Matters
Every **challenge** is an opportunity to grow and learn.
Embrace the process, and let your imagination guide you!
""",
  highlightSentances: [
    /// 📍 Simple Example (Default Settings)
    SketchySentance(text: "Introduction"),

    /// 🎨 Highlight Effect (Custom Color + Tap Action)
    SketchySentance(
      text: "highlighted text",
      sketchyColor: Colors.brown.withValues(alpha: 0.4),
      sketchyType: SketchyType.highlight,
      onTap: () => _launchInBrowser(Uri.parse(
          'https://pub.dev/packages/flutter_sketchy_text')),
    ),

    /// 🖊️ Underline Effect
    SketchySentance(
      text: 'underlined concepts',
      sketchyType: SketchyType.underline,
    ),

    /// ⭕ Circle Effect
    SketchySentance(
      text: 'circled techniques',
      sketchyType: SketchyType.circle,
    ),

    /// ✍️ Strikethrough Effect
    SketchySentance(
      text: 'strikethrough effects',
      sketchyType: SketchyType.strikethrough,
    ),

    /// 🟦 Rectangle Effect
    SketchySentance(
      text: 'rectangled challenges',
      sketchyType: SketchyType.rectangle,
    ),
  ],
);
```

2️⃣ Display the Animated Text

Use SketchyParagraph to render the animated text inside your widget tree:

```
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/sketchy_paragraph.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter Sketchy Text")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SketchyParagraph(
            paragraph: paragraphModel.paragraph,
            highlights: paragraphModel.highlightSentances,
          ),
        ),
      ),
    );
  }
}
```

## ⚙️ Customization

Each sketchy effect can be customized using the SketchySentance properties:

```
SketchySentance(
  text: 'Flutter is awesome!',
  sketchyColor: Colors.purple.withValues(alpha: 0.4), // Custom color
  sketchyType: SketchyType.circle, // Choose an effect
  duration: const Duration(milliseconds: 500), // Speed of the animation
  onTap: () => debugPrint('Flutter is awesome! tapped'), // Action when tapped
),
```

## 🎭 Plain vs. Organic Mode

You can choose between two animation styles:

1️⃣ Plain Mode: Perfect straight-line animations for a clean effect.
2️⃣ Organic Mode: Hand-drawn, wavy lines for a natural effect.

```
SketchyParagraph(
  paragraph: paragraphModel.paragraph,
  highlights: paragraphModel.highlightSentances,
  animationMode: SketchyAnimationMode.plain,  // 🟢 Straight-line animation
)
```

```
SketchyParagraph(
  paragraph: paragraphModel.paragraph,
  highlights: paragraphModel.highlightSentances,
  animationMode: SketchyAnimationMode.organic, // 🔵 Hand-drawn animation
)
```

---

## 🤝 Contributing

Want to improve Flutter Sketchy Text? Contributions are welcome!

Steps to Contribute:

1. Fork the Repo – Click the “Fork” button on GitHub
2. Clone Your Fork – git clone https://github.com/Wahab-Khan/flutter_sketchy_text.git
3. Create a Branch – git checkout -b my-feature
4. Make Your Changes – Improve animations, fix bugs, or optimize code
5. Push Your Changes – git push origin my-feature
6. Create a Pull Request – Submit your PR for review

---

## 📜 License

This project is licensed under the MIT License.

💡 Enjoy using Flutter Sketchy Text? Give it a ⭐ on GitHub! 🚀

---

## 🎉 Final Thoughts

Now you have everything you need to add sketchy text animations to your Flutter app with ease. Whether you’re aiming for a clean-cut look or a hand-drawn feel, this package has you covered! ✍️🎨🚀

## Flutter Sketchy Text 🎨✍️

Flutter Sketchy Text is a package that lets you add human-like, hand-drawn text animations to your Flutter apps. With effects like highlighting, underlining, circling, and more, you can create dynamic and visually engaging text displays that feel organic and lively.

**Live Example:**

[Abdul Wahab Khan](https://wahab-khan.github.io/Abdul-Wahab-Khan/)

Here's a live example showcasing the implementation of this package.

## 📸 Example Preview

<img src="https://github.com/Wahab-Khan/flutter_sketchy_text/raw/main/assets/demo.gif" width="238" height="500">

## ✨ Features

- Sketchy Effects – Highlight, Underline, Strikethrough, Circle, Rectangle, and Cross animations.
- Smooth Hand-Drawn Look – Mimics natural writing with animated strokes.
- Customizable – Control animation speed, color, and delays.
- Lightweight & Easy to Use – Simple API for integration into any Flutter project.

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
SketchyModel paragraphModel = SketchyModel(
  paragraph: """
## 📝 Introduction
In a world full of possibilities, creativity is the key to unlocking new ideas.
Whether you're working on a highlighted project, exploring underlined concepts,
experimenting with circled techniques, testing strikethrough effects,
or tackling rectangled challenges, the journey is as important as the destination.

## ❓ Why It Matters
Remember, every challenge is an opportunity to grow and learn.
Embrace the process, and let your imagination guide you!

## 🔄 Repeated Words Demo
Working on another highlighted project can reinforce ideas.
Some underlined concepts are worth revisiting.
Even circled techniques can evolve over time.
Sometimes, strikethrough effects help remove clutter.
Finally, tackling rectangled challenges again builds mastery.
""",
  highlightSentances: [

    /// 📍 Simple Example (Default Settings)
    /// Highlights "Introduction" with default animation & color.
    SketchySentance(text: "Introduction"),

    /// 🎨 Highlight Effect (Custom Color + Tap Action)
    /// Click to open the Flutter Sketchy Text package on pub.dev.
    SketchySentance(
      text: "highlighted project",
      sketchyColor: Colors.brown.withValues(alpha: 0.4), // Optional: Default varies.
      sketchyType: SketchyType.highlight, // Required: Defines the animation type.
      onTap: () => _launchInBrowser(Uri.parse(
          'https://pub.dev/packages/flutter_sketchy_text')), // Optional: Adds interactivity.
    ),

    /// 🖊️ Underline Effect
    /// Click to log a message in debug console.
    SketchySentance(
      text: 'underlined concepts',
      sketchyType: SketchyType.underline,
      onTap: () => debugPrint('Underlined text clicked!'),
    ),

    /// ⭕ Circle Effect
    /// Click to log a message in debug console.
    SketchySentance(
      text: 'circled techniques',
      sketchyType: SketchyType.circle,
      onTap: () => debugPrint('Circled text clicked!'),
    ),

    /// ✍️ Strikethrough Effect
    /// Click to log a message in debug console.
    SketchySentance(
      text: 'strikethrough effects',
      sketchyType: SketchyType.strikethrough,
      onTap: () => debugPrint('Strikethrough text clicked!'),
    ),

    /// 🟦 Rectangle Effect
    /// Click to log a message in debug console.
    SketchySentance(
      text: 'rectangled challenges',
      sketchyType: SketchyType.rectangle,
      onTap: () => debugPrint('Rectangled text clicked!'),
    ),

    /// 🟦 Rectangle Effect (Another Example)
    /// Highlights "Matters" with a rectangle effect.
    SketchySentance(
      text: 'Matters',
      sketchyType: SketchyType.rectangle,
      onTap: () => debugPrint('Matters clicked!'),
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

## 🤝 Contributing

Want to improve Flutter Sketchy Text? Contributions are welcome!

Steps to Contribute:

1. Fork the Repo – Click the “Fork” button on GitHub
2. Clone Your Fork – git clone https://github.com/Wahab-Khan/flutter_sketchy_text.git
3. Create a Branch – git checkout -b my-feature
4. Make Your Changes – Improve animations, fix bugs, or optimize code
5. Push Your Changes – git push origin my-feature
6. Create a Pull Request – Submit your PR for review

## 📜 License

This project is licensed under the MIT License.

💡 Enjoy using Flutter Sketchy Text? Give it a ⭐ on GitHub! 🚀

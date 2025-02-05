## Flutter Sketchy Text 🎨✍️

Flutter Sketchy Text is a package that lets you add human-like, hand-drawn text animations to your Flutter apps. With effects like highlighting, underlining, circling, and more, you can create dynamic and visually engaging text displays that feel organic and lively.

## 📸 Example Preview

<img src="https://github.com/Wahab-Khan/flutter_sketchy_text/blob/main/assets/demo.gif" width="238" height="500">

## ✨ Features

    •	Sketchy Effects – Highlight, Underline, Strikethrough, Circle, Rectangle, and Cross animations
    •	Smooth Hand-Drawn Look – Mimics natural writing with animated strokes
    •	Customizable – Control animation speed, color, and delays
    •	Lightweight & Easy to Use – Simple API for integration into any Flutter project

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

```SketchyModel paragraphModel = SketchyModel(
  paragraph:
      """In a world full of possibilities, creativity is the key to unlocking new ideas. Whether you're working on a highlighted project, exploring underlined concepts, or experimenting with circled techniques, the journey is as important as the destination. Remember, every rectangled challenge is an opportunity to grow and learn. Embrace the process, and let your imagination guide you!""",
  highlightSentances: [
    SketchySentance(
      text: "highlighted project",
      highlightColor: Colors.red.withOpacity(0.4),
      highlightType: SketchyType.highlight,
      startDelay: Duration.zero,
    ),
    SketchySentance(
      text: 'underlined concepts',
      highlightColor: Colors.blue,
      highlightType: SketchyType.underline,
      startDelay: const Duration(seconds: 2),
    ),
    SketchySentance(
      text: 'circled techniques',
      highlightColor: Colors.green,
      highlightType: SketchyType.circle,
      startDelay: const Duration(seconds: 4),
    ),
    SketchySentance(
      text: 'rectangled challenge',
      highlightColor: Colors.amberAccent,
      highlightType: SketchyType.rectangle,
      startDelay: const Duration(seconds: 6),
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
  highlightColor: Colors.purple.withOpacity(0.5), // Custom color
  highlightType: SketchyType.circle, // Choose an effect
  startDelay: const Duration(seconds: 3), // Delay before animation starts
  duration: const Duration(seconds: 2), // Speed of the animation
),
```

## 🤝 Contributing

Want to improve Flutter Sketchy Text? Contributions are welcome!

Steps to Contribute: 1. Fork the Repo – Click the “Fork” button on GitHub 2. Clone Your Fork – git clone https://github.com/yourusername/flutter_sketchy_text.git 3. Create a Branch – git checkout -b my-feature 4. Make Your Changes – Improve animations, fix bugs, or optimize code 5. Push Your Changes – git push origin my-feature 6. Create a Pull Request – Submit your PR for review

## 📜 License

This project is licensed under the MIT License.

💡 Enjoy using Flutter Sketchy Text? Give it a ⭐ on GitHub! 🚀

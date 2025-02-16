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

1️⃣ Define Sketchy Models

Create headings and paragraphs with different animation styles:

```
/// **Sketchy Models for Headings**
final plainHeadingModel = SketchyModel(
  paragraph: "Plain Animation",
  highlightSentances: [
    SketchySentance(
      text: "Plain Animation",
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ],
);

final organicHeadingModel = SketchyModel(
  paragraph: "Organic Animation",
  highlightSentances: [
    SketchySentance(
      text: "Organic Animation",
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ],
);

/// **Paragraph with words highlighted using sketchy effects.**
SketchyModel paragraphModel = SketchyModel(
  paragraph: """
Flutter Sketchy Text makes animations fun!
You can use highlighted text, underlined words,
circled techniques, strikethrough effects,
or rectangled challenges to bring text to life.
""",
  highlightSentances: [
    SketchySentance(text: "highlighted text", sketchyType: SketchyType.highlight),
    SketchySentance(text: "underlined words", sketchyType: SketchyType.underline),
    SketchySentance(text: "circled techniques", sketchyType: SketchyType.circle),
    SketchySentance(text: "strikethrough effects", sketchyType: SketchyType.strikethrough),
    SketchySentance(text: "rectangled challenges", sketchyType: SketchyType.rectangle),
  ],
);
```

2️⃣ Display Plain & Organic Animations Together

Use SketchyParagraph to render the animated text inside your widget tree:

```
void main() {
  runApp(const MyApp());
}

/// **Main Application Widget**
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sketchy Text Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

/// **Home Page with Plain and Organic Animations**
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Sketchy Text Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Plain Animation**
            SketchyParagraph(
              paragraph: plainHeadingModel.paragraph,
              highlights: plainHeadingModel.highlightSentances,
              animationMode: SketchyAnimationMode.plain,
            ),
            SketchyParagraph(
              paragraph: paragraphModel.paragraph,
              highlights: paragraphModel.highlightSentances,
              animationMode: SketchyAnimationMode.plain,
            ),

            const SizedBox(height: 20),

            /// **Organic Animation**
            SketchyParagraph(
              paragraph: organicHeadingModel.paragraph,
              highlights: organicHeadingModel.highlightSentances,
              animationMode: SketchyAnimationMode.organic,
            ),
            SketchyParagraph(
              paragraph: paragraphModel.paragraph,
              highlights: paragraphModel.highlightSentances,
              animationMode: SketchyAnimationMode.organic,
            ),
          ],
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

1️⃣. Plain Mode: Perfect straight-line animations for a clean effect.
2️⃣. Organic Mode: Hand-drawn, wavy lines for a natural effect.

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

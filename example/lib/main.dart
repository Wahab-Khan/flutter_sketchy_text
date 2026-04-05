import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/flutter_sketchy_text.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';

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

final staticHeadingModel = SketchyModel(
  paragraph: "Static Rendering (Upfront)",
  highlightSentances: [
    SketchySentance(
      text: "Static Rendering (Upfront)",
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
    SketchySentance(
      text: "highlighted text",
      sketchyType: SketchyType.highlight,
      onTap: () {
        debugPrint("User clicked 'highlighted text'!");
      },
    ),
    SketchySentance(
      text: "underlined words",
      sketchyType: SketchyType.underline,
      onTap: () {
        debugPrint("User clicked 'underlined words'!");
      },
    ),
    SketchySentance(
      text: "circled techniques",
      sketchyType: SketchyType.circle,
    ),
    SketchySentance(
      text: "strikethrough effects",
      sketchyType: SketchyType.strikethrough,
    ),
    SketchySentance(
      text: "rectangled challenges",
      sketchyType: SketchyType.rectangle,
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

/// **Main Application Widget.**
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

/// Home Page with Plain and Organic Animations.**
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Sketchy Text Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
            const SizedBox(height: 20),
            SketchyParagraph(
              paragraph: staticHeadingModel.paragraph,
              highlights: staticHeadingModel.highlightSentances,
              animationMode: SketchyAnimationMode.organic,
              isAnimated: false,
            ),
            SketchyParagraph(
              paragraph: paragraphModel.paragraph,
              highlights: paragraphModel.highlightSentances,
              animationMode: SketchyAnimationMode.organic,
              isAnimated: false,
            ),
            const SizedBox(height: 20),
            const Text(
              "Markdown Support:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SketchyParagraph.parse(
              "This is ==highlighted==, this is __underlined__, and this is ~~striked out~~.\nAlso, you can have ((circles)) and [[rectangles]]!",
              highlightColor: Colors.yellow.withValues(alpha: 0.4),
              underlineColor: Colors.blue,
              strikethroughColor: Colors.red,
              circleColor: Colors.purple,
              rectangleColor: Colors.green,
            ),
          ],
        ),
      ),
    ),);
  }
}

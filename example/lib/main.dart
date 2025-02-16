import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/flutter_sketchy_text.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';
import 'package:url_launcher/url_launcher.dart';

/// **Defines the paragraph and highlights specific words for animation.**
///
/// - The `SketchyModel` stores a paragraph.
/// - `SketchySentance` objects define which words will be animated.
SketchyModel paragraphModel = SketchyModel(
  paragraph: """
Introduction  
In a world full of possibilities, creativity is the key to unlocking new ideas.  
Whether you're working on a highlighted project, exploring underlined concepts, experimenting with circled techniques, testing strikethrough effects, or tackling rectangled challenges, the journey is as important as the destination.  

Why It Matters? 
Remember, every challenge  is an opportunity to grow and learn.  
Embrace the process, and let your imagination guide you!  

Repeated Words Demo  
Working on another highlighted project can reinforce ideas.  
Some  underlined concepts are worth revisiting.  
Even circled techniques can evolve over time.  
Sometimes, strikethrough effects help remove clutter.  
Finally, tackling rectangled challenges again builds mastery.
""",
  highlightSentances: [
    ///**Simplest User case** with default settings.
    SketchySentance(text: "Introduction"),

    /// **Highlight effect** with a custom color and a tap action.
    SketchySentance(
      text: "highlighted project",
      sketchyColor: Colors.brown.withValues(
        alpha: 0.4,
      ), // Optional: Default varies by type.
      sketchyType: SketchyType.highlight, // Required: Effect type.
      onTap:
          () => _launchInBrowser(
            Uri.parse('https://pub.dev/packages/flutter_sketchy_text'),
          ), // Optional: Default is null.
    ),

    /// **Underline effect** with default color and animation settings.
    SketchySentance(
      text: 'underlined concepts',
      sketchyType: SketchyType.underline, // Required.
      onTap: () => debugPrint('Underlined text clicked!'), // Optional.
    ),

    /// **Circle effect** with default settings.
    SketchySentance(
      text: 'circled techniques',
      sketchyType: SketchyType.circle, // Required.
      onTap: () => debugPrint('Circled text clicked!'), // Optional.
    ),

    /// **Strikethrough effect** with default settings.
    SketchySentance(
      text: 'strikethrough effects',
      sketchyType: SketchyType.strikethrough, // Required.
      onTap: () => debugPrint('Strikethrough text clicked!'), // Optional.
    ),

    /// **Rectangle effect** with default settings.
    SketchySentance(
      text: 'rectangled challenges',
      sketchyType: SketchyType.rectangle, // Required.
      onTap: () => debugPrint('Rectangled text clicked!'), // Optional.
    ),

    /// **Rectangle effect** with default settings.
    SketchySentance(
      text: 'Matters',
      sketchyType: SketchyType.rectangle, // Required.
      onTap: () => debugPrint('Rectangled text clicked!'), // Optional.
    ),
  ],
);

/// **Opens a URL in the browser when a user taps a highlighted word.**
Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

void main() {
  runApp(const MyApp());
}

/// **Main Application Widget.**
///
/// Sets up the material theme and home screen.
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
      home: const MyHomePage(title: 'Flutter Sketchy Text Demo'),
    );
  }
}

/// **Home Page of the App.**
///
/// Displays the paragraph with sketchy text effects.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            /// **Displays the paragraph with animated effects.**
            ///
            /// - `paragraph`: The full text content.
            /// - `highlights`: List of words/phrases to animate.
            SketchyParagraph(
              paragraph: paragraphModel.paragraph,
              highlights: paragraphModel.highlightSentances,
            ),
          ],
        ),
      ),
    );
  }
}

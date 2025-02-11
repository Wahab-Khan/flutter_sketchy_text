import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';
import 'package:url_launcher/url_launcher.dart';

SketchyModel paragraphModel = SketchyModel(
  paragraph:
      """In a world full of possibilities, creativity is the key to unlocking new ideas. Whether you're working on a highlighted project, exploring underlined concepts, experimenting with circled techniques, testing strikethrough effects, or tackling rectangled challenges, the journey is as important as the destination. Remember, every challenge is an opportunity to grow and learn. Embrace the process, and let your imagination guide you!""",
  highlightSentances: [
    SketchySentance(
      text: "highlighted project",
      sketchyColor: Colors.red.withValues(alpha: 0.4),
      sketchyType: SketchyType.highlight,
      startDelay: Duration.zero,
      onTap: () => _launchInBrowser(
          Uri.parse('https://pub.dev/packages/flutter_sketchy_text')),
    ),
    SketchySentance(
      text: 'underlined concepts',
      sketchyColor: Colors.blue,
      sketchyType: SketchyType.underline,
      startDelay: const Duration(seconds: 2),
      onTap: () => debugPrint('Underlined text clicked!'),
    ),
    SketchySentance(
      text: 'circled techniques',
      sketchyColor: Colors.green,
      sketchyType: SketchyType.circle,
      startDelay: const Duration(seconds: 4),
      duration: const Duration(seconds: 4),
      onTap: () => debugPrint('Circled text clicked!'),
    ),
    SketchySentance(
      text: 'strikethrough effects',
      sketchyColor: Colors.purple,
      sketchyType: SketchyType.strikethrough,
      startDelay: const Duration(seconds: 5),
      duration: Duration(milliseconds: 500),
      onTap: () => debugPrint('Strikethrough text clicked!'),
    ),
    SketchySentance(
      text: 'rectangled challenges',
      sketchyColor: Colors.amberAccent,
      sketchyType: SketchyType.rectangle,
      startDelay: const Duration(seconds: 6),
      duration: const Duration(seconds: 2),
      onTap: () => debugPrint('Rectangled text clicked!'),
    ),
  ],
);

/// Function to launch a URL in the browser.
Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

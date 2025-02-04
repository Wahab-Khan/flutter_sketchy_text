import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';

SketchyModel paragraphModel = SketchyModel(
  paragraph:
      """In a world full of possibilities,creativity is the key to unlocking new ideas. Whether you're working on a highlighted project, exploring underlined concepts, or experimenting with circled techniques, the journey is as important as the destination. Remember, every rectangled challenge is an opportunity to grow and learn. Embrace the process, and let your imagination guide you!""",
  highlightSentances: [
    SketchySentance(
      text: "highlighted project",
      highlightColor: Colors.red.withValues(alpha: 0.4),
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
    )
  ],
);

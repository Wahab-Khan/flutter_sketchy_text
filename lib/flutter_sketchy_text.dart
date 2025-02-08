import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';
import 'package:flutter_sketchy_text/sketch/circule/circule_text.dart';
import 'package:flutter_sketchy_text/sketch/highlighter/high_lighter_text.dart';
import 'package:flutter_sketchy_text/sketch/rectangle/rectangle_text.dart';
import 'package:flutter_sketchy_text/sketch/strickthrough/strickthrough_text.dart';
import 'package:flutter_sketchy_text/sketch/underline/underline_text.dart';

/// A widget that **applies sketchy animations to specific words inside a paragraph**.
///
/// This widget processes a paragraph and applies **animated sketchy effects** to selected words,
/// such as:
/// - **Highlighting**
/// - **Underlining**
/// - **Strikethrough**
/// - **Encircling**
/// - **Drawing a rectangle around text**
///
/// ### **Features:**
/// - **Supports multiple sketchy effects** within a single paragraph.
/// - **Customizable colors, durations, and start delays** for each effect.
/// - **Maintains proper text flow** without breaking paragraph structure.
/// - **Uses `RichText` for efficient rendering.**
///
/// ### **Usage Example:**
/// ```dart
/// SketchyParagraph(
///   paragraph: "Flutter makes UI development easy!",
///   highlights: [
///     SketchySentance(
///       text: "Flutter",
///       sketchyColor: Colors.red,
///       sketchyType: SketchyType.highlight,
///       startDelay: Duration(seconds: 1),
///     ),
///     SketchySentance(
///       text: "UI development",
///       sketchyColor: Colors.blue,
///       sketchyType: SketchyType.underline,
///       startDelay: Duration(seconds: 2),
///     ),
///   ],
/// )
/// ```
class SketchyParagraph extends StatelessWidget {
  /// The full paragraph in which sketchy effects will be applied.
  final String paragraph;

  /// A list of words/sentences to be highlighted with different sketchy effects.
  final List<SketchySentance> highlights;

  /// Creates a `SketchyParagraph` that applies animated sketchy effects to selected words.
  const SketchyParagraph({
    super.key,
    required this.paragraph,
    required this.highlights,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.black, height: 1.5),
        children: _processParagraph(),
      ),
    );
  }

  /// Processes the paragraph and applies sketchy effects to highlighted words.
  List<InlineSpan> _processParagraph() {
    final List<InlineSpan> spans = [];
    String remainingText = paragraph;

    for (final highlight in highlights) {
      final int startIndex = remainingText.indexOf(highlight.text);

      if (startIndex != -1) {
        // Add normal text before the highlighted text
        if (startIndex > 0) {
          spans.add(
            TextSpan(
              text: remainingText.substring(0, startIndex),
            ),
          );
        }

        // Add the highlighted text with the correct animation
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _buildAnimation(highlight),
          ),
        );

        // Remove the processed part and continue
        remainingText =
            remainingText.substring(startIndex + highlight.text.length);
      }
    }

    // Add any remaining text as normal text
    if (remainingText.isNotEmpty) {
      spans.add(
        TextSpan(
          text: remainingText,
        ),
      );
    }

    return spans;
  }

  /// Builds the appropriate animation effect based on the highlight type.
  Widget _buildAnimation(SketchySentance highlight) {
    switch (highlight.sketchyType) {
      case SketchyType.highlight:
        return AnimatedHighlightedText(
          text: highlight.text,
          highlightColor: highlight.sketchyColor,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          duration: highlight.duration,
          startDelay: highlight.startDelay,
        );
      case SketchyType.underline:
        return AnimatedUnderlineText(
          text: highlight.text,
          underlineColor: highlight.sketchyColor,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          duration: highlight.duration,
          startDelay: highlight.startDelay,
        );
      case SketchyType.strikethrough:
        return AnimatedStrikethroughText(
          text: highlight.text,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          strikeColor: highlight.sketchyColor,
          duration: highlight.duration,
          startDelay: highlight.startDelay,
        );
      case SketchyType.circle:
        return AnimatedCircleText(
          text: highlight.text,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          circleColor: highlight.sketchyColor,
          duration: highlight.duration,
          startDelay: highlight.startDelay,
        );
      case SketchyType.rectangle:
        return AnimatedRectangleText(
          text: highlight.text,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          rectangleColor: highlight.sketchyColor,
          duration: highlight.duration,
          startDelay: highlight.startDelay,
        );
    }
  }
}

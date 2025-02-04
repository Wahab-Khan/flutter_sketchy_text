import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';
import 'package:flutter_sketchy_text/sketch/circule/circule_text.dart';
import 'package:flutter_sketchy_text/sketch/highlighter/high_lighter_text.dart';
import 'package:flutter_sketchy_text/sketch/rectangle/rectangle_text.dart';
import 'package:flutter_sketchy_text/sketch/strickthrough/strickthrough_text.dart';
import 'package:flutter_sketchy_text/sketch/underline/underline_text.dart';

class SketchyParagraph extends StatelessWidget {
  final String paragraph;
  final List<SketchySentance> highlights;

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

  Widget _buildAnimation(SketchySentance highlight) {
    switch (highlight.highlightType) {
      case SketchyType.highlight:
        return AnimatedHighlightedText(
          text: highlight.text,
          highlightColor: highlight.highlightColor,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          duration: highlight.duration,
          startDelay: highlight.startDelay,
        );
      case SketchyType.underline:
        return AnimatedUnderlineText(
          text: highlight.text,
          underlineColor: highlight.highlightColor,
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
          strikeColor: highlight.highlightColor,
          duration: highlight.duration,
          startDelay: highlight.startDelay,
        );
      case SketchyType.circle:
        return AnimatedCircleText(
          text: highlight.text,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          circleColor: highlight.highlightColor,
          duration: highlight.duration,
          startDelay: highlight.startDelay,
        );
      case SketchyType.rectangle:
        return AnimatedRectangleText(
          text: highlight.text,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          rectangleColor: highlight.highlightColor,
          duration: highlight.duration,
          startDelay: highlight.startDelay,
        );
    }
  }
}

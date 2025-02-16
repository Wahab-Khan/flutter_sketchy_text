import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';

/// **A `CustomPainter` that creates an animated highlight effect behind text.**
///
/// **Supports two modes:**
/// - **Organic Mode:** Wavy, hand-drawn highlight.
/// - **Plain Mode:** Straight, structured highlight.
///
/// This effect mimics the look of someone **marking text with a highlighter**.
///
/// ### **Example Usage:**
/// ```dart
/// CustomPaint(
///   painter: HighlighterPainter(
///     text: "Flutter",
///     textStyle: TextStyle(fontSize: 24, color: Colors.black),
///     highlightColor: Colors.yellow,
///     animationValue: 1.0,  // 100% completed highlight
///     animationMode: SketchyAnimationMode.organic, // or SketchyAnimationMode.plain
///     precomputedOffsets: List.generate(1000, (index) => Random().nextDouble()),
///   ),
///   child: Text("Flutter", style: TextStyle(fontSize: 24, color: Colors.black)),
/// )
/// ```
class HighlighterPainter extends CustomPainter {
  /// The text to be highlighted.
  final String text;

  /// The text style used for measuring dimensions.
  final TextStyle textStyle;

  /// The color of the animated highlight.
  final Color highlightColor;

  /// Controls the animation progress (0 to 1).
  final double animationValue;

  /// A list of random offsets to create an organic, hand-drawn effect.
  final List<double> precomputedOffsets;

  /// Determines whether the highlight should be **sketchy (organic)** or **straight (plain)**.
  final SketchyAnimationMode animationMode;

  /// Creates a `HighlighterPainter` to draw an animated highlight behind text.
  HighlighterPainter({
    required this.text,
    required this.textStyle,
    required this.highlightColor,
    required this.animationValue,
    required this.precomputedOffsets,
    this.animationMode = SketchyAnimationMode.organic, // Default to organic
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 10,
    );
    textPainter.layout(maxWidth: size.width);

    for (var line in textPainter.computeLineMetrics()) {
      final lineWidth = line.width + 6.0;
      final lineHeight = line.height;
      final lineTop = line.baseline - textStyle.fontSize! * 0.8;

      final path = Path();

      // **Plain Mode: Draw a clean, straight highlight**
      if (animationMode == SketchyAnimationMode.plain) {
        final highlightHeight = lineHeight * 0.85;
        path.addRect(
          Rect.fromLTWH(
            0,
            lineTop,
            lineWidth * animationValue,
            highlightHeight,
          ),
        );
      }
      // **Organic Mode: Wavy, hand-drawn highlight**
      else {
        // **Top wavy line**
        path.moveTo(0, lineTop);
        for (double x = 0; x <= lineWidth * animationValue; x += 10) {
          final y =
              lineTop +
              precomputedOffsets[(x ~/ 10) % precomputedOffsets.length];
          path.lineTo(x, y);
        }

        // **Bottom wavy line**
        for (double x = lineWidth * animationValue; x >= 0; x -= 10) {
          final y =
              lineTop +
              lineHeight * 0.8 +
              precomputedOffsets[(x ~/ 10) % precomputedOffsets.length];
          path.lineTo(x, y);
        }

        path.close();
      }

      canvas.drawPath(
        path,
        Paint()
          ..color = highlightColor
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

import 'package:flutter/material.dart';

/// A `CustomPainter` that creates an **animated, hand-drawn highlight effect** behind text.
///
/// This effect mimics the look of someone **marking text with a highlighter**
/// in a slightly wavy, natural manner.
///
/// The highlight **gradually appears from left to right**, creating a realistic animation effect.
///
/// ### **Usage:**
/// Used internally by `AnimatedHighlightedText` to render the highlight effect.
///
/// - **Customization:** Controlled via `animationValue`, `highlightColor`, and `precomputedOffsets`.
/// - **Performance:** Redraws only when `animationValue` changes.
///
/// ### **Example Usage:**
/// ```dart
/// CustomPaint(
///   painter: HighlighterPainter(
///     text: "Flutter",
///     textStyle: TextStyle(fontSize: 24, color: Colors.black),
///     highlightColor: Colors.yellow,
///     animationValue: 1.0,  // 100% completed highlight
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

  /// Creates a `HighlighterPainter` to draw an animated sketchy highlight behind text.
  HighlighterPainter({
    required this.text,
    required this.textStyle,
    required this.highlightColor,
    required this.animationValue,
    required this.precomputedOffsets,
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

      // Top wavy line (starts from the left)
      path.moveTo(0, lineTop);
      for (double x = 0; x <= lineWidth * animationValue; x += 10) {
        final y =
            lineTop + precomputedOffsets[(x ~/ 10) % precomputedOffsets.length];
        path.lineTo(x, y);
      }

      // Bottom wavy line (adds depth to the highlight effect)
      for (double x = lineWidth * animationValue; x >= 0; x -= 10) {
        final y =
            lineTop +
            lineHeight * 0.8 +
            precomputedOffsets[(x ~/ 10) % precomputedOffsets.length];
        path.lineTo(x, y);
      }

      path.close();
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

import 'package:flutter/material.dart';

/// A `CustomPainter` that creates an **animated, hand-drawn underline effect** under text.
///
/// This effect mimics a person **underlining text with a pen**, creating a wavy, natural line
/// that gradually appears below the word.
///
/// ### **Features:**
/// - **Realistic Hand-Drawn Look:** Uses randomized offsets for a human-like effect.
/// - **Animated Effect:** The underline **progressively appears** as the animation progresses.
/// - **Works with Any Text:** Automatically adjusts to text width and height.
///
/// ### **Usage:**
/// This painter is used internally by `AnimatedUnderlineText` to render the effect.
///
/// ### **Example Usage:**
/// ```dart
/// CustomPaint(
///   painter: UnderlinePainter(
///     text: "Flutter",
///     textStyle: TextStyle(fontSize: 24, color: Colors.black),
///     underlineColor: Colors.blue,
///     animationValue: 1.0,  // 100% completed underline
///     precomputedOffsets: List.generate(1000, (index) => Random().nextDouble()),
///   ),
///   child: Text("Flutter", style: TextStyle(fontSize: 24, color: Colors.black)),
/// )
/// ```
class UnderlinePainter extends CustomPainter {
  /// The text to be underlined.
  final String text;

  /// The text style used for measurement.
  final TextStyle textStyle;

  /// The color of the animated underline.
  final Color underlineColor;

  /// Controls the animation progress (0 to 1).
  final double animationValue;

  /// A list of random offsets to create an organic, hand-drawn effect.
  final List<double> precomputedOffsets;

  /// Creates an `UnderlinePainter` to draw an animated, wavy underline effect.
  UnderlinePainter({
    required this.text,
    required this.textStyle,
    required this.underlineColor,
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
      final lineWidth = line.width + 8.0;
      final lineTop = line.baseline + 3; // Position slightly below text

      final path = Path();
      path.moveTo(0, lineTop);

      // Draw the underline with wavy imperfections
      for (double x = 0; x <= lineWidth * animationValue; x += 8) {
        final y =
            lineTop + precomputedOffsets[(x ~/ 8) % precomputedOffsets.length];
        path.lineTo(x, y);
      }

      canvas.drawPath(
        path,
        Paint()
          ..color = underlineColor
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

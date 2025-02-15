import 'package:flutter/material.dart';

/// A `CustomPainter` that creates an **animated, hand-drawn strikethrough effect** over text.
///
/// This effect mimics a person **striking through text with a pen**, creating a natural,
/// wavy line that gradually extends across the word.
///
/// ### **Features:**
/// - **Realistic Hand-Drawn Look:** Uses randomized offsets for a **human-like** effect.
/// - **Animated Effect:** The strikethrough **progressively appears** as the animation progresses.
/// - **Works with Any Text:** Automatically adjusts to text width and height.
///
/// ### **Usage:**
/// This painter is used internally by `AnimatedStrikethroughText` to render the effect.
///
/// ### **Example Usage:**
/// ```dart
/// CustomPaint(
///   painter: StrikethroughPainter(
///     text: "Flutter",
///     textStyle: TextStyle(fontSize: 24, color: Colors.black),
///     strikeColor: Colors.red,
///     animationValue: 1.0,  // 100% completed strikethrough
///     precomputedOffsets: List.generate(1000, (index) => Random().nextDouble()),
///   ),
///   child: Text("Flutter", style: TextStyle(fontSize: 24, color: Colors.black)),
/// )
/// ```
class StrikethroughPainter extends CustomPainter {
  /// The text to be striked through.
  final String text;

  /// The text style used for measurement.
  final TextStyle textStyle;

  /// The color of the strikethrough animation.
  final Color strikeColor;

  /// Controls the animation progress (0 to 1).
  final double animationValue;

  /// A list of random offsets to create an organic, hand-drawn effect.
  final List<double> precomputedOffsets;

  /// Creates a `StrikethroughPainter` to draw an animated, wavy strikethrough line over text.
  StrikethroughPainter({
    required this.text,
    required this.textStyle,
    required this.strikeColor,
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
      final lineWidth = line.width;
      final strikeY = line.baseline - (line.height * 0.2); // Middle of the text

      final path = Path();
      path.moveTo(0, strikeY);

      // Draw the strikethrough line with wavy imperfections
      for (double x = 0; x <= lineWidth * animationValue; x += 8) {
        final y =
            strikeY + precomputedOffsets[(x ~/ 8) % precomputedOffsets.length];
        path.lineTo(x, y);
      }

      canvas.drawPath(
        path,
        Paint()
          ..color = strikeColor
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

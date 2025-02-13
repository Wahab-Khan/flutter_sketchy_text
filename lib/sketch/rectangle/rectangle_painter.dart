import 'package:flutter/material.dart';

/// A `CustomPainter` that creates an **animated, hand-drawn rectangle effect** around text.
///
/// This effect simulates a person **drawing a rectangle around text in a natural, sketchy manner**.
/// The rectangle **gradually appears**, starting from the top-left and moving **down, right, up, and left**.
///
/// ### **Features:**
/// - **Realistic Hand-Drawn Look:** Uses **randomized wavy offsets** for an organic feel.
/// - **Animated Effect:** The rectangle **draws progressively** as the animation progresses.
/// - **Works with Any Text:** Automatically adapts to text size and width.
///
/// ### **Usage:**
/// This painter is used internally by `AnimatedRectangleText` to apply the effect.
///
/// ### **Example Usage:**
/// ```dart
/// CustomPaint(
///   painter: RectanglePainter(
///     text: "Flutter",
///     textStyle: TextStyle(fontSize: 24, color: Colors.black),
///     rectangleColor: Colors.orange,
///     animationValue: 1.0,  // 100% completed rectangle
///     precomputedOffsets: List.generate(1000, (index) => Random().nextDouble()),
///   ),
///   child: Text("Flutter", style: TextStyle(fontSize: 24, color: Colors.black)),
/// )
/// ```
class RectanglePainter extends CustomPainter {
  /// The text to be enclosed in a rectangle.
  final String text;

  /// The text style used for measurement.
  final TextStyle textStyle;

  /// The color of the animated rectangle.
  final Color rectangleColor;

  /// Controls the animation progress (0 to 1).
  final double animationValue;

  /// A list of random offsets to create an organic, hand-drawn effect.
  final List<double> precomputedOffsets;

  /// Creates a `RectanglePainter` to draw an animated sketchy rectangle around text.
  RectanglePainter({
    required this.text,
    required this.textStyle,
    required this.rectangleColor,
    required this.animationValue,
    required this.precomputedOffsets,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout(maxWidth: size.width);

    final wordWidth =
        textPainter.width + 6.0; // Extra padding for full coverage
    final wordHeight = textPainter.height;
    final offsetX = -1.0;
    final offsetY = 1.0;

    final path = Path();
    final totalLength = (wordWidth + wordHeight) * 2;
    final progressLength = totalLength * animationValue;

    // Define rectangle segments
    final downLength = wordHeight;
    final rightLength = wordWidth;
    final upLength = wordHeight;
    final leftLength = wordWidth;

    double drawnLength = 0;

    // Start at the top-left
    path.moveTo(offsetX, offsetY);

    // Draw Down
    if (drawnLength < progressLength) {
      final remaining = progressLength - drawnLength;
      for (double y = 0; y <= downLength && y <= remaining; y += 6) {
        final x =
            offsetX + precomputedOffsets[(y ~/ 6) % precomputedOffsets.length];
        path.lineTo(x, offsetY + y);
      }
      drawnLength += downLength;
    }

    // Draw Right
    if (drawnLength < progressLength) {
      final remaining = progressLength - drawnLength;
      for (double x = 0; x <= rightLength && x <= remaining; x += 6) {
        final y = offsetY +
            downLength +
            precomputedOffsets[(x ~/ 6) % precomputedOffsets.length];
        path.lineTo(offsetX + x, y);
      }
      drawnLength += rightLength;
    }

    // Draw Up
    if (drawnLength < progressLength) {
      final remaining = progressLength - drawnLength;
      for (double y = 0; y <= upLength && y <= remaining; y += 6) {
        final x = offsetX +
            rightLength +
            precomputedOffsets[(y ~/ 6) % precomputedOffsets.length];
        path.lineTo(x, offsetY + downLength - y);
      }
      drawnLength += upLength;
    }

    // Draw Left (closing the shape)
    if (drawnLength < progressLength) {
      final remaining = progressLength - drawnLength;
      for (double x = 0; x <= leftLength && x <= remaining; x += 6) {
        final y =
            offsetY + precomputedOffsets[(x ~/ 6) % precomputedOffsets.length];
        path.lineTo(offsetX + rightLength - x, y);
      }
    }

    canvas.drawPath(path, _paint());
  }

  /// Defines the paint style for the rectangle stroke.
  Paint _paint() {
    return Paint()
      ..color = rectangleColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

import 'dart:math';
import 'package:flutter/material.dart';

/// A `CustomPainter` that creates an **animated hand-drawn circle effect** around the text.
///
/// This effect mimics an organic, human-like **sketchy** drawing that progressively
/// circles the word with **three rounds**, giving it a lively animation.
///
/// The effect starts at the right of the text and completes **three revolutions**
/// to create a natural drawing motion.
///
/// ### **Usage:**
/// Used internally by `AnimatedCircleText` to apply the animation effect.
///
/// - **Customization:** Controlled via `animationValue`, `circleColor`, and `precomputedOffsets`.
/// - **Performance:** Redraws only when `animationValue` changes.
///
/// ### **Example Usage:**
/// ```dart
/// CustomPaint(
///   painter: CirclePainter(
///     text: "Flutter",
///     textStyle: TextStyle(fontSize: 24, color: Colors.black),
///     circleColor: Colors.blue,
///     animationValue: 1.0,  // 100% completed animation
///     precomputedOffsets: List.generate(1000, (index) => Random().nextDouble()),
///   ),
///   child: Text("Flutter", style: TextStyle(fontSize: 24, color: Colors.black)),
/// )
/// ```
class CirclePainter extends CustomPainter {
  /// The text to be circled.
  final String text;

  /// The text style used for measuring dimensions.
  final TextStyle textStyle;

  /// The color of the animated circle.
  final Color circleColor;

  /// Controls the animation progress (0 to 3 full circles).
  final double animationValue;

  /// A list of random offsets to create an organic, hand-drawn effect.
  final List<double> precomputedOffsets;

  /// Creates a `CirclePainter` to draw an animated sketchy circle around text.
  CirclePainter({
    required this.text,
    required this.textStyle,
    required this.circleColor,
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

    final wordWidth = textPainter.width;
    final wordHeight = textPainter.height;
    final centerX = wordWidth / 2;
    final centerY = wordHeight / 2;

    final path = Path();
    final stretchX = wordWidth * 0.55; // Adjust horizontal stretching
    final stretchY = wordHeight * 0.55; // Adjust vertical stretching

    for (int i = 0; i < 3; i++) {
      final currentProgress = (animationValue - i).clamp(0.0, 1.0);
      if (currentProgress > 0) {
        path.moveTo(centerX + stretchX, centerY);

        for (double angle = 0;
            angle <= 2 * pi * currentProgress;
            angle += 0.1) {
          final x = centerX +
              stretchX * cos(angle) +
              precomputedOffsets[
                      (angle * 10).toInt() % precomputedOffsets.length] *
                  0.5;
          final y = centerY +
              stretchY * sin(angle) +
              precomputedOffsets[
                      (angle * 10).toInt() % precomputedOffsets.length] *
                  0.5;
          path.lineTo(x, y);
        }
      }
    }

    final paint = Paint()
      ..color = circleColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

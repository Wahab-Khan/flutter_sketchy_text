import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';

/// A `CustomPainter` that creates an **animated circle effect** around text.
///
/// **Supports two modes:**
/// - **Organic Mode:** Wavy, hand-drawn look.
/// - **Plain Mode:** Smooth, structured ellipse.
///
/// The animation starts at the right side and progressively **completes three full circles**.
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
///     animationMode: SketchyAnimationMode.organic, // or SketchyAnimationMode.plain
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

  /// A list of random offsets for Organic Mode.
  final List<double> precomputedOffsets;

  /// Determines whether the circle is **sketchy** or **plain**.
  final SketchyAnimationMode animationMode;

  /// Creates a `CirclePainter` to draw an animated sketchy or smooth circle.
  CirclePainter({
    required this.text,
    required this.textStyle,
    required this.circleColor,
    required this.animationValue,
    required this.precomputedOffsets,
    this.animationMode = SketchyAnimationMode.organic,
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
    final stretchX = wordWidth * 0.55;
    final stretchY = wordHeight * 0.55;

    for (int i = 0; i < 3; i++) {
      final currentProgress = (animationValue - i).clamp(0.0, 1.0);
      if (currentProgress > 0) {
        path.moveTo(centerX + stretchX, centerY);

        for (
          double angle = 0;
          angle <= 2 * pi * currentProgress;
          angle += 0.1
        ) {
          final randomOffset =
              (animationMode == SketchyAnimationMode.organic)
                  ? precomputedOffsets[(angle * 10).toInt() %
                          precomputedOffsets.length] *
                      0.5
                  : 0; // No randomness in Plain Mode

          final x = centerX + stretchX * cos(angle) + randomOffset;
          final y = centerY + stretchY * sin(angle) + randomOffset;

          path.lineTo(x, y);
        }
      }
    }

    final paint =
        Paint()
          ..color = circleColor
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

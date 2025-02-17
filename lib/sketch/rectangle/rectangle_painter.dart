import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';

/// A `CustomPainter` that creates an **animated rectangle effect** around text.
///
/// **Supports two modes:**
/// - **Organic Mode:** Wavy, hand-drawn effect.
/// - **Plain Mode:** Smooth, structured rectangle.
///
/// ### **Example Usage:**
/// ```dart
/// CustomPaint(
///   painter: RectanglePainter(
///     text: "Flutter",
///     textStyle: TextStyle(fontSize: 24, color: Colors.black),
///     rectangleColor: Colors.orange,
///     animationValue: 1.0,  // 100% completed animation
///     precomputedOffsets: List.generate(1000, (index) => Random().nextDouble()),
///     animationMode: SketchyAnimationMode.organic, // or SketchyAnimationMode.plain
///   ),
///   child: Text("Flutter", style: TextStyle(fontSize: 24, color: Colors.black)),
/// )
/// ```
class RectanglePainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color rectangleColor;
  final double animationValue;
  final List<double> precomputedOffsets;
  final SketchyAnimationMode animationMode;

  RectanglePainter({
    required this.text,
    required this.textStyle,
    required this.rectangleColor,
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

    final wordWidth = textPainter.width + 6.0;
    final wordHeight = textPainter.height;
    final offsetX = -1.0;
    final offsetY = 1.0;

    final path = Path();
    final totalLength = (wordWidth + wordHeight) * 2;
    final progressLength = totalLength * animationValue;

    double drawnLength = 0;

    /// **Helper function to get the offset:**
    /// - **Organic Mode:** Adds small random offsets.
    /// - **Plain Mode:** Returns 0 (perfect straight lines).
    double getOffset(double value) =>
        animationMode == SketchyAnimationMode.organic
            ? precomputedOffsets[(value ~/ 6) % precomputedOffsets.length]
            : 0; // Plain mode removes randomization

    // **Start at the top-left**
    path.moveTo(offsetX, offsetY);

    // **Draw Down**
    if (drawnLength < progressLength) {
      final remaining = progressLength - drawnLength;
      for (double y = 0; y <= wordHeight && y <= remaining; y += 6) {
        final x =
            animationMode == SketchyAnimationMode.organic
                ? offsetX + getOffset(y)
                : offsetX; // **Plain Mode keeps x constant**
        path.lineTo(x, offsetY + y);
      }
      drawnLength += wordHeight;
    }

    // **Draw Right**
    if (drawnLength < progressLength) {
      final remaining = progressLength - drawnLength;
      for (double x = 0; x <= wordWidth && x <= remaining; x += 6) {
        final y =
            animationMode == SketchyAnimationMode.organic
                ? offsetY + wordHeight + getOffset(x)
                : offsetY + wordHeight; // **Plain Mode keeps y constant**
        path.lineTo(offsetX + x, y);
      }
      drawnLength += wordWidth;
    }

    // **Draw Up**
    if (drawnLength < progressLength) {
      final remaining = progressLength - drawnLength;
      for (double y = 0; y <= wordHeight && y <= remaining; y += 6) {
        final x =
            animationMode == SketchyAnimationMode.organic
                ? offsetX + wordWidth + getOffset(y)
                : offsetX + wordWidth; // **Plain Mode keeps x constant**
        path.lineTo(x, offsetY + wordHeight - y);
      }
      drawnLength += wordHeight;
    }

    // **Draw Left (closing the shape)**
    if (drawnLength < progressLength) {
      final remaining = progressLength - drawnLength;
      for (double x = 0; x <= wordWidth && x <= remaining; x += 6) {
        final y =
            animationMode == SketchyAnimationMode.organic
                ? offsetY + getOffset(x)
                : offsetY; // **Plain Mode keeps y constant**
        path.lineTo(offsetX + wordWidth - x, y);
      }
    }

    // **Draw the rectangle**
    canvas.drawPath(path, _paint());
  }

  /// **Defines the paint style for the rectangle stroke.**
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

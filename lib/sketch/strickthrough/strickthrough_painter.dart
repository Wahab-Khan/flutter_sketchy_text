import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';

/// A `CustomPainter` that creates an **animated, hand-drawn strikethrough effect** over text.
///
/// **Supports two modes:**
/// - **Organic Mode:** Wavy, hand-drawn strikethrough.
/// - **Plain Mode:** Smooth, straight line.
class StrikethroughPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color strikeColor;
  final double animationValue;
  final List<double> precomputedOffsets;
  final SketchyAnimationMode animationMode; // New Mode

  StrikethroughPainter({
    required this.text,
    required this.textStyle,
    required this.strikeColor,
    required this.animationValue,
    required this.precomputedOffsets,
    required this.animationMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout(maxWidth: size.width);

    for (var line in textPainter.computeLineMetrics()) {
      final lineWidth = line.width;
      final strikeY = line.baseline - (line.height * 0.2);

      final path = Path();
      path.moveTo(0, strikeY);

      if (animationMode == SketchyAnimationMode.plain) {
        // **PLAIN MODE: Perfectly straight line**
        path.lineTo(lineWidth * animationValue, strikeY);
      } else {
        // **ORGANIC MODE: Wavy effect**
        for (double x = 0; x <= lineWidth * animationValue; x += 8) {
          final y =
              strikeY +
              precomputedOffsets[(x ~/ 8) % precomputedOffsets.length];
          path.lineTo(x, y);
        }
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

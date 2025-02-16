import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';

/// A `CustomPainter` that creates an **animated, hand-drawn underline effect** under text.
///
/// **Supports two modes:**
/// - **Organic Mode:** Wavy, hand-drawn underline.
/// - **Plain Mode:** Straight underline.
class UnderlinePainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color underlineColor;
  final double animationValue;
  final List<double> precomputedOffsets;
  final SketchyAnimationMode animationMode; // New Mode

  UnderlinePainter({
    required this.text,
    required this.textStyle,
    required this.underlineColor,
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
      final lineWidth = line.width + 8.0;
      final lineTop = line.baseline + 3;

      final path = Path();
      path.moveTo(0, lineTop);

      if (animationMode == SketchyAnimationMode.plain) {
        // **PLAIN MODE: Perfectly straight underline**
        path.lineTo(lineWidth * animationValue, lineTop);
      } else {
        // **ORGANIC MODE: Wavy underline**
        for (double x = 0; x <= lineWidth * animationValue; x += 8) {
          final y =
              lineTop +
              precomputedOffsets[(x ~/ 8) % precomputedOffsets.length];
          path.lineTo(x, y);
        }
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

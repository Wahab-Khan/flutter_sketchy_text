import 'package:flutter/material.dart';

class HighlighterPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color highlightColor;
  final double animationValue;
  final List<double> precomputedOffsets;

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
      final lineWidth = line.width;
      final lineHeight = line.height;
      final lineTop = line.baseline - textStyle.fontSize! * 0.8;

      final path = Path();

      // Top wavy line
      path.moveTo(0, lineTop);
      for (double x = 0; x <= lineWidth * animationValue; x += 10) {
        final y =
            lineTop + precomputedOffsets[(x ~/ 10) % precomputedOffsets.length];
        path.lineTo(x, y);
      }

      // Bottom wavy line
      for (double x = lineWidth * animationValue; x >= 0; x -= 10) {
        final y = lineTop +
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

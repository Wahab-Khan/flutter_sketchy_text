import 'package:flutter/material.dart';

class UnderlinePainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color underlineColor;
  final double animationValue;
  final List<double> precomputedOffsets;

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
      final lineWidth = line.width;
      final lineTop = line.baseline + 3; // Position slightly below text

      final path = Path();
      path.moveTo(0, lineTop);

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

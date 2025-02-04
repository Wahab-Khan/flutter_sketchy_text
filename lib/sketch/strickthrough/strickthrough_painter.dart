import 'package:flutter/material.dart';

class StrikethroughPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color strikeColor;
  final double animationValue;
  final List<double> precomputedOffsets;

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

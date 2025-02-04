import 'dart:math';

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color circleColor;
  final double animationValue;
  final List<double> precomputedOffsets;

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
    final stretchX = wordWidth * 0.6; // Make the circle stretch with text width
    final stretchY = wordHeight * 0.5;

    for (int i = 0; i < 3; i++) {
      // Create 3 progressively larger circles
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

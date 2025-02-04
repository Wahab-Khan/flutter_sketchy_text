import 'package:flutter/material.dart';

class RectanglePainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color rectangleColor;
  final double animationValue;
  final List<double> precomputedOffsets;

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

    final wordWidth = textPainter.width;
    final wordHeight = textPainter.height;
    final offsetX = 4.0;
    final offsetY = 1.0;

    final path = Path();
    final totalLength = (wordWidth + wordHeight) * 2;
    final progressLength = totalLength * animationValue;

    // Define segments
    final downLength = wordHeight;
    final rightLength = wordWidth;
    final upLength = wordHeight;
    final leftLength = wordWidth;

    double drawnLength = 0;

    // Start at the top-left
    path.moveTo(offsetX, offsetY);

    // DRAW DOWN
    if (drawnLength < progressLength) {
      final remaining = progressLength - drawnLength;
      for (double y = 0; y <= downLength && y <= remaining; y += 6) {
        final x =
            offsetX + precomputedOffsets[(y ~/ 6) % precomputedOffsets.length];
        path.lineTo(x, offsetY + y);
      }
      drawnLength += downLength;
    }

    // DRAW RIGHT
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

    // DRAW UP
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

    // DRAW LEFT (closing the shape)
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

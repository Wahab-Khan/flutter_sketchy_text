import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/sketch/rectangle/rectangle_painter.dart';

class AnimatedRectangleText extends StatefulWidget {
  final String text;
  final Color rectangleColor;
  final TextStyle textStyle;
  final Duration duration;
  final Duration startDelay;

  const AnimatedRectangleText({
    super.key,
    required this.text,
    required this.rectangleColor,
    required this.textStyle,
    this.duration = const Duration(seconds: 2),
    this.startDelay = Duration.zero,
  });

  @override
  _AnimatedRectangleTextState createState() => _AnimatedRectangleTextState();
}

class _AnimatedRectangleTextState extends State<AnimatedRectangleText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<double> _precomputedOffsets;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0, end: 1) // Draws progressively
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Generate precomputed offsets for a wavy, hand-drawn look
    _precomputedOffsets = List.generate(
      1000,
      (index) => Random()
          .nextDouble(), // More randomness for an organic feel Random().nextDouble() * 6 - 3
    );

    // Start animation with delay if needed
    if (widget.startDelay > Duration.zero) {
      Future.delayed(widget.startDelay, () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: RectanglePainter(
            text: widget.text,
            textStyle: widget.textStyle,
            rectangleColor: widget.rectangleColor,
            animationValue: _animation.value,
            precomputedOffsets: _precomputedOffsets,
          ),
          child: Text(
            widget.text,
            style: widget.textStyle,
          ),
        );
      },
    );
  }
}

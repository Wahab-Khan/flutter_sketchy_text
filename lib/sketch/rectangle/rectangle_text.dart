import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';
import 'package:flutter_sketchy_text/sketch/rectangle/rectangle_painter.dart';

/// A widget that **animates a rectangle effect** around text.
///
/// **Supports two modes:**
/// - **Organic Mode:** Wavy, hand-drawn effect.
/// - **Plain Mode:** Smooth, structured animation.
///
/// ### **Example Usage:**
/// ```dart
/// AnimatedRectangleText(
///   text: "Flutter is cool!",
///   rectangleColor: Colors.orange,
///   textStyle: TextStyle(fontSize: 24, color: Colors.black),
///   duration: Duration(seconds: 2),
///   startDelay: Duration(seconds: 1),
///   animationMode: SketchyAnimationMode.organic, // or SketchyAnimationMode.plain
/// )
/// ```
class AnimatedRectangleText extends StatefulWidget {
  final String text;
  final Color rectangleColor;
  final TextStyle textStyle;
  final Duration duration;
  final Duration startDelay;
  final SketchyAnimationMode animationMode;

  const AnimatedRectangleText({
    super.key,
    required this.text,
    required this.rectangleColor,
    required this.textStyle,
    this.duration = const Duration(seconds: 2),
    this.startDelay = Duration.zero,
    this.animationMode = SketchyAnimationMode.organic,
  });

  @override
  State<AnimatedRectangleText> createState() => _AnimatedRectangleTextState();
}

class _AnimatedRectangleTextState extends State<AnimatedRectangleText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<double> _precomputedOffsets;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Precompute offsets for Organic Mode (random waviness)
    _precomputedOffsets =
        widget.animationMode == SketchyAnimationMode.organic
            ? List.generate(1000, (index) => Random().nextDouble() * 3 - 1)
            : List.filled(1000, 0); // Plain Mode has no randomness

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
            animationMode: widget.animationMode,
          ),
          child: Text(widget.text, style: widget.textStyle),
        );
      },
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';
import 'package:flutter_sketchy_text/sketch/circule/circule_painter.dart';

/// A widget that **animates a circle effect** around text.
///
/// **Supports two modes:**
/// - **Organic Mode:** Wavy, hand-drawn effect.
/// - **Plain Mode:** Smooth, structured animation.
///
/// ### **Features:**
/// - **Configurable Mode:** Choose `plain` or `organic` animation.
/// - **Realistic Hand-Drawn Effect:** In `organic` mode, the animation has **human-like** imperfections.
/// - **Smooth Motion:** In `plain` mode, the circle is drawn **precisely**.
///
/// ### **Example Usage:**
/// ```dart
/// AnimatedCircleText(
///   text: "Flutter",
///   circleColor: Colors.red,
///   textStyle: TextStyle(fontSize: 24, color: Colors.black),
///   duration: Duration(seconds: 2),
///   startDelay: Duration(seconds: 1),
///   animationMode: SketchyAnimationMode.organic, // or SketchyAnimationMode.plain
/// )
/// ```
class AnimatedCircleText extends StatefulWidget {
  /// The text that will be circled.
  final String text;

  /// The color of the animated circle.
  final Color circleColor;

  /// The style of the text inside the circle.
  final TextStyle textStyle;

  /// The total duration of the animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration startDelay;

  /// **Defines whether the animation is `plain` or `organic`.**
  final SketchyAnimationMode animationMode;

  /// Creates an animated sketchy or structured circle effect.
  const AnimatedCircleText({
    super.key,
    required this.text,
    required this.circleColor,
    required this.textStyle,
    this.duration = const Duration(seconds: 2),
    this.startDelay = Duration.zero,
    this.animationMode = SketchyAnimationMode.organic,
  });

  @override
  State<AnimatedCircleText> createState() => _AnimatedCircleTextState();
}

class _AnimatedCircleTextState extends State<AnimatedCircleText>
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

    // Generate random offsets for Organic Mode
    _precomputedOffsets = List.generate(
      1000,
      (index) => Random().nextDouble() * 3 - 1,
    );

    // Start animation with optional delay
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
          painter: CirclePainter(
            text: widget.text,
            textStyle: widget.textStyle,
            circleColor: widget.circleColor,
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

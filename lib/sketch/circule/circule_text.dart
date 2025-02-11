import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/sketch/circule/circule_painter.dart';

/// A widget that **animates a sketchy circle effect** around a word or phrase.
///
/// This widget progressively draws a **hand-drawn, organic circle** around the given text.
/// It completes **three full rounds** before finishing the animation.
///
/// ### **Features:**
/// - **Customizable Animation:** Control speed, delay, and color.
/// - **Realistic Sketchy Look:** Uses random offsets for human-like imperfections.
/// - **Integrates with Other Effects:** Works alongside highlight, underline, strikethrough, etc.
///
/// ### **Example Usage:**
/// ```dart
/// AnimatedCircleText(
///   text: "Flutter",
///   circleColor: Colors.red,
///   textStyle: TextStyle(fontSize: 24, color: Colors.black),
///   duration: Duration(seconds: 2),
///   startDelay: Duration(seconds: 1),
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

  /// Creates an animated sketchy circle effect around text.
  const AnimatedCircleText({
    super.key,
    required this.text,
    required this.circleColor,
    required this.textStyle,
    this.duration = const Duration(seconds: 4),
    this.startDelay = Duration.zero,
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

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // The animation progresses through 3 full circles
    _animation = Tween<double>(begin: 0, end: 3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Generate random offsets to simulate hand-drawn movement
    _precomputedOffsets =
        List.generate(1000, (index) => Random().nextDouble() * 3 - 1);

    // Start animation after delay if needed
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

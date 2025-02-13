import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/sketch/rectangle/rectangle_painter.dart';

/// A widget that **animates a sketchy rectangle effect** around a word or phrase.
///
/// This widget progressively draws a **hand-drawn, wavy rectangle** around the text,
/// simulating a **person manually sketching a box** over the word.
///
/// ### **Features:**
/// - **Customizable Animation:** Control speed, delay, and color.
/// - **Realistic Sketchy Look:** Uses random offsets for human-like imperfections.
/// - **Integrates with Other Effects:** Works alongside highlight, underline, strikethrough, etc.
///
/// ### **Example Usage:**
/// ```dart
/// AnimatedRectangleText(
///   text: "Flutter is cool!",
///   rectangleColor: Colors.orange,
///   textStyle: TextStyle(fontSize: 24, color: Colors.black),
///   duration: Duration(seconds: 2),
///   startDelay: Duration(seconds: 1),
/// )
/// ```
class AnimatedRectangleText extends StatefulWidget {
  /// The text that will be enclosed in a rectangle.
  final String text;

  /// The color of the animated rectangle.
  final Color rectangleColor;

  /// The style of the text inside the rectangle.
  final TextStyle textStyle;

  /// The total duration of the animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration startDelay;

  /// Creates an animated sketchy rectangle effect around text.
  const AnimatedRectangleText({
    super.key,
    required this.text,
    required this.rectangleColor,
    required this.textStyle,
    this.duration = const Duration(seconds: 2),
    this.startDelay = Duration.zero,
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

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Generate random offsets for a sketchy effect
    _precomputedOffsets =
        List.generate(1000, (index) => Random().nextDouble() * 2 - 0.8);

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

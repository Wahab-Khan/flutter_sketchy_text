import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/sketch/strickthrough/strickthrough_painter.dart';

/// A widget that **animates a sketchy strikethrough effect** over a word or phrase.
///
/// This widget progressively **draws a wavy, hand-drawn strikethrough** over the text,
/// simulating a **person manually crossing out a word** with a pen.
///
/// ### **Features:**
/// - **Customizable Animation:** Control speed, delay, and color.
/// - **Realistic Sketchy Look:** Uses random offsets for **human-like imperfections**.
/// - **Integrates with Other Effects:** Works alongside highlight, underline, rectangle, etc.
///
/// ### **Example Usage:**
/// ```dart
/// AnimatedStrikethroughText(
///   text: "Outdated!",
///   strikeColor: Colors.red,
///   textStyle: TextStyle(fontSize: 24, color: Colors.black),
///   duration: Duration(seconds: 2),
///   startDelay: Duration(seconds: 1),
/// )
/// ```
class AnimatedStrikethroughText extends StatefulWidget {
  /// The text that will be striked through.
  final String text;

  /// The color of the animated strikethrough.
  final Color strikeColor;

  /// The style of the text inside the strikethrough.
  final TextStyle textStyle;

  /// The total duration of the animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration startDelay;

  /// Creates an animated sketchy strikethrough effect over text.
  const AnimatedStrikethroughText({
    super.key,
    required this.text,
    required this.strikeColor,
    required this.textStyle,
    this.duration = const Duration(seconds: 2),
    this.startDelay = Duration.zero,
  });

  @override
  State<AnimatedStrikethroughText> createState() =>
      _AnimatedStrikethroughTextState();
}

class _AnimatedStrikethroughTextState extends State<AnimatedStrikethroughText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<double> _precomputedOffsets;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Generate precomputed offsets to create a natural wavy strike effect
    _precomputedOffsets = List.generate(
      1000,
      (index) =>
          Random().nextDouble() * 3.5 -
          1.5, // Small variation for a human-like effect
    );

    // Start the animation after a delay if provided
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
          painter: StrikethroughPainter(
            text: widget.text,
            textStyle: widget.textStyle,
            strikeColor: widget.strikeColor,
            animationValue: _animation.value,
            precomputedOffsets: _precomputedOffsets,
          ),
          child: Text(widget.text, style: widget.textStyle),
        );
      },
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/sketch/underline/underline_painter.dart';

/// A widget that **animates a sketchy underline effect** under a word or phrase.
///
/// This widget progressively **draws a wavy, hand-drawn underline** below the text,
/// simulating a **person manually underlining a word** with a pen.
///
/// ### **Features:**
/// - **Customizable Animation:** Control speed, delay, and color.
/// - **Realistic Sketchy Look:** Uses random offsets for **human-like imperfections**.
/// - **Integrates with Other Effects:** Works alongside highlight, strikethrough, rectangle, etc.
///
/// ### **Example Usage:**
/// ```dart
/// AnimatedUnderlineText(
///   text: "Important!",
///   underlineColor: Colors.blue,
///   textStyle: TextStyle(fontSize: 24, color: Colors.black),
///   duration: Duration(seconds: 2),
///   startDelay: Duration(seconds: 1),
/// )
/// ```
class AnimatedUnderlineText extends StatefulWidget {
  /// The text that will be underlined.
  final String text;

  /// The color of the animated underline.
  final Color underlineColor;

  /// The style of the text inside the underline.
  final TextStyle textStyle;

  /// The total duration of the animation.
  final Duration duration;

  /// The delay before the animation starts.
  final Duration startDelay;

  /// Creates an animated sketchy underline effect under text.
  const AnimatedUnderlineText({
    super.key,
    required this.text,
    required this.underlineColor,
    required this.textStyle,
    this.duration = const Duration(milliseconds: 500),
    this.startDelay = Duration.zero,
  });

  @override
  State<AnimatedUnderlineText> createState() => _AnimatedUnderlineTextState();
}

class _AnimatedUnderlineTextState extends State<AnimatedUnderlineText>
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

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Generate precomputed offsets to create a natural wavy underline
    _precomputedOffsets = List.generate(
      1000,
      (index) =>
          Random().nextDouble() * 3 - 1, // Smaller variation than highlight
    );

    // Delay the animation start if required
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
          painter: UnderlinePainter(
            text: widget.text,
            textStyle: widget.textStyle,
            underlineColor: widget.underlineColor,
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

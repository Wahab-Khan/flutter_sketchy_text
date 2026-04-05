import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';
import 'package:flutter_sketchy_text/sketch/highlighter/highlighter_painter.dart';

/// A widget that animates a **hand-drawn, sketchy highlight effect** behind the text.
///
/// Supports two animation modes:
/// - **Organic Mode:** Random wavy lines for a natural, hand-drawn effect.
/// - **Plain Mode:** Smooth, straight highlighting for a more structured look.
///
/// ### **Example Usage:**
/// ```dart
/// AnimatedHighlightedText(
///   text: "Flutter is amazing!",
///   highlightColor: Colors.yellow.withOpacity(0.4),
///   textStyle: TextStyle(fontSize: 24, color: Colors.black),
///   animationMode: SketchyAnimationMode.organic, // or SketchyAnimationMode.plain
///   duration: Duration(seconds: 2),
///   startDelay: Duration(milliseconds: 500),
/// )
/// ```
class AnimatedHighlightedText extends StatefulWidget {
  /// The text that will be highlighted.
  final String text;

  /// The color of the highlight effect.
  final Color highlightColor;

  /// The text style used to render the text.
  final TextStyle textStyle;

  /// The total duration of the highlight animation.
  final Duration duration;

  /// The delay before the highlight animation starts.
  final Duration startDelay;

  /// **Determines whether the highlight is sketchy (Organic) or straight (Plain).**
  final SketchyAnimationMode animationMode;

  final bool isAnimated;

  /// Creates an animated sketchy highlight effect for text.
  const AnimatedHighlightedText({
    super.key,
    required this.text,
    required this.highlightColor,
    required this.textStyle,
    this.animationMode = SketchyAnimationMode.organic, // Default to organic
    this.duration = const Duration(milliseconds: 2000),
    this.startDelay = Duration.zero,
    this.isAnimated = true,
  });

  @override
  State<AnimatedHighlightedText> createState() =>
      _AnimatedHighlightedTextState();
}

class _AnimatedHighlightedTextState extends State<AnimatedHighlightedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController with the provided duration
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Define the animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    if (!widget.isAnimated) {
      _controller.value = 1.0;
      return;
    }

    // Start the animation after the given delay
    if (widget.startDelay > Duration.zero) {
      Future.delayed(widget.startDelay, () {
        if (mounted) {
          _controller.forward();
        }
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
          painter: HighlighterPainter(
            text: widget.text,
            textStyle: widget.textStyle,
            highlightColor: widget.highlightColor,
            animationValue: _animation.value,
            animationMode: widget.animationMode,
          ),
          child: Text(widget.text, style: widget.textStyle),
        );
      },
    );
  }
}

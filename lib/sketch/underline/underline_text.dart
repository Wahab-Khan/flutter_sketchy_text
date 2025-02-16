import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';
import 'package:flutter_sketchy_text/sketch/underline/underline_painter.dart';

/// A widget that **animates a sketchy underline effect** under text.
///
/// **Supports two modes:**
/// - **Organic Mode:** Wavy, hand-drawn underline.
/// - **Plain Mode:** Straight underline.
///
/// ### **Example Usage:**
/// ```dart
/// AnimatedUnderlineText(
///   text: "Important!",
///   underlineColor: Colors.blue,
///   textStyle: TextStyle(fontSize: 24, color: Colors.black),
///   duration: Duration(seconds: 2),
///   startDelay: Duration(seconds: 1),
///   animationMode: SketchyAnimationMode.organic, // or SketchyAnimationMode.plain
/// )
/// ```
class AnimatedUnderlineText extends StatefulWidget {
  final String text;
  final Color underlineColor;
  final TextStyle textStyle;
  final Duration duration;
  final Duration startDelay;
  final SketchyAnimationMode animationMode; // New Mode for Plain/Organic

  const AnimatedUnderlineText({
    super.key,
    required this.text,
    required this.underlineColor,
    required this.textStyle,
    this.duration = const Duration(milliseconds: 500),
    this.startDelay = Duration.zero,
    this.animationMode = SketchyAnimationMode.organic, // Default to Organic
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

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _precomputedOffsets = List.generate(
      1000,
      (index) =>
          widget.animationMode == SketchyAnimationMode.organic
              ? Random().nextDouble() * 3 -
                  1 // Wavy Effect
              : 0, // Plain Mode: No Offsets
    );

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
            animationMode: widget.animationMode,
          ),
          child: Text(widget.text, style: widget.textStyle),
        );
      },
    );
  }
}

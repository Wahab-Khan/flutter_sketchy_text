import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';
import 'package:flutter_sketchy_text/sketch/strickthrough/strickthrough_painter.dart';

/// A widget that **animates a sketchy strikethrough effect** over text.
///
/// **Supports two modes:**
/// - **Organic Mode:** Wavy, hand-drawn strikethrough.
/// - **Plain Mode:** Smooth, straight line.
///
/// ### **Example Usage:**
/// ```dart
/// AnimatedStrikethroughText(
///   text: "Outdated!",
///   strikeColor: Colors.red,
///   textStyle: TextStyle(fontSize: 24, color: Colors.black),
///   duration: Duration(seconds: 2),
///   startDelay: Duration(seconds: 1),
///   animationMode: SketchyAnimationMode.organic, // or SketchyAnimationMode.plain
/// )
/// ```
class AnimatedStrikethroughText extends StatefulWidget {
  final String text;
  final Color strikeColor;
  final TextStyle textStyle;
  final Duration duration;
  final Duration startDelay;
  final SketchyAnimationMode animationMode; // New Mode for Plain/Organic

  const AnimatedStrikethroughText({
    super.key,
    required this.text,
    required this.strikeColor,
    required this.textStyle,
    this.duration = const Duration(seconds: 2),
    this.startDelay = Duration.zero,
    this.animationMode = SketchyAnimationMode.organic, // Default to Organic
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

    _precomputedOffsets = List.generate(
      1000,
      (index) =>
          widget.animationMode == SketchyAnimationMode.organic
              ? Random().nextDouble() * 3.5 -
                  1.5 // Wavy Effect
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
          painter: StrikethroughPainter(
            text: widget.text,
            textStyle: widget.textStyle,
            strikeColor: widget.strikeColor,
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

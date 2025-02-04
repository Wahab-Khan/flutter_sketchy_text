import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/sketch/highlighter/highlighter_Painter.dart';

class AnimatedHighlightedText extends StatefulWidget {
  final String text;
  final Color highlightColor;
  final TextStyle textStyle;
  final Duration duration; // Animation duration
  final Duration startDelay; // Delay before animation starts

  const AnimatedHighlightedText({
    super.key,
    required this.text,
    required this.highlightColor,
    required this.textStyle,
    this.duration = const Duration(seconds: 2),
    this.startDelay = Duration.zero,
  });

  @override
  _AnimatedHighlightedTextState createState() =>
      _AnimatedHighlightedTextState();
}

class _AnimatedHighlightedTextState extends State<AnimatedHighlightedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<double> _precomputedOffsets;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController with the provided duration
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Define the animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Precompute offsets for smooth animation
    _precomputedOffsets = List.generate(
      1000,
      (index) => Random().nextDouble() * 6 - 3,
    );

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

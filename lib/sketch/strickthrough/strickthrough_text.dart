import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/sketch/strickthrough/strickthrough_painter.dart';

class AnimatedStrikethroughText extends StatefulWidget {
  final String text;
  final Color strikeColor;
  final TextStyle textStyle;
  final Duration duration;
  final Duration startDelay;

  const AnimatedStrikethroughText({
    super.key,
    required this.text,
    required this.strikeColor,
    required this.textStyle,
    this.duration = const Duration(seconds: 2),
    this.startDelay = Duration.zero,
  });

  @override
  _AnimatedStrikethroughTextState createState() =>
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

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Generate precomputed offsets to create a natural wavy strike effect
    _precomputedOffsets = List.generate(
      1000,
      (index) =>
          Random().nextDouble() * 4 -
          2, // Small variation for a human-like effect
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
          child: Text(
            widget.text,
            style: widget.textStyle,
          ),
        );
      },
    );
  }
}

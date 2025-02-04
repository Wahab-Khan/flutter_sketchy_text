import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/sketch/underline/underline_painter.dart';

class AnimatedUnderlineText extends StatefulWidget {
  final String text;
  final Color underlineColor;
  final TextStyle textStyle;
  final Duration duration;
  final Duration startDelay;

  const AnimatedUnderlineText({
    super.key,
    required this.text,
    required this.underlineColor,
    required this.textStyle,
    this.duration = const Duration(milliseconds: 500),
    this.startDelay = Duration.zero,
  });

  @override
  _AnimatedUnderlineTextState createState() => _AnimatedUnderlineTextState();
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
          Random().nextDouble() * 4 - 2, // Smaller variation than highlight
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

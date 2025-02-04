import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/sketch/circule/circule_painter.dart';

class AnimatedCircleText extends StatefulWidget {
  final String text;
  final Color circleColor;
  final TextStyle textStyle;
  final Duration duration;
  final Duration startDelay;

  const AnimatedCircleText({
    super.key,
    required this.text,
    required this.circleColor,
    required this.textStyle,
    this.duration = const Duration(seconds: 2),
    this.startDelay = Duration.zero,
  });

  @override
  _AnimatedCircleTextState createState() => _AnimatedCircleTextState();
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

    _animation = Tween<double>(begin: 0, end: 3) // 3 full rounds
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Generate precomputed offsets to create a natural hand-drawn effect
    _precomputedOffsets = List.generate(
      1000,
      (index) => Random()
          .nextDouble(), // Adds slight randomness  (index) => Random().nextDouble() * 6 - 3,
    );

    // Start animation with delay if needed
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

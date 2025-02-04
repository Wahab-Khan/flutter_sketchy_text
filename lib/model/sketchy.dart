import 'package:flutter/material.dart';

class SketchyModel {
  final String paragraph;
  List<SketchySentance> highlightSentances;

  SketchyModel({
    required this.paragraph,
    required this.highlightSentances,
  });
}

enum SketchyType { highlight, underline, strikethrough, circle, rectangle }

class SketchySentance {
  final String text;
  final Color highlightColor;
  final TextStyle? textStyle;
  final Duration startDelay;
  final Duration duration;
  final SketchyType highlightType;

  SketchySentance({
    required this.text,
    required this.highlightColor,
    this.textStyle =
        const TextStyle(fontSize: 14, color: Colors.black, height: 1.25),
    this.startDelay = const Duration(milliseconds: 500),
    this.duration = const Duration(milliseconds: 500),
    this.highlightType = SketchyType.highlight,
  });
}

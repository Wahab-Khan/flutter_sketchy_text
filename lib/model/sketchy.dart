import 'package:flutter/material.dart';

part 'sketchy_sentance.dart';

/// A model representing a paragraph with highlighted sentences.
///
/// This model is used to define a paragraph and a list of sentences or phrases
/// within the paragraph that should be highlighted, underlined, circled, etc.
///
/// Example:
/// ```dart
/// SketchyModel paragraphModel = SketchyModel(
///   paragraph: "This is a sample paragraph with highlighted text.",
///   highlightSentances: [
///     SketchySentance(
///       text: "highlighted text",
///       sketchyColor: Colors.yellow,
///       sketchyType: SketchyType.highlight,
///     ),
///   ],
/// );
/// ```
class SketchyModel {
  /// The main paragraph text.
  final String paragraph;

  /// A list of sentences or phrases within the paragraph that should be styled.
  ///
  /// Each item in this list is a [SketchySentance] object that defines the text,
  /// style, and animation properties for the highlighted portion.
  List<SketchySentance> highlightSentances;

  /// Creates a [SketchyModel] instance.
  ///
  /// - [paragraph]: The main paragraph text.
  /// - [highlightSentances]: A list of sentences or phrases to be styled.
  SketchyModel({
    required this.paragraph,
    required List<SketchySentance> highlightSentances,
  }) : highlightSentances = List.generate(
         highlightSentances.length,
         (index) => SketchySentance(
           text: highlightSentances[index].text,
           sketchyType: highlightSentances[index].sketchyType,
           sketchyColor: highlightSentances[index].sketchyColor,
           textStyle: highlightSentances[index].textStyle,
           duration: highlightSentances[index].duration,
           onTap: highlightSentances[index].onTap,
         ),
       );
}

import 'package:flutter/material.dart';

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
    required this.highlightSentances,
  });
}

/// Defines the types of styling that can be applied to a sentence or phrase.
///
/// - [highlight]: Highlights the text with a background color.
/// - [underline]: Underlines the text.
/// - [strikethrough]: Draws a line through the text.
/// - [circle]: Draws a circle around the text.
/// - [rectangle]: Draws a rectangle around the text.
enum SketchyType { highlight, underline, strikethrough, circle, rectangle }

/// Represents a sentence or phrase within a paragraph that should be styled.
///
/// This class defines the text, color, style, and animation properties for
/// a highlighted portion of the paragraph.
///
/// Example:
/// ```dart
/// SketchySentance(
///   text: "highlighted text",
///   sketchyColor: Colors.yellow,
///   sketchyType: SketchyType.highlight,
///   startDelay: Duration(seconds: 1),
///   duration: Duration(milliseconds: 500),
///   onTap: () {
///      print("User clicked on highlighted text!");
///   },
/// );
/// ```

class SketchySentance {
  /// The text to be styled.
  final String text;

  /// The color used for the styling (e.g., highlight, underline, etc.).
  final Color sketchyColor;

  /// The text style for the sentence or phrase.
  ///
  /// Defaults to a standard text style:
  /// ```dart
  /// TextStyle(fontSize: 14, color: Colors.black, height: 1.25)
  /// ```
  final TextStyle? textStyle;

  /// The delay before the styling animation starts.
  ///
  /// Defaults to 500 milliseconds.
  final Duration startDelay;

  /// The duration of the styling animation.
  ///
  /// Defaults to 500 milliseconds.
  final Duration duration;

  /// The type of styling to apply to the text.
  ///
  /// Defaults to [SketchyType.highlight].
  final SketchyType sketchyType;

  /// Callback function triggered when the user taps on the text.
  ///
  /// If null, no interaction is enabled.
  final VoidCallback? onTap;

  /// Creates a [SketchySentance] instance.
  ///
  /// - [text]: The text to be styled.
  /// - [sketchyColor]: The color used for the styling.
  /// - [textStyle]: The text style for the sentence or phrase.
  /// - [startDelay]: The delay before the styling animation starts.
  /// - [duration]: The duration of the styling animation.
  /// - [sketchyType]: The type of styling to apply.
  /// - [onTap]: The callback function triggered when the user taps on the text.
  SketchySentance({
    required this.text,
    required this.sketchyColor,
    this.textStyle =
        const TextStyle(fontSize: 14, color: Colors.black, height: 1.25),
    this.startDelay = const Duration(milliseconds: 500),
    this.duration = const Duration(milliseconds: 500),
    this.sketchyType = SketchyType.highlight,
    this.onTap,
  });
}

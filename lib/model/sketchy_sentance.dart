part of "sketchy.dart";

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
  ///
  /// Defaults to [_getDefaultColor].
  final Color? sketchyColor;

  /// The text style for the sentence or phrase.
  ///
  /// Defaults to a standard text style:
  /// ```dart
  /// TextStyle(fontSize: 14, color: Colors.black, height: 1.25)
  /// ```
  final TextStyle? textStyle;

  /// The delay before the styling animation starts.
  ///
  /// This value calculated based on the [SketchySentance] order of apperance in the paragraph.
  Duration? startDelay;

  /// The duration of the styling animation.
  ///
  /// Defaults to [_getDefaultDuration].
  final Duration? duration;

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
    Color? sketchyColor,
    this.textStyle =
        const TextStyle(fontSize: 14, color: Colors.black, height: 1.25),
    Duration? duration,
    this.sketchyType = SketchyType.highlight,
    this.onTap,
  })  : sketchyColor = sketchyColor ?? _getDefaultColor(sketchyType),
        duration = getDefaultDuration(sketchyType);

  SketchySentance.internalConstructor({
    required this.text,
    required this.sketchyColor,
    required this.textStyle,
    required this.startDelay,
    required this.duration,
    required this.sketchyType,
    required this.onTap,
  });

  /// Returns a default color for each [SketchyType].
  ///
  /// This method is used internally to provide default colors if the user
  /// doesn't specify a color when creating a [SketchySentance] instance.
  static Color _getDefaultColor(SketchyType type) {
    switch (type) {
      case SketchyType.highlight:
        return Colors.red.withValues(alpha: 0.4);
      case SketchyType.underline:
        return Colors.blue;
      case SketchyType.strikethrough:
        return Colors.purple;
      case SketchyType.circle:
        return Colors.green;
      case SketchyType.rectangle:
        return Colors.amber;
    }
  }

  /// Returns a default duration for each [SketchyType] animation.
  ///
  /// This method is used internally to provide default durations if the user
  /// doesn't specify a duration when creating a [SketchySentance] instance.
  static Duration getDefaultDuration(SketchyType type) {
    switch (type) {
      case SketchyType.highlight:
        return const Duration(milliseconds: 500);
      case SketchyType.underline:
        return const Duration(milliseconds: 500);
      case SketchyType.strikethrough:
        return const Duration(milliseconds: 700);
      case SketchyType.circle:
        return const Duration(seconds: 2);
      case SketchyType.rectangle:
        return const Duration(seconds: 2);
    }
  }
}

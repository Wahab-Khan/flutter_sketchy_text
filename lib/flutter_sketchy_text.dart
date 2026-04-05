import 'package:flutter/material.dart';
import 'package:flutter_sketchy_text/model/sketchy.dart';
import 'package:flutter_sketchy_text/sketch/circule/circule_text.dart';
import 'package:flutter_sketchy_text/sketch/highlighter/high_lighter_text.dart';
import 'package:flutter_sketchy_text/sketch/rectangle/rectangle_text.dart';
import 'package:flutter_sketchy_text/sketch/strickthrough/strickthrough_text.dart';
import 'package:flutter_sketchy_text/sketch/underline/underline_text.dart';

/// A widget that **applies sketchy animations to specific words inside a paragraph**.
///
/// This widget processes a paragraph and applies **animated sketchy effects** to selected words,
/// such as:
/// - **Highlighting**
/// - **Underlining**
/// - **Strikethrough**
/// - **Encircling**
/// - **Drawing a rectangle around text**
///
/// ### **Features:**
/// - **Supports multiple sketchy effects** within a single paragraph.
/// - **Customizable colors, durations, and start delays** for each effect.
/// - **Allows tap interaction with an `onTap` callback for highlighted words.**
/// - **Maintains proper text flow** without breaking paragraph structure.
/// - **Uses `RichText` for efficient rendering.**
///
/// ### **Usage Example:**
/// ```dart
/// SketchyParagraph(
///   paragraph: "Flutter makes UI development easy!",
///   highlights: [
///     SketchySentance(
///       text: "Flutter",
///       sketchyColor: Colors.red,
///       sketchyType: SketchyType.highlight,
///       startDelay: Duration(seconds: 1),
///     ),
///     SketchySentance(
///       text: "UI development",
///       sketchyColor: Colors.blue,
///       sketchyType: SketchyType.underline,
///       startDelay: Duration(seconds: 2),
///       onTap: () {
///          print("Flutter text clicked!");
///       },
///     ),
///   ],
/// )
/// ```
class SketchyParagraph extends StatelessWidget {
  /// The full paragraph in which sketchy effects will be applied.
  final String paragraph;

  /// A list of words/sentences to be highlighted with different sketchy effects.
  final List<SketchySentance> highlights;

  final SketchyAnimationMode animationMode;

  /// Whether all sketchy effects should animate by default.
  final bool isAnimated;

  /// Creates a `SketchyParagraph` that applies animated sketchy effects to selected words.
  const SketchyParagraph({
    super.key,
    required this.paragraph,
    required this.highlights,
    this.animationMode = SketchyAnimationMode.organic,
    this.isAnimated = true,
  });

  /// Parses a markdown-like string to automatically produce a `SketchyParagraph`.
  ///
  /// **Supported Syntax:**
  /// - `==text==` -> Highlight
  /// - `__text__` -> Underline
  /// - `~~text~~` -> Strikethrough
  /// - `((text))` -> Circle
  /// - `[[text]]` -> Rectangle
  ///
  /// **Example:**
  /// ```dart
  /// SketchyParagraph.parse(
  ///   "Welcome to ==Flutter==! It is an __amazing__ framework.",
  /// );
  /// ```
  factory SketchyParagraph.parse(
    String markdownStr, {
    Key? key,
    SketchyAnimationMode animationMode = SketchyAnimationMode.organic,
    bool isAnimated = true,
    Color? highlightColor,
    TextStyle? highlightStyle,
    Color? underlineColor,
    TextStyle? underlineStyle,
    Color? strikethroughColor,
    TextStyle? strikethroughStyle,
    Color? circleColor,
    TextStyle? circleStyle,
    Color? rectangleColor,
    TextStyle? rectangleStyle,
  }) {
    final List<SketchySentance> builtHighlights = [];
    String rawParagraph = markdownStr;

    final RegExp exp = RegExp(
        r'==([^=]+)==|__([^_]+)__|~~([^~]+)~~|\(\(([^)]+)\)\)|\[\[([^\]]+)\]\]');

    final matches = exp.allMatches(markdownStr);

    for (final match in matches) {
      String? text;
      SketchyType? type;

      if (match.group(1) != null) {
        text = match.group(1);
        type = SketchyType.highlight;
      } else if (match.group(2) != null) {
        text = match.group(2);
        type = SketchyType.underline;
      } else if (match.group(3) != null) {
        text = match.group(3);
        type = SketchyType.strikethrough;
      } else if (match.group(4) != null) {
        text = match.group(4);
        type = SketchyType.circle;
      } else if (match.group(5) != null) {
        text = match.group(5);
        type = SketchyType.rectangle;
      }

      if (text != null && type != null) {
        Color? color;
        TextStyle? style;
        switch (type) {
          case SketchyType.highlight:
            color = highlightColor;
            style = highlightStyle;
            break;
          case SketchyType.underline:
            color = underlineColor;
            style = underlineStyle;
            break;
          case SketchyType.strikethrough:
            color = strikethroughColor;
            style = strikethroughStyle;
            break;
          case SketchyType.circle:
            color = circleColor;
            style = circleStyle;
            break;
          case SketchyType.rectangle:
            color = rectangleColor;
            style = rectangleStyle;
            break;
        }

        builtHighlights.add(
          SketchySentance(
            text: text,
            sketchyType: type,
            sketchyColor: color,
            textStyle: style,
          ),
        );
      }
    }

    // Clean up the markdown string to create the pure paragraph
    rawParagraph = rawParagraph.replaceAllMapped(exp, (match) {
      return match.group(1) ??
          match.group(2) ??
          match.group(3) ??
          match.group(4) ??
          match.group(5) ??
          '';
    });

    return SketchyParagraph(
      key: key,
      paragraph: rawParagraph,
      highlights: builtHighlights,
      animationMode: animationMode,
      isAnimated: isAnimated,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.black, height: 1.5),
        children: _processParagraph(),
      ),
    );
  }

  /// **Processes the paragraph and applies sketchy effects to highlighted words.**
  ///
  /// This method:
  /// - **Finds and applies sketchy effects** to words in the paragraph.
  /// - **Maintains the original text structure** while inserting animated effects.
  /// - **Ensures animations occur in paragraph order** (not the array order).
  ///
  /// ### **How It Works:**
  /// 1. **Sorts highlights** by their first occurrence.
  /// 2. **Adds normal text before each highlight**.
  /// 3. **Replaces the highlighted word** with an animated widget.
  /// 4. **Continues until all highlights are processed**.
  ///
  /// ### **Example Usage:**
  /// ```dart
  /// RichText(
  ///   text: TextSpan(children: _processParagraph()),
  /// )
  /// ```
  List<InlineSpan> _processParagraph() {
    final List<InlineSpan> spans = [];

    // **Use the sorted highlights with correct startDelays**
    final sortedHighlights = _computeStartDelays();

    int currentPosition = 0;

    for (final highlight in sortedHighlights) {
      // **Find the position of this highlight in the original paragraph**
      final index = paragraph.indexOf(highlight.text, currentPosition);

      if (index == -1) continue; // Skip if not found

      // **Add text before the highlight**
      if (index > currentPosition) {
        spans.add(TextSpan(text: paragraph.substring(currentPosition, index)));
      }

      // **Add the animated highlight**
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: RepaintBoundary(child: _buildAnimation(highlight)),
        ),
      );

      // **Update current position to skip the processed highlight**
      currentPosition = index + highlight.text.length;
    }

    // **Add remaining text after the last highlight**
    if (currentPosition < paragraph.length) {
      spans.add(TextSpan(text: paragraph.substring(currentPosition)));
    }

    return spans;
  }

  /// **Computes the correct animation start delays based on paragraph order.**
  ///
  /// This method:
  /// - **Finds all occurrences** of highlighted words in the paragraph.
  /// - **Sorts them in the order they appear** (ensuring proper animation sequence).
  /// - **Assigns increasing start delays** so animations occur sequentially.
  ///
  /// ### **How It Works:**
  /// 1. **Finds every occurrence** of each highlighted word.
  /// 2. **Sorts occurrences** by their position in the paragraph.
  /// 3. **Calculates start delays**, ensuring each animation follows the previous one.
  ///
  /// ### **Example Usage:**
  /// ```dart
  /// final orderedHighlights = _computeStartDelays();
  /// print(orderedHighlights); // Logs each word with its computed delay.
  /// ```
  List<SketchySentance> _computeStartDelays() {
    final List<MapEntry<int, SketchySentance>> indexedOccurrences = [];

    // Step 1: Find all occurrences of ALL highlighted words in the paragraph
    for (final highlight in highlights) {
      int searchIndex = 0;
      while (true) {
        final index = paragraph.indexOf(highlight.text, searchIndex);
        if (index == -1) break;

        // Track the position and the highlight
        indexedOccurrences.add(MapEntry(index, highlight));
        searchIndex = index + highlight.text.length;
      }
    }

    // Step 2: Sort all occurrences by their position in the paragraph
    indexedOccurrences.sort((a, b) => a.key.compareTo(b.key));

    // Step 3: Assign sequential delays based on sorted order
    Duration accumulatedDelay = const Duration(milliseconds: 1000);
    List<SketchySentance> orderedSentences = [];

    for (final entry in indexedOccurrences) {
      final highlight = entry.value;
      final duration = highlight.duration ?? const Duration(seconds: 1);

      orderedSentences.add(
        SketchySentance.internalConstructor(
          text: highlight.text,
          sketchyColor: highlight.sketchyColor,
          textStyle: highlight.textStyle,
          duration: duration,
          startDelay: accumulatedDelay,
          sketchyType: highlight.sketchyType,
          isAnimated: isAnimated && highlight.isAnimated,
          onTap: highlight.onTap,
        ),
      );

      // Increment delay for the next animation
      accumulatedDelay += duration + const Duration(seconds: 1);
    }

    return orderedSentences;
  }

  /// Builds the appropriate animation effect based on the highlight type.
  Widget _buildAnimation(SketchySentance highlight) {
    Widget animatedWidget;

    switch (highlight.sketchyType) {
      case SketchyType.highlight:
        animatedWidget = AnimatedHighlightedText(
          text: highlight.text,
          highlightColor: highlight.sketchyColor!,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          duration: highlight.duration!,
          startDelay: highlight.startDelay!,
          animationMode: animationMode,
          isAnimated: highlight.isAnimated,
        );
        break;
      case SketchyType.underline:
        animatedWidget = AnimatedUnderlineText(
          text: highlight.text,
          underlineColor: highlight.sketchyColor!,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          duration: highlight.duration!,
          startDelay: highlight.startDelay!,
          animationMode: animationMode,
          isAnimated: highlight.isAnimated,
        );
        break;
      case SketchyType.strikethrough:
        animatedWidget = AnimatedStrikethroughText(
          text: highlight.text,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          strikeColor: highlight.sketchyColor!,
          duration: highlight.duration!,
          startDelay: highlight.startDelay!,
          animationMode: animationMode,
          isAnimated: highlight.isAnimated,
        );
        break;
      case SketchyType.circle:
        animatedWidget = AnimatedCircleText(
          text: highlight.text,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          circleColor: highlight.sketchyColor!,
          duration: highlight.duration!,
          startDelay: highlight.startDelay!,
          animationMode: animationMode,
          isAnimated: highlight.isAnimated,
        );
        break;
      case SketchyType.rectangle:
        animatedWidget = AnimatedRectangleText(
          text: highlight.text,
          textStyle: highlight.textStyle ??
              const TextStyle(fontSize: 14, color: Colors.black),
          rectangleColor: highlight.sketchyColor!,
          duration: highlight.duration!,
          startDelay: highlight.startDelay!,
          animationMode: animationMode,
          isAnimated: highlight.isAnimated,
        );
        break;
    }

    // ✅ Wrap in GestureDetector if `onTap` is provided
    return GestureDetector(onTap: highlight.onTap, child: animatedWidget);
  }
}

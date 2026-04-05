import 'dart:math';

/// A globally shared pool of random offsets for drawing organic sketchy animations.
///
/// Instead of every individual sketchy sentence instantiating `1000` random variables
/// upon rendering, they all pull from this static pool. This significantly saves
/// memory resources when many sketchy texts are drawn on screen.
class SketchyRandomPool {
  static final List<double> offsets = List.generate(
    1000,
    (index) => Random().nextDouble() * 3 - 1,
  );
}

class Range {
  static Iterable<int> range(int low, int high) sync* {
    for (int i = low; i < high; ++i) {
      yield i;
    }
  }
}

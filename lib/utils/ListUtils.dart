class ListUtils {
  static List<E> generateInverse<E>(int from, int to, E generateInverse(int index)) {
    final result = List<E>();
    for (int i = from; i >= to; i--) {
      result.add(generateInverse(i));
    }

    return result;
  }

  static List<E> generateInRange<E>(int from, int to, E generateInRange(int index)) {
    final result = List<E>();
    for (int i = from; i <= to; i++) {
      result.add(generateInRange(i));
    }

    return result;
  }

  static String parseListAsQuotedString(List<int> from) {
    return from.map((s) => "'$s'").join(",");
  }

  static Iterable<int> range(int low, int high) sync* {
    for (int i = low; i < high; ++i) {
      yield i;
    }
  }
}

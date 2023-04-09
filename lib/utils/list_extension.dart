extension ListExtension<T> on List<T> {
  Map<int, U> toIndexMap<U>(U Function(T) getValue) {
    var map = <int, U>{};

    for (int i = 0; i < length; ++i) {
      map[i] = getValue(this[i]);
    }

    return map;
  }

  Map<U, T> toMap<U>(U Function(T) getKey) {
    var map = <U, T>{};

    for (final item in this) {
      map[getKey(item)] = item;
    }

    return map;
  }
}
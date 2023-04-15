extension IterableExtension<T> on Iterable<T> {
  Map<U, T> toKeyMap<U>(U Function(T) getKey) => toMap(getKey: getKey, getValue: (item) => item);

  Map<T, U> toValueMap<U>(U Function(T) getValue)  => toMap(getKey: (item) => item, getValue: getValue);

  Map<U, V> toMap<U, V>({required U Function(T) getKey, required V Function(T) getValue}) {
    var map = <U, V>{};

    for (final item in this) {
      map[getKey(item)] = getValue(item);
    }

    return map;
  }

  List<U> toNewList<U>(U Function(T) builder) {
    final newList = <U>[];

    for (final item in this) {
      newList.add(builder(item));
    }

    return newList;
  }
}
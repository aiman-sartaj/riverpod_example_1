extension ImmutableListMethods<T> on List<T> {
  List<T> withNew(T item) {
    return [...this, item];
  }

  List<T> withRemoved(T item, {required bool Function(T) test}) {
    for (final i in this) {
      if (test(i)) {
        return [...this]..remove(i);
      }
    }

    return this;
  }

  List<T> updateWith(T item, {required bool Function(T) test}) {
    var updatedList = <T>[];
    for (final i in this) {
      updatedList = map((e) => test(i) ? item : i).toList();
    }

    return updatedList;
  }
}

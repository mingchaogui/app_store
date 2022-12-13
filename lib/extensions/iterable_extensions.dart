import 'package:collection/collection.dart';

extension AsIterableExtensions<T> on Iterable<T> {
  List<T> divide(
    T divider, {
    bool addBefore = false,
    bool addAfter = false,
  }) {
    final List<T> list = <T>[];

    forEachIndexed((int index, T child) {
      if (addBefore || index > 0) {
        list.add(divider);
      }
      list.add(child);
    });
    if (addAfter) {
      list.add(divider);
    }

    return list;
  }
}

extension AsListExt<T> on List<T?> {
  List<T?> removeNull() {
    removeWhere((T? element) => element == null);
    return this;
  }
}

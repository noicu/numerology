class UtilList {
  static filter<T>(List<T> list, bool Function(T) f) {
    List<T> result = [];
    for (int i = 0; i < list.length; i++) {
      if (f(list[i])) result.add(list[i]);
    }
    return result;
  }
}

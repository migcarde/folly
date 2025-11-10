extension LetExtension<T> on T? {
  R? let<R>(R Function(T data) f) {
    if (this != null) {
      return f(this as T);
    }
    return null;
  }
}

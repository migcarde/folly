class PageRemoteEntity<T> {
  final List<T> content;
  final int page;
  final int totalPages;
  final int total;

  const PageRemoteEntity({
    required this.content,
    required this.page,
    required this.totalPages,
    required this.total,
  });

  static (int startIndex, int endIndex) getIndexes({
    required int page,
    required int size,
    int? total,
  }) {
    final startIndex = page * size;
    final end = startIndex + size - 1;

    final endIndex = total != null && end > total ? (total - 1) : end;

    return (startIndex, endIndex);
  }
}

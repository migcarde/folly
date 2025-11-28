class PageEntity<T> {
  final List<T> content;
  final int page;
  final int totalPages;
  final int total;

  const PageEntity({
    required this.content,
    required this.page,
    required this.totalPages,
    required this.total,
  });
}

class Page<T> {
  final int total;
  final List<T> items;

  Page({
    required this.total,
    required this.items,
  });
}

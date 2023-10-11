import 'price.dart';

class Comic {
  final String title;
  final String description;
  final String thumbnail;
  final int issueNumber;
  final int pageCount;
  final List<Price> prices;
  final List<String> creators;

  Comic({
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.issueNumber,
    required this.pageCount,
    required this.prices,
    required this.creators,
  });
}

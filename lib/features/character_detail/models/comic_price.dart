import 'package:json_annotation/json_annotation.dart';

part 'comic_price.g.dart';

@JsonSerializable(createToJson: false)
class ComicPrice {
  String? type;
  double? price;

  ComicPrice({this.type, this.price});

  factory ComicPrice.fromJson(Map<String, dynamic> json) =>
      _$ComicPriceFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';
import 'comic_date.dart';
import 'comic_price.dart';
import 'text_object.dart';
import '../../home/models/image.dart';
import '../../home/models/summary.dart';
import '../../home/models/url.dart';
import '../../home/models/default_element_object.dart';

part 'comic.g.dart';

@JsonSerializable(createToJson: false)
class Comic {
  int? id;
  int? digitalId;
  String? title;
  int? issueNumber;
  String? variantDescription;
  String? description;
  String? modified;
  String? isbn;
  String? upc;
  String? diamondCode;
  String? ean;
  String? issn;
  String? format;
  int? pageCount;
  List<TextObject>? textObjects;
  String? resourceURI;
  List<Url>? urls;
  Summary? series;
  List<Summary>? variants;
  List<Summary>? collections;
  List<Summary>? collectedIssues;
  List<ComicDate>? dates;
  List<ComicPrice>? prices;
  Image? thumbnail;
  List<Image>? images;
  DefaultElementObject? creators;
  DefaultElementObject? characters;
  DefaultElementObject? stories;
  DefaultElementObject? events;

  Comic(
      {this.id,
      this.digitalId,
      this.title,
      this.issueNumber,
      this.variantDescription,
      this.description,
      this.modified,
      this.isbn,
      this.upc,
      this.diamondCode,
      this.ean,
      this.issn,
      this.format,
      this.pageCount,
      this.textObjects,
      this.resourceURI,
      this.urls,
      this.series,
      this.variants,
      this.collections,
      this.collectedIssues,
      this.dates,
      this.prices,
      this.thumbnail,
      this.images,
      this.creators,
      this.characters,
      this.stories,
      this.events});

  factory Comic.fromJson(Map<String, dynamic> json) => _$ComicFromJson(json);
}

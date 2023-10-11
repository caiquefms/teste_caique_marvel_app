import 'package:json_annotation/json_annotation.dart';

part 'comic_date.g.dart';

@JsonSerializable(createToJson: false)
class ComicDate {
  String? type;
  String? date;

  ComicDate({this.type, this.date});

  factory ComicDate.fromJson(Map<String, dynamic> json) =>
      _$ComicDateFromJson(json);
}

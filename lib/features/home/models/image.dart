import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(createToJson: false)
class Image {
  String? path;
  String? extension;

  Image({this.path, this.extension});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

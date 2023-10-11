import 'package:json_annotation/json_annotation.dart';

part 'text_object.g.dart';

@JsonSerializable(createToJson: false)
class TextObject {
  String? type;
  String? language;
  String? text;

  TextObject({this.type, this.language, this.text});

  factory TextObject.fromJson(Map<String, dynamic> json) =>
      _$TextObjectFromJson(json);
}

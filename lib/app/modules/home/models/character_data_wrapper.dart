import 'package:json_annotation/json_annotation.dart';
import 'character_data_container.dart';

part 'character_data_wrapper.g.dart';

@JsonSerializable(createToJson: false)
class CharacterDataWrapper {
  int? code;
  String? status;
  String? copyright;
  String? attributionText;
  String? attributionHTML;
  String? etag;
  CharacterDataContainer? data;

  CharacterDataWrapper(
      {this.code,
      this.status,
      this.copyright,
      this.attributionText,
      this.attributionHTML,
      this.etag,
      this.data});

  factory CharacterDataWrapper.fromJson(Map<String, dynamic> json) =>
      _$CharacterDataWrapperFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';
import 'comic_data_container.dart';

part 'comic_data_wrapper.g.dart';

@JsonSerializable(createToJson: false)
class ComicDataWrapper {
  int? code;
  String? status;
  String? copyright;
  String? attributionText;
  String? attributionHTML;
  String? etag;
  ComicDataContainer? data;

  ComicDataWrapper(
      {this.code,
      this.status,
      this.copyright,
      this.attributionText,
      this.attributionHTML,
      this.etag,
      this.data});

  factory ComicDataWrapper.fromJson(Map<String, dynamic> json) =>
      _$ComicDataWrapperFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';
import 'summary.dart';

part 'default_element_object.g.dart';

@JsonSerializable(createToJson: false)
class DefaultElementObject {
  int? available;
  String? collectionURI;
  List<Summary>? items;
  int? returned;

  DefaultElementObject(
      {this.available, this.collectionURI, this.items, this.returned});

  factory DefaultElementObject.fromJson(Map<String, dynamic> json) =>
      _$DefaultElementObjectFromJson(json);
}

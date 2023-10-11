import 'package:json_annotation/json_annotation.dart';
import 'default_element_object.dart';
import 'image.dart';
import './url.dart';

part 'character.g.dart';

@JsonSerializable(createToJson: false)
class Character {
  int? id;
  String? name;
  String? description;
  String? modified;
  Image? thumbnail;
  String? resourceURI;
  DefaultElementObject? comics;
  DefaultElementObject? series;
  DefaultElementObject? stories;
  DefaultElementObject? events;
  List<Url>? urls;

  Character(
      {this.id,
      this.name,
      this.description,
      this.modified,
      this.thumbnail,
      this.resourceURI,
      this.comics,
      this.series,
      this.stories,
      this.events,
      this.urls});

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}

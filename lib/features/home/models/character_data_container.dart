import 'package:json_annotation/json_annotation.dart';
import 'character.dart';

part 'character_data_container.g.dart';

@JsonSerializable(createToJson: false)
class CharacterDataContainer {
  int? offset;
  int? limit;
  int? total;
  int? count;
  List<Character>? results;

  CharacterDataContainer(
      {this.offset, this.limit, this.total, this.count, this.results});

  factory CharacterDataContainer.fromJson(Map<String, dynamic> json) =>
      _$CharacterDataContainerFromJson(json);
}

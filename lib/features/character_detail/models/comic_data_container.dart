import 'package:json_annotation/json_annotation.dart';
import 'comic.dart';

part 'comic_data_container.g.dart';

@JsonSerializable(createToJson: false)
class ComicDataContainer {
  int? offset;
  int? limit;
  int? total;
  int? count;
  List<Comic>? results;

  ComicDataContainer(
      {this.offset, this.limit, this.total, this.count, this.results});

  factory ComicDataContainer.fromJson(Map<String, dynamic> json) =>
      _$ComicDataContainerFromJson(json);
}

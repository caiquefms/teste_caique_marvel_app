import 'package:json_annotation/json_annotation.dart';

part 'summary.g.dart';

@JsonSerializable(createToJson: false)
class Summary {
  String? resourceURI;
  String? name;
  String? type;
  String? role;

  Summary({this.resourceURI, this.name, this.type, this.role});

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);
}

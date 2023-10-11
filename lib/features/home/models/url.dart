import 'package:json_annotation/json_annotation.dart';

part 'url.g.dart';

@JsonSerializable(createToJson: false)
class Url {
  String? type;
  String? url;

  Url({this.type, this.url});

  factory Url.fromJson(Map<String, dynamic> json) => _$UrlFromJson(json);
}

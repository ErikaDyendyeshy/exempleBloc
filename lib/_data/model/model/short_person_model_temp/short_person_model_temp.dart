import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';
part 'short_person_model_temp.g.dart';

@JsonSerializable()
class ShortPersonModel extends ToJsonInterface {
  final String id;
  final String name;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  ShortPersonModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  factory ShortPersonModel.fromJson(Map<String, dynamic> json) =>
      _$ShortPersonModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShortPersonModelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'tag_model.g.dart';

@JsonSerializable()
class TagModel implements ToJsonInterface {
  final String id;
  final String tag;

  TagModel({
    required this.id,
    required this.tag,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) => _$TagModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}

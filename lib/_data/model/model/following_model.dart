import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'following_model.g.dart';

@JsonSerializable()
class FollowingModel extends ToJsonInterface {
  @JsonKey(name: 'following_id')
  final String followingId;

  FollowingModel({
    required this.followingId,
  });

  factory FollowingModel.fromJson(Map<String, dynamic> json) => _$FollowingModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FollowingModelToJson(this);
}

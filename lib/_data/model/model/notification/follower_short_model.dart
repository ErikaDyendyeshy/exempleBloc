import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'follower_short_model.g.dart';

@JsonSerializable()
class FollowerShortModel extends ToJsonInterface {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'avatar_url')
  final String avatartUrl;
  @JsonKey(name: 'is_following')
  final bool isFollowing;
  FollowerShortModel({
    required this.isFollowing,
    required this.id,
    required this.name,
    required this.avatartUrl,
  });

  factory FollowerShortModel.fromJson(Map<String, dynamic> json) =>
      _$FollowerShortModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FollowerShortModelToJson(this);
}

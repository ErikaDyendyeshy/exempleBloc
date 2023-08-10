import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'relations_count_model.g.dart';

@JsonSerializable()
class RelationsCountModel implements ToJsonInterface {
  @JsonKey(name: 'followers_count')
  final int followersCount;
  @JsonKey(name: 'following_count')
  final int followingCount;

  RelationsCountModel({
    required this.followersCount,
    required this.followingCount,
  });

  factory RelationsCountModel.fromJson(Map<String, dynamic> json) =>
      _$RelationsCountModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RelationsCountModelToJson(this);
}

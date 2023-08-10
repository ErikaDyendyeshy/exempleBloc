import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';
part 'unfollow_model.g.dart';


@JsonSerializable()
class UnfollowModel extends ToJsonInterface {
  @JsonKey(name: 'unfollow_id')
  final String unfollowId;

  UnfollowModel({
    required this.unfollowId,
});

  factory UnfollowModel.fromJson(Map<String, dynamic> json) => _$UnfollowModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnfollowModelToJson(this);
}
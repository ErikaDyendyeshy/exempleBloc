import 'package:json_annotation/json_annotation.dart';

part 'block_user_model.g.dart';

@JsonSerializable()
class BlockUserModel {
  @JsonKey(name: 'ignored_id')
  final String userId;

  BlockUserModel({
    required this.userId,
  });

  factory BlockUserModel.fromJson(Map<String, dynamic> json) => _$BlockUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlockUserModelToJson(this);
}

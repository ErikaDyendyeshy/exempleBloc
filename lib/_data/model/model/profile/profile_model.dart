import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/profile/custom_info_model.dart';
import 'package:parallel/_data/model/model/profile/tag_model.dart';
import 'package:parallel/_data/model/model/profile/user_model.dart';

part 'profile_model.g.dart';

@JsonSerializable(includeIfNull: true)
class ProfileModel {
  @JsonKey(name: 'i_following')
  late final bool? iFollowing;
  final UserModel user;
  final List<TagModel> tags;
  @JsonKey(name: 'custom_info')
  final List<CustomInfoModel> customInfo;

  ProfileModel({
    this.iFollowing,
    required this.user,
    required this.tags,
    required this.customInfo,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

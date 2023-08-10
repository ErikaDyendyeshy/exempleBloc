// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      iFollowing: json['i_following'] as bool?,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      customInfo: (json['custom_info'] as List<dynamic>)
          .map((e) => CustomInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'i_following': instance.iFollowing,
      'user': instance.user,
      'tags': instance.tags,
      'custom_info': instance.customInfo,
    };

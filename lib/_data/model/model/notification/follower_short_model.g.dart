// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower_short_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowerShortModel _$FollowerShortModelFromJson(Map<String, dynamic> json) =>
    FollowerShortModel(
      isFollowing: json['is_following'] as bool,
      id: json['id'] as String,
      name: json['name'] as String,
      avatartUrl: json['avatar_url'] as String,
    );

Map<String, dynamic> _$FollowerShortModelToJson(FollowerShortModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar_url': instance.avatartUrl,
      'is_following': instance.isFollowing,
    };

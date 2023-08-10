// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relations_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelationsCountModel _$RelationsCountModelFromJson(Map<String, dynamic> json) =>
    RelationsCountModel(
      followersCount: json['followers_count'] as int,
      followingCount: json['following_count'] as int,
    );

Map<String, dynamic> _$RelationsCountModelToJson(
        RelationsCountModel instance) =>
    <String, dynamic>{
      'followers_count': instance.followersCount,
      'following_count': instance.followingCount,
    };

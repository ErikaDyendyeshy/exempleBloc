// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String,
      aboutMe: json['about_me'] as String,
      followers: json['followers'] as int,
      following: json['following'] as int,
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'about_me': instance.aboutMe,
      'following': instance.following,
      'followers': instance.followers,
    };

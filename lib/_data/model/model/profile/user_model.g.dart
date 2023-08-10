// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      birthDate: json['birth_date'] as String,
      country: json['country'] as String? ?? '',
      aboutMe: json['about_me'] as String,
      avatarUrl: json['avatar_url'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birth_date': instance.birthDate,
      'country': instance.country,
      'about_me': instance.aboutMe,
      'avatar_url': instance.avatarUrl,
      'email': instance.email,
    };

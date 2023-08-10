// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      userId: json['user_id'] as String,
      accessToken: json['access'] as String,
      refreshToken: json['refresh'] as String,
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'user_id': instance.userId,
      'access': instance.accessToken,
      'refresh': instance.refreshToken,
    };

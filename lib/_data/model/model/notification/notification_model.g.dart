// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      follower:
          FollowerShortModel.fromJson(json['follow'] as Map<String, dynamic>),
      type: json['notification_type'] as int,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'follow': instance.follower,
      'notification_type': instance.type,
    };

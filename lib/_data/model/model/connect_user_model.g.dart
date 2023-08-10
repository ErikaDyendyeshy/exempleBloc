// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectUserModel _$ConnectUserModelFromJson(Map<String, dynamic> json) =>
    ConnectUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      dateCreated: json['data_created'] == null
          ? null
          : DateTime.parse(json['data_created'] as String),
      avatarUrl: json['avatar_url'] as String?,
      isSubscribed: json['is_subscribed_me_to_user'] as bool?,
    );

Map<String, dynamic> _$ConnectUserModelToJson(ConnectUserModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'data_created': instance.dateCreated?.toIso8601String(),
    'avatar_url': instance.avatarUrl,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('is_subscribed_me_to_user', instance.isSubscribed);
  return val;
}

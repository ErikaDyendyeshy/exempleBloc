// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionModel _$ConnectionModelFromJson(Map<String, dynamic> json) =>
    ConnectionModel(
      id: json['id'] as String,
      follower: json['follower'] == null
          ? null
          : ConnectUserModel.fromJson(json['follower'] as Map<String, dynamic>),
      following: json['following'] == null
          ? null
          : ConnectUserModel.fromJson(
              json['following'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConnectionModelToJson(ConnectionModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('follower', instance.follower);
  writeNotNull('following', instance.following);
  return val;
}

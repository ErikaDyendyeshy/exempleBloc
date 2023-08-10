// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ChangePasswordRequestToJson(
    ChangePasswordRequest instance) {
  final val = <String, dynamic>{
    'email': instance.email,
    'code': instance.code,
    'password': instance.newPassword,
    'password_confirmation': instance.repeatNewPassword,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('old_password', instance.oldPassword);
  return val;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_toggle_pause_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestTogglePauseModel _$RequestTogglePauseModelFromJson(
        Map<String, dynamic> json) =>
    RequestTogglePauseModel(
      requestId: json['request_id'] as String,
      pause: json['pause'] as bool,
    );

Map<String, dynamic> _$RequestTogglePauseModelToJson(
        RequestTogglePauseModel instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'pause': instance.pause,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestModel _$RequestModelFromJson(Map<String, dynamic> json) => RequestModel(
      id: json['id'] as String,
      resolved: json['resolved'] as bool,
      request: json['request'] as String,
    );

Map<String, dynamic> _$RequestModelToJson(RequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resolved': instance.resolved,
      'request': instance.request,
    };

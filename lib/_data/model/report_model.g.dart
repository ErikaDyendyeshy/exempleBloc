// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      id: json['id'] as String,
      topic: json['topic'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'description': instance.description,
    };

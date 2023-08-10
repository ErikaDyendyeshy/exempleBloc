// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestDetailModel _$RequestDetailModelFromJson(Map<String, dynamic> json) =>
    RequestDetailModel(
      request: RequestModel.fromJson(json['request'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => PersonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestDetailModelToJson(RequestDetailModel instance) =>
    <String, dynamic>{
      'request': instance.request,
      'results': instance.results,
    };

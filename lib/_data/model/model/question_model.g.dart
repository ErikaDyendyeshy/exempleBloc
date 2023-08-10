// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      json['id'] as String,
      json['question'] as String,
      (json['answers'] as List<dynamic>)
          .map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['isFreeText'] as bool?,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
      'isFreeText': instance.isFreeText,
    };

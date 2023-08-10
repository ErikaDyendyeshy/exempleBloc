// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) => AnswerModel(
      questionId: json['question_id'] as String?,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'answer': instance.answer,
    };

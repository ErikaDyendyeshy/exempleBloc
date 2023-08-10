import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'answer_model.g.dart';

@JsonSerializable()
class AnswerModel extends ToJsonInterface {
  @JsonKey(name: 'question_id')
  String? questionId;
  final String answer;

  AnswerModel({
    this.questionId,
    required this.answer,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) => _$AnswerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);
}

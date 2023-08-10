import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/answer_model.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel extends ToJsonInterface {
  final String id;
  final String question;
  final List<AnswerModel> answers;
  final bool? isFreeText;

  QuestionModel(
    this.id,
    this.question,
    this.answers,
    this.isFreeText,
  );

  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

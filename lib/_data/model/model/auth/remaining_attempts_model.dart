import 'package:json_annotation/json_annotation.dart';

part 'remaining_attempts_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RemainingAttemptsModel {
  @JsonKey(name: 'remaining_attempts')
  final int remainingAttempts;

  RemainingAttemptsModel({
    required this.remainingAttempts,
  });

  factory RemainingAttemptsModel.fromJson(Map<String, dynamic> json) =>
      _$RemainingAttemptsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemainingAttemptsModelToJson(this);
}

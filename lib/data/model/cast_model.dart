import 'package:json_annotation/json_annotation.dart';

part 'cast_model.g.dart';

@JsonSerializable()
class CastModel{
  final String name;
  @JsonKey(defaultValue: '')
  final String? character;
  @JsonKey(name: 'profile_path', defaultValue: '')
  final String? photoActor;

  CastModel({
    required this.name,
    required this.character,
    required this.photoActor
});

  factory CastModel.fromJson(Map<String, dynamic> json) => _$CastModelFromJson(json);

  Map<String, dynamic> toJson() => _$CastModelToJson(this);
}
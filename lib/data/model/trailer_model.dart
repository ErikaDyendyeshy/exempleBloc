import 'package:json_annotation/json_annotation.dart';
part 'trailer_model.g.dart';

@JsonSerializable()
class TrailerModel {
  final String key;

  TrailerModel({
    required this.key,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> json) => _$TrailerModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrailerModelToJson(this);
}

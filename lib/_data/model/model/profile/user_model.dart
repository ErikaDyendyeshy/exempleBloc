import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'user_model.g.dart';

@JsonSerializable(includeIfNull: true)
class UserModel implements ToJsonInterface {
  final String id;
  final String name;
  @JsonKey(name: 'birth_date')
  final String birthDate;
  @JsonKey(defaultValue: '')
  final String? country;
  @JsonKey(name: 'about_me')
  final String aboutMe;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  final String? email;

  UserModel({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.country,
    required this.aboutMe,
    required this.avatarUrl,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

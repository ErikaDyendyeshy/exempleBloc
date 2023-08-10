import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel extends ToJsonInterface {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'access')
  final String accessToken;
  @JsonKey(name: 'refresh')
  final String refreshToken;

  AuthModel({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}

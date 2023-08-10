import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'change_password_request.g.dart';

@JsonSerializable(createFactory: false)
class ChangePasswordRequest extends ToJsonInterface {
  final String email;
  final String code;
  @JsonKey(name: 'password')
  final String newPassword;
  @JsonKey(name: 'password_confirmation')
  final String repeatNewPassword;
  @JsonKey(name: 'old_password', includeIfNull: false)
  final String? oldPassword;

  ChangePasswordRequest({
    required this.email,
    required this.code,
    required this.newPassword,
    required this.repeatNewPassword,
    this.oldPassword,
  });

  @override
  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}

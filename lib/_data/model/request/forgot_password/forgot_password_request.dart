import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable(createFactory: false)
class ForgotPasswordRequest extends ToJsonInterface {
  final String email;

  ForgotPasswordRequest({
    required this.email,
  });

  @override
  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}

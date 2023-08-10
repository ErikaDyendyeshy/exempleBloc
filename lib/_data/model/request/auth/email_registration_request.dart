import 'package:parallel/_data/model/model/to_json_interface.dart';

class EmailRegistrationRequest implements ToJsonInterface {
  final String name;
  final String email;
  final String password;
  final String passwordRepeat;
  final String? code;

  EmailRegistrationRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordRepeat,
    this.code,
  });

  @override
  Map toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordRepeat,
        if (code != null) 'code': code,
      };
}

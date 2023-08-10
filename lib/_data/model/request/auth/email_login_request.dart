import 'package:parallel/_data/model/model/to_json_interface.dart';

class EmailLoginRequest implements ToJsonInterface {
  final String email;
  final String password;

  EmailLoginRequest({
    required this.email,
    required this.password,
  });

  @override
  Map toJson() => {
        'email': email,
        'password': password,
      };
}

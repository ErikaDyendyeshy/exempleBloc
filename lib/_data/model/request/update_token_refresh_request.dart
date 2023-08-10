import 'package:parallel/_data/model/model/to_json_interface.dart';

class UpdateTokenRefreshRequest implements ToJsonInterface {
  final String refreshToken;

  const UpdateTokenRefreshRequest({
    required this.refreshToken,
  });

  @override
  Map toJson() => {
        'refresh': refreshToken,
      };
}

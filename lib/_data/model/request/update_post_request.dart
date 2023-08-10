import 'package:parallel/_data/model/model/to_json_interface.dart';

class UpdatePostRequest implements ToJsonInterface {
  final String text;

  const UpdatePostRequest({
    required this.text,
  });

  @override
  Map toJson() => {
        'text': text,
      };
}

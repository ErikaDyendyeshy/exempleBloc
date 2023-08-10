
import 'package:parallel/_data/model/model/to_json_interface.dart';

class LikeRequest implements ToJsonInterface {
  final String postId;

  const LikeRequest({
    required this.postId,
  });

  @override
  Map toJson() => {
        'post_id': postId,
      };
}

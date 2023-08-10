import 'package:parallel/_data/model/model/to_json_interface.dart';

class CommentRequest implements ToJsonInterface {
  final String postId;
  final String comment;

  const CommentRequest({
    required this.postId,
    required this.comment,
  });

  @override
  Map toJson() => {
        'post_id': postId,
        'comment': comment,
      };
}

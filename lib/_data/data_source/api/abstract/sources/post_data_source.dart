import 'package:parallel/_data/data_source/api/abstract/data_source.dart';
import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/post/comment_model.dart';
import 'package:parallel/_data/model/model/post/post_model.dart';

abstract class PostDataSource extends DataSource {
  PostDataSource({
    required super.getConnect,
    required super.apiDataSource,
  });

  Future<ListModel<PostModel>> getListPost({
    required int page,
  });

  Future<void> likePost({
    required String postId,
  });

  Future<PostModel> getPostById({
    required String postId,
  });

  Future<bool> postComment({
    required String postId,
    required String comment,
  });

  Future<List<CommentModel>> getCommentsByPostId({
    required String postId,
  });

  Future<void> editPost({
    required String postId,
    required String text,
  });

  Future<void> deletePost({
    required String postId,
  });

  Future<void> sendReport({
    required String postId,
    required String topic,
    required String description,
  });
}

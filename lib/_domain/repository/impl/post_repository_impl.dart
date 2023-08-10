import 'package:parallel/_data/data_source/api/abstract/api_data_source.dart';
import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/post/comment_model.dart';
import 'package:parallel/_data/model/model/post/post_model.dart';
import 'package:parallel/_domain/error_handler/error_handler.dart';
import 'package:parallel/_domain/repository/abstract/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiDataSource _apiDataSource;
  final ErrorHandler _errorHandler;

  PostRepositoryImpl(
    this._apiDataSource,
    this._errorHandler,
  );

  @override
  Future<ListModel<PostModel>> getListPost({
    required int page,
  }) {
    return _apiDataSource.postDataSource.getListPost(
      page: page,
    );
  }

  @override
  Future<void> likePost({
    required String postId,
  }) {
    return _apiDataSource.postDataSource.likePost(
      postId: postId,
    );
  }

  @override
  Future<PostModel> getPostById({
    required String postId,
  }) {
    return _apiDataSource.postDataSource.getPostById(
      postId: postId,
    );
  }

  @override
  Future<bool> postComment({
    required String postId,
    required String comment,
  }) {
    return _apiDataSource.postDataSource.postComment(
      postId: postId,
      comment: comment,
    );
  }

  @override
  Future<List<CommentModel>> getCommentsByPostId({required String postId}) {
    return _apiDataSource.postDataSource.getCommentsByPostId(postId: postId);
  }

  @override
  Future<void> editPost({
    required String postId,
    required String text,
  }) {
    return _apiDataSource.postDataSource.editPost(postId: postId, text: text);
  }

  @override
  Future<void> deletePost({required String postId}) {
    return _apiDataSource.postDataSource.deletePost(postId: postId);
  }

  @override
  Future<void> sendReport({
    required String postId,
    required String topic,
    required String description,
  }) {
    return _apiDataSource.postDataSource.sendReport(
      postId: postId,
      topic: topic,
      description: description,
    );
  }
}

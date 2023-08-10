import 'dart:convert';

import 'package:get/get.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/post_data_source.dart';
import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/list_model/post_list_response.dart';
import 'package:parallel/_data/model/model/comment_request.dart';
import 'package:parallel/_data/model/model/post/comment_model.dart';
import 'package:parallel/_data/model/model/post/post_model.dart';
import 'package:parallel/_data/model/report_model.dart';
import 'package:parallel/_data/model/request/empty_request.dart';
import 'package:parallel/_data/model/request/like_request.dart';
import 'package:parallel/_data/model/request/update_post_request.dart';
import 'package:parallel/util/http_extension.dart';

class PostDataSourceImpl extends PostDataSource {
  PostDataSourceImpl({
    required super.getConnect,
    required super.apiDataSource,
  });

  @override
  Future<ListModel<PostModel>> getListPost({
    required int page,
  }) {
    final Map<String, dynamic> query = {};
    query['page'] = page.toString();

    return getConnect
        .getRequest(
      url: 'post/feed',
      query: query,
    )
        .then((Response response) {
      return PostListResponse.fromJson(
        jsonDecode(response.bodyString!),
      );
    });
  }

  @override
  Future<void> likePost({
    required String postId,
  }) {
    return getConnect.postRequest(
      url: 'post/like/',
      request: LikeRequest(postId: postId),
    );
  }

  @override
  Future<PostModel> getPostById({
    required String postId,
  }) {
    return getConnect
        .getRequest(url: 'post/details/$postId')
        .then((Response response) => PostModel.fromJson(
              jsonDecode(response.bodyString!),
            ));
  }

  @override
  Future<bool> postComment({
    required String postId,
    required String comment,
  }) {
    return getConnect
        .postRequest(
          url: 'post/comment/',
          request: CommentRequest(
            postId: postId,
            comment: comment,
          ),
        )
        .then(
          (Response response) => response.isOk,
        );
  }

  @override
  Future<List<CommentModel>> getCommentsByPostId({
    required String postId,
  }) {
    return getConnect.getRequest(url: 'post/$postId/comments/').then((Response response) {
      List<dynamic> responseBody = jsonDecode(response.bodyString!);
      return responseBody.map((json) => CommentModel.fromJson(json)).toList();
    });
  }

  @override
  Future<void> editPost({
    required String postId,
    required String text,
  }) {
    return getConnect.patchRequest(
      url: 'post/update/$postId',
      request: UpdatePostRequest(
        text: text,
      ),
    );
  }

  @override
  Future<void> deletePost({
    required String postId,
  }) {
    return getConnect.deleteRequest(
      url: 'post/delete/$postId',
      request: EmptyRequest(),
    );
  }


  //TODO there is no endpoint.
  @override
  Future<void> sendReport({
    required String postId,
    required String topic,
    required String description,
  }) {
    return getConnect
        .postRequest(
            url: 'url',
            request: ReportModel(
              id: postId,
              topic: topic,
              description: description,
            ))
        .then((value) {
      value.isOk;
    });
  }
}

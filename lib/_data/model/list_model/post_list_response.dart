import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/post/post_model.dart';

class PostListResponse extends ListModel<PostModel> {
  PostListResponse({
    required List<PostModel> data,
    required Pagination pagination,
  }) : super(
          data: data,
          pagination: pagination,
        );

  factory PostListResponse.fromJson(Map<String, dynamic> json) {
    return PostListResponse(
      data:
          List<PostModel>.from(json['data'].map((x) => PostModel.fromJson(x))),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

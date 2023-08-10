import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/post/comment_model.dart';
import 'package:parallel/_data/model/model/post/post_model.dart';
import 'package:parallel/_domain/repository/abstract/post_repository.dart';
import 'package:parallel/_domain/wrapper/post_detail_wrapper.dart';
import 'package:parallel/route/app_routes.dart';

class PostDetailController extends GetxController {
  final PostRepository _postRepository = Get.find();
  final Rx<PostModel?> _postRx = Rx(null);
  final RxBool isPostLoading = false.obs;
  final TextEditingController commentController = TextEditingController();
  final RxList<CommentModel> commentListRx = RxList.empty();
  final RxString commentTextRx = ''.obs;
  final RxInt commentsAmountRx = 0.obs;

  late final String postId;

  PostDetailController() {
    final PostDetailWrapper wrapper = Get.arguments as PostDetailWrapper;
    postId = wrapper.postId;
  }

  @override
  void onInit() {
    super.onInit();
    getPostById();
    getCommentsById();
  }

  void getPostById() async {
    isPostLoading.value = true;
    _postRepository.getPostById(postId: postId).then((PostModel post) {
      _postRx.value = post;
      isPostLoading.value = false;
      commentsAmountRx.value = post.commentsAmount;
    });
  }

  void getCommentsById({bool reset = false}) {
    commentListRx.clear();
    _postRepository.getCommentsByPostId(postId: postId).then(
          (comment) => commentListRx.value = comment,
        );
    if (commentListRx.isNotEmpty && reset) {
      commentListRx.clear();
    }
  }

  void checkTextComment(String text) {
    commentTextRx.value = text;
  }

  void likePost() {
    if (!_postRx.value!.isLiked) {
      ++_postRx.value!.likesAmount;
      _postRx.value!.isLiked = true;
    } else {
      --_postRx.value!.likesAmount;
      _postRx.value!.isLiked = false;
    }

    _postRepository.likePost(postId: _postRx.value!.id);

    _postRx.refresh();
  }

  void postComment() {
    if (commentTextRx.value.isEmpty) {
      return;
    }
    _postRepository
        .postComment(
      postId: postId,
      comment: commentTextRx.value,
    )
        .then((isOkay) {
      if (isOkay) {
        getCommentsById();
      }
    });
    commentTextRx.value = '';
    commentsAmountRx.value++;
    commentController.clear();
  }

  void openProfile({required String personId}) {
    Get.toNamed(RoutePaths.otherProfile, arguments: personId);
  }

  String getVideoIdFromUrl(String url) {
    RegExp regExp = RegExp(r"(?<=youtu\.be\/|v\=)([^#\&\?]*).*");
    Match? match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  PostModel get post => _postRx.value!;
}

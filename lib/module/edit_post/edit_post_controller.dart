import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/post/post_model.dart';
import 'package:parallel/_domain/repository/abstract/post_repository.dart';
import 'package:parallel/_domain/wrapper/post_detail_wrapper.dart';
import 'package:parallel/module/profile/profile_controller.dart';
import 'package:video_player/video_player.dart';

class EditPostController extends GetxController {
  late final String postId;
  final Rx<PostModel?> _postRx = Rx(null);
  final PostRepository _postRepository = Get.find();
  final TextEditingController textController = TextEditingController();
  late final VideoPlayerController videoPlayerController;

  final RxBool isVideoInizialized = false.obs;
  final RxBool isPostLoading = true.obs;

  final RxDouble mediaHeight = (Get.width * 0.5).obs;

  EditPostController() {
    final PostDetailWrapper wrapper = Get.arguments as PostDetailWrapper;
    postId = wrapper.postId;
  }

  @override
  void onInit() async {
    isPostLoading.value = true;
    await getPostById();
    await _initializePlayer();
    isPostLoading.value = false;

    super.onInit();
  }

  Future<void> getPostById() async {
    await _postRepository.getPostById(postId: postId).then((PostModel post) {
      _postRx.value = post;
      textController.text = post.text;
    });
  }

  void editPost() {
    _postRepository
        .editPost(postId: postId, text: textController.text)
        .then((value) {
      Get.close(3);
      Get.find<ProfileController>().getMyPost();
    });
  }

  Future<void> _initializePlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(post.mediaUrl),
    );

    videoPlayerController.initialize().then((value) {
      isVideoInizialized.value = true;
      videoPlayerController.setVolume(0);
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
    }).onError((error, stackTrace) {
      isVideoInizialized.value = false;
      videoPlayerController.dispose();
    });
  }

  PostModel get post => _postRx.value!;
}

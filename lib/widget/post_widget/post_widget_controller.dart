import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/post/post_model.dart';
import 'package:parallel/_domain/repository/abstract/post_repository.dart';
import 'package:parallel/_domain/wrapper/post_detail_wrapper.dart';
import 'package:parallel/module/profile/profile_controller.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/util/extensions/snackbar.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/post_widget/widget/report_post_widget.dart';
import 'package:video_player/video_player.dart';

class PostWidgetController extends GetxController {
  final PostRepository _postRepository = Get.find();

  late Rx<PostModel> _postRx;
  late VideoPlayerController videoPlayerController;

  final RxBool isMediaInizialized = false.obs;
  final RxBool isVideoPlaying = false.obs;
  final RxBool isMuted = false.obs;
  final RxBool isControlPanelVisible = true.obs;
  final RxBool isVideoLoadingInProgress = false.obs;
  final TextEditingController topicController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxString position = RxString('0:00:00');

  final double soundVolume = 4.0;

  Timer? timer;

  PostWidgetController({
    required PostModel post,
  }) {
    _postRx = Rx(post);
  }

  @override
  void onInit() {
    _initializePlayer();
    super.onInit();
  }

  void handleInvisible() {
    if (post.isVideoPost) {
      pauseVideo();
    }
  }

  void handleTapOnPlayButton() {
    if (isVideoPlaying.value) {
      pauseVideo();
    } else {
      playVideo();
      if (!isControlPanelVisible.value) {
        isControlPanelVisible.value = true;
        hideControlPannel();
      }
    }
  }

  void handleTapOnVideo() {
    if (!isControlPanelVisible.value || !isVideoPlaying.value) {
      isControlPanelVisible.value = true;
      hideControlPannel();
    } else {
      isControlPanelVisible.value = !isControlPanelVisible.value;
    }
  }

  void hideControlPannel() {
    if (!isControlPanelVisible.value) {
      isControlPanelVisible.value = true;
      Timer(const Duration(seconds: 5), () {
        isControlPanelVisible.value = false;
      });
    }
  }

  void _initializePlayer() {
    if (post.isVideoPost) {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(
          post.mediaUrl,
        ),
      );

      videoPlayerController.initialize().then((value) {
        isMediaInizialized.value = true;
        videoPlayerController.setLooping(true);
      }).onError((error, stackTrace) {
        isMediaInizialized.value = false;
        videoPlayerController.dispose();
      });
    }
  }

  void openEditPostBS() {
    Get.bottomSheet(
      PBottomSheetWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PButtonWidget(
                text: 'txt_edit_post'.tr.capitalizeFirst!,
                colorTrascparent: true,
                onPressed: () => openEditPostBS(),
              ),
              const SizedBox(height: 16),
              PButtonWidget(
                colorBorder: Get.theme.colorScheme.error,
                textStyle: Get.theme.textTheme.displayMedium!.copyWith(
                  color: Get.theme.colorScheme.error,
                ),
                text: 'txt_delete_post'.tr.capitalizeFirst!,
                colorTrascparent: true,
                onPressed: () => openDeletePostBS(),
              ),
              const SizedBox(height: 16),
              PButtonWidget(
                text: 'txt_cancel'.tr.capitalizeFirst!,
                onPressed: () => Get.back(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openDeletePostBS() {
    Get.bottomSheet(
      PBottomSheetWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PButtonWidget(
                colorBorder: Get.theme.colorScheme.error,
                textStyle: Get.theme.textTheme.displayMedium!.copyWith(
                  color: Get.theme.colorScheme.error,
                ),
                text: 'txt_delete'.tr.capitalizeFirst!,
                colorTrascparent: true,
                onPressed: () => deletePost(),
              ),
              const SizedBox(height: 16),
              PButtonWidget(
                text: 'txt_cancel'.tr.capitalizeFirst!,
                onPressed: () => Get.back(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void playVideo() {
    if (!post.isVideoPost || !isMediaInizialized.value) {
      return;
    }
    if (isMediaInizialized.value && !videoPlayerController.value.isPlaying) {
      isVideoPlaying.value = true;
      isControlPanelVisible.value = false;

      videoPlayerController.play();
      startTimer();
    }
  }

  void pauseVideo() {
    if (!post.isVideoPost || !isMediaInizialized.value) {
      return;
    }
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    isVideoLoadingInProgress.value = false;
    isVideoPlaying.value = false;
    videoPlayerController.pause();
  }

  void deletePost() {
    _postRepository.deletePost(postId: post.id).then((value) {
      while (Get.isBottomSheetOpen!) {
        Get.back();
      }
      Get.close(1);
      Get.find<ProfileController>().getMyPost();
    });
  }

  void toggleMute() {
    if (isMuted.value) {
      videoPlayerController.setVolume(soundVolume);
    } else {
      videoPlayerController.setVolume(0.0);
    }
    isMuted.toggle();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (!videoPlayerController.value.isPlaying) {
        t.cancel();
      } else {
        position.value = videoPlayerController.value.position.toString().split('.').first;
      }
    });
  }

  String getVideoIdFromUrl(String url) {
    RegExp regExp = RegExp(r"(?<=youtu\.be\/|v\=)([^#\&\?]*).*");
    Match? match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  void getPostById(String postId) {
    _postRepository.getPostById(postId: postId).then((PostModel post) {
      _postRx.value = post;
      _postRx.refresh();
    });
  }

  void likePost() {
    if (!_postRx.value.isLiked) {
      ++_postRx.value.likesAmount;
      _postRx.value.isLiked = true;
    } else {
      --_postRx.value.likesAmount;
      _postRx.value.isLiked = false;
    }

    _postRepository.likePost(postId: _postRx.value.id);

    _postRx.refresh();
  }

  void openEditPostPage() {
    Get.toNamed(
      RoutePaths.editPost,
      arguments: PostDetailWrapper(postId: post.id),
    );
  }

  void openDetailPage(String postId) {
    Get.toNamed(
      RoutePaths.postDetail,
      arguments: PostDetailWrapper(postId: postId),
    )!
        .whenComplete(() {
      getPostById(post.id);
    });
  }

  void openProfilePage({required String personId}) {
    Get.toNamed(RoutePaths.otherProfile, arguments: personId);
  }

  void openOptionMenu(String postId) {
    Get.bottomSheet(
      PBottomSheetTransparentWidget(
        textFirstButton: 'txt_report_post'.tr.capitalizeFirst!,
        onTapFirstButton: () => reportPost(postId),
        onCancel: () => Get.back(),
      ),
    );
  }

  @override
  void onClose() {
    if (isMediaInizialized.value) {
      videoPlayerController.dispose();
    }
  }

  PostModel get post => _postRx.value;

  void reportPost(String postId) {
    Get.bottomSheet(const PBottomSheetWidget(child: ReportPostWidget(),));
  }

  void sendReport(String postId) {
    _postRepository.sendReport(postId: postId, topic: topicController.text, description: descriptionController.text).then((value){
      Get.close(2);
      Get.showSuccessMessage('txt_your_report_has_been_sent'.tr.capitalizeFirst!,
          icon: 'icon_warning');
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/widget/p_image_widget.dart';
import 'package:parallel/widget/p_svg_icon.dart';
import 'package:parallel/widget/profile/widget/video_item_widget/video_item_controller.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_player/video_player.dart';

class VideoItemWidget<T> extends StatelessWidget {
  late final VideoItemController controller;
  final Function(String postId) openDetailPost;
  final bool
      playOnOpen; //TODO required to decide how to view vids inside gallery tab list

  final T media;

  VideoItemWidget({
    required this.media,
    required this.openDetailPost,
    this.playOnOpen = false,
    super.key,
  }) {
    if (!Get.isRegistered<VideoItemController>(
      tag: 'media_${(media as dynamic).id}',
    )) {
      Get.lazyPut(
        () => VideoItemController(),
        tag: 'media_${(media as dynamic).id}',
      );
    }

    controller =
        Get.find<VideoItemController>(tag: 'media_${(media as dynamic).id}');
    controller.initializePlayer(media);
  }

  @override
  Widget build(BuildContext context) {
    return (media as dynamic).type == 3 ? _youtube() : _video();
  }

  Widget _video() {
    return Obx(
      () => controller.isMediaInizialized
              .value //TODO discuss how to handle vids in gallery and posts
          ? GestureDetector(
              onTap: () => openDetailPost((media as dynamic).id),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio:
                        controller.videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(controller.videoPlayerController),
                  ),
                ],
              ),
            )
          : GestureDetector(
              onTap: () => openDetailPost((media as dynamic).id),
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  shape: BoxShape.rectangle,
                  height: Get.height / 4,
                  width: Get.width,
                ),
              ),
            ),
    );
  }

  Widget _youtube() {
    String videoId = controller.getVideoIdFromUrl((media as dynamic).mediaUrl);
    String thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';
    double mediaWidth = (Get.width - 3) / 2.5;

    return GestureDetector(
      onTap: () => openDetailPost((media as dynamic).id),
      child: videoId.isNotEmpty
          ? Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: PImageWidget(
                    url: thumbnailUrl,
                    width: mediaWidth,
                    height: mediaWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                const PSVGIcon(
                  icon: 'icon_play',
                  width: 40,
                  height: 40,
                )
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PImageWidget(
                url:
                    'https://cdn.pixabay.com/photo/2015/03/10/17/23/youtube-667451_1280.png',
                width: mediaWidth,
                height: mediaWidth,
                fit: BoxFit.contain,
              ),
            ),
    );
  }
}

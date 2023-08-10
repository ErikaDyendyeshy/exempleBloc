import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/post/post_model.dart';
import 'package:parallel/const.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/post_widget/post_widget_controller.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostWidget extends StatelessWidget {
  late final PostWidgetController controller;

  final PostModel post;
  final bool isDetailPost;
  final bool isMyPost;
  final int? commentsAmount;

  PostWidget({
    super.key,
    required this.post,
    required this.isDetailPost,
    this.commentsAmount,
    this.isMyPost = false,
  }) {
    if (!Get.isRegistered<PostWidgetController>(
      tag: 'post_${post.id}',
    )) {
      Get.lazyPut(
        () => PostWidgetController(
          post: post,
        ),
        tag: 'post_${post.id}',
      );
    }

    controller = Get.find<PostWidgetController>(tag: 'post_${post.id}');
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('post_${post.id}'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction <= 0.4 && !isDetailPost) {
          controller.handleInvisible();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: horizontalPaddingScreen,
              right: horizontalPaddingScreen,
              bottom: 12,
            ),
            child: Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () => controller.openProfilePage(personId: controller.post.userId),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PAvatarWidget(
                          height: 40,
                          width: 40,
                          avatarUrl: controller.post.avatarUrl,
                          borderRadius: 8,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          controller.post.username,
                          style: Get.theme.textTheme.headlineMedium,
                        ),
                        const Spacer(),
                        if (isMyPost)
                          Center(
                            child: PSVGIcon(
                              icon: 'icon_more',
                              onTap: controller.openEditPostBS,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                if (!isMyPost)
                  GestureDetector(
                      onTap: () => controller.openOptionMenu(controller.post.id),
                      child: const PSVGIcon(icon: 'icon_more')),
              ],
            ),
          ),
          if (controller.post.type == 0) _text(),
          if (controller.post.type == 1) _image(),
          if (controller.post.type == 2) _video(),
          if (controller.post.type == 3) _youtube(),
          if (controller.post.type == 4)
            _nft(), // TODO Cannot test, waiting for nft link from back-end

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPaddingScreen,
              vertical: 18,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Row(
                    children: [
                      PSVGIcon(
                        icon: controller.post.isLiked ? 'icon_like_red' : 'icon_like',
                        onTap: () => controller.likePost(),
                      ),
                      const SizedBox(width: 17),
                      Text(
                        '${controller.post.likesAmount} ${'txt_likes'.tr}',
                        style: Get.theme.textTheme.titleLarge,
                      ),
                      const SizedBox(width: 17),
                      GestureDetector(
                        onTap: () =>
                            isDetailPost ? null : controller.openDetailPage(controller.post.id),
                        child: Row(
                          children: [
                            const PSVGIcon(icon: 'icon_chat'),
                            const SizedBox(width: 17),
                            Text(
                              isDetailPost
                                  ? '$commentsAmount ${'txt_comments'.tr}'
                                  : '${controller.post.commentsAmount} ${'txt_comments'.tr}',
                              style: Get.theme.textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  controller.post.createdOnString,
                  style: Get.theme.textTheme.titleLarge,
                ),
              ],
            ),
          ),
          controller.post.text.isEmpty || controller.post.type == 0
              ? const SizedBox.shrink()
              : _text(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget _text() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
      child: GestureDetector(
        onTap: () => isDetailPost ? null : controller.openDetailPage(controller.post.id),
        child: Text(
          controller.post.text,
          style: Get.textTheme.labelLarge!.copyWith(
            fontSize: 14,
          ),
          maxLines: isDetailPost ? null : 2,
          overflow: isDetailPost ? null : TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _image() {
    return GestureDetector(
      onTap: () => isDetailPost ? null : controller.openDetailPage(controller.post.id),
      child: Image(
        fit: BoxFit.cover,
        width: Get.width,
        image: NetworkImage(
          controller.post.mediaUrl,
        ),
      ),
    );
  }

  Widget _nft() {
    return Image(
      fit: BoxFit.cover,
      width: Get.width,
      image: NetworkImage(
        controller.post.nftLink,
      ),
    );
  }

  Widget _youtube() {
    String videoId = controller.getVideoIdFromUrl(controller.post.mediaUrl);
    return Center(
      child: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        ),
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
      ),
    );
  }

  Widget _video() {
    return Obx(
      () => controller.isMediaInizialized.value
          ? GestureDetector(
              onTap: controller.handleTapOnVideo,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: controller.videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(controller.videoPlayerController),
                  ),
                  if (controller.isControlPanelVisible.value)
                    Obx(
                      () => PSVGIcon(
                        icon: controller.isVideoPlaying.value ? 'icon_pause' : 'icon_play',
                        color: AppColors.white,
                        width: 40,
                        height: 40,
                        onTap: controller.handleTapOnPlayButton,
                      ),
                    ),
                  if (controller.isControlPanelVisible.value)
                    Positioned(
                      bottom: 0,
                      child: Container(
                        color: Colors.black45,
                        height: 40,
                        width: Get.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 5),
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: PSVGIcon(
                                  icon: controller.isMuted.value ? 'icon_mute' : 'icon_volume',
                                  onTap: controller.toggleMute,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: VideoProgressIndicator(
                                controller.videoPlayerController,
                                allowScrubbing: false,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Obx(
                              () => SizedBox(
                                width: 120,
                                child: Text(
                                  '${controller.position.value} / ${controller.videoPlayerController.value.duration.toString().split('.').first}',
                                  style: const TextStyle(color: AppColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )
          : SkeletonAvatar(
              style: SkeletonAvatarStyle(
                shape: BoxShape.rectangle,
                height: Get.height / 4,
                width: Get.width,
              ),
            ),
    );
  }
}

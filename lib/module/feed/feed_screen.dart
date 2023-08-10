import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/feed/feed_controller.dart';
import 'package:parallel/widget/p_list_view_widget.dart';
import 'package:parallel/widget/post_widget/post_widget.dart';
import 'package:skeletons/skeletons.dart';

class FeedScreen extends GetView<FeedController> {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PListViewWidget(
        onPullToRefresh: () => controller.getPostList(reset: true),
        onEndOfPage: () => controller.loadMorePosts(),
        loadingItem: SkeletonAvatar(
          style: SkeletonAvatarStyle(
            height: 300,
            width: Get.width,
          ),
        ),
        count: controller.postListRx.length,
        onBuildItem: (int index) {
          return PostWidget(
            post: controller.postListRx[index]!,
            isDetailPost: false,
          );
        },
      ),
    );
  }
}

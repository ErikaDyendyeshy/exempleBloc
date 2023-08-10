import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/profile/profile_controller.dart';
import 'package:parallel/widget/profile/p_profile_skeleton.dart';
import 'package:parallel/widget/profile/p_profile_widget.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const PProfileSkeleton()
          : Obx(
              () => PProfileWidget(
                tapController: controller.tabController,
                avatarUrl: controller.selfProfile.value!.user.avatarUrl,
                userName: controller.selfProfile.value!.user.name,
                country: controller.selfProfile.value!.user.country ?? '',
                postList: controller.postListRx.toList(),
                galleryList: controller.galleryListRx.toList(),
                followers: controller.relationsCountRx.value == null
                    ? '0'
                    : controller.relationsCountRx.value!.followersCount
                        .toString(),
                following: controller.relationsCountRx.value == null
                    ? '0'
                    : controller.relationsCountRx.value!.followingCount
                        .toString(),
                secondButton: () => controller.editProfileScreen(),
                firstButton: () => controller.goToCreatePost(),
                aboutMe: controller.selfProfile.value!.user.aboutMe,
                openShowMoreAboutMe: () => controller.openShowMoreAboutMe(),
                openDetailPage: (postId) => controller.openDetailPage(postId),
                openConnectionList: () => controller.openConnectionList(),
                loadMorePages: () => controller.loadMoreGalleryPages(),
              ),
            ),
    );
  }
}

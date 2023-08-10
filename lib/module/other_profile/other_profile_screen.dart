import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/other_profile/other_profile_controller.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/profile/p_profile_skeleton.dart';
import 'package:parallel/widget/profile/p_profile_widget.dart';

class OtherProfileScreen extends GetView<OtherProfileController> {
  const OtherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
         GestureDetector(
           onTap: () => controller.openOptionMenu(),
           child: const Padding(
             padding: EdgeInsets.symmetric(horizontal: 16.0),
             child: PSVGIcon(icon: 'icon_more'),
           ),
         )
        ],
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text(
          'txt_user_profile'.tr.capitalizeFirst!,
        ),
        elevation: 0,
      ),
      body: Obx(
        () => controller.profileRx.value == null ||
                controller.relationsCount.value == null
            ? const PProfileSkeleton()
            : PProfileWidget(
                isFollowing: controller.profileRx.value!.iFollowing!,
                tapController: controller.tabController,
                avatarUrl: controller.profileRx.value!.user.avatarUrl,
                userName: controller.profileRx.value!.user.name,
                country: controller.profileRx.value!.user.country ?? '',
                postList: const [],
                galleryList: const  [],
                loadMorePages: () {},
                followers:
                    controller.relationsCount.value!.followersCount.toString(),
                following:
                    controller.relationsCount.value!.followingCount.toString(),
                secondButton: () => controller.openChatRoom(),
                firstButton: () => controller.toggleFollow(),
                loading: controller.isFollowInProgress.value,
                aboutMe: controller.profileRx.value!.user.aboutMe,
                openShowMoreAboutMe: () => controller.openShowMoreAboutMe(),
                otherProfile: true,
              ),
      ),
    );
  }
}

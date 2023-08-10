import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/profile/profile_model.dart';
import 'package:parallel/_data/model/model/relations_count_model.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/module/other_profile/widget/report_user_widget.dart';
import 'package:parallel/util/extensions/snackbar.dart';
import 'package:parallel/widget/__.dart';

class OtherProfileController extends GetxController with GetSingleTickerProviderStateMixin {
  final ProfileRepository _profileRepository = Get.find();
  late TabController tabController;
  final Rx<RelationsCountModel?> relationsCount = Rx(null);
  final Rx<ProfileModel?> profileRx = Rx(null);
  final TextEditingController topicController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late String profileId = '';
  final RxBool isLoading = false.obs;
  final RxBool isFollowInProgress = false.obs;

  OtherProfileController() {
    profileId = Get.arguments as String;
    getUserById(profileId: profileId);
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    getRelationsCount();
    isLoading.value = false;
  }

  Future<void> getRelationsCount() async {
    relationsCount.value = await _profileRepository.getRelationsCount(
      profileId: profileId,
    );
  }

  Future<void> getUserById({required String profileId}) async {
    isLoading.value = true;
    await _profileRepository.getProfileById(profileId: profileId).then((ProfileModel profileModel) {
      profileRx.value = profileModel;
      isLoading.value = false;
    });
    isLoading.value = false;
  }

  void openChatRoom() {
    Get.showErrorMessage('Sorry!', 'This section is under development');
  }

  void followUser() {
    isFollowInProgress.value = true;
    _profileRepository.follow(followingId: profileId).then((value) {
      getRelationsCount();
      getUserById(profileId: profileId);
      isFollowInProgress.value = false;
    });
    isFollowInProgress.value = false;
  }

  void unfollowUser() {
    isFollowInProgress.value = true;
    _profileRepository.unfollow(unfollowId: profileId).then((value) {
      getRelationsCount();
      getUserById(profileId: profileId);
      isFollowInProgress.value = false;
    });
    isFollowInProgress.value = false;
  }

  void toggleFollow() {
    if (profileRx.value!.iFollowing == true) {
      unfollowUser();
    } else {
      followUser();
    }
  }

  void openShowMoreAboutMe() {
    Get.bottomSheet(
      isScrollControlled: true,
      PBottomSheetWidget(
        child: PMoreAboutUserWidget(
          aboutUser: profileRx.value!.user.aboutMe,
          customInfo: profileRx.value!.customInfo,
          tags: profileRx.value!.tags,
        ),
      ),
    );
  }

  void openOptionMenu() {
    Get.bottomSheet(
      PBottomSheetTransparentWidget(
        textFirstButton: 'txt_block_user'.tr.capitalizeFirst!,
        textSecondButton: 'txt_report_user'.tr.capitalizeFirst!,
        onTapFirstButton: () => confirmBlockUser(),
        onTapSecondButton: () => reportUser(),
        onCancel: () => Get.back(),
      ),
    );
  }

  void confirmBlockUser() {
    Get.bottomSheet(PBottomSheetWidget(
      title: '${'txt_block_user'.tr.capitalizeFirst!}?',
      description: 'txt_user_wont_be_able_to_message_you_or_view'.tr.capitalizeFirst!,
      onPressedFirstButton: () => blockUser(userId: profileId),
      onPressedSecondButton: () => Get.close(2),
      textFirstButton: 'txt_block_user'.tr.capitalizeFirst!,
      textSecondButton: 'txt_cancel'.tr.capitalizeFirst!,
    ));
  }

  void blockUser({required String userId}) {
    _profileRepository.blockUser(userId: userId).then((value) {
      Get.close(2);
      Get.showSuccessMessage('txt_the_user_is_blocked'.tr.capitalizeFirst!, icon: 'icon_warning');
    });
  }

  void unBlockUser({required String userId}) {
    _profileRepository.unBlockUser(userId: userId).then((value) {
      Get.close(2);
      Get.showSuccessMessage('txt_the_user_is_blocked'.tr.capitalizeFirst!, icon: 'icon_warning');
    });
  }

  void reportUser() {
    Get.bottomSheet(
      const PBottomSheetWidget(
        child: ReportUserWidget(),
      ),
    );
  }

  void sendReport() {
    _profileRepository
        .sendReportUser(
      userId: profileId,
      topic: topicController.text,
      description: descriptionController.text,
    )
        .then((value) {
      Get.close(2);
      Get.showSuccessMessage('txt_your_user_report_has_been_sent'.tr.capitalizeFirst!,
          icon: 'icon_warning');
    });
  }
}

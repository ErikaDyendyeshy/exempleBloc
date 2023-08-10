import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/notification/notification_model.dart';
import 'package:parallel/_domain/repository/abstract/notification_repository.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/route/app_routes.dart';

class NotificationListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final NotificationRepository _notificationRepository = Get.find();
  final ProfileRepository _profileRepository = Get.find();
  final RxList<NotificationModel> _initialNotificationList = RxList.empty();
  final RxList<NotificationModel> notificationRequestList = RxList.empty();
  final RxList<NotificationModel> notificationAlertList = RxList.empty();
  //TODO decide how to update list of notifications properly

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getFollowRequests();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    getFollowRequests();
  }

  void getFollowRequests() {
    isLoading.value = true;
    _notificationRepository.getFollows().then((value) {
      _initialNotificationList.value = value;
      notificationRequestList.clear();
      notificationAlertList.clear();
      for (NotificationModel notification in value) {
        if (notification.type == 0) {
          notificationRequestList.add(notification);
        } else if (notification.type == 1) {
          notificationAlertList.add(notification);
        }
      }
    });
    isLoading.value = false;
  }

  void followUser(String profileId) {
    _profileRepository.follow(followingId: profileId).then((value) {
      return getFollowRequests();
    });
  }

  void unfollowUser(String profileId) {
    _profileRepository.unfollow(unfollowId: profileId).then((value) {
      return getFollowRequests();
    });
  }

  void openOtherProfile(String personId) {
    Get.toNamed(RoutePaths.otherProfile, arguments: personId);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

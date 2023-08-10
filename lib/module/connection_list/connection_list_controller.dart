import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/connection_model.dart';
import 'package:parallel/_data/model/model/relations_count_model.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/util/mixin/subscribe_self_profile_mixin.dart';

class ConnectionListController extends GetxController
    with SubscribeSelfProfileMixin, GetSingleTickerProviderStateMixin {
  final ProfileRepository _profileRepository = Get.find();
  late TabController tabController;
  final Rx<RelationsCountModel?> relationsCountRx = Rx(null);
  final RxList<ConnectionModel> followersListRx = RxList.empty();
  final RxList<ConnectionModel> followingListRx = RxList.empty();
  final RxBool isLoading = false.obs;

  ConnectionListController() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void onReady() async {
    super.onReady();
    isLoading.value = true;
    await getRelationsCount();
    await getFollowsList();
    await getFollowersList();
    isLoading.value = false;
  }

  Future<void> getRelationsCount() async {
    isLoading.value = true;
    await _profileRepository
        .getRelationsCount(profileId: selfProfile.value!.user.id)
        .then((RelationsCountModel relationsCount) {
      relationsCountRx.value = relationsCount;
      isLoading.value = false;
    });
    isLoading.value = false;
  }

  Future<void> getFollowsList() async {
    List<ConnectionModel> connectionList = await _profileRepository.getFollowsList();
    updateFollowsList(connectionList);
  }

  void updateFollowsList(List<ConnectionModel> newList) {
    isLoading.value = true;

    followingListRx.removeWhere((item) => !newList.contains(item));
    for (var newItem in newList) {
      if (!followingListRx.contains(newItem)) {
        followingListRx.add(newItem);
      }
    }
    isLoading.value = false;

  }

  Future<void> getFollowersList() async {
    List<ConnectionModel> connectionList = await _profileRepository.getFollowersList();
    updateFollowersList(connectionList);
  }

  void updateFollowersList(List<ConnectionModel> newList) {
    isLoading.value = true;

    followersListRx.removeWhere((item) => !newList.contains(item));
    for (var newItem in newList) {
      if (!followersListRx.contains(newItem)) {
        followersListRx.add(newItem);
      }
    }
    isLoading.value = false;

  }

  void followUser(String profileId) async {
    await _profileRepository.follow(followingId: profileId);
    await getRelationsCount();
    await getFollowersList();
    await getFollowsList();
  }

  void unfollowUser(String profileId) async {
    await _profileRepository.unfollow(unfollowId: profileId);
    await getRelationsCount();
    await getFollowersList();
    await getFollowsList();
  }

  void openOtherProfile(String profileId) {
    Get.toNamed(RoutePaths.otherProfile, arguments: profileId);
  }

 void getBack() {
    Get.back(result: true);
 }
}

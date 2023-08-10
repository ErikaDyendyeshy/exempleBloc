import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/connection_model.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/connection_list/connection_list_controller.dart';
import 'package:parallel/widget/__.dart';

class ConnectionWidget extends GetView<ConnectionListController> {
  final ConnectionModel connection;
  final bool followersList;

  const ConnectionWidget({
    super.key,
    required this.connection,
    this.followersList = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPaddingScreen,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (connection.follower == null) {
                    controller.openOtherProfile(connection.following!.id);
                  } else {
                    controller.openOtherProfile(connection.follower!.id);
                  }
                },
                child: PAvatarWidget(
                  width: 48,
                  height: 48,
                  avatarUrl: connection.follower == null
                      ? connection.following!.avatarUrl
                      : connection.follower!.avatarUrl,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                connection.follower == null
                    ? connection.following!.name
                    : connection.follower!.name,
                style: Get.theme.textTheme.labelLarge!.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          followersList == false
              ? PButtonWidget(
                  width: 90,
                  height: 30,
                  borderRadius: 14,
                  text: 'txt_unfollow'.tr,
                  colorTrascparent: true,
                  loading: controller.isLoading.value,
                  onPressed: () => controller.unfollowUser(connection.following!.id),
                )
              : connection.follower!.isSubscribed == false
                  ? PButtonWidget(
                      width: 90,
                      height: 30,
                      borderRadius: 14,
                      text: 'txt_follow'.tr,
                      loading: controller.isLoading.value,
                      onPressed: () => controller.followUser(connection.follower!.id),
                    )
                  : const SizedBox.shrink()
        ],
      ),
    );
  }
}

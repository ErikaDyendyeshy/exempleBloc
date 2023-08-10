import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/notification/notification_model.dart';
import 'package:parallel/const.dart';
import 'package:parallel/widget/p_avatar_widget.dart';
import 'package:parallel/widget/p_button_widget.dart';

class NotificationItemWidget extends StatelessWidget {
  final bool isRequest;
  final NotificationModel notification;
  final VoidCallback openOtherProfile;
  final VoidCallback followUser;
  final VoidCallback unfollowUser;

  const NotificationItemWidget({
    required this.notification,
    required this.followUser,
    required this.unfollowUser,
    required this.openOtherProfile,
    this.isRequest = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: horizontalPaddingScreen,
      ),
      child: GestureDetector(
        onTap: openOtherProfile,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PAvatarWidget(
              height: 48,
              width: 48,
              borderRadius: 12,
              avatarUrl: notification.follower.avatartUrl,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  notification.follower.name,
                  style: Get.theme.textTheme.titleLarge!.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Started following',
                  style: Get.theme.textTheme.labelLarge!.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  '2 hours ago'.toUpperCase(),
                  style: Get.theme.textTheme.titleSmall!.copyWith(fontSize: 10),
                ),
              ],
            ),
            const Spacer(),
            isRequest
                ? !notification.follower.isFollowing
                    ? PButtonWidget(
                        width: 90,
                        height: 30,
                        borderRadius: 14,
                        text: 'txt_follow'.tr,
                        onPressed: followUser,
                      )
                    : PButtonWidget(
                        width: 90,
                        height: 30,
                        borderRadius: 14,
                        text: 'txt_unfollow'.tr,
                        colorTrascparent: true,
                        onPressed: unfollowUser,
                      )
                : Container() //TODO waiting for item post from back-end
          ],
        ),
      ),
    );
  }
}

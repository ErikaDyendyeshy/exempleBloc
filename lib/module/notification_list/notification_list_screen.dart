import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/notification_list/notification_list_controller.dart';
import 'package:parallel/module/notification_list/widget/notification_item_widget.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/p_list_view_widget.dart';
import 'package:parallel/widget/p_tab_bar_label_widget.dart';

class NotificationListScreen extends GetView<NotificationListController> {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            border: const Border(
              bottom: BorderSide(
                width: 2.5,
                color: AppColors.gray100,
              ),
            ),
          ),
          height: 50,
          child: TabBar(
            controller: controller.tabController,
            indicatorColor: AppColors.black,
            indicatorWeight: 3,
            tabs: [
              TabBarLabelWidget(
                text: 'txt_requests'.tr.capitalizeFirst!,
                isSelected: controller.tabController.index == 0 ? true : false,
              ),
              TabBarLabelWidget(
                text: 'txt_alerts'.tr.capitalizeFirst!,
                isSelected: controller.tabController.index == 1 ? true : false,
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              _listRequest(),
              _listAlerts(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listRequest() {
    return Obx(
      () => controller.notificationRequestList.isNotEmpty
          ? PListViewWidget(
              count: controller.notificationRequestList.length,
              isLoading: controller.isLoading.value,
              onBuildItem: (index) => NotificationItemWidget(
                followUser: () => controller.followUser(
                  controller.notificationRequestList[index].follower.id,
                ),
                unfollowUser: () => controller.unfollowUser(
                  controller.notificationRequestList[index].follower.id,
                ),
                isRequest: true,
                notification: controller.notificationRequestList[index],
                openOtherProfile: () => controller.openOtherProfile(
                  controller.notificationRequestList[index].follower.id,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                ),
                const PSVGIcon(icon: 'icon_notification_gradient'),
                Text(
                  'txt_here_will_be_displayed_all_notifications'.tr.capitalizeFirst!,
                  style: Get.theme.textTheme.titleLarge!.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _listAlerts() {
    return Obx(
      () => controller.notificationAlertList.isNotEmpty
          ? PListViewWidget(
              count: 2,
              isLoading: controller.isLoading.value,
              onBuildItem: (index) => NotificationItemWidget(
                isRequest: false,
                notification: controller.notificationAlertList[index],
                followUser: () => controller.followUser(
                  controller.notificationAlertList[index].follower.id,
                ),
                unfollowUser: () => controller.unfollowUser(
                  controller.notificationAlertList[index].follower.id,
                ),
                openOtherProfile: () => controller.isLoading,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200
                ),
                const PSVGIcon(icon: 'icon_notification_gradient'),
                const SizedBox(height: 15),
                Text(
                  'txt_here_will_be_displayed_all_notifications'.tr.capitalizeFirst!,
                  style: Get.theme.textTheme.titleLarge!.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
    );
  }
}

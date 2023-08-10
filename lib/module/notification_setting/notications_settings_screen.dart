import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/notification_setting/notification_setting_controller.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';

class NotificationSettingsScreen extends GetView<NotificationSettingsController> {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          elevation: 0,
          title: Text('txt_notification_settings'.tr.capitalizeFirst!),
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              child: PSVGIcon(
                icon: 'icon_arrow_left',
              ),
            ),
          ),
        ),
        body: _body());
  }

  Widget _body() {
    return ListTile(
      title: Text(
        'txt_notifications'.tr.capitalizeFirst!,
        style: Get.theme.textTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Container(
        height: 31,
        width: 51,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.pink, AppColors.blue],
            ),
            borderRadius: BorderRadius.circular(50)),
        child: Obx(
          () => CupertinoSwitch(
            value: controller.isIncludedNotification.value,
            activeColor: Colors.transparent,
            trackColor: Get.theme.disabledColor,
            onChanged: (bool value) {
              controller.isIncludedNotification.value = value;
              controller.updateNotifications(value);
            },
          ),
        ),
      ),
    );
  }
}

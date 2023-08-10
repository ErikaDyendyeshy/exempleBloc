import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/setting/setting_controller.dart';
import 'package:parallel/widget/__.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          'txt_settings'.tr.capitalizeFirst!,
        ),
        elevation: 0,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _listTileItem(
          title: 'txt_terms_privacy_policy'.tr.capitalize!,
          icon: 'icon_docs',
          onTap: () => controller.openTermsPrivacyPolicyScreen(),
        ),
        _listTileItem(
          title: 'txt_support_email'.tr.capitalizeFirst!,
          icon: 'icon_massage',
          onTap: () => controller.openSupportEmailScreen(),
        ),
        _listTileItem(
          title: 'txt_notification_settings'.tr.capitalizeFirst!,
          icon: 'icon_notification',
          onTap: () => controller.opeNotificationSettingsScreen(),
        ),
        _listTileItem(
          title: 'txt_edit_profile'.tr.capitalizeFirst!,
          icon: 'icon_edit',
          onTap: () => controller.openEditProfileScreen(),
        ),
        _listTileItem(
          title: 'txt_log_out'.tr.capitalizeFirst!,
          icon: 'icon_log_out',
          trailing: false,
          textColor: Get.theme.colorScheme.error,
          onTap: () => controller.showExitConfirmation(),
        ),
      ],
    );
  }

  Widget _listTileItem({
    required String title,
    bool? trailing = true,
    required String icon,
    Color? textColor,
    required Function() onTap,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          horizontalTitleGap: 0,
          title: Text(
            title,
            style: Get.theme.textTheme.headlineMedium!
                .copyWith(fontWeight: FontWeight.w500, color: textColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: verticalPaddingScreen,
          ),
          leading: PSVGIcon(
            icon: icon,
          ),
          trailing: trailing == false
              ? const SizedBox.shrink()
              : PSVGIcon(
                  icon: 'icon_carret_right',
                  color: Get.theme.colorScheme.onSurface,
                ),
        ),
        const Divider()
      ],
    );
  }
}

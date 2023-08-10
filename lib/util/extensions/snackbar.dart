import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';

extension GetInst on GetInterface {
  void showMessage(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }

  void showSuccessMessage(String message, {String? title, String? icon}) {
    Get.snackbar(title ?? '', '',
        titleText: const SizedBox.shrink(),
        messageText: Text(message,
            style: Get.theme.textTheme.labelLarge!.copyWith(
              fontSize: 14,
            )),
        icon:  PSVGIcon(icon: icon ?? 'icon_check_gradient'),
        backgroundColor: Get.theme.colorScheme.background,
        padding: const EdgeInsets.all(20),
        boxShadows: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ]);
  }

  void showErrorMessage(String title, String message) {
    Get.snackbar(
      title,
      message,
      colorText: Get.theme.colorScheme.background,
      backgroundColor: Get.theme.colorScheme.error,
    );
  }
}

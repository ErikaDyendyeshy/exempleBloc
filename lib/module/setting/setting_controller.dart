import 'package:get/get.dart';
import 'package:parallel/_domain/repository/abstract/auth_repository.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/widget/__.dart';

class SettingController extends GetxController {
  final AuthRepository _authRepository = Get.find();

  void openEditProfileScreen() {
    Get.toNamed(RoutePaths.editProfile);
  }

  void openTermsPrivacyPolicyScreen() {
    Get.toNamed(RoutePaths.termsPrivacyPolicy);
  }

  void opeNotificationSettingsScreen() {
    Get.toNamed(RoutePaths.notificationSettings);
  }

  void openSupportEmailScreen() {
    Get.toNamed(RoutePaths.supportEmail);
  }

  void showExitConfirmation() {
    Get.bottomSheet(
      PBottomSheetWidget(
        title: '${'txt_log_out'.tr.capitalizeFirst!}?',
        description: 'txt_are_you_sure_want_to_log_out'.tr.capitalizeFirst!,
        textFirstButton: 'txt_log_out'.tr.capitalizeFirst!,
        textSecondButton: 'txt_cancel'.tr.capitalizeFirst!,
        onPressedFirstButton: () => logOut(),
        onPressedSecondButton: () => Get.back(),
      ),
    );
  }

  void logOut() {
    _authRepository.logout();
  }
}

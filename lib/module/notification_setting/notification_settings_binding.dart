import 'package:get/get.dart';
import 'package:parallel/module/notification_setting/notification_setting_controller.dart';

class NotificationSettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationSettingsController>(() => NotificationSettingsController());
  }
}

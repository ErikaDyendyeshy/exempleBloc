import 'package:get/get.dart';
import 'package:parallel/module/notification_list/notification_list_controller.dart';

class NotificationListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationListController>(() => NotificationListController());
  }
}

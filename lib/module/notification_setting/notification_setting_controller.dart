import 'package:get/get.dart';
import 'package:parallel/_domain/repository/abstract/notification_repository.dart';

class NotificationSettingsController extends GetxController {
  final NotificationRepository _notificationRepository = Get.find();
  final RxBool isIncludedNotification = true.obs;


//TODO чекаю від бекенда статус нотіфікашки

  void updateNotifications(bool status) {
    _notificationRepository.updateNotifications(enabled: status);
    print(status);
  }

}

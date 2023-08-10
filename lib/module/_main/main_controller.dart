import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:parallel/module/notification_list/notification_list_controller.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/util/mixin/get_self_profile_mixin.dart';
import 'package:parallel/util/mixin/subscribe_self_profile_mixin.dart';

class MainController extends GetxController with SubscribeSelfProfileMixin, GetSelfProfileMixin {
  final RxInt tabIndexRx = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getUserMe();
    requestPermissionPushNotification();
  }

  void updateTabIndex(int tabIndex) {
    tabIndexRx.value = tabIndex;
  }

  void openSettingScreen() {
    Get.toNamed(RoutePaths.setting);
  }

  void openSearchScreen() {
    Get.toNamed(RoutePaths.search);
  }

  Future<void> requestPermissionPushNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    if (GetPlatform.isIOS) {
      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    final String? tokenFB = await FirebaseMessaging.instance.getToken();
    print("$tokenFB");
  }

  String get title {
    switch (tabIndexRx.value) {
      case 0:
        return 'txt_feed';
      case 1:
        return 'txt_chat';
      case 2:
        return 'txt_notifications';
      case 3:
        return 'txt_my_profile';
    }
    return 'txt_feed';
  }

  void updateNotificationList() {
    if (tabIndexRx.value == 2) {
      Get.find<NotificationListController>().getFollowRequests();
    }
  }
}

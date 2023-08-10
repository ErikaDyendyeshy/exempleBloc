import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/_main/main_controller.dart';
import 'package:parallel/module/chat/chat_list/chat_list_binding.dart';
import 'package:parallel/module/chat/chat_list/chat_list_screen.dart';
import 'package:parallel/module/feed/feed_binding.dart';
import 'package:parallel/module/feed/feed_screen.dart';
import 'package:parallel/module/notification_list/notification_list_binding.dart';
import 'package:parallel/module/notification_list/notification_list_screen.dart';
import 'package:parallel/module/profile/profile_binding.dart';
import 'package:parallel/module/profile/profile_screen.dart';
import 'package:parallel/module/smart_desires/smart_desires_binding.dart';
import 'package:parallel/module/smart_desires/smart_desires_screen.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/botton_navigation/bottom_bar_menu_item.dart';
import 'package:parallel/widget/botton_navigation/p_bottom_navigation_widget.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: controller.tabIndexRx.value == 4 ? null : _appBar(),
        extendBody: true,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Obx(
          () => IndexedStack(
            index: controller.tabIndexRx.value,
            children: [
              Navigator(
                key: const Key('feed'),
                initialRoute: RoutePaths.feed,
                onGenerateRoute: (routeSettings) {
                  return GetPageRoute(
                    routeName: RoutePaths.feed,
                    page: () => const FeedScreen(),
                    binding: FeedBinding(),
                  );
                },
              ),
              Navigator(
                key: const Key('chatList'),
                initialRoute: RoutePaths.chatList,
                onGenerateRoute: (routeSettings) {
                  return GetPageRoute(
                    routeName: RoutePaths.chatList,
                    page: () => const ChatListScreen(),
                    binding: ChatListBinding(),
                  );
                },
              ),
              Navigator(
                key: const Key('notifications'),
                initialRoute: RoutePaths.notificationList,
                onGenerateRoute: (routeSettings) {
                  return GetPageRoute(
                    routeName: RoutePaths.notificationList,
                    page: () => const NotificationListScreen(),
                    binding: NotificationListBinding(),
                  );
                },
              ),
              Navigator(
                key: const Key('profile'),
                initialRoute: RoutePaths.profile,
                onGenerateRoute: (routeSettings) {
                  return GetPageRoute(
                    routeName: RoutePaths.profile,
                    page: () => const ProfileScreen(),
                    binding: ProfileBinding(),
                  );
                },
              ),
              Navigator(
                key: const Key('smart_desires'),
                initialRoute: RoutePaths.smartDesires,
                onGenerateRoute: (routeSettings) {
                  return GetPageRoute(
                    routeName: RoutePaths.smartDesires,
                    page: () => const SmartDesiresScreen(),
                    binding: SmartDesiresBinding(),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: 68,
          width: 68,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 8,
            onPressed: () => controller.updateTabIndex(4),
            child: Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.pink,
                    AppColors.blue,
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: PSVGIcon(
                  icon: 'icon_search',
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => PBottomNavigationWidget(
            currentIndex: controller.tabIndexRx.value,
            items: [
              BottomBarMenuItem(
                colorItem: controller.tabIndexRx.value == 0
                    ? Get.theme.colorScheme.onPrimary
                    : Get.theme.colorScheme.primary,
                title: 'txt_feed'.tr.capitalizeFirst!,
                onTap: () => controller.updateTabIndex(0),
                iconAssetName: 'icon_feed',
              ),
              BottomBarMenuItem(
                colorItem: controller.tabIndexRx.value == 1
                    ? Get.theme.colorScheme.onPrimary
                    : Get.theme.colorScheme.primary,
                title: 'txt_chat'.tr.capitalizeFirst!,
                onTap: () => controller.updateTabIndex(1),
                iconAssetName: 'icon_chat',
              ),
              BottomBarMenuItem(
                colorItem: controller.tabIndexRx.value == 2
                    ? Get.theme.colorScheme.onPrimary
                    : Get.theme.colorScheme.primary,
                title: 'txt_notifications'.tr.capitalizeFirst!,
                onTap: () {
                  controller.updateNotificationList();
                  controller.updateTabIndex(2);
                } ,
                iconAssetName: 'icon_notification',
              ),
              BottomBarMenuItem(
                colorItem: controller.tabIndexRx.value == 3
                    ? Get.theme.colorScheme.onPrimary
                    : Get.theme.colorScheme.primary,
                title: 'txt_profile'.tr.capitalizeFirst!,
                onTap: () =>
                  controller.updateTabIndex(3),
                iconAssetName: 'icon_user',
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    if (controller.tabIndexRx.value == 4) {
      return const PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox.shrink(),
      );
    }
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      leading: controller.tabIndexRx.value == 0
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PSVGIcon(
                    icon: 'icon_search',
                    onTap: () => controller.openSearchScreen(),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
      title: Obx(
        () => Text(
          controller.title.tr.capitalizeFirst!,
        ),
      ),
      actions: <Widget>[
        Obx(
          () => controller.tabIndexRx.value == 3
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: InkWell(
                    onTap: () => controller.openSettingScreen(),
                    child: const PSVGIcon(icon: 'icon_settings'),
                  ),
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }
}

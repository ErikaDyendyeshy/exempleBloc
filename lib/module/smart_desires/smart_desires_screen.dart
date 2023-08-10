import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/request_model.dart';
import 'package:parallel/module/smart_desires/smart_desires_controller.dart';
import 'package:parallel/module/smart_desires/widget/empty_widget.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/p_list_view_widget.dart';

class SmartDesiresScreen extends GetView<SmartDesiresController> {
  const SmartDesiresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          _completedList(),
          _processingList(),
          _pausedList(),
        ],
      ),
    );
  }

  Widget _tabItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Text(
        text.capitalizeFirst!,
        style: Get.theme.textTheme.labelLarge!.copyWith(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _completedList() {
    return Obx(
      () => PListViewWidget(
        emptyListMessage: EmptyWidget(
          icon: 'icon_completed_request',
          text: 'txt_here_you_will_find_a_list_of_all_your_completed_searches'
              .tr
              .capitalizeFirst!,
        ),
        padding: const EdgeInsets.only(bottom: 130),
        count: controller.completedListRx.length,
        onPullToRefresh: () => controller.getCompletedListRequest(reset: true),
        onBuildItem: (int index) {
          RequestModel request = controller.completedListRx[index]!;
          return _itemRequest(
            status: 'Completed!',
            statusColor: Get.theme.colorScheme.tertiary,
            request: request.request,
            onTap: () => controller.openSmartSearchScreen(
              status: 'completed',
              requestId: controller.completedListRx[index]!.id,
            ),
          );
        },
      ),
    );
  }

  Widget _processingList() {
    return Obx(
      () => PListViewWidget(
        emptyListMessage: EmptyWidget(
          icon: 'icon_processing_request',
          text: 'txt_here_you_will_find_a_list_of_all_your_process_searches'.tr.capitalizeFirst!,
        ),
        loadingItem: Container(
          height: 300,
          width: 300,
          color: Colors.red,
        ),
        count: controller.processingListRx.length,
        onPullToRefresh: () => controller.getProcessingListRequest(reset: true),
        padding: const EdgeInsets.only(bottom: 130),
        onBuildItem: (int index) {
          RequestModel request = controller.processingListRx[index]!;
          return _itemRequest(
            status: 'Processing..',
            request: request.request,
            onTap: () => controller.openSmartSearchScreen(
              status: 'processing',
              requestId: controller.processingListRx[index]!.id,
            ),
          );
        },
      ),
    );
  }

  Widget _pausedList() {
    return Obx(
      () => PListViewWidget(
        emptyListMessage: EmptyWidget(
          icon: 'icon_paused_request',
          text: 'txt_here_you_will_find_a_list_of_all_your_searches_that_are_currently_paused'
              .tr
              .capitalizeFirst!,
        ),
        padding: const EdgeInsets.only(bottom: 130),
        count: controller.pausedListRx.length,
        onPullToRefresh: () => controller.getPausedListRequest(reset: true),
        onBuildItem: (int index) {
          RequestModel request = controller.pausedListRx[index]!;
          return _itemRequest(
            status: 'Paused',
            statusColor: Get.theme.colorScheme.onError,
            request: request.request,
            onTap: () => controller.openSmartSearchScreen(
              status: 'paused',
              requestId: controller.pausedListRx[index]!.id,
            ),
          );
        },
      ),
    );
  }

  Widget _itemRequest({
    required String status,
    Color? statusColor,
    required String request,
    required Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      child: ListTile(
        onTap: onTap,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            status,
            style: Get.theme.textTheme.titleLarge!.copyWith(
              color: statusColor,
            ),
          ),
        ),
        subtitle: Text(
          request,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Get.theme.textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const PSVGIcon(icon: 'icon_carret_right'),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(180.0),
      child: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.pink, AppColors.blue],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 0,
            ),
            Center(
              child: Text(
                'txt_smart_desires'.tr.capitalizeFirst!,
                style: Get.theme.textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 27),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () => controller.openSmartSearchScreen(status: ''),
                child: Container(
                  height: 48,
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'txt_search'.tr.capitalizeFirst!,
                        style: Get.theme.textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      PSVGIcon(
                        icon: 'icon_search',
                        color: Get.theme.colorScheme.onSurface,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 55,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    width: 2.5,
                    color: AppColors.gray100,
                  ),
                ),
              ),
              child: TabBar(
                automaticIndicatorColorAdjustment: false,
                controller: controller.tabController,
                indicatorColor: Get.theme.colorScheme.onPrimary,
                labelStyle: Get.theme.textTheme.labelLarge,
                unselectedLabelColor: Colors.grey,
                // Колір тексту неактивних табів
                unselectedLabelStyle: Get.theme.textTheme.titleSmall,
                tabs: [
                  _tabItem('txt_completed'.tr),
                  _tabItem('txt_processing'.tr),
                  _tabItem('txt_paused'.tr),
                ],
                onTap: (index) {
                  if (index == 0) {
                    controller.getCompletedListRequest();
                  } else if (index == 1) {
                    controller.getProcessingListRequest();
                  } else {
                    controller.getPausedListRequest();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

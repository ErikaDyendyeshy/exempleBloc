import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/smart_desires/smart_search/smart_search_controller.dart';
import 'package:parallel/module/smart_desires/smart_search/widget/request_completed_widget.dart';
import 'package:parallel/module/smart_desires/smart_search/widget/request_processing_or_paused_widget.dart';
import 'package:parallel/widget/__.dart';

class SmartSearchScreen extends GetView<SmartSearchController> {
  const SmartSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(horizontalPaddingScreen),
          child: PSVGIcon(
            icon: 'icon_arrow_left',
            onTap: controller.getBack,
            height: 16,
            width: 16,
          ),
        ),
        actions: [
          controller.statusRequest.value != ''
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
                  child: PSVGIcon(
                    icon: 'icon_more',
                    onTap: () => controller.openOptionMenu(),
                  ),
                )
              : const SizedBox.shrink(),
        ],
        title: Text('txt_search'.tr.capitalizeFirst!),
      ),
      body: _getWidgetForStatus(controller.statusRequest.value),
    );
  }

  Widget _getWidgetForStatus(String status) {
    switch (status) {
      case 'completed':
        return const RequestCompletedWidget();
      case 'processing':
        return const RequestProcessingOrPausedWidget();
      case 'paused':
        return const RequestProcessingOrPausedWidget();
      default:
        return _search();
    }
  }

  Widget _search() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPaddingScreen,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'txt_to_ensure_better_results_kindly_provide_a_more'.tr.capitalizeFirst!,
            style: Get.theme.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          PInputTextFieldWidget(
            controller: controller.searchController,
            hintText: 'txt_please_write_your_desire'.tr.capitalizeFirst!,
            maxLength: 400,
            maxLines: 15,
            onChanged: (value) {
              controller.checkTextSearch(value);
            },
          ),
          Text(
            'txt_minimum_50_symbols'.tr.capitalizeFirst!,
            style: Get.theme.textTheme.titleSmall,
          ),
          const Spacer(),
          Obx(
            () => PButtonWidget(
              loading: controller.isLoading.value,
              disabled: !controller.isFormValid,
              text: 'txt_search'.tr.capitalizeFirst!,
              onPressed: () {
                controller.postSearchRequest();
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

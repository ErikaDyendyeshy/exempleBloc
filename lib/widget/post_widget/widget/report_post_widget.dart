import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/post_widget/post_widget_controller.dart';

class ReportPostWidget extends GetView<PostWidgetController> {
  const ReportPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'txt_report_post'.tr.capitalizeFirst!,
              style: Get.theme.textTheme.headlineMedium,
            ),
          ),
          PInputTextFieldWidget(
            labelText: 'txt_topic'.tr.toUpperCase(),
            hintText: 'txt_write_report_topic'.tr.capitalizeFirst!,
          ),
          const SizedBox(height: 15),
          PInputTextFieldWidget(
            labelText: 'txt_description'.tr.toUpperCase(),
            hintText: 'txt_write_report_description'.tr.capitalizeFirst!,
          ),
          const SizedBox(height: 15),
          PButtonWidget(
            text: 'txt_send_report'.tr.capitalizeFirst!,
            onPressed: () => controller.sendReport(controller.post.id),
          ),
          const SizedBox(height: 15),
          PButtonWidget(
            text: 'txt_cancel'.tr.capitalizeFirst!,
            colorTrascparent: true,
            onPressed: () => Get.close(2),
          ),
        ],
      ),
    );
  }
}

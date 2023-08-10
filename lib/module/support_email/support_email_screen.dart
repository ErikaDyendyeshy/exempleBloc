import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/support_email/support_email_controller.dart';
import 'package:parallel/widget/__.dart';

class SupportEmailScreen extends GetView<SupportEmailController> {
  const SupportEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'txt_support_email'.tr.capitalizeFirst!,
          ),
          elevation: 0,
          leading: InkWell(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              child: PSVGIcon(
                icon: 'icon_arrow_left',
              ),
            ),
          ),
        ),
        body: _body());
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(horizontalPaddingScreen),
      child: Column(
        children: [
          Text(
            'txt_support_email'.tr.capitalizeFirst!,
            style: Get.theme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 12),
          Text(
            'txt_if_you_have_any_questions_issues'.tr,
            textAlign: TextAlign.center,
            style: Get.theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 28),
          PInputTextFieldWidget(
            labelText: 'txt_topic'.tr.toUpperCase(),
            hintText: 'txt_write_your_topic'.tr.capitalizeFirst!,
          ),
          const SizedBox(height: 12),
          PInputTextFieldWidget(
            labelText: 'txt_description'.tr.toUpperCase(),
            hintText: 'txt_write_description'.tr.capitalizeFirst!,
            maxLength: 600,
            maxLines: 9,
          ),
          const Spacer(),
          PButtonWidget(
            text: 'txt_send_mail'.tr.capitalizeFirst!,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

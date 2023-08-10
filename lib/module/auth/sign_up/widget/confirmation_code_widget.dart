import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/auth/sign_up/sign_up_controller.dart';
import 'package:parallel/widget/__.dart';

class ConfirmationCodeWidget extends GetView<SignUpController> {
  const ConfirmationCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PTitleBlockWidget(
            title: 'txt_6_digit_code',
            description: '${'txt_please_enter_code'.tr} ${controller.emailRx.value}',
          ),
          const SizedBox(height: 12),
          Obx(
            () => PPinPutWidget(
              isError: controller.inputCodeErrorMsg.isNotEmpty ? true : false,
              validatorText: controller.inputCodeErrorMsg.value,
              warningText: controller.remainingAttemptsRx.value.toString(),
              label: 'txt_enter_code'.tr.toUpperCase(),
              controller: controller.codeConfirmController,
              onChange: (value) => controller.checkCode(value),
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              text: 'txt_didnt_get_a_code'.tr.capitalizeFirst!,
              style: Get.theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
              children: <InlineSpan>[
                const WidgetSpan(
                  child: SizedBox(width: 5),
                ),
                TextSpan(
                  text: 'txt_resend_code'.tr.capitalizeFirst!,
                  style: Get.theme.textTheme.labelLarge!.copyWith(
                    fontSize: 14,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () => controller.resendCode(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'txt_you_can_resend_the_code'.tr.capitalizeFirst!,
            style: Get.theme.textTheme.bodySmall,
          ),
          const Spacer(),
          Obx(
            () => PButtonWidget(
              loading: controller.isLoading.value,
              disabled: !controller.isConfirmationCodeFull.value || controller.isLoading.value,
              text: 'txt_send_code'.tr.capitalizeFirst!,
              onPressed: () => controller.confirmCode(),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

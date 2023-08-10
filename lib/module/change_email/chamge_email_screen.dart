import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/change_email/change_email_controller.dart';
import 'package:parallel/widget/__.dart';

class ChangeEmailScreen extends GetView<ChangeEmailController> {
  const ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Obx(
          () => Text(
            controller.step == 0
                ? 'txt_change_email'.tr.capitalizeFirst!
                : 'txt_confirmation_code'.tr.capitalizeFirst!,
          ),
        ),
        leading: InkWell(
          onTap: () => controller.getBack(),
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
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(horizontalPaddingScreen),
      child: Obx(
        () => Column(
          children: [
            if (controller.step == 0) _form(),
            if (controller.step == 1) _confirmationCode()
          ],
        ),
      ),
    );
  }

  Widget _form() {
    return Flexible(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'txt_your_current_email'.tr.toUpperCase(),
                style: Get.theme.textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
                  child: Text(controller.selfProfile.value!.user.email!),
                ),
              ),
              const SizedBox(height: 12),
              PInputTextFieldWidget(
                focusNode: controller.emailFocusNode,
                onChanged: controller.validateAndClearEmailError,
                labelText: 'txt_new_email'.tr.toUpperCase(),
                controller: controller.newEmailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.go,
              ),
            ],
          ),
          const Spacer(),
          Obx(
            () => PButtonWidget(
              disabled: !controller.isEmailValid,
              text: 'txt_next'.tr,
              onPressed: () => controller.sendEmailChangeCode(),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _confirmationCode() {
    return Obx(
      () => PConfirmationCodeWidget(
        height: Get.height * 0.82,
        controller: controller.codeConfirmController,
        email: controller.newEmailController.text,
        validatorText: controller.inputCodeErrorMsg.value,
        warningText: controller.remainingAttemptsRx.value.toString(),
        isError: controller.inputCodeErrorMsg.isNotEmpty ? true : false,
        onTapResendCode: () => controller.resendCode(),
        disabledButton: !controller.isConfirmationCodeFull.value,
        onPressed: () => controller.changeEmailWithCode(),
        onChange: (value) => controller.checkCode(value),
      ),
    );
  }
}

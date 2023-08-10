import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/change_password/change_password_controller.dart';
import 'package:parallel/widget/__.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

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
                ? 'txt_change_password'.tr.capitalizeFirst!
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
              Obx(() =>
                PInputTextFieldWidget(
                  onChanged: (value) => controller.checkOldPassword(value),
                  labelText: 'txt_old_password'.tr.toUpperCase(),
                  controller: controller.oldPasswordController,
                  textInputAction: TextInputAction.next,
                  validatorText: controller.inputOldPasswordErrorMsg.value.isNotEmpty
                      ? controller.inputOldPasswordErrorMsg.value
                      : null,
                  trailingIcon:
                      controller.oldPasswordObscured.value ? 'icon_eye_closed' : 'icon_eye_opened',
                  trailingOnTap: () {
                    controller.oldPasswordObscured.toggle();
                  },
                  obscureText: controller.oldPasswordObscured.value,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => PInputTextFieldWidget(
                  onChanged: (value) => controller.checkNewPassword(value),
                  labelText: 'txt_new_password'.tr.toUpperCase(),
                  controller: controller.newPasswordController,
                  textInputAction: TextInputAction.next,
                  description: 'txt_password_must_contain_at'.tr.capitalizeFirst!,
                  validatorText: controller.inputNewPasswordErrorMsg.value.isNotEmpty
                      ? controller.inputNewPasswordErrorMsg.value
                      : null,
                  trailingIcon:
                      controller.newPasswordObscured.value ? 'icon_eye_closed' : 'icon_eye_opened',
                  trailingOnTap: () {
                    controller.newPasswordObscured.toggle();
                  },
                  obscureText: controller.newPasswordObscured.value,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => PInputTextFieldWidget(
                  onChanged: (value) => controller.checkRepeatNewPassword(value),
                  labelText: 'txt_repeat_new_password'.tr.toUpperCase(),
                  controller: controller.repeatNewPasswordController,
                  textInputAction: TextInputAction.go,
                  validatorText: controller.inputRepeatNewPasswordErrorMsg.value.isNotEmpty
                      ? controller.inputRepeatNewPasswordErrorMsg.value
                      : null,
                  trailingIcon: controller.repeatNewPasswordObscured.value
                      ? 'icon_eye_closed'
                      : 'icon_eye_opened',
                  trailingOnTap: () {
                    controller.repeatNewPasswordObscured.toggle();
                  },
                  obscureText: controller.repeatNewPasswordObscured.value,
                ),
              ),
            ],
          ),
          const Spacer(),
          Obx(
            () => PButtonWidget(
              disabled: !controller.isFormValid,
              text: 'txt_next'.tr,
              onPressed: () => controller.sendPasswordChangeCode(),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  //TODO email

  Widget _confirmationCode() {
    return Obx(
      () => PConfirmationCodeWidget(
        height: Get.height * 0.82,
        controller: controller.codeConfirmController,
        email: 'controller.selfProfile.value!.user.email!',
        validatorText: controller.inputCodeErrorMsg.value,
        warningText: controller.remainingAttemptsRx.value.toString(),
        isError: controller.inputCodeErrorMsg.isNotEmpty ? true : false,
        onTapResendCode: () => controller.resendCode(),
        disabledButton: !controller.isConfirmationCodeFull.value,
        onPressed: () => controller.changePasswordWithCode(),
        onChange: (value) => controller.checkCode(value),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/auth/forgot_password/forgot_password_controller.dart';
import 'package:parallel/widget/__.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

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
                ? 'txt_forgot_password'.tr.capitalizeFirst!
                : controller.step == 1
                    ? 'txt_confirmation_code'.tr.capitalizeFirst!
                    : 'txt_create_a_new_password'.tr.capitalizeFirst!,
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
    return Stack(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPaddingScreen,
              vertical: verticalPaddingScreen,
            ),
            child:
              Obx(
                () => ListView(
                  children: [
                    if (controller.step == 0) _blockEmail(),
                    if (controller.step == 1) _confirmationCode(),
                    if (controller.step == 2) _changePassword(),
                  ],
                ),
              ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _bottomButton(),
        ),
      ],
    );
  }

  Widget _blockEmail() {
    return Column(
      children: [
        PTitleBlockWidget(
          description: 'txt_enter_an_email_connected_to_your_account'.tr,
        ),
        const SizedBox(height: 20),
        Obx(
          () => PInputTextFieldWidget(
            focusNode: controller.emailFocusNode,
            controller: controller.emailController,
            labelText: 'txt_email'.tr.toUpperCase(),
            hintText: 'txt_write_your_name'.tr.capitalizeFirst!,
            textInputAction: TextInputAction.next,
            onChanged: controller.validateAndClearEmailError,
            validatorText: controller.inputEmailErrorMsg.value.isNotEmpty
                ? controller.inputEmailErrorMsg.value
                : null,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _confirmationCode() {
    return Column(
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
            controller: controller.confirmCodeController,
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
      ],
    );
  }

  Widget _changePassword() {
    return Column(
      children: [
        Obx(
          () => PInputTextFieldWidget(
            labelText: 'txt_password'.tr.toUpperCase(),
            hintText: 'txt_create_a_password'.tr.capitalizeFirst!,
            description: 'txt_password_must_contain_at'.tr.capitalizeFirst!,
            obscureText: controller.passwordObscured.value,
            controller: controller.newPasswordController,
            trailingIcon:
                controller.passwordObscured.value ? 'icon_eye_closed' : 'icon_eye_opened',
            trailingOnTap: () {
              controller.passwordObscured.toggle();
            },
            textInputAction: TextInputAction.next,
            onChanged: (value) => controller.checkNewPassword(value),
            validatorText: controller.inputPasswordErrorMsg.value.isNotEmpty
                ? controller.inputPasswordErrorMsg.value
                : null,
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => PInputTextFieldWidget(
            labelText: 'txt_repeat_password'.tr.toUpperCase(),
            hintText: 'txt_repeat_password'.tr.capitalizeFirst!,
            obscureText: controller.passwordRepeatObscured.value,
            controller: controller.repeatNewPasswordController,
            trailingIcon:
                controller.passwordRepeatObscured.value ? 'icon_eye_closed' : 'icon_eye_opened',
            trailingOnTap: () {
              controller.passwordRepeatObscured.toggle();
            },
            textInputAction: TextInputAction.go,
            onChanged: (value) => controller.checkNewPasswordRepeat(value),
          ),
        ),
       const SizedBox(height: 150),
      ],
    );
  }

  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
      child: Column(
        children: [
          Obx(
            () => PButtonWidget(
              loading: controller.isLoading.value,
              disabled: !controller.isFormValid || controller.isLoading.value,
              text: controller.step == 0
                  ? 'txt_continue'.tr
                  : controller.step == 1
                      ? 'txt_send_code'.tr
                      : 'txt_save'.tr,
              onPressed: () => controller.requestResetPasswordCodeByEmail(),
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => controller.openSingUp(),
            child: RichText(
              text: TextSpan(
                  text: 'txt_dont_have_an_account'.tr.capitalizeFirst!,
                  style: Get.theme.textTheme.titleSmall!,
                  children: <InlineSpan>[
                    const WidgetSpan(
                      child: SizedBox(width: 5),
                    ),
                    TextSpan(
                      text: 'txt_sign_up'.tr.capitalizeFirst!,
                      style: Get.theme.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/auth/sign_up/sign_up_controller.dart';
import 'package:parallel/widget/__.dart';

class CreatingProfileWidget extends GetView<SignUpController> {
  const CreatingProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.84,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _title(),
              _formField(),
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
              child: _bottomButton()),
        ],
      ),
    );
  }

  Widget _title() {
    return Column(
      children: [
        Text(
          'txt_creating_profile'.tr.capitalizeFirst!,
          style: Get.theme.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'txt_please_enter_your_personal_information'.tr.capitalizeFirst!,
          style: Get.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _formField() {
    const double height = 10.0;
    return Column(
      children: [
        const SizedBox(height: 16),
        PInputTextFieldWidget(
          labelText: 'txt_name'.tr.toUpperCase(),
          hintText: 'txt_write_your_name'.tr.capitalizeFirst!,
          controller: controller.nameController,
          textInputAction: TextInputAction.next,
          onChanged: (value) => controller.checkName(value),
          validatorText: controller.inputNameErrorMsg.value.isNotEmpty
              ? controller.inputNameErrorMsg.value
              : null,
        ),
        const SizedBox(height: height),
        Obx(
          () => PInputTextFieldWidget(
            focusNode: controller.emailFocusNode,
            labelText: "txt_email".tr.toUpperCase(),
            hintText: 'txt_write_your_email'.tr.capitalizeFirst!,
            controller: controller.emailController,
            textInputAction: TextInputAction.next,
            onChanged: controller.validateAndClearEmailError,
            validatorText: controller.inputEmailErrorMsg.value.isNotEmpty
                ? controller.inputEmailErrorMsg.value
                : null,
          ),
        ),
        const SizedBox(height: height),
        Obx(
          () => PInputTextFieldWidget(
            labelText: 'txt_password'.tr.toUpperCase(),
            hintText: 'txt_create_a_password'.tr.capitalizeFirst!,
            description: 'txt_password_must_contain_at'.tr.capitalizeFirst!,
            obscureText: controller.passwordObscured.value,
            controller: controller.passwordController,
            trailingIcon: controller.passwordObscured.value ? 'icon_eye_closed' : 'icon_eye_opened',
            trailingOnTap: () {
              controller.passwordObscured.toggle();
            },
            textInputAction: TextInputAction.next,
            onChanged: (value) => controller.checkPassword(value),
            validatorText: controller.inputPasswordErrorMsg.value.isNotEmpty
                ? controller.inputPasswordErrorMsg.value
                : null,
          ),
        ),
        const SizedBox(height: height),
        Obx(
          () => PInputTextFieldWidget(
            labelText: 'txt_repeat_password'.tr.toUpperCase(),
            hintText: 'txt_repeat_password'.tr.capitalizeFirst!,
            obscureText: controller.passwordRepeatObscured.value,
            controller: controller.passwordRepeatController,
            trailingIcon:
                controller.passwordRepeatObscured.value ? 'icon_eye_closed' : 'icon_eye_opened',
            trailingOnTap: () {
              controller.passwordRepeatObscured.toggle();
            },
            textInputAction: TextInputAction.go,
            onChanged: (value) => controller.checkPasswordRepeat(value),
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => Text(
            controller.errorMsgRx.value,
            style: Get.theme.textTheme.bodySmall!.copyWith(
              color: Get.theme.colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomButton() {
    return Column(
      children: [
        Obx(
          () => PButtonWidget(
            loading: controller.isLoading.value,
            disabled: !controller.isFormValid || controller.isLoading.value,
            text: 'txt_continue'.tr,
            onPressed: () => controller.registerByEmail(),
          ),
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
              text: '${'txt_already_have_an_account'.tr.capitalizeFirst!}?',
              style: Get.theme.textTheme.titleSmall!,
              children: <InlineSpan>[
                const WidgetSpan(
                  child: SizedBox(width: 5),
                ),
                TextSpan(
                  text: 'txt_login'.tr.capitalizeFirst!,
                  style: Get.theme.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () => controller.openLoginScreen(),
                ),
              ]),
        ),
        const SizedBox(height: 35),
      ],
    );
  }
}

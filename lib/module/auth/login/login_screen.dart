import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/auth/login/login_controller.dart';
import 'package:parallel/widget/__.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text('txt_login'.tr.capitalizeFirst!),
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
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: horizontalPaddingScreen,
            vertical: verticalPaddingScreen,
          ),
          children: [
            Obx(
                  () => PInputTextFieldWidget(
                focusNode: controller.emailFocusNode,
                controller: controller.emailController,
                labelText: 'txt_email'.tr.toUpperCase(),
                hintText: 'txt_write_your_name'.tr.capitalizeFirst!,
                onChanged: controller.validateAndClearEmailError,
                textInputAction: TextInputAction.next,
                validatorText: controller.inputEmailErrorMsg.value.isNotEmpty
                    ? controller.inputEmailErrorMsg.value
                    : null,
                validatorEnable: controller.inputEmailErrorMsg.value.isNotEmpty ? true : false,
              ),
            ),
            const SizedBox(height: 12),
            Obx(
                  () => PInputTextFieldWidget(
                controller: controller.passwordController,
                labelText: 'txt_password'.tr.toUpperCase(),
                hintText: 'txt_write_your_password'.tr.capitalizeFirst!,
                obscureText: controller.passwordObscured.value,
                trailingIcon: controller.passwordObscured.value ? 'icon_eye_closed' : 'icon_eye_opened',
                trailingOnTap: () {
                  controller.passwordObscured.toggle();
                },
                textInputAction: TextInputAction.go,
                onChanged: (value) => controller.checkPassword(value),
                validatorText: controller.inputPasswordErrorMsg.value.isNotEmpty
                    ? controller.inputPasswordErrorMsg.value
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Obx(
                  () => Text(
                controller.errorMsgRx.value,
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  color: Get.theme.colorScheme.error,
                ),
              ),
            ),
            TextButton(
              onPressed: () => controller.openForgotPassword(),
              child: Text(
                'txt_forgot_your_password'.tr.capitalizeFirst!,
                style: Get.theme.textTheme.labelLarge!.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
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


  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
      child: Column(
        children: [
          Obx(
                () => PButtonWidget(
              loading: controller.isLoading.value,
              disabled: !controller.isFormValid || controller.isLoading.value,
              text: 'txt_login'.tr,
              onPressed: () => controller.loginByEmail(),
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}

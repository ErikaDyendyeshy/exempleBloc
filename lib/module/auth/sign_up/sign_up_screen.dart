import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/auth/sign_up/sign_up_controller.dart';
import 'package:parallel/module/auth/sign_up/widget/creating_profile.dart';
import 'package:parallel/widget/__.dart' hide PConfirmationCodeWidget;

import 'widget/confirmation_code_widget.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Obx(
          () => Text(
            controller.step != 1
                ? 'txt_sign_up'.tr.capitalizeFirst!
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
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalPaddingScreen,
          vertical: verticalPaddingScreen,
        ),
        child: Obx(
          () => Column(
            children: [
              if (controller.step == 0) const CreatingProfileWidget(),
              if (controller.step == 1) const ConfirmationCodeWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/auth/sign_up/sign_up_complete/sign_up_completed_controller.dart';
import 'package:parallel/widget/__.dart';

class SignUpCompletedScreen extends GetView<SignUpCompletedController> {
  const SignUpCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('txt_sign_up'.tr.capitalizeFirst!),
      ),
      body: _finishedRegistration(),
    );
  }

  Widget _finishedRegistration() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PSVGIcon(
              icon: 'icon_answer',
            ),
            const SizedBox(height: 12),
            PTitleBlockWidget(
              title: 'txt_answer_our_5_quick_question_to_complete'.tr,
              description: 'txt_help_us_better_personalise_your_profile'.tr,
            ),
            const SizedBox(height: 12),
            PButtonWidget(
              text: 'txt_lets_start'.tr,
              onPressed: () => controller.openPersonalizedQuestionScreen(),
            ),
            const SizedBox(height: 12),
            PButtonWidget(
              text: 'txt_maybe_later'.tr,
              colorTrascparent: true,
              onPressed: () => controller.goToMainScreen(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

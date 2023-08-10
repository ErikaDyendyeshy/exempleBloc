import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/first_page/first_screen_controller.dart';
import 'package:parallel/widget/__.dart';

class FirstPageScreen extends GetView<FirsPageController> {
  const FirstPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              transform: Transform.translate(
                offset: Offset(
                  0,
                  GetPlatform.isAndroid
                      ? controller.isShowLoginButtons.value == true
                          ? 30
                          : 110
                      : controller.isShowLoginButtons.value == true
                          ? -30
                          : 70,
                ),
              ).transform,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: PSVGIcon(
                  icon: 'logo',
                ),
              ),
            ),
            const SizedBox(height: 90),
            _buttons(),
          ],
        ),
      ),
    );
  }

  Widget _buttons() {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutBack,
        transform: Transform.translate(
          offset: Offset(
            0,
            controller.isShowLoginButtons.value == true ? 0 : 150,
          ),
        ).transform,
        child: AnimatedOpacity(
          opacity: controller.isShowLoginButtons.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.linearToEaseOut,
          child: Column(
            children: [
              PButtonWidget(
                text: 'txt_sign_up'.tr.capitalizeFirst!,
                onPressed: () => controller.onSignUp(),
              ),
              const SizedBox(height: 16),
              PButtonWidget(
                colorTrascparent: true,
                text: 'txt_login'.tr.capitalizeFirst!,
                onPressed: () => controller.onLogin(),
              ),
              _termsPolicy(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _termsPolicy() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          Text(
            'txt_by_continuing_you_agree'.tr.capitalizeFirst!,
            style: Get.theme.textTheme.titleSmall!,
          ),
          RichText(
            text: TextSpan(
                text: 'txt_terms_conditions'.tr.capitalizeFirst!,
                style: Get.theme.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
                children: <InlineSpan>[
                  const WidgetSpan(
                    child: SizedBox(width: 5),
                  ),
                  TextSpan(
                    text: 'txt_and'.tr,
                    style: Get.theme.textTheme.titleSmall!,
                  ),
                  const WidgetSpan(
                    child: SizedBox(width: 5),
                  ),
                  TextSpan(
                    text: 'txt_privacy_policy'.tr.capitalizeFirst!,
                    style: Get.theme.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const WidgetSpan(
                    child: SizedBox(width: 5),
                  ),
                ]),
          ),
          SizedBox(height: GetPlatform.isAndroid ? 0 : 20),
        ],
      ),
    );
  }
}

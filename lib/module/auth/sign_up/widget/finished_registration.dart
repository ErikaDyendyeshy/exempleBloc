import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/widget/__.dart';

class FinishedRegistrationWidget extends StatelessWidget {
  const FinishedRegistrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
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
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            PButtonWidget(
              text: 'txt_maybe_later'.tr,
              colorTrascparent: true,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

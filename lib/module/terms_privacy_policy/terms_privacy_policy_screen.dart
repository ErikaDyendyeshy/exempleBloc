import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/terms_privacy_policy/terms_privacy_policy_controller.dart';
import 'package:parallel/widget/__.dart';

class TermsPrivacyPolicyScreen extends GetView<TermsPrivacyPolicyController> {
  const TermsPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('txt_terms_privacy_policy'.tr.capitalizeFirst!),
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
    );
  }
}

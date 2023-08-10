import 'package:get/get.dart';
import 'package:parallel/module/terms_privacy_policy/terms_privacy_policy_controller.dart';

class TermsPrivacyPolicyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsPrivacyPolicyController>(() => TermsPrivacyPolicyController());
  }
}

import 'package:get/get.dart';
import 'package:parallel/module/support_email/support_email_controller.dart';

class SupportEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportEmailController>(() => SupportEmailController());
  }
}

import 'package:get/get.dart';
import 'package:parallel/module/change_email/change_email_controller.dart';

class ChangeEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeEmailController>(() => ChangeEmailController());
  }
}

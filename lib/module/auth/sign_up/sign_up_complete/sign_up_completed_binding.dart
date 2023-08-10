import 'package:get/get.dart';
import 'package:parallel/module/auth/sign_up/sign_up_complete/sign_up_completed_controller.dart';

class SignUpCompleteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpCompletedController>(
      () => SignUpCompletedController(),
    );
  }
}

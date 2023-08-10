import 'package:get/get.dart';
import 'package:parallel/module/auth/forgot_password/forgot_password_controller.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}

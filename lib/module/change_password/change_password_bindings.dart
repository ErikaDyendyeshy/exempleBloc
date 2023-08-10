import 'package:get/get.dart';
import 'package:parallel/module/change_password/change_password_controller.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}

import 'package:get/get.dart';
import 'package:parallel/module/other_profile/other_profile_controller.dart';

class OtherProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtherProfileController>(() => OtherProfileController());
  }
}

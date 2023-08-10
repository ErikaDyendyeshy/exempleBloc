import 'package:get/get.dart';
import 'package:parallel/module/first_page/first_screen_controller.dart';

class FirstPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirsPageController>(() => FirsPageController());
  }
}

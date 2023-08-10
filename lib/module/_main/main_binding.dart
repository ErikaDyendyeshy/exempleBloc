import 'package:get/get.dart';
import 'package:parallel/module/_main/main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}

import 'package:get/get.dart';
import 'package:parallel/module/smart_desires/smart_desires_controller.dart';

class SmartDesiresBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SmartDesiresController>(() => SmartDesiresController());
  }
}

import 'package:get/get.dart';
import 'package:parallel/module/smart_desires/smart_search/smart_search_controller.dart';

class SmartSearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SmartSearchController>(() => SmartSearchController());
  }
}

import 'package:get/get.dart';
import 'package:parallel/module/connection_list/connection_list_controller.dart';

class ConnectionListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionListController>(() => ConnectionListController());
  }
}

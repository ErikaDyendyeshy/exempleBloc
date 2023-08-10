import 'package:get/get.dart';
import 'package:parallel/module/search/search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }
}

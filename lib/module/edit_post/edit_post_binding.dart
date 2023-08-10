import 'package:get/get.dart';
import 'package:parallel/module/edit_post/edit_post_controller.dart';

class EditPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPostController>(() => EditPostController());
  }
}

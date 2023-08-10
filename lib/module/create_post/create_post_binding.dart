import 'package:get/get.dart';
import 'package:parallel/module/create_post/create_post_controller.dart';

class CreatePostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostController>(() => CreatePostController());
  }
}

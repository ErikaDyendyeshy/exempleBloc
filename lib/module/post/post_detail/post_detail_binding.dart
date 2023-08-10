import 'package:get/get.dart';
import 'package:parallel/_domain/wrapper/post_detail_wrapper.dart';
import 'package:parallel/module/post/post_detail/post_detail_controller.dart';

class PostDetailBinding implements Bindings {
  @override
  void dependencies() {
    final PostDetailWrapper wrapper = Get.arguments as PostDetailWrapper;

    Get.lazyPut<PostDetailController>(
      () => PostDetailController(),
      tag: 'post_detail_page_${wrapper.postId}',
    );
  }
}

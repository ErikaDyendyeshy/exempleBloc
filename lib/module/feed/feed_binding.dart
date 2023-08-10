import 'package:get/get.dart';
import 'package:parallel/module/feed/feed_controller.dart';

class FeedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedController>(() => FeedController());
  }
}

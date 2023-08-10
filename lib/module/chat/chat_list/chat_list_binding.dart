import 'package:get/get.dart';
import 'package:parallel/module/chat/chat_list/chat_list_conroller.dart';

class ChatListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatListController>(() => ChatListController());
  }
}

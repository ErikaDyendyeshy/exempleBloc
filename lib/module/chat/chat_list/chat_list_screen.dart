import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/chat/chat_list/chat_list_conroller.dart';

class ChatListScreen extends GetView<ChatListController> {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'CHAT',
        ),
      ),
    );
  }
}

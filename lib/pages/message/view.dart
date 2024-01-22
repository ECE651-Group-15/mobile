import 'package:exchange/pages/message/widgets/conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const HelloWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Message")),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) => const ConversationItem(),
          itemCount: 10,
        ),
      ),
    );
  }
}

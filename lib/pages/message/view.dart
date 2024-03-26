import 'package:exchange/common/store/user.dart';
import 'package:exchange/pages/message/widgets/conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  Widget _buildConversationList() {
    return ListView.builder(
      itemBuilder: (context, index) => ConversationItem(
        key: Key('conversationItem_$index'), // Assign a unique key based on index
        conversation: controller.state.conversationList[index],
      ),
      itemCount: controller.state.conversationList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Message")),
      body: SafeArea(
        child: Obx(
          () => UserStore.to.customerProfilesDetails.isEmpty
              ? const Center(child: Text("Please login first"))
              : _buildConversationList(),
        ),
      ),
    );
  }
}

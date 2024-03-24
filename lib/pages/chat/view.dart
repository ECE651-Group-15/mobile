import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';

import 'index.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  Widget _buildMessageList() {
    return Obx(
      () => controller.state.messages.length == 0
          ? const Center(
              child: Text("No messages yet"),
            )
          : ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print("index: $index");
                V2TimMessage message = controller.state.messages[index];
                String avatar = message.faceUrl ?? "https://picsum.photos/200";
                String name = message.nickName ?? message.userID ?? '';

                String time = DateFormat('yyyy-MM-dd – kk:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        message.timestamp! * 1000));
                String content = message.textElem!.text ?? "Unknown";

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      avatar,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  subtitle: Text(content),
                );
              },
              itemCount: controller.state.messages.length,
            ),
    );
  }

  Widget _buildInputbox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller.input,
        decoration: InputDecoration(
          isDense: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          labelText: 'Type a message',
          suffixIcon: IconButton(
            onPressed: controller.sendMessage,
            icon: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Page")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildInputbox(),
          ],
        ),
      ),
    );
  }
}

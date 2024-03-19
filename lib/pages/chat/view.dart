import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
                var isSelfMessage = controller.state.messages[index]
                        ['sender'] ==
                    controller.selfId;

                String avatar;
                String name;
                if (isSelfMessage) {
                  avatar = controller.selfAvatar;
                  name = controller.selfName;
                } else {
                  avatar = controller.profilesDetails['avatar'];
                  name = controller.profilesDetails['name'];
                }

                String time = DateFormat('yyyy-MM-dd – kk:mm')
                    .format(controller.state.messages[index]['date']);
                String content = controller.state.messages[index]['content'];

                return ListTile(
                  leading: CircleAvatar(
                    child: Image.network(avatar),
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

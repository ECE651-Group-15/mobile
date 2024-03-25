import 'dart:core';
import 'package:exchange/common/style/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import '../../common/routes/names.dart';
import '../../common/store/user.dart';
import 'index.dart';

class ChatPage extends GetView<ChatController> {
   const ChatPage({Key? key}) : super(key: key);

   Widget _buildMessageList() {
     UserStore userStore = Get.find<UserStore>();
     return Obx(
           () => controller.state.messages.length == 0
           ? const Center(
         child: Text("No messages yet"),
       )
           : ListView.builder(
         reverse: true,
         shrinkWrap: true,
         itemBuilder: (context, index) {
           V2TimMessage message = controller.state.messages[index];
           String avatar = message.faceUrl ?? "https://picsum.photos/200";
           String name = message.nickName ?? message.userID ?? '';
           String time = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.fromMillisecondsSinceEpoch(message.timestamp! * 1000));
           String content = message.textElem!.text ?? "Unknown";
           bool isCurrentUser = name.toLowerCase() == userStore.customerProfilesDetails['name'].toLowerCase();

           // 使用Row来组织头像和消息框，确保它们在同一行
           // 并通过crossAxisAlignment属性设置为CrossAxisAlignment.start来保证它们顶部对齐
           return Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
             child: Row(
               mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start, // 使头像和消息框顶部对齐
               children: [
                 if (!isCurrentUser) // 对于非当前用户，头像显示在左侧
                   Padding(
                     padding: const EdgeInsets.only(left: 8.0),
                     child: GestureDetector(
                       onTap: () async {
                         Map<String, dynamic>? customerProfilesDetails =  await controller.getProfile(message.userID!);
                         Get.toNamed(AppRoutes.userProfile,
                             arguments: customerProfilesDetails);
                       },
                       child: CircleAvatar(
                         backgroundImage: NetworkImage(avatar),
                         radius: 20,
                       ),
                     ),
                   ),
                 Expanded(
                   child: Column(
                     crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                     children: [
                       Container(
                         padding: const EdgeInsets.all(8.0),
                         decoration: BoxDecoration(
                           color: AppColor.myColor, // 调整为您的AppColor.myColor
                           borderRadius: BorderRadius.circular(8),
                         ),
                         child: Text(content, style: const TextStyle(color: Colors.white)),
                       ),
                       const SizedBox(height: 4),
                       Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                     ],
                   ),
                 ),
                 if (isCurrentUser) // 对于当前用户，头像显示在右侧
                   Padding(
                     padding: const EdgeInsets.only(left: 8.0),
                     child: CircleAvatar(
                       backgroundImage: NetworkImage(avatar),
                       radius: 20,
                     ),
                   ),
               ],
             ),
           );
         },
         itemCount: controller.state.messages.length,
       ),
     );
   }


   Widget _buildInputBox() {
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
            _buildInputBox(),
          ],
        ),
      ),
    );
  }
}

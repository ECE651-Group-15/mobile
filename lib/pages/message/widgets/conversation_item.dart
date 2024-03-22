import 'package:badges/badges.dart' as badges;
import 'package:exchange/common/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';

class ConversationItem extends StatelessWidget {
  final V2TimConversation conversation;

  const ConversationItem({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    String lastMessage;

    if (conversation.lastMessage != null) {
      if (conversation.lastMessage!.textElem != null) {
        lastMessage = conversation.lastMessage!.textElem!.text ?? "";
      } else {
        lastMessage = "[Image]";
      }
    } else {
      lastMessage = "";
    }

    return ListTile(
      onTap: () {
        Get.toNamed(AppRoutes.chat, arguments: conversation.userID!);
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          conversation.faceUrl ?? "https://picsum.photos/200",
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(conversation.showName ?? "", overflow: TextOverflow.ellipsis),
      subtitle: Text(lastMessage, overflow: TextOverflow.ellipsis),
      trailing: badges.Badge(
        badgeContent: Text(
          conversation.unreadCount.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        showBadge: (conversation.unreadCount ?? 0) > 0,
        badgeStyle: const badges.BadgeStyle(badgeColor: Colors.blue),
      ),
    );
  }
}

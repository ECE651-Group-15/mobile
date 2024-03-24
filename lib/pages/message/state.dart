import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';

class MessageState {
  final _conversationList = <V2TimConversation?>[].obs;
  set conversationList(value) => _conversationList.value = value;
  get conversationList => _conversationList;
}

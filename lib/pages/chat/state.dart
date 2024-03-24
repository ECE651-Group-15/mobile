import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';

class ChatState {
  // title
  final _title = "".obs;
  set title(value) => _title.value = value;
  get title => _title.value;

  final _messages = <V2TimMessage>[].obs;
  set messages(value) => _messages.value = value;
  get messages => _messages;

  final _conversation = <dynamic>[].obs;
  set conversation(value) => _conversation.value = value;
  get conversation => _conversation;
}

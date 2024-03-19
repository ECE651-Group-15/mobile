import 'package:exchange/common/store/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'index.dart';

class ChatController extends GetxController {
  ChatController();

  final state = ChatState();

  Map<String, dynamic> profilesDetails = {};
  var selfId = UserStore.to.customerProfilesDetails['id'];
  var selfName = UserStore.to.customerProfilesDetails['name'];
  var selfAvatar = UserStore.to.customerProfilesDetails['avatar'];

  TextEditingController input = TextEditingController();

  void sendMessage() async {
    if (input.text.isEmpty) {
      EasyLoading.showToast("Can't send empty message");
      return;
    }

    // if (response.error != null) {
    //   print('Error fetching row: ${response.error!.message}');
    //   return;
    // }

    state.messages.insert(0, {
      "content": input.text,
      "sender": selfId,
      "date": DateTime.now(),
    });
    input.clear();
  }

  void fetchMessages() async {
    // final response = await client
    //     .from('conversations')
    //     .select()
    //     .eq('user_id', selfId)
    //     .eq('other_id', profilesDetails['id'])
    //     .single();

    // state.messages = response['messages'];
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();

    // retrieve arguments from previous screen
    profilesDetails = Get.arguments;

    // fetch message history
    fetchMessages();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }
}

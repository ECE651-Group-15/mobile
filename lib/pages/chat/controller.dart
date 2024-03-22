import 'package:exchange/common/store/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_msg_create_info_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

import 'index.dart';

class ChatController extends GetxController {
  ChatController();

  final state = ChatState();

  String otherUserId = '';

  var selfId = UserStore.to.customerProfilesDetails['id'];
  var selfName = UserStore.to.customerProfilesDetails['name'];
  var selfAvatar = UserStore.to.customerProfilesDetails['avatar'];

  TextEditingController input = TextEditingController();

  void sendMessage() async {
    if (input.text.isEmpty) {
      EasyLoading.showToast("Can't send empty message");
      return;
    }

    V2TimValueCallback<V2TimMsgCreateInfoResult> createTextMessageRes =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .createTextMessage(text: input.text);

    if (createTextMessageRes.code == 0) {
      String? id = createTextMessageRes.data?.id;
      V2TimValueCallback<V2TimMessage> sendMessageRes = await TencentImSDKPlugin
          .v2TIMManager
          .getMessageManager()
          .sendMessage(id: id!, receiver: otherUserId, groupID: '');
      if (sendMessageRes.code == 0) {
        print("send message success");
        state.messages.insert(0, sendMessageRes.data!);
      } else {
        print("send message failed");
        EasyLoading.showError("Other user haven't register in IM system");
        print(sendMessageRes.desc);
      }
    }

    input.clear();
  }

  Future<void> fetchMessages() async {
    V2TimValueCallback<List<V2TimMessage>> getC2CHistoryMessageListRes =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .getC2CHistoryMessageList(
              userID: otherUserId,
              count: 100,
              lastMsgID: null,
            );
    if (getC2CHistoryMessageListRes.code == 0) {
      state.messages = getC2CHistoryMessageListRes.data!;
    } else {
      EasyLoading.showToast("Failed to fetch message history");
    }
  }

  Future<void> handleMessage() async {
    V2TimAdvancedMsgListener listener = V2TimAdvancedMsgListener(
      onRecvNewMessage: (V2TimMessage message) async {
        state.messages.insert(0, message);
      },
    );
    TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .addAdvancedMsgListener(listener: listener);
  }

  Future<void> clearUnreadCount() async {
    await TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .markC2CMessageAsRead(userID: otherUserId);
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();

    // retrieve arguments from previous screen
    otherUserId = Get.arguments;

    // fetch message history
    fetchMessages();

    handleMessage();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    clearUnreadCount();
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }
}

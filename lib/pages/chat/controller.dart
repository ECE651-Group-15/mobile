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
  var detailedPost = <String,dynamic>{};
  bool isSendOffer = true;
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
        state.messages.insert(0, sendMessageRes.data!);
      } else {
        EasyLoading.showError("Other user haven't register in IM system");
      }
    }

    input.clear();
  }

  void sendHelloMessage(double price, String title) async {
    // 固定发送的消息内容
    String messageContent = "hello, I am willing to pay \$$price for your $title";

    V2TimValueCallback<V2TimMsgCreateInfoResult> createTextMessageRes =
    await TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .createTextMessage(text: messageContent); // 使用固定内容创建文本消息

    if (createTextMessageRes.code == 0) {
      String? id = createTextMessageRes.data?.id;
      V2TimValueCallback<V2TimMessage> sendMessageRes = await TencentImSDKPlugin
          .v2TIMManager
          .getMessageManager()
          .sendMessage(id: id!, receiver: otherUserId, groupID: '');
      if (sendMessageRes.code == 0) {
        // 这里假设你有一个状态对象（state）和一个保存消息的列表（messages）
        // 如果你的应用程序的架构不同，你可能需要调整这部分代码
        state.messages.insert(0, sendMessageRes.data!);
      } else {
        EasyLoading.showError("Other user haven't register in IM system");
      }
    }

    // 由于我们不是从输入框读取内容，这里不需要清除输入
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

    final Map<String, dynamic> args = Get.arguments;

    // 从Map中提取参数
    detailedPost = args['detailedPost'];
    isSendOffer = args['isSendOffer'];
    otherUserId =detailedPost['customerProfilesDetails']?['id'];
    if(isSendOffer)
      {
        sendHelloMessage(detailedPost['listingDetails']?['price'],detailedPost['listingDetails']?['title']);
      }
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

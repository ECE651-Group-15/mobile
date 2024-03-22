import 'package:exchange/common/store/user.dart';
import 'package:exchange/common/utils/utils.dart';
import 'package:get/get.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimConversationListener.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_callback.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

import 'index.dart';

class MessageController extends GetxController {
  MessageController();

  final state = MessageState();

  Future<void> getConversationList() async {
    V2TimValueCallback<V2TimConversationResult> res = await TencentImSDKPlugin
        .v2TIMManager
        .getConversationManager()
        .getConversationList(count: 100, nextSeq: "0");
    state.conversationList = res.data!.conversationList!;
  }

  Future<void> updateUserInfo() async {
    var userId = UserStore.to.customerProfilesDetails['id'];
    var nickName = UserStore.to.customerProfilesDetails['name'];
    var avatar = UserStore.to.customerProfilesDetails['avatar'];

    V2TimUserFullInfo userFullInfo = V2TimUserFullInfo(
      nickName: nickName,
      faceUrl: avatar,
      userID: userId,
    );
    V2TimCallback setSelfInfoRes = await TencentImSDKPlugin.v2TIMManager
        .setSelfInfo(userFullInfo: userFullInfo); //用户资料设置信息
    if (setSelfInfoRes.code == 0) {
      print("setSelfInfo success");
    }
  }

  Future<void> timLogin() async {
    var userId = UserStore.to.customerProfilesDetails['id'];

    // request userSig from backend
    var userSig = await HttpUtil().post(
      "https://exchange-vwdpdyrqzw.us-east-1.fcapp.run/api/v1/auth/userSig",
      data: {"userId": userId},
    );

    V2TimCallback res = await TencentImSDKPlugin.v2TIMManager.login(
      userID: userId,
      userSig: userSig["data"],
    );

    if (res.code == 0) {
      print("login success");
      getConversationList();
      updateUserInfo();
    } else {
      print("login failed");
    }
  }

  void handleConversation() async {
    V2TimConversationListener listener = V2TimConversationListener(
      onConversationChanged: (List<V2TimConversation> conversationList) {
        print("onConversationChanged");
        for (int i = 0; i < conversationList.length; i++) {
          for (int j = 0; j < state.conversationList.length; j++) {
            if (conversationList[i].conversationID ==
                state.conversationList[j].conversationID) {
              state.conversationList[j] = conversationList[i];
              break;
            }
          }
        }
      },
      onNewConversation: (List<V2TimConversation> conversationList) {
        state.conversationList.insertAll(0, conversationList);
      },
    );
    TencentImSDKPlugin.v2TIMManager
        .getConversationManager()
        .addConversationListener(listener: listener);
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();

    timLogin();
    handleConversation();
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
    super.dispose();
  }
}

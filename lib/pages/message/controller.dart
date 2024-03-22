import 'package:exchange/common/store/user.dart';
import 'package:exchange/main.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimSDKListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/log_level_enum.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

import 'index.dart';

class MessageController extends GetxController {
  MessageController();

  final state = MessageState();

  Future<void> fetchConversationList() async {
    String userId = UserStore.to.customerProfilesDetails['id'];
    var rows =
        await client.from('conversations').select().eq("user_id", userId);
    print(rows);
  }

  void handleNewMessage(PostgresChangePayload payload) {
    print('New message: $payload');
  }

  void initTimSdk() async {
    int sdkAppID = 1771000292;

    V2TimSDKListener sdkListener = V2TimSDKListener(
      onConnectFailed: (int code, String error) {
        print("onConnectFailed: $code, $error");
      },
      onConnectSuccess: () {
        print("onConnectSuccess");
      },
      onConnecting: () {
        print("onConnecting");
      },
    );

    TencentImSDKPlugin.v2TIMManager.initSDK(
      sdkAppID: 1400563371,
      loglevel: LogLevelEnum.V2TIM_LOG_DEBUG,
      listener: sdkListener,
    );
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();

    initTimSdk();

    // var userId = UserStore.to.customerProfilesDetails['id'];
    // print("userId: $userId");
    // client
    //     .channel(userId)
    //     .onPostgresChanges(
    //         schema: 'public',
    //         table: 'conversations',
    //         event: PostgresChangeEvent.all,
    //         callback: handleNewMessage)
    //     .subscribe();
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

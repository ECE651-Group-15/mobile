import 'package:exchange/common/store/user.dart';
import 'package:exchange/main.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();

    var userId = UserStore.to.customerProfilesDetails['id'];
    print("userId: $userId");
    client
        .channel(userId)
        .onPostgresChanges(
            schema: 'public',
            table: 'conversations',
            event: PostgresChangeEvent.all,
            callback: handleNewMessage)
        .subscribe();
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

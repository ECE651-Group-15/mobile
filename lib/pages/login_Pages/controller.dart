
import 'package:get/get.dart';
import 'index.dart';

class LoginController extends GetxController{
  LoginController();

  final state = LoginControllerState();

  void login(String newUserId) {
    state.userId.value = newUserId; // 更新用户ID
  }

  void loadData(){
    login('ff8bc70f-bd42-4c5d-849f-498a70b3f095');
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    loadData();
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
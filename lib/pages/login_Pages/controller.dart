import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/apis/post.dart';
import '../../common/entities/post.dart';
import '../home/controller.dart';
import 'index.dart';

class LoginController extends GetxController {
  LoginController();

  final state = LoginControllerState();

  Future<Map<String, dynamic>?> logIn(String email, String password) async {
    LoginRequestEntity req = LoginRequestEntity(
      email: email,
      password: password,
    );
    Map<String, dynamic>? userProfile = {};

    try {
      LoginResponseEntity res = await PostApi.logInPost(req);
      if (res.code == 200 && res.data != null) {
        userProfile = res.data!.toJson(); // 使用 Data 类的 toJson 方法
        state.isLogin = true;
        state.customerProfilesDetails.value = userProfile;
        // EasyLoading.showSuccess('login success');
        final HomeController homeController = Get.find<HomeController>();
        homeController.refreshUI();
        Get.back();
      } else {
        print('Error: getProfile()');
        state.isLogin = false;
        EasyLoading.showError('login failed');
      }
    } catch (e) {
      print('Error : $e');
      EasyLoading.showError('login failed : $e');
    }
    return userProfile;
  }

  // void login(String newUserId) {
  //   state.userId.value = newUserId; // 更新用户ID
  // }

  // void loadData(){
  //   state.customerProfilesDetails =
  //   // login('ff8bc70f-bd42-4c5d-849f-498a70b3f095');
  // }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    // loadData();
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

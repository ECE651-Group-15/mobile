
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../common/apis/post.dart';
import '../../common/entities/post.dart';
import 'index.dart';

class LoginController extends GetxController{
  LoginController();

  final state = LoginControllerState();
  // MineController mineController = Get.find<MineController>();

  Future<void> logIn(BuildContext context,String email, String password) async {
    LoginRequestEntity req = LoginRequestEntity(
      email: email,
      password: password,
    );
    Map<String, dynamic>? userProfile = {};
    // EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
    try {
      LoginResponseEntity res = await PostApi.logInPost(req);
      if (res.code == 200 && res.data != null) {
        userProfile = res.data!.toJson(); // 使用 Data 类的 toJson 方法
        state.isLogin = true;
        state.id = userProfile['id'];
        state.userId.value = userProfile['id'];
        state.name = userProfile['name'];
        state.email = userProfile['email'];
        state.avatar = userProfile['avatar'];
        state.phone = userProfile['phone'];
        state.longitude = userProfile['longitude']?.toDouble();
        state.latitude = userProfile['latitude']?.toDouble();
        state.postedListingIds.assignAll(List<String>.from(userProfile['postedListingIds'] ?? []));
        state.starredListIds.assignAll(List<String>.from(userProfile['starredListIds'] ?? []));
        EasyLoading.showSuccess('login success');
        Get.find<LoginController>().update();
        Navigator.pop(context);
      } else {
        print('Error: getProfile()');
        // userProfile = {};
        state.isLogin = false;
        EasyLoading.showError('login failed');
      }
    } catch (e) {
      print('Error : $e');
      EasyLoading.showError('login failed : $e');
      // userProfile = {}; // 捕获异常时也确保返回一个空Map
    }
    // return userProfile;
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